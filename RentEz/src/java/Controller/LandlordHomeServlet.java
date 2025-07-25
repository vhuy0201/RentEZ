package Controller;

import DAO.WalletDAO;
import DAO.PaymentDAO;
import DAO.PropertyDAO;
import Model.User;
import Model.Wallet;
import Model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LandlordHomeServlet", urlPatterns = {"/landLordHomeServlet"})
public class LandlordHomeServlet extends HttpServlet {

    private PaymentDAO paymentDAO;
    private PropertyDAO propertyDAO;
    
    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
        propertyDAO = new PropertyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Kiểm tra xem user có phải là landlord không
        User user = (User) session.getAttribute("user");
        if (!"landlord".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Lấy thông tin wallet của user
            WalletDAO walletDAO = new WalletDAO();
            Wallet userWallet = walletDAO.getWalletByUserId(user.getUserId());
            
            // Nếu chưa có wallet, tạo wallet mới với số dư 0
            if (userWallet == null) {
                userWallet = new Wallet();
                userWallet.setUserId(user.getUserId());
                userWallet.setBalance(0.0);
                userWallet.setLastUpdated(new java.util.Date());
                walletDAO.create(userWallet);
            }
            
            // =============== THỐNG KÊ DOANH THU ===============
            int landlordId = user.getUserId();
            
            // Thống kê doanh thu theo thời gian
            double totalRevenue = paymentDAO.getTotalRevenueByLandlord(landlordId);
            double monthlyRevenue = paymentDAO.getMonthlyRevenueByLandlord(landlordId);
            double quarterlyRevenue = paymentDAO.getQuarterlyRevenueByLandlord(landlordId);
            double yearlyRevenue = paymentDAO.getYearlyRevenueByLandlord(landlordId);
            
            // Thống kê giao dịch
            int totalTransactions = paymentDAO.getTotalTransactionsByLandlord(landlordId);
            int completedTransactions = paymentDAO.getCompletedTransactionsByLandlord(landlordId);
            int pendingTransactions = paymentDAO.getPendingTransactionsByLandlord(landlordId);
            double averageTransaction = paymentDAO.getAverageTransactionByLandlord(landlordId);
            
            // Dữ liệu cho biểu đồ (12 tháng gần nhất)
            List<Double> monthlyRevenueChart = paymentDAO.getMonthlyRevenueStatsByLandlord(landlordId, 12);
            List<String> monthLabels = paymentDAO.getMonthLabels(12);
            
            // Giao dịch gần đây
            List<Payment> recentPayments = paymentDAO.getRecentPaymentsByLandlord(landlordId, 10);
            
            // Thống kê tài sản (nếu có PropertyDAO)
            int totalProperties = 0;
            int activeProperties = 0;
            try {
                totalProperties = propertyDAO.getPropertiesByLandlordId(landlordId).size();
                // Có thể thêm logic để đếm active properties
                activeProperties = totalProperties; // Tạm thời
            } catch (Exception e) {
                System.out.println("PropertyDAO error: " + e.getMessage());
            }
            
            // Tính toán tỷ lệ phần trăm thay đổi
            double monthlyGrowth = 0.0;
            if (monthlyRevenueChart.size() >= 2) {
                double currentMonth = monthlyRevenueChart.get(monthlyRevenueChart.size() - 1);
                double previousMonth = monthlyRevenueChart.get(monthlyRevenueChart.size() - 2);
                if (previousMonth > 0) {
                    monthlyGrowth = ((currentMonth - previousMonth) / previousMonth) * 100;
                }
            }
            
            // =============== SET ATTRIBUTES ===============
            
            // Wallet info
            request.setAttribute("userWallet", userWallet);
            
            // Revenue statistics
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("quarterlyRevenue", quarterlyRevenue);
            request.setAttribute("yearlyRevenue", yearlyRevenue);
            request.setAttribute("monthlyGrowth", String.format("%.1f", monthlyGrowth));
            
            // Transaction statistics
            request.setAttribute("totalTransactions", totalTransactions);
            request.setAttribute("completedTransactions", completedTransactions);
            request.setAttribute("pendingTransactions", pendingTransactions);
            request.setAttribute("averageTransaction", averageTransaction);
            
            // Chart data
            request.setAttribute("monthlyRevenueChart", monthlyRevenueChart);
            request.setAttribute("monthLabels", monthLabels);
            
            // Recent data
            request.setAttribute("recentPayments", recentPayments);
            
            // Property statistics
            request.setAttribute("totalProperties", totalProperties);
            request.setAttribute("activeProperties", activeProperties);
            
            // Success rate calculation
            double successRate = totalTransactions > 0 ? (double) completedTransactions / totalTransactions * 100 : 0;
            request.setAttribute("successRate", String.format("%.1f", successRate));
            
        } catch (Exception e) {
            e.printStackTrace();
            // Set default values in case of error
            request.setAttribute("totalRevenue", 0.0);
            request.setAttribute("monthlyRevenue", 0.0);
            request.setAttribute("quarterlyRevenue", 0.0);
            request.setAttribute("yearlyRevenue", 0.0);
            request.setAttribute("monthlyGrowth", "0.0");
            request.setAttribute("totalTransactions", 0);
            request.setAttribute("completedTransactions", 0);
            request.setAttribute("pendingTransactions", 0);
            request.setAttribute("averageTransaction", 0.0);
            request.setAttribute("successRate", "0.0");
            request.setAttribute("totalProperties", 0);
            request.setAttribute("activeProperties", 0);
        }
        
        request.getRequestDispatcher("/view/landlord/page/account-dashboard.jsp").forward(request, response);
    }
}
