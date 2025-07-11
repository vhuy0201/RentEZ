package Controller;

import DAO.TierDAO;
import DAO.UserTierDAO;
import Model.Tier;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

/**
 * Admin servlet for managing tier packages and memberships
 */
@WebServlet(name = "AdminTierServlet", urlPatterns = {"/admin/tiers", "/admin/tier-action"})
public class AdminTierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdmin(request, response)) {
            return;
        }

        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            loadEditTierForm(request, response);
        } else if ("view-memberships".equals(action)) {
            loadMembershipsList(request, response);
        } else {
            loadTierManagement(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdmin(request, response)) {
            return;
        }

        String action = request.getParameter("action");
        
        switch (action) {
            case "create":
                createTier(request, response);
                break;
            case "update":
                updateTier(request, response);
                break;
            case "delete":
                deleteTier(request, response);
                break;
            case "expire-memberships":
                expireUserMemberships(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/tiers");
        }
    }

    /**
     * Check if user is admin
     */
    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"Admin".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home?error=" + 
                    URLEncoder.encode("Bạn không có quyền truy cập trang này", "UTF-8"));
            return false;
        }
        return true;
    }

    /**
     * Load tier management dashboard
     */
    private void loadTierManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            TierDAO tierDAO = new TierDAO();
            UserTierDAO userTierDAO = new UserTierDAO();
            
            // Get all tiers
            List<Tier> allTiers = tierDAO.getAllTiers();
            
            // Update expired tiers
            userTierDAO.updateExpiredTiers();
            
            // Get statistics - count active memberships for each tier
            for (Tier tier : allTiers) {
                // This would require a new method in UserTierDAO to count active memberships per tier
                // For now, we'll just set the tier data
            }
            
            request.setAttribute("tiers", allTiers);
            request.setAttribute("pageTitle", "Quản lý gói thành viên");
            
            request.getRequestDispatcher("/view/admin/tier-management.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi tải dữ liệu", "UTF-8"));
        }
    }

    /**
     * Load edit tier form
     */
    private void loadEditTierForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("id"));
            TierDAO tierDAO = new TierDAO();
            
            Tier tier = tierDAO.getById(tierId);
            if (tier == null) {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                        URLEncoder.encode("Không tìm thấy gói thành viên", "UTF-8"));
                return;
            }
            
            request.setAttribute("tier", tier);
            request.setAttribute("pageTitle", "Chỉnh sửa gói thành viên");
            request.setAttribute("isEdit", true);
            
            request.getRequestDispatcher("/view/admin/tier-form.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi tải thông tin gói", "UTF-8"));
        }
    }

    /**
     * Create new tier
     */
    private void createTier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String tierName = request.getParameter("tierName");
            double price = Double.parseDouble(request.getParameter("price"));
            int priorityLevel = Integer.parseInt(request.getParameter("priorityLevel"));
            String description = request.getParameter("description");
            
            Tier tier = new Tier();
            tier.setTierName(tierName);
            tier.setPrice(price);
            tier.setPriorityLevel(priorityLevel);
            tier.setDescription(description);
            
            TierDAO tierDAO = new TierDAO();
            boolean success = tierDAO.create(tier);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?success=" + 
                        URLEncoder.encode("Tạo gói thành viên thành công", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                        URLEncoder.encode("Không thể tạo gói thành viên", "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi tạo gói", "UTF-8"));
        }
    }

    /**
     * Update existing tier
     */
    private void updateTier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("tierId"));
            String tierName = request.getParameter("tierName");
            double price = Double.parseDouble(request.getParameter("price"));
            int priorityLevel = Integer.parseInt(request.getParameter("priorityLevel"));
            String description = request.getParameter("description");
            
            Tier tier = new Tier();
            tier.setTierId(tierId);
            tier.setTierName(tierName);
            tier.setPrice(price);
            tier.setPriorityLevel(priorityLevel);
            tier.setDescription(description);
            
            TierDAO tierDAO = new TierDAO();
            boolean success = tierDAO.update(tier);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?success=" + 
                        URLEncoder.encode("Cập nhật gói thành viên thành công", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                        URLEncoder.encode("Không thể cập nhật gói thành viên", "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi cập nhật gói", "UTF-8"));
        }
    }

    /**
     * Delete tier
     */
    private void deleteTier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("tierId"));
            
            TierDAO tierDAO = new TierDAO();
            boolean success = tierDAO.delete(tierId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?success=" + 
                        URLEncoder.encode("Xóa gói thành viên thành công", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                        URLEncoder.encode("Không thể xóa gói thành viên", "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi xóa gói", "UTF-8"));
        }
    }

    /**
     * Load memberships list
     */
    private void loadMembershipsList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserTierDAO userTierDAO = new UserTierDAO();
            
            // Update expired tiers first
            userTierDAO.updateExpiredTiers();
            
            // Get all user tiers (this would require a new method to get all user tiers with user info)
            // For now, we'll just forward to the memberships page
            
            request.setAttribute("pageTitle", "Quản lý thành viên");
            request.getRequestDispatcher("/view/admin/membership-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi tải danh sách thành viên", "UTF-8"));
        }
    }

    /**
     * Expire user memberships manually
     */
    private void expireUserMemberships(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserTierDAO userTierDAO = new UserTierDAO();
            boolean success = userTierDAO.updateExpiredTiers();
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?success=" + 
                        URLEncoder.encode("Đã cập nhật trạng thái thành viên hết hạn", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                        URLEncoder.encode("Không có thành viên nào cần cập nhật", "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tiers?error=" + 
                    URLEncoder.encode("Có lỗi xảy ra khi cập nhật trạng thái", "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin servlet for managing tier packages and memberships";
    }
}
