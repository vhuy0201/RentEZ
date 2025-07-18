package Controller;

import java.io.IOException;

import DAO.AdminUserDAO;
import DAO.PropertyTypeDAO;
import DAO.ServiceFeeDAO;
import DAO.TierDAO;
import DAO.BookingDAO;
import DAO.PaymentDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminDeleteActionServlet", urlPatterns = {"/admin/delete-action"})
public class AdminDeleteActionServlet extends HttpServlet {
    
    private AdminUserDAO userDAO;
    private PropertyTypeDAO propertyTypeDAO;
    private ServiceFeeDAO serviceFeeDAO;
    private TierDAO tierDAO;
    private BookingDAO bookingDAO;
    private PaymentDAO paymentDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new AdminUserDAO();
        propertyTypeDAO = new PropertyTypeDAO();
        serviceFeeDAO = new ServiceFeeDAO();
        tierDAO = new TierDAO();
        bookingDAO = new BookingDAO();
        paymentDAO = new PaymentDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check if user is admin
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        
        if (id == null || id.isEmpty() || type == null || type.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=invalid");
            return;
        }
        
        boolean success = false;
        String redirectUrl = "/admin/dashboard";
        
        try {
            switch (type) {
                case "user":
                    int userId = Integer.parseInt(id);
                    success = userDAO.deleteUser(userId);
                    redirectUrl = "/admin/users";
                    break;
                    
                case "property-type":
                    int typeId = Integer.parseInt(id);
                    success = propertyTypeDAO.deletePropertyType(typeId);
                    redirectUrl = "/admin/property-types";
                    break;
                    
                case "service-fee":
                    int feeId = Integer.parseInt(id);
                    success = serviceFeeDAO.deleteServiceFee(feeId);
                    redirectUrl = "/admin/service-fees";
                    break;
                    
                case "tier":
                    int tierId = Integer.parseInt(id);
                    success = tierDAO.deleteTier(tierId);
                    redirectUrl = "/admin/tiers";
                    break;
                    
                case "booking":
                    int bookingId = Integer.parseInt(id);
                    success = bookingDAO.delete(bookingId);
                    redirectUrl = "/admin/bookings";
                    break;
                    
                case "payment":
                    int paymentId = Integer.parseInt(id);
                    success = paymentDAO.delete(paymentId);
                    redirectUrl = "/admin/payments";
                    break;
                    
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=unknown");
                    return;
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + redirectUrl + "?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + redirectUrl + "?error=delete");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + redirectUrl + "?error=exception");
        }
    }
}
