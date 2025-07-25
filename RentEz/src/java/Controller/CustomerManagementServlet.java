package Controller;

import DAO.BookingDAO;
import DAO.PropertyDAO;
import DAO.UsersDao;
import Model.Booking;
import Model.Property;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CustomerManagementServlet", urlPatterns = {"/customerManagement"})
public class CustomerManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Get landlord's properties
            PropertyDAO propertyDAO = new PropertyDAO();
            List<Property> properties = propertyDAO.getPropertiesByLandlordId(user.getUserId());
            
            // Get all bookings for these properties
            BookingDAO bookingDAO = new BookingDAO();
            UsersDao userDAO = new UsersDao();
            
            List<Map<String, Object>> customerBookings = new ArrayList<>();
            
            for (Property property : properties) {
                List<Booking> bookings = bookingDAO.getBookingsByPropertyId(property.getPropertyId());
                
                for (Booking booking : bookings) {
                    if ("Confirmed".equals(booking.getStatus())) {
                        User renter = userDAO.getById(booking.getRenterId());
                        
                        Map<String, Object> customerData = new HashMap<>();
                        customerData.put("booking", booking);
                        customerData.put("property", property);
                        customerData.put("renter", renter);
                        
                        // Calculate rental status
                        Date currentDate = new Date();
                        Date endDate = booking.getEndDate();
                        
                        String status;
                        long daysDiff = (endDate.getTime() - currentDate.getTime()) / (1000 * 60 * 60 * 24);
                        
                        if (daysDiff < 0) {
                            status = "Đã quá hạn";
                        } else if (daysDiff <= 30) {
                            status = "Sắp hết hạn";
                        } else {
                            status = "Còn hạn";
                        }
                        
                        customerData.put("status", status);
                        customerData.put("daysLeft", daysDiff);
                        
                        customerBookings.add(customerData);
                    }
                }
            }
            
            request.setAttribute("customerBookings", customerBookings);
            request.getRequestDispatcher("/view/landlord/page/customerManagement.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách khách hàng.");
            request.getRequestDispatcher("/view/landlord/page/customerManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Customer Management Servlet for landlords";
    }
}
