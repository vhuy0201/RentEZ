package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import Model.Booking;
import DTO.BookingDTO;
import Model.User;
import Model.Bill;
import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import DAO.UsersDao;
import DAO.BillDAO;
import Model.Location;
import Model.Property;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LandlordContractServlet", urlPatterns = {"/contractManagement", "/approveContract", "/rejectContract"})
public class LandlordContractServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private UsersDao userDAO;
    private PropertyDAO propertyDAO;
    private LocationDAO locationDAO;
    private PropertyTypeDAO propertyTypeDAO;
    private BillDAO billDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        bookingDAO = new BookingDAO();
        userDAO = new UsersDao();
        propertyDAO = new PropertyDAO();
        locationDAO = new LocationDAO();
        propertyTypeDAO = new PropertyTypeDAO();
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/contractManagement".equals(path)) {
            handleContractManagement(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/approveContract".equals(path)) {
            handleApproveContract(request, response);
        } else if ("/rejectContract".equals(path)) {
            handleRejectContract(request, response);
        }
    }

    private void handleContractManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get current user from session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            if (currentUser == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Check if user is landlord
            if (!"Landlord".equals(currentUser.getRole())) {
                request.setAttribute("error", "Bạn không có quyền truy cập trang này.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/landlord/page/contractManagement.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Get all bookings/contracts for the landlord
            int landlordId = currentUser.getUserId();
            
            List<Booking> bookings = bookingDAO.getBookingsByLandlord(landlordId);
            List<BookingDTO> bookingDTOs = new ArrayList<>();

            for (Booking booking : bookings) {
                BookingDTO bookingDTO = new BookingDTO();

                // Set booking
                bookingDTO.setBooking(booking);

                // Set renter
                User renter = userDAO.getById(booking.getRenterId());
                bookingDTO.setRenter(renter);

                // Set property
                Property property = propertyDAO.getById(booking.getPropertyId());
                bookingDTO.setProperty(property);

                Location location = locationDAO.getById(property.getLocationId());
                bookingDTO.setLocation(location);
                // Set landlord (from property)
                if (property != null) {
                    User landlord = userDAO.getById(property.getLandlordId());
                    bookingDTO.setLandlord(landlord);
                }

                bookingDTOs.add(bookingDTO);
            }
            request.setAttribute("contracts", bookingDTOs);
            // Calculate statistics
            Map<String, Integer> stats = bookingDAO.getContractStats(landlordId);
            request.setAttribute("stats", stats);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/landlord/page/contractManagement.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách hợp đồng: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/landlord/page/contractManagement.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void handleApproveContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try {
            // Read JSON data from request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            Map<String, Object> requestData = gson.fromJson(sb.toString(), Map.class);
            int contractId = ((Double) requestData.get("contractId")).intValue();

            // Get booking details
            Booking booking = bookingDAO.getById(contractId);
            if (booking == null) {
                Map<String, Object> responseData = new HashMap<>();
                responseData.put("success", false);
                responseData.put("message", "Không tìm thấy hợp đồng");
                out.print(gson.toJson(responseData));
                return;
            }

            // Get property to find landlord
            Property property = propertyDAO.getById(booking.getPropertyId());
            if (property == null) {
                Map<String, Object> responseData = new HashMap<>();
                responseData.put("success", false);
                responseData.put("message", "Không tìm thấy thông tin bất động sản");
                out.print(gson.toJson(responseData));
                return;
            }

            // Approve the contract first
            boolean success = bookingDAO.approveContract(contractId);

            if (success) {
                // Update property availability status to "Rented"
                boolean propertyUpdated = propertyDAO.updateAvailabilityStatus(booking.getPropertyId(), "Rented");
                
                // Create bill for the rental contract
                Bill contractBill = new Bill();
                contractBill.setPropertyId(booking.getPropertyId());
                contractBill.setRenterId(booking.getRenterId());
                contractBill.setBillingPeriod(getCurrentBillingPeriod());
                contractBill.setTotalAmount(booking.getTotalPrice());
                contractBill.setDueDate(booking.getStartDate()); // Due on contract start date
                contractBill.setStatus("Pending"); // Initial status is pending

                // Insert bill record
                boolean billCreated = billDAO.insert(contractBill);

                Map<String, Object> responseData = new HashMap<>();
                if (billCreated && propertyUpdated) {
                    responseData.put("success", true);
                    responseData.put("message", "Hợp đồng đã được duyệt thành công, trạng thái bất động sản đã được cập nhật và hóa đơn đã được tạo");
                } else if (propertyUpdated) {
                    responseData.put("success", true);
                    responseData.put("message", "Hợp đồng đã được duyệt thành công và trạng thái bất động sản đã được cập nhật nhưng có lỗi khi tạo hóa đơn");
                } else if (billCreated) {
                    responseData.put("success", true);
                    responseData.put("message", "Hợp đồng đã được duyệt thành công và hóa đơn đã được tạo nhưng có lỗi khi cập nhật trạng thái bất động sản");
                } else {
                    responseData.put("success", true);
                    responseData.put("message", "Hợp đồng đã được duyệt thành công nhưng có lỗi khi tạo hóa đơn và cập nhật trạng thái bất động sản");
                }
                out.print(gson.toJson(responseData));
            } else {
                Map<String, Object> responseData = new HashMap<>();
                responseData.put("success", false);
                responseData.put("message", "Không thể duyệt hợp đồng");
                out.print(gson.toJson(responseData));
            }

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", false);
            responseData.put("message", "Có lỗi xảy ra: " + e.getMessage());
            out.print(gson.toJson(responseData));
        } finally {
            out.flush();
            out.close();
        }
    }

    private void handleRejectContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try {
            // Read JSON data from request
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            Map<String, Object> requestData = gson.fromJson(sb.toString(), Map.class);
            int contractId = ((Double) requestData.get("contractId")).intValue();
            String reason = (String) requestData.get("reason");

            // Use real database implementation
            boolean success = bookingDAO.rejectContract(contractId, reason);

            Map<String, Object> responseData = new HashMap<>();
            if (success) {
                responseData.put("success", true);
                responseData.put("message", "Hợp đồng đã được từ chối");
            } else {
                responseData.put("success", false);
                responseData.put("message", "Không thể từ chối hợp đồng");
            }

            out.print(gson.toJson(responseData));

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", false);
            responseData.put("message", "Có lỗi xảy ra: " + e.getMessage());
            out.print(gson.toJson(responseData));
        } finally {
            out.flush();
            out.close();
        }
    }
    
    /**
     * Helper method to generate current billing period string
     * Format: MM/yyyy (e.g., "01/2025")
     */
    private String getCurrentBillingPeriod() {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/yyyy");
        return sdf.format(new Date());
    }
}
