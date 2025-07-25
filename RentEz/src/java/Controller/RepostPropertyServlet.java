package Controller;

import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.PropertyDAO;
import Model.Booking;
import Model.Location;
import Model.Property;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.sql.Timestamp;

@WebServlet(name = "RepostPropertyServlet", urlPatterns = {"/repostProperty"})
public class RepostPropertyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String propertyIdStr = request.getParameter("propertyId");
        
        if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
            session.setAttribute("error", "ID bất động sản không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
            return;
        }
        
        try {
            int originalPropertyId = Integer.parseInt(propertyIdStr);
            
            // Lấy thông tin property gốc
            PropertyDAO propertyDAO = new PropertyDAO();
            Property originalProperty = propertyDAO.getById(originalPropertyId);
            
            if (originalProperty == null) {
                session.setAttribute("error", "Không tìm thấy bất động sản.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Kiểm tra quyền sở hữu
            if (originalProperty.getLandlordId() != user.getUserId()) {
                session.setAttribute("error", "Bạn không có quyền thực hiện thao tác này.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Kiểm tra trạng thái phải là "Rented"
            if (!"Rented".equals(originalProperty.getAvailabilityStatus())) {
                session.setAttribute("error", "Chỉ có thể đăng lại những bất động sản đã được thuê.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Tạo location mới (copy từ location cũ)
            LocationDAO locationDAO = new LocationDAO();
            Location originalLocation = locationDAO.getById(originalProperty.getLocationId());
            
            Location newLocation = new Location();
            newLocation.setAddress(originalLocation.getAddress());
            newLocation.setCity(originalLocation.getCity());
            newLocation.setStateProvince(originalLocation.getStateProvince());
            newLocation.setCountry(originalLocation.getCountry());
            newLocation.setZipCode(originalLocation.getZipCode());
            
            int newLocationId = locationDAO.insertLocation(newLocation);
            if (newLocationId == -1) {
                session.setAttribute("error", "Không thể tạo địa chỉ mới. Vui lòng thử lại.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Tạo property mới với thông tin tương tự
            Property newProperty = new Property();
            newProperty.setTitle(originalProperty.getTitle() + " (Đăng lại)");
            newProperty.setDescription(originalProperty.getDescription());
            newProperty.setTypeId(originalProperty.getTypeId());
            newProperty.setLocationId(newLocationId);
            newProperty.setLandlordId(user.getUserId());
            newProperty.setPrice(originalProperty.getPrice());
            newProperty.setSize(originalProperty.getSize());
            newProperty.setNumberOfBedrooms(originalProperty.getNumberOfBedrooms());
            newProperty.setNumberOfBathrooms(originalProperty.getNumberOfBathrooms());
            newProperty.setAvailabilityStatus("Available"); // Đặt trạng thái là Available
            newProperty.setPriorityLevel(originalProperty.getPriorityLevel());
            newProperty.setPublicStatus(true); // Mặc định chưa công khai
            newProperty.setAvatar(originalProperty.getAvatar()); // Sử dụng cùng ảnh
            
            int newPropertyId = propertyDAO.addProperty(newProperty);
            if (newPropertyId == -1) {
                session.setAttribute("error", "Không thể tạo bất động sản mới. Vui lòng thử lại.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Lấy booking template từ property gốc để tạo booking mới
            BookingDAO bookingDAO = new BookingDAO();
            Booking originalBooking = bookingDAO.getBookingByPropertyId(originalPropertyId);
            
            if (originalBooking != null) {
                // Tạo booking mới với thông tin tương tự nhưng chưa có người thuê
                Booking newBooking = new Booking();
                newBooking.setPropertyId(newPropertyId);
                newBooking.setRenterId(0); // Để trống - chưa có người thuê
                newBooking.setStartDate(new Timestamp(System.currentTimeMillis())); // Ngày hiện tại
                newBooking.setEndDate(new Timestamp(System.currentTimeMillis())); // Ngày hiện tại (sẽ được cập nhật khi có người thuê)
                newBooking.setTotalPrice(originalBooking.getTotalPrice());
                newBooking.setStatus("Pending"); // Trạng thái template, chưa có người thuê thực tế
                newBooking.setDepositAmount(originalBooking.getDepositAmount());
                newBooking.setMonthlyRent(originalBooking.getMonthlyRent());
                newBooking.setPenaltyClause(originalBooking.getPenaltyClause());
                newBooking.setTermsAndConditions(originalBooking.getTermsAndConditions());
                newBooking.setCreatedAt(new Date());
                newBooking.setSignedAt(null);
                newBooking.setSignedByRenter(false);
                newBooking.setSignedByLandlord(true); // Landlord đã đồng ý với template
                
                boolean bookingSuccess = bookingDAO.addProperty(newBooking);
                if (!bookingSuccess) {
                    System.out.println("Warning: Failed to create booking template for new property " + newPropertyId);
                }
            }
            
            session.setAttribute("successMessage", "Đăng lại tin thành công! Bất động sản mới đã được tạo với trạng thái 'Còn trống'.");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID bất động sản không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
        } catch (Exception e) {
            System.err.println("Error in RepostPropertyServlet: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi đăng lại tin. Vui lòng thử lại.");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Servlet handles reposting of rented properties as new available properties.";
    }
}
