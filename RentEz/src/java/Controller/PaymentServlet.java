package Controller;

import DAO.BillDAO;
import DAO.BillDetailDAO;
import DAO.FeeCategoryDAO;
import DAO.PaymentDAO;
import DAO.PropertyDAO;
import DAO.UsersDao;
import DAO.WalletDAO;
import DAO.WalletTransferDao;
import Model.Bill;
import Model.BillDetail;
import Model.FeeCategory;
import Model.Payment;
import Model.Property;
import Model.User;
import Model.Wallet;
import Model.WalletTransfer;
import Util.Common;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Haipro
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/payments", "/payment-action"})
public class PaymentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            // Default action - show payment dashboard
            loadPaymentDashboard(request, response, currentUser);
        } else {
            switch (action) {
                case "bill-details":
                    loadBillDetails(request, response, currentUser);
                    break;
                case "payment-history":
                    loadPaymentHistory(request, response, currentUser);
                    break;
                case "wallet-info":
                    loadWalletInfo(request, response, currentUser);
                    break;
                default:
                    loadPaymentDashboard(request, response, currentUser);
                    break;
            }
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "pay-bill":
                    processBillPayment(request, response, currentUser);
                    break;
                case "add-funds":
                    processAddFunds(request, response, currentUser);
                    break;
                case "withdraw-funds":
                    processWithdrawFunds(request, response, currentUser);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/payments");
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/payments");
        }
    }

    /**
     * Load the main payment dashboard with overview information
     */
    private void loadPaymentDashboard(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {

        try {
            // Initialize DAOs
            BillDAO billDAO = new BillDAO();
            PaymentDAO paymentDAO = new PaymentDAO();
            WalletDAO walletDAO = new WalletDAO();
            PropertyDAO propertyDAO = new PropertyDAO();
            FeeCategory feeCategory = new FeeCategory();
            BillDetailDAO billDetailDAO = new BillDetailDAO();
            FeeCategoryDAO feeCategoryDAO = new FeeCategoryDAO();

            // Get user's wallet
            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());

            // Get bills based on user role
            List<Bill> bills = new ArrayList<>();
            List<Payment> recentPayments = new ArrayList<>();

            if ("Renter".equals(currentUser.getRole())) {
                // For renters - get their bills
                bills = billDAO.getBillsByRenterId(currentUser.getUserId());
                recentPayments = paymentDAO.getPaymentsByPayerId(currentUser.getUserId());
            } else if ("Landlord".equals(currentUser.getRole())) {
                // For landlords - get bills for their properties
                bills = billDAO.getBillsForLandlord(currentUser.getUserId());
                recentPayments = paymentDAO.getPaymentsByPayeeId(currentUser.getUserId());
            }

            // Separate paid and unpaid bills
            List<Bill> unpaidBills = new ArrayList<>();
            List<Bill> paidBills = new ArrayList<>();

            for (Bill bill : bills) {
                if ("Pending".equals(bill.getStatus())) {
                    unpaidBills.add(bill);
                } else {
                    paidBills.add(bill);
                }
            }

            // Calculate totals
            Double totalUnpaid = 0.0;
            for (Bill bill : unpaidBills) {
                totalUnpaid += bill.getTotalAmount();
            }

            // Get bill details for unpaid bills (for display)
            for (Bill bill : unpaidBills) {
                List<BillDetail> billDetails = billDetailDAO.getBillDetailByBillId(bill.getBillId());
                for (BillDetail detail : billDetails) {
                    FeeCategory category = feeCategoryDAO.getById(detail.getCategoryId());
                    detail.setFeeCategory(category);
                }
                bill.setBillDetails(billDetails);

                // Get property info for bill
                Property property = propertyDAO.getById(bill.getPropertyId());
                bill.setProperty(property);
            }

            // Get bill details for paid bills
            for (Bill bill : paidBills) {
                Property property = propertyDAO.getById(bill.getPropertyId());
                bill.setProperty(property);
            }

            // Set attributes for JSP
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("userWallet", userWallet);
            request.setAttribute("unpaidBills", unpaidBills);
            request.setAttribute("paidBills", paidBills);
            request.setAttribute("recentPayments", recentPayments);
            request.setAttribute("totalUnpaid", totalUnpaid);

            // Forward to JSP
            request.getRequestDispatcher("/view/common/view-payments.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải thông tin thanh toán: " + e.getMessage());
            request.getRequestDispatcher("/view/common/view-payments.jsp").forward(request, response);
        }
    }

    /**
     * Load detailed information for a specific bill
     */
    private void loadBillDetails(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {

        String billIdParam = request.getParameter("billId");

        if (billIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Thiếu thông tin hóa đơn", "UTF-8"));
            return;
        }

        try {
            int billId = Integer.parseInt(billIdParam);

            BillDAO billDAO = new BillDAO();
            BillDetailDAO billDetailDAO = new BillDetailDAO();
            FeeCategoryDAO feeCategoryDAO = new FeeCategoryDAO();
            PropertyDAO propertyDAO = new PropertyDAO();
            UsersDao userDAO = new UsersDao();

            Bill bill = billDAO.getById(billId);

            if (bill == null) {
                response.sendRedirect(request.getContextPath() + "/payments?error="
                        + URLEncoder.encode("Không tìm thấy hóa đơn", "UTF-8"));
                return;
            }

            // Check authorization
            if ("Renter".equals(currentUser.getRole()) && bill.getRenterId() != currentUser.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/payments?error="
                        + URLEncoder.encode("Bạn không có quyền xem hóa đơn này", "UTF-8"));
                return;
            }

            // Get bill details
            List<BillDetail> billDetails = billDetailDAO.getBillDetailByBillId(billId);
            for (BillDetail detail : billDetails) {
                FeeCategory category = feeCategoryDAO.getById(detail.getCategoryId());
                detail.setFeeCategory(category);
            }

            // Get property and landlord info
            Property property = propertyDAO.getById(bill.getPropertyId());
            User landlord = null;
            User renter = userDAO.getById(bill.getRenterId());

            if (property != null) {
                landlord = userDAO.getById(property.getLandlordId());
            }

            bill.setBillDetails(billDetails);
            bill.setProperty(property);

            request.setAttribute("bill", bill);
            request.setAttribute("landlord", landlord);
            request.setAttribute("renter", renter);
            request.setAttribute("currentUser", currentUser);

            request.getRequestDispatcher("/view/common/bill-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("ID hóa đơn không hợp lệ", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Lỗi khi tải chi tiết hóa đơn", "UTF-8"));
        }
    }

    /**
     * Load payment history for the current user
     */
    private void loadPaymentHistory(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {

        try {
            PaymentDAO paymentDAO = new PaymentDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();

            List<Payment> payments = new ArrayList<>();
            List<WalletTransfer> walletTransfers = walletTransferDAO.getTransfersByUserId(currentUser.getUserId());

            if ("Renter".equals(currentUser.getRole())) {
                payments = paymentDAO.getPaymentsByPayerId(currentUser.getUserId());
            } else if ("Landlord".equals(currentUser.getRole())) {
                payments = paymentDAO.getPaymentsByPayeeId(currentUser.getUserId());
            }

            request.setAttribute("payments", payments);
            request.setAttribute("walletTransfers", walletTransfers);
            request.setAttribute("currentUser", currentUser);

            request.getRequestDispatcher("/view/common/payment-history.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Lỗi khi tải lịch sử thanh toán", "UTF-8"));
        }
    }

    /**
     * Load wallet information
     */
    private void loadWalletInfo(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {

        try {
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();

            Wallet wallet = walletDAO.getWalletByUserId(currentUser.getUserId());
            List<WalletTransfer> recentTransfers = walletTransferDAO.getRecentTransfersByUserId(currentUser.getUserId(), 10);

            request.setAttribute("wallet", wallet);
            request.setAttribute("recentTransfers", recentTransfers);
            request.setAttribute("currentUser", currentUser);

            request.getRequestDispatcher("/view/common/wallet-info.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Lỗi khi tải thông tin ví", "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>    

    private void processBillPayment(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(request.getParameter("billId"));
            String paymentMethod = request.getParameter("paymentMethod");

            // Initialize DAOs
            BillDAO billDAO = new BillDAO();
            PaymentDAO paymentDAO = new PaymentDAO();
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();
            PropertyDAO propertyDAO = new PropertyDAO();
            UsersDao userDAO = new UsersDao();

            // Get data
            Bill bill = billDAO.getById(billId);
            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());
            Property property = propertyDAO.getById(bill.getPropertyId());
            User landlord = userDAO.getById(property.getLandlordId());
            Wallet landlordWallet = walletDAO.getWalletByUserId(landlord.getUserId());
            
            // Create wallet transfer records
            WalletTransfer renterTransfer = new WalletTransfer();
            renterTransfer.setAmount(-bill.getTotalAmount()); // Negative for outgoing
            renterTransfer.setUserID(currentUser.getUserId());
            renterTransfer.setIsRefunded(false);
            renterTransfer.setTimeCode(Common.generateTimeCode(3));
            renterTransfer.setTransCode("Thanh toán hóa đơn #" + billId);
            walletTransferDAO.create(renterTransfer);

            WalletTransfer landlordTransfer = new WalletTransfer();
            landlordTransfer.setAmount(bill.getTotalAmount()); // Positive for incoming
            landlordTransfer.setTransCode("Nhận thanh toán hóa đơn #" + billId);
            landlordTransfer.setUserID(landlord.getUserId());
            landlordTransfer.setTimeCode(Common.generateTimeCode(3));
            renterTransfer.setIsRefunded(false);
            walletTransferDAO.create(landlordTransfer);
            
            // Create payment record
            Payment payment = new Payment();
            payment.setReferenceId(billId);
            payment.setPayerId(currentUser.getUserId());
            payment.setPayeeId(landlord.getUserId());
            payment.setAmount(bill.getTotalAmount());
            payment.setPaymentMethod(paymentMethod);
            payment.setStatus("Completed");
            payment.setPaymentDate(new Date());
            payment.setReferenceType("Bill");
            payment.setTransCode("PAY" + billId);
            payment.setWalletTransferId(walletTransferDAO.getLastTransfersByUserId(currentUser.getUserId()).getWalletTransferID());
            payment.setTimeCode(Common.generateTimeCode(3));
            paymentDAO.create(payment);

            // Update wallet balances
            userWallet.setBalance(userWallet.getBalance() - bill.getTotalAmount());
            landlordWallet.setBalance(landlordWallet.getBalance() + bill.getTotalAmount());
            walletDAO.update(userWallet);
            walletDAO.update(landlordWallet);

            

            // Update bill status
            bill.setStatus("Paid");
            billDAO.update(bill);

            response.sendRedirect(request.getContextPath() + "/payments?success="
                    + URLEncoder.encode("Thanh toán thành công!", "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Lỗi thanh toán: " + e.getMessage(), "UTF-8"));
        }
    }

    private void processAddFunds(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            Double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentMethod = request.getParameter("paymentMethod");
            String description = request.getParameter("description");

            // Initialize DAOs
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();
            PaymentDAO paymentDAO = new PaymentDAO();

            // Get user's wallet
            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());

            // Create wallet transfer record
            WalletTransfer transfer = new WalletTransfer();
            transfer.setAmount(amount);
            transfer.setUserID(currentUser.getUserId());
            transfer.setIsRefunded(false);
            transfer.setTimeCode(Common.generateTimeCode(3));
            transfer.setTransCode("Deposit");
            walletTransferDAO.create(transfer);

            // Create payment record
            Payment fundPayment = new Payment();
            fundPayment.setPayerId(currentUser.getUserId());
            fundPayment.setPayeeId(3); // System account
            fundPayment.setAmount(amount);
            fundPayment.setPaymentMethod(paymentMethod);
            fundPayment.setStatus("Completed");
            fundPayment.setPaymentDate(new Date());
            fundPayment.setReferenceType("Wallet");
            fundPayment.setReferenceId(1);
            fundPayment.setTransCode("Deposit");
            fundPayment.setWalletTransferId(walletTransferDAO.getLastTransfersByUserId(currentUser.getUserId()).getWalletTransferID());
            fundPayment.setTimeCode(Common.generateTimeCode(3));
            paymentDAO.create(fundPayment);

            // Update wallet balance
            userWallet.setBalance(userWallet.getBalance() + amount);
            walletDAO.update(userWallet);

            response.sendRedirect(request.getContextPath() + "/payments?success="
                    + URLEncoder.encode("Nạp tiền thành công!", "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Lỗi nạp tiền: " + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * Process withdrawal from wallet to bank account
     */
    private void processWithdrawFunds(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            Double amount = Double.parseDouble(request.getParameter("amount"));
            String bankAccount = request.getParameter("bankAccount");
            String bankName = request.getParameter("bankName");
            String description = request.getParameter("description");

            // Initialize DAOs
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();
            PaymentDAO paymentDAO = new PaymentDAO();

            // Get user's wallet
            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());

            // Check if user has sufficient balance
            if (userWallet.getBalance() < amount) {
                response.sendRedirect(request.getContextPath() + "/payments?error="
                        + URLEncoder.encode("Số dư không đủ để thực hiện giao dịch!", "UTF-8"));
                return;
            }

            // Create wallet transfer record for withdrawal
            WalletTransfer transfer = new WalletTransfer();
            transfer.setAmount(amount);
            transfer.setUserID(currentUser.getUserId());
            transfer.setIsRefunded(false);
            transfer.setTimeCode(Common.generateTimeCode(3));
            transfer.setTransCode("Withdrawal");
            walletTransferDAO.create(transfer);

            // Create payment record for withdrawal
            Payment withdrawalPayment = new Payment();
            withdrawalPayment.setPayerId(currentUser.getUserId()); // System account as payer
            withdrawalPayment.setPayeeId(3); // User as payee
            withdrawalPayment.setAmount(-amount);
            withdrawalPayment.setStatus("Pending");
            withdrawalPayment.setPaymentDate(new Date());
            withdrawalPayment.setReferenceType("Wallet");
            withdrawalPayment.setReferenceId(1);
            withdrawalPayment.setTransCode("Withdrawal");
            withdrawalPayment.setWalletTransferId(walletTransferDAO.getLastTransfersByUserId(currentUser.getUserId()).getWalletTransferID());
            withdrawalPayment.setTimeCode(Common.generateTimeCode(3));

            // Add bank details to description
            String fullDescription = "Rút tiền về tài khoản: " + bankAccount + " - " + bankName;
            if (description != null && !description.trim().isEmpty()) {
                fullDescription += " - " + description;
            }
            withdrawalPayment.setPaymentMethod(fullDescription);

            paymentDAO.create(withdrawalPayment);

            // Update wallet balance (deduct the withdrawal amount)
            userWallet.setBalance(userWallet.getBalance() - amount);
            walletDAO.update(userWallet);

            response.sendRedirect(request.getContextPath() + "/payments?success="
                    + URLEncoder.encode("Yêu cầu rút tiền đã được gửi! Số tiền sẽ được chuyển về tài khoản "
                            + bankAccount + " trong 1-3 ngày làm việc.", "UTF-8"));

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Số tiền không hợp lệ!", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/payments?error="
                    + URLEncoder.encode("Lỗi rút tiền: " + e.getMessage(), "UTF-8"));
        }
    }

}
