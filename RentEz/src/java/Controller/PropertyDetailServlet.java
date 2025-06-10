package Controller;

import DAO.LocationDAO;
import DAO.PropertyDAO;
import DAO.PropertyImageDAO;
import DAO.PropertyTypeDAO;
import DAO.UserDao;
import DAO.BookingDAO;
import Model.Location;
import Model.Property;
import Model.PropertyImage;
import Model.PropertyType;
import Model.User;
import Model.Booking;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PropertyDetailServlet", urlPatterns = {"/property-detail"})
public class PropertyDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy propertyId từ request parameter
        String propertyIdStr = request.getParameter("id");
        
        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            // Nếu không có ID, chuyển hướng về trang chủ hoặc trang tìm kiếm
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
              // Khởi tạo các DAO
            PropertyDAO propertyDAO = new PropertyDAO();
            LocationDAO locationDAO = new LocationDAO();
            PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
            PropertyImageDAO propertyImageDAO = new PropertyImageDAO();
            UserDao userDAO = new UserDao();
            BookingDAO bookingDAO = new BookingDAO();
            
            // Lấy thông tin chi tiết bất động sản
            Property property = propertyDAO.getById(propertyId);
            
            if (property == null) {
                // Nếu không tìm thấy bất động sản với ID đã cho
                request.setAttribute("errorMessage", "Không tìm thấy bất động sản");
                request.getRequestDispatcher("/view/guest/page/error.jsp").forward(request, response);
                return;
            }
            
            // Lấy thông tin về vị trí
            Location location = locationDAO.getById(property.getLocationId());
            
            // Lấy thông tin về loại bất động sản
            PropertyType propertyType = propertyTypeDAO.getById(property.getTypeId());
            
            // Lấy danh sách hình ảnh của bất động sản
            List<PropertyImage> propertyImages = propertyImageDAO.getByPropertyId(propertyId);
            
            // Lấy thông tin của chủ nhà
            User landlord = userDAO.getById(property.getLandlordId());
            
            // Lấy booking template của property (booking đã được landlord tạo sẵn)
            Booking propertyBookingTemplate = null;
            List<Booking> propertyBookings = bookingDAO.getBookingsByPropertyId(propertyId);
            
            // Tìm booking template (booking mà landlord đã signed và có status là "Template" hoặc booking đầu tiên)
            for (Booking booking : propertyBookings) {
                if ("Template".equals(booking.getStatus()) || 
                    (booking.isSignedByLandlord() && !booking.isSignedByRenter())) {
                    propertyBookingTemplate = booking;
                    break;
                }
            }
            
            // Nếu không có template, lấy booking đầu tiên làm template
            if (propertyBookingTemplate == null && !propertyBookings.isEmpty()) {
                propertyBookingTemplate = propertyBookings.get(0);
            }
              // Lưu thông tin vào request
            request.setAttribute("property", property);
            request.setAttribute("location", location);
            request.setAttribute("propertyType", propertyType);
            request.setAttribute("propertyImages", propertyImages);
            request.setAttribute("landlord", landlord);
            request.setAttribute("propertyBookingTemplate", propertyBookingTemplate);
            
            // Chuyển hướng đến trang chi tiết bất động sản
            request.getRequestDispatcher("/view/guest/page/property-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Xử lý khi ID không hợp lệ
            request.setAttribute("errorMessage", "ID bất động sản không hợp lệ");
            request.getRequestDispatcher("/view/guest/page/error.jsp").forward(request, response);
        }
    }    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // For POST requests, redirect to GET
        doGet(request, response);
    }
}
