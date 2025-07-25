package Controller;

import java.io.IOException;
import java.util.List;

import DAO.AdminsUserDAO;
import DAO.PropertyDAO;
import DAO.PaymentDAO;
import DAO.BookingDAO;
import DAO.SupportTicketDAO;
import DAO.ReviewDAO;
import Model.User;
import Model.Property;
import Model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    
    private AdminsUserDAO userDAO;
    private PropertyDAO propertyDAO;
    private PaymentDAO paymentDAO;
    private BookingDAO bookingDAO;
    private SupportTicketDAO supportDAO;
    private ReviewDAO reviewDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new AdminsUserDAO();
        propertyDAO = new PropertyDAO();
        paymentDAO = new PaymentDAO();
        bookingDAO = new BookingDAO();
        supportDAO = new SupportTicketDAO();
        reviewDAO = new ReviewDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        
        try {
            // a. Thống kê nhanh (Quick Statistics)
            // Tổng số phòng trọ
            int totalProperties = propertyDAO.getTotalProperties();
            
            // Số phòng đang được thuê / còn trống
            int rentedProperties = propertyDAO.getRentedPropertiesCount();
            int availableProperties = propertyDAO.getAvailablePropertiesCount();
            
            // Doanh thu tháng / quý / năm
            double monthlyRevenue = paymentDAO.getMonthlyRevenue();
            double quarterlyRevenue = paymentDAO.getQuarterlyRevenue();
            double yearlyRevenue = paymentDAO.getYearlyRevenue();
            double totalRevenue = paymentDAO.getTotalRevenue();
            
            // Số lượng người dùng đang hoạt động (chủ trọ, khách thuê)
            int totalUsers = userDAO.getTotalUsers();
            int activeLandlords = userDAO.getActiveLandlordsCount();
            int activeRenters = userDAO.getActiveRentersCount();
            int totalActiveUsers = activeLandlords + activeRenters;
            
            // Số hợp đồng (bookings) đang hiệu lực / sắp hết hạn
            int totalBookings = bookingDAO.getAllBookings().size();
            int activeBookings = bookingDAO.getActiveBookingsCount();
            int expiringBookings = bookingDAO.getExpiringBookingsCount();
            int confirmedBookings = bookingDAO.getConfirmedBookingsCount();
            int pendingBookings = bookingDAO.getPendingBookingsCount();
            int cancelledBookings = bookingDAO.getCancelledBookingsCount();
            
            // b. Dữ liệu cho biểu đồ trực quan
            // Biểu đồ doanh thu theo thời gian (12 tháng gần nhất)
            List<Double> monthlyRevenueChart = paymentDAO.getMonthlyRevenueStats(12);
            List<String> monthLabels = paymentDAO.getMonthLabels(12);
            
            // Tỷ lệ phòng trống vs đã thuê (pie chart data)
            double rentedPercentage = totalProperties > 0 ? (double) rentedProperties / totalProperties * 100 : 0;
            double availablePercentage = totalProperties > 0 ? (double) availableProperties / totalProperties * 100 : 0;
            
            // Biểu đồ số lượng người thuê mới theo tháng (12 tháng gần nhất)
            List<Integer> newRentersChart = userDAO.getNewRentersPerMonth(12);
            
            // c. Dữ liệu hoạt động gần đây
            List<User> recentUsers = userDAO.getRecentUsers(5);
            List<Property> recentProperties = propertyDAO.getRecentProperties(5);
            List<Payment> recentPayments = paymentDAO.getRecentPayments(10);
            
            // d. Hỗ trợ & phản hồi
            int supportTickets = supportDAO.getOpenTicketsCount();
            int totalReviews = reviewDAO.getTotalReviewsCount();
            double averageRating = reviewDAO.getAverageRating();
            
            // Set attributes cho thống kê nhanh
            request.setAttribute("totalProperties", totalProperties);
            request.setAttribute("rentedProperties", rentedProperties);
            request.setAttribute("availableProperties", availableProperties);
            request.setAttribute("rentedPercentage", String.format("%.1f", rentedPercentage));
            request.setAttribute("availablePercentage", String.format("%.1f", availablePercentage));
            
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("quarterlyRevenue", quarterlyRevenue);
            request.setAttribute("yearlyRevenue", yearlyRevenue);
            request.setAttribute("totalRevenue", totalRevenue);
            
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("activeLandlords", activeLandlords);
            request.setAttribute("activeRenters", activeRenters);
            request.setAttribute("totalActiveUsers", totalActiveUsers);
            
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("activeBookings", activeBookings);
            request.setAttribute("expiringBookings", expiringBookings);
            request.setAttribute("confirmedBookings", confirmedBookings);
            request.setAttribute("pendingBookings", pendingBookings);
            request.setAttribute("cancelledBookings", cancelledBookings);
            
            // Set attributes cho biểu đồ
            request.setAttribute("monthlyRevenueChart", monthlyRevenueChart);
            request.setAttribute("monthLabels", monthLabels);
            request.setAttribute("newRentersChart", newRentersChart);
            
            // Set attributes cho hoạt động gần đây
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("recentProperties", recentProperties);
            request.setAttribute("recentPayments", recentPayments);
            
            // Set attributes cho hỗ trợ & phản hồi
            request.setAttribute("supportTickets", supportTickets);
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("averageRating", String.format("%.1f", averageRating));
            
            request.getRequestDispatcher("/view/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
}
