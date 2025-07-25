package Controller;

import DAO.BillDAO;
import DAO.BillDetailDAO;
import DAO.FeeCategoryDAO;
import DAO.PropertyDAO;
import DAO.WalletDAO;
import Model.Bill;
import Model.BillDetail;
import Model.FeeCategory;
import Model.Property;
import Model.User;
import Model.Wallet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling bill details view
 */
@WebServlet(name = "BillDetailsServlet", urlPatterns = {"/bill-details"})
public class BillDetailsServlet extends HttpServlet {

    private BillDAO billDAO;
    private BillDetailDAO billDetailDAO;
    private FeeCategoryDAO feeCategoryDAO;
    private PropertyDAO propertyDAO;
    private WalletDAO walletDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
        billDetailDAO = new BillDetailDAO();
        feeCategoryDAO = new FeeCategoryDAO();
        propertyDAO = new PropertyDAO();
        walletDAO = new WalletDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        
        // Get bill ID from parameter
        String billIdParam = request.getParameter("id");
        if (billIdParam == null || billIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/payments");
            return;
        }

        try {
            int billId = Integer.parseInt(billIdParam);
            
            // Get bill details
            Bill bill = billDAO.getById(billId);
            if (bill == null) {
                request.setAttribute("error", "Không tìm thấy hóa đơn");
                request.getRequestDispatcher("/view/common/error.jsp").forward(request, response);
                return;
            }

            // Check if user has permission to view this bill
            if (!"Admin".equals(currentUser.getRole()) && bill.getRenterId() != currentUser.getUserId()) {
                request.setAttribute("error", "Bạn không có quyền xem hóa đơn này");
                request.getRequestDispatcher("/view/common/error.jsp").forward(request, response);
                return;
            }

            // Get property information
            Property property = propertyDAO.getById(bill.getPropertyId());
            bill.setProperty(property);

            // Get bill details
            List<BillDetail> billDetails = billDetailDAO.getBillDetailByBillId(billId);
            
            // Populate fee category information for each bill detail
            if (billDetails != null && !billDetails.isEmpty()) {
                for (BillDetail detail : billDetails) {
                    FeeCategory category = feeCategoryDAO.getById(detail.getCategoryId());
                    detail.setFeeCategory(category);
                }
                bill.setBillDetails(billDetails);
            }

            // Get user wallet information for payment modal
            Wallet userWallet = walletDAO.getWalletByUserId(currentUser.getUserId());
            
            // Set attributes for JSP
            request.setAttribute("bill", bill);
            request.setAttribute("userWallet", userWallet);
            
            // Forward to bill details page
            request.getRequestDispatcher("/view/common/bill-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/payments");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin hóa đơn");
            request.getRequestDispatcher("/view/common/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Bill Details Servlet";
    }
}
