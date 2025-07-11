package Controller;

import DAO.TierDAO;
import DAO.UserTierDAO;
import DAO.PaymentDAO;
import DAO.WalletDAO;
import DAO.WalletTransferDao;
import Model.Tier;
import Model.UserTier;
import Model.User;
import Model.Payment;
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
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Servlet for handling tier membership management and purchases
 */
@WebServlet(name = "TierMembershipServlet", urlPatterns = {"/membership", "/membership-action"})
public class TierMembershipServlet extends HttpServlet {

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
        
        if ("history".equals(action)) {
            loadMembershipHistory(request, response, currentUser);
        } else {
            loadMembershipDashboard(request, response, currentUser);
        }
    }

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
                case "purchase":
                    purchaseTierMembership(request, response, currentUser);
                    break;
                case "upgrade":
                    upgradeTierMembership(request, response, currentUser);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/membership");
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/membership");
        }
    }

    /**
     * Load the membership dashboard with available tiers and current membership
     */
    private void loadMembershipDashboard(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            TierDAO tierDAO = new TierDAO();
            UserTierDAO userTierDAO = new UserTierDAO();
            WalletDAO walletDAO = new WalletDAO();

            // Get available tiers
            List<Tier> availableTiers = tierDAO.getAvailableTiers();
            
            // Get user's current tier
            UserTier currentUserTier = userTierDAO.getCurrentUserTier(currentUser.getUserId());
            Tier currentTier = null;
            if (currentUserTier != null) {
                currentTier = tierDAO.getById(currentUserTier.getTierId());
            }

            // Get user's wallet
            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());

            // Set attributes
            request.setAttribute("availableTiers", availableTiers);
            request.setAttribute("currentUserTier", currentUserTier);
            request.setAttribute("currentTier", currentTier);
            request.setAttribute("userWallet", userWallet);
            request.setAttribute("currentUser", currentUser);

            // Forward to membership dashboard page
            request.getRequestDispatcher("/view/common/membership-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/membership?error="
                    + URLEncoder.encode("Lỗi tải trang: " + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * Load membership history
     */
    private void loadMembershipHistory(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            UserTierDAO userTierDAO = new UserTierDAO();
            TierDAO tierDAO = new TierDAO();
            PaymentDAO paymentDAO = new PaymentDAO();

            // Get user's tier history
            List<UserTier> tierHistory = userTierDAO.getUserTierHistory(currentUser.getUserId());
            
            // Get tier membership payments
            List<Payment> tierPayments = paymentDAO.getPaymentsByPayerId(currentUser.getUserId());
            // Filter only tier-related payments
            tierPayments.removeIf(payment -> !"Tier".equals(payment.getReferenceType()));

            // Set attributes
            request.setAttribute("tierHistory", tierHistory);
            request.setAttribute("tierPayments", tierPayments);
            request.setAttribute("currentUser", currentUser);

            // Forward to membership history page
            request.getRequestDispatcher("/view/common/membership-history.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/membership?error="
                    + URLEncoder.encode("Lỗi tải lịch sử: " + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * Purchase a new tier membership
     */
    private void purchaseTierMembership(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("tierId"));
            String paymentMethod = request.getParameter("paymentMethod");
            int durationMonths = Integer.parseInt(request.getParameter("duration"));

            // Initialize DAOs
            TierDAO tierDAO = new TierDAO();
            UserTierDAO userTierDAO = new UserTierDAO();
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();
            PaymentDAO paymentDAO = new PaymentDAO();

            // Get tier information
            Tier tier = tierDAO.getById(tierId);
            if (tier == null) {
                response.sendRedirect(request.getContextPath() + "/membership?error="
                        + URLEncoder.encode("Gói thành viên không tồn tại!", "UTF-8"));
                return;
            }

            // Calculate total price
            double totalPrice = tier.getPrice() * durationMonths;

            // Check if user has sufficient balance for wallet payment
            if ("wallet".equals(paymentMethod)) {
                Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());
                if (userWallet == null || userWallet.getBalance() < totalPrice) {
                    response.sendRedirect(request.getContextPath() + "/membership?error="
                            + URLEncoder.encode("Số dư ví không đủ để mua gói thành viên!", "UTF-8"));
                    return;
                }

                // Process wallet payment
                processWalletPayment(currentUser, tier, totalPrice, durationMonths, userWallet, 
                                   walletDAO, walletTransferDAO, paymentDAO, userTierDAO);
            } else {
                // Handle other payment methods (bank transfer, etc.)
                response.sendRedirect(request.getContextPath() + "/membership?error="
                        + URLEncoder.encode("Phương thức thanh toán chưa được hỗ trợ!", "UTF-8"));
                return;
            }

            response.sendRedirect(request.getContextPath() + "/membership?success="
                    + URLEncoder.encode("Mua gói thành viên thành công!", "UTF-8"));

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/membership?error="
                    + URLEncoder.encode("Thông tin không hợp lệ!", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/membership?error="
                    + URLEncoder.encode("Lỗi mua gói thành viên: " + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * Upgrade current tier membership
     */
    private void upgradeTierMembership(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            int newTierId = Integer.parseInt(request.getParameter("tierId"));
            String paymentMethod = request.getParameter("paymentMethod");

            // Initialize DAOs
            TierDAO tierDAO = new TierDAO();
            UserTierDAO userTierDAO = new UserTierDAO();
            WalletDAO walletDAO = new WalletDAO();
            WalletTransferDao walletTransferDAO = new WalletTransferDao();
            PaymentDAO paymentDAO = new PaymentDAO();

            // Get current tier
            UserTier currentUserTier = userTierDAO.getCurrentUserTier(currentUser.getUserId());
            if (currentUserTier == null) {
                response.sendRedirect(request.getContextPath() + "/membership?error="
                        + URLEncoder.encode("Bạn chưa có gói thành viên nào!", "UTF-8"));
                return;
            }

            Tier currentTier = tierDAO.getById(currentUserTier.getTierId());
            Tier newTier = tierDAO.getById(newTierId);

            if (newTier == null) {
                response.sendRedirect(request.getContextPath() + "/membership?error="
                        + URLEncoder.encode("Gói thành viên không tồn tại!", "UTF-8"));
                return;
            }

            // Check if new tier is better than current tier
            if (newTier.getPriorityLevel() >= currentTier.getPriorityLevel()) {
                response.sendRedirect(request.getContextPath() + "/membership?error="
                        + URLEncoder.encode("Chỉ có thể nâng cấp lên gói cao hơn!", "UTF-8"));
                return;
            }

            // Calculate remaining days and upgrade price
            long remainingDays = (currentUserTier.getEndDate().getTime() - new Date().getTime()) / (24 * 60 * 60 * 1000);
            double priceDifference = newTier.getPrice() - currentTier.getPrice();
            double upgradePrice = (priceDifference * remainingDays) / 30; // Pro-rated pricing

            // Process wallet payment for upgrade
            if ("wallet".equals(paymentMethod)) {
                Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());
                if (userWallet == null || userWallet.getBalance() < upgradePrice) {
                    response.sendRedirect(request.getContextPath() + "/membership?error="
                            + URLEncoder.encode("Số dư ví không đủ để nâng cấp!", "UTF-8"));
                    return;
                }

                // Expire current tier and create new one
                userTierDAO.expireOldTiers(currentUser.getUserId());
                
                // Create new tier with same end date
                UserTier newUserTier = new UserTier();
                newUserTier.setUserId(currentUser.getUserId());
                newUserTier.setTierId(newTierId);
                newUserTier.setStartDate(new Date());
                newUserTier.setEndDate(currentUserTier.getEndDate());
                newUserTier.setStatus("Active");
                userTierDAO.create(newUserTier);

                // Process payment
                processWalletPaymentForUpgrade(currentUser, newTier, upgradePrice, userWallet, 
                                             walletDAO, walletTransferDAO, paymentDAO, newUserTier.getUserTierId());
            }

            response.sendRedirect(request.getContextPath() + "/membership?success="
                    + URLEncoder.encode("Nâng cấp gói thành viên thành công!", "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/membership?error="
                    + URLEncoder.encode("Lỗi nâng cấp: " + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * Process wallet payment for tier membership
     */
    private void processWalletPayment(User currentUser, Tier tier, double totalPrice, int durationMonths,
                                    Wallet userWallet, WalletDAO walletDAO, WalletTransferDao walletTransferDAO,
                                    PaymentDAO paymentDAO, UserTierDAO userTierDAO) throws Exception {
        
        // Create wallet transfer record for payment
        WalletTransfer transfer = new WalletTransfer();
        transfer.setAmount(-totalPrice); // Negative for outgoing payment
        transfer.setUserID(currentUser.getUserId());
        transfer.setIsRefunded(false);
        transfer.setTimeCode(Common.generateTimeCode(3));
        transfer.setTransCode("Mua gói " + tier.getTierName() + " - " + durationMonths + " tháng");
        walletTransferDAO.create(transfer);

        // Create payment record
        Payment payment = new Payment();
        payment.setPayerId(currentUser.getUserId());
        payment.setPayeeId(1); // System account
        payment.setAmount(totalPrice);
        payment.setPaymentMethod("wallet");
        payment.setStatus("Completed");
        payment.setPaymentDate(new Date());
        payment.setReferenceType("Tier");
        payment.setReferenceId(tier.getTierId());
        payment.setTransCode("TIER" + tier.getTierId());
        payment.setWalletTransferId(transfer.getWalletTransferID());
        payment.setTimeCode(Common.generateTimeCode(3));
        payment.setIsRefunded(false);
        paymentDAO.create(payment);

        // Update wallet balance
        userWallet.setBalance(userWallet.getBalance() - totalPrice);
        userWallet.setLastUpdated(new Date());
        walletDAO.update(userWallet);

        // Expire old tiers and create new tier
        userTierDAO.expireOldTiers(currentUser.getUserId());

        // Calculate end date
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.MONTH, durationMonths);

        UserTier newUserTier = new UserTier();
        newUserTier.setUserId(currentUser.getUserId());
        newUserTier.setTierId(tier.getTierId());
        newUserTier.setStartDate(new Date());
        newUserTier.setEndDate(calendar.getTime());
        newUserTier.setStatus("Active");
        userTierDAO.create(newUserTier);
    }

    /**
     * Process wallet payment for tier upgrade
     */
    private void processWalletPaymentForUpgrade(User currentUser, Tier newTier, double upgradePrice,
                                              Wallet userWallet, WalletDAO walletDAO, WalletTransferDao walletTransferDAO,
                                              PaymentDAO paymentDAO, int newUserTierId) throws Exception {
        
        // Create wallet transfer record for upgrade payment
        WalletTransfer transfer = new WalletTransfer();
        transfer.setAmount(-upgradePrice); // Negative for outgoing payment
        transfer.setUserID(currentUser.getUserId());
        transfer.setIsRefunded(false);
        transfer.setTimeCode(Common.generateTimeCode(3));
        transfer.setTransCode("Nâng cấp lên gói " + newTier.getTierName());
        walletTransferDAO.create(transfer);

        // Create payment record
        Payment payment = new Payment();
        payment.setPayerId(currentUser.getUserId());
        payment.setPayeeId(1); // System account
        payment.setAmount(upgradePrice);
        payment.setPaymentMethod("wallet");
        payment.setStatus("Completed");
        payment.setPaymentDate(new Date());
        payment.setReferenceType("Tier");
        payment.setReferenceId(newUserTierId);
        payment.setTransCode("UPGRADE" + newTier.getTierId());
        payment.setWalletTransferId(transfer.getWalletTransferID());
        payment.setTimeCode(Common.generateTimeCode(3));
        payment.setIsRefunded(false);
        paymentDAO.create(payment);

        // Update wallet balance
        userWallet.setBalance(userWallet.getBalance() - upgradePrice);
        userWallet.setLastUpdated(new Date());
        walletDAO.update(userWallet);
    }

    @Override
    public String getServletInfo() {
        return "Tier Membership Management Servlet";
    }
}
