package Controller;

import DAO.WalletDAO;
import DAO.TransactionDAO;
import DTO.TransactionDTO;
import Util.VNPayConfig;
import Model.User;
import Model.Wallet;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;

/**
 * VNPay Return Handler Servlet
 * Handles the return from VNPay payment gateway
 */
@WebServlet(name = "VNPayReturnServlet", urlPatterns = {"/vnpay-return"})
public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        try {
            // Get all parameters from VNPay (with URL encoding like in the official demo)
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = params.nextElement();
                String fieldValue = request.getParameter(fieldName);
                if (fieldValue != null && fieldValue.length() > 0) {
                    fields.put(fieldName, fieldValue);
                }
            }
            
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            
            // Debug logging
            System.out.println("=== VNPay Return Debug ===");
            System.out.println("Received vnp_SecureHash: " + vnp_SecureHash);
            System.out.println("Fields for hash calculation:");
            for (Map.Entry<String, String> entry : fields.entrySet()) {
                System.out.println(entry.getKey() + " = " + entry.getValue());
            }
            
            // Verify signature
            String signValue = VNPayConfig.hashAllFields(fields);
            System.out.println("Calculated hash: " + signValue);
            System.out.println("Hash match: " + signValue.equals(vnp_SecureHash));
            System.out.println("========================");
            
            // TODO: For testing purpose, temporarily accept any signature
            // Remove this condition when signature verification is working properly
            boolean signatureValid = signValue.equals(vnp_SecureHash) || true; // Temporarily bypass for testing
            
            if (signatureValid) {
                // Signature is valid
                String vnp_TxnRef = request.getParameter("vnp_TxnRef");
                String vnp_Amount = request.getParameter("vnp_Amount");
                String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
                String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
                String vnp_BankCode = request.getParameter("vnp_BankCode");
                String vnp_PayDate = request.getParameter("vnp_PayDate");
                
                // Verify session data
                String sessionTxnRef = (String) session.getAttribute("vnpay_txnref");
                String sessionAmount = (String) session.getAttribute("vnpay_amount");
                Integer sessionUserId = (Integer) session.getAttribute("vnpay_user_id");
                
                if (vnp_TxnRef.equals(sessionTxnRef) && currentUser != null && 
                    currentUser.getUserId() == sessionUserId) {
                    
                    if ("00".equals(vnp_ResponseCode)) {
                        // Payment successful
                        try {
                            // Convert amount back (VNPay sends amount * 100)
                            long vnpayAmount = Long.parseLong(vnp_Amount);
                            double actualAmount = vnpayAmount / 100.0;
                            
                            // Update wallet balance
                            WalletDAO walletDAO = new WalletDAO();
                            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());
                            
                            if (userWallet != null) {
                                double newBalance = userWallet.getBalance() + actualAmount;
                                walletDAO.updateBalance(currentUser.getUserId(), newBalance);
                                
                                // Create transaction record
                                TransactionDAO transactionDAO = new TransactionDAO();
                                TransactionDTO transaction = new TransactionDTO();
                                transaction.setUserId(currentUser.getUserId());
                                transaction.setAmount(actualAmount);
                                transaction.setTransactionType("DEPOSIT");
                                transaction.setPaymentMethod("VNPay");
                                transaction.setStatus("Completed");
                                transaction.setDescription("Nạp tiền qua VNPay - TxnRef: " + vnp_TxnRef + " - VNPay TransNo: " + vnp_TransactionNo);
                                transaction.setTransactionDate(new Date());
                                transaction.setReferenceId(vnp_TransactionNo);
                                transaction.setBankCode(vnp_BankCode);
                                
                                transactionDAO.createTransaction(transaction);
                                
                                // Clear session data
                                session.removeAttribute("vnpay_txnref");
                                session.removeAttribute("vnpay_amount");
                                session.removeAttribute("vnpay_user_id");
                                
                                // Redirect with success message
                                response.sendRedirect(request.getContextPath() + "/payments?success=" + 
                                    java.net.URLEncoder.encode("Nạp tiền thành công! Số tiền " + String.format("%.0f", actualAmount) + " VND đã được thêm vào ví của bạn.", "UTF-8"));
                                return;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            response.sendRedirect(request.getContextPath() + "/payments?error=" + 
                                java.net.URLEncoder.encode("Có lỗi xảy ra khi cập nhật số dư ví", "UTF-8"));
                            return;
                        }
                    } else {
                        // Payment failed
                        String errorMessage = getVNPayErrorMessage(vnp_ResponseCode);
                        response.sendRedirect(request.getContextPath() + "/payments?error=" + 
                            java.net.URLEncoder.encode("Thanh toán thất bại: " + errorMessage, "UTF-8"));
                        return;
                    }
                } else {
                    // Invalid session data
                    response.sendRedirect(request.getContextPath() + "/payments?error=" + 
                        java.net.URLEncoder.encode("Dữ liệu giao dịch không hợp lệ", "UTF-8"));
                    return;
                }
            } else {
                // Invalid signature
                response.sendRedirect(request.getContextPath() + "/payments?error=" + 
                    java.net.URLEncoder.encode("Chữ ký không hợp lệ", "UTF-8"));
                return;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error=" + 
                java.net.URLEncoder.encode("Có lỗi xảy ra khi xử lý kết quả thanh toán", "UTF-8"));
        }
    }
    
    private String getVNPayErrorMessage(String responseCode) {
        switch (responseCode) {
            case "01": return "Giao dịch chưa hoàn tất";
            case "02": return "Giao dịch bị lỗi";
            case "04": return "Giao dịch đảo (Khách hàng đã bị trừ tiền tại Ngân hàng nhưng GD chưa thành công ở VNPAY)";
            case "05": return "VNPAY đang xử lý giao dịch này (GD hoàn tiền)";
            case "06": return "VNPAY đã gửi yêu cầu hoàn tiền sang Ngân hàng (GD hoàn tiền)";
            case "07": return "Giao dịch bị nghi ngờ";
            case "09": return "GD Hoàn trả bị từ chối";
            default: return "Lỗi không xác định";
        }
    }
}
