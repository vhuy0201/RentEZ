package Controller;

import java.io.IOException;

import DAO.UsersDao;
import DAO.BookingDAO;
import DAO.PropertyDAO;
import Model.User;
import Model.Booking;
import Model.Property;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/user-detail")
public class UserDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String userIdParam = request.getParameter("userId");
            if (userIdParam == null || userIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
                return;
            }
            
            int userId = Integer.parseInt(userIdParam);
            
            // Get user information
            UsersDao userDAO = new UsersDao();
            User userDetail = userDAO.getById(userId);
            
            boolean is = userDetail.isStatus();
            if (userDetail == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }
            
            // Get user's booking history
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> userBookings = bookingDAO.getBookingsByRenterId(userId);
            
            // Get properties associated with this user (if landlord)
            PropertyDAO propertyDAO = new PropertyDAO();
            List<Property> userProperties = null;
            if ("Landlord".equals(userDetail.getRole())) {
                userProperties = propertyDAO.getPropertiesByLandlordId(userId);
            }
            
            // Set attributes for JSP
            request.setAttribute("userDetail", userDetail);
            request.setAttribute("userBookings", userBookings);
            request.setAttribute("userProperties", userProperties);
            request.setAttribute("currentUser", currentUser);
            
            // Forward to JSP
            request.getRequestDispatcher("/view/common/user-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User ID format");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi tải thông tin người dùng: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customerManagement");
        }
    }
}
