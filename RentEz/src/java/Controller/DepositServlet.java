package Controller;

import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to handle deposit routing
 * Routes deposit requests to appropriate payment method
 */
@WebServlet(name = "DepositServlet", urlPatterns = {"/deposit"})
public class DepositServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.getWriter().write("{\"code\":\"01\",\"message\":\"Vui lòng đăng nhập để thực hiện giao dịch\"}");
            return;
        }
        
        // Get parameters
        String amount = request.getParameter("amount");
        String method = request.getParameter("method");
        
        // Validate amount
        if (amount == null || amount.trim().isEmpty()) {
            response.getWriter().write("{\"code\":\"02\",\"message\":\"Số tiền không hợp lệ\"}");
            return;
        }
        
        try {
            double amountValue = Double.parseDouble(amount);
            if (amountValue < 10000) {
                response.getWriter().write("{\"code\":\"03\",\"message\":\"Số tiền tối thiểu là 10,000 VND\"}");
                return;
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"code\":\"02\",\"message\":\"Số tiền không hợp lệ\"}");
            return;
        }
        
        // Route to appropriate payment method
        if ("vnpay".equals(method)) {
            // Forward to VNPay servlet
            request.getRequestDispatcher("/vnpay-payment").forward(request, response);
        } else if ("momo".equals(method)) {
            // TODO: Implement MoMo payment
            response.getWriter().write("{\"code\":\"04\",\"message\":\"MoMo payment chưa được hỗ trợ\"}");
        } else if ("bank_transfer".equals(method)) {
            // TODO: Implement bank transfer
            response.getWriter().write("{\"code\":\"04\",\"message\":\"Chuyển khoản ngân hàng chưa được hỗ trợ\"}");
        } else if ("credit_card".equals(method)) {
            // TODO: Implement credit card payment
            response.getWriter().write("{\"code\":\"04\",\"message\":\"Thẻ tín dụng chưa được hỗ trợ\"}");
        } else {
            response.getWriter().write("{\"code\":\"05\",\"message\":\"Phương thức thanh toán không hợp lệ\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to POST
        doPost(request, response);
    }
}
