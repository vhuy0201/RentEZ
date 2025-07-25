package Controller;

import DAO.WalletDAO;
import DAO.WalletTransferDao;
import Model.User;
import Model.Wallet;
import Model.WalletTransfer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "FinancialManagementServlet", urlPatterns = {"/financialManagement"})
public class FinancialManagementServlet extends HttpServlet {

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
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao transferDAO = new WalletTransferDao();
            
            // Get user's wallet
            Wallet wallet = walletDAO.getWalletByUserId(user.getUserId());
            if (wallet == null) {
                // Create wallet if not exists
                wallet = new Wallet();
                wallet.setUserId(user.getUserId());
                wallet.setBalance(0.0);
                wallet.setLastUpdated(new Date());
                walletDAO.insert(wallet);
                wallet = walletDAO.getWalletByUserId(user.getUserId());
            }
            
            // Get transaction history
            List<WalletTransfer> transactions = transferDAO.getTransfersByUserId(user.getUserId());
            
            request.setAttribute("wallet", wallet);
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("/view/landlord/page/financialManagement.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin tài chính.");
            request.getRequestDispatcher("/view/landlord/page/financialManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String amountStr = request.getParameter("amount");
        
        try {
            double amount = Double.parseDouble(amountStr);
            
            if (amount <= 0) {
                request.setAttribute("error", "Số tiền phải lớn hơn 0.");
                doGet(request, response);
                return;
            }
            
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao transferDAO = new WalletTransferDao();
            
            Wallet wallet = walletDAO.getWalletByUserId(user.getUserId());
            
            if ("deposit".equals(action)) {
                // Deposit money
                wallet.setBalance(wallet.getBalance() + amount);
                wallet.setLastUpdated(new Date());
                walletDAO.update(wallet);
                
                // Record transaction
                WalletTransfer transfer = new WalletTransfer();
                transfer.setUserID(user.getUserId());
                transfer.setAmount(amount);
                transfer.setTransCode(generateTransactionCode());
                transfer.setTimeCode(generateTimeCode());
                transfer.setContent("Nạp tiền vào ví");
                transfer.setIsRefunded(false);
                transferDAO.create(transfer);
                
                session.setAttribute("successMessage", "Nạp tiền thành công! Số dư hiện tại: " + String.format("%,.0f", wallet.getBalance()) + " VNĐ");
                
            } else if ("withdraw".equals(action)) {
                // Withdraw money
                if (wallet.getBalance() < amount) {
                    request.setAttribute("error", "Số dư không đủ để thực hiện giao dịch.");
                    doGet(request, response);
                    return;
                }
                
                wallet.setBalance(wallet.getBalance() - amount);
                wallet.setLastUpdated(new Date());
                walletDAO.update(wallet);
                
                // Record transaction
                WalletTransfer transfer = new WalletTransfer();
                transfer.setUserID(user.getUserId());
                transfer.setAmount(-amount); // Negative for withdrawal
                transfer.setTransCode(generateTransactionCode());
                transfer.setTimeCode(generateTimeCode());
                transfer.setContent("Rút tiền từ ví");
                transfer.setIsRefunded(false);
                transferDAO.create(transfer);
                
                session.setAttribute("successMessage", "Rút tiền thành công! Số dư hiện tại: " + String.format("%,.0f", wallet.getBalance()) + " VNĐ");
            }
            
            response.sendRedirect("financialManagement");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số tiền không hợp lệ.");
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi thực hiện giao dịch.");
            doGet(request, response);
        }
    }
    
    private String generateTransactionCode() {
        return "TXN" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    
    private String generateTimeCode() {
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        return now.format(formatter);
    }

    @Override
    public String getServletInfo() {
        return "Financial Management Servlet for wallet operations";
    }
}
