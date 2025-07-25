package Controller;

import DAO.PropertyDAO;
import DAO.UsersDao;
import DAO.PropertyTypeDAO;
import Model.Property;
import Model.User;
import Model.PropertyType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "AdminPostsServlet", urlPatterns = {"/admin/posts"})
public class AdminPostsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        try {
            String action = request.getParameter("action");
            
            if ("view".equals(action)) {
                viewProperty(request, response);
                return;
            }
            
            // Get filter parameters
            String statusFilter = request.getParameter("status");
            String searchQuery = request.getParameter("search");
            
            // Get pagination parameters
            int page = 1;
            int pageSize = 10;
            try {
                String pageParam = request.getParameter("page");
                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            PropertyDAO propertyDAO = new PropertyDAO();
            UsersDao userDAO = new UsersDao();
            PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
            
            // Get all properties with pagination and filters
            List<Property> properties;
            int totalProperties;
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                properties = propertyDAO.searchPropertiesForAdmin(searchQuery, statusFilter, page, pageSize);
                totalProperties = propertyDAO.countSearchPropertiesForAdmin(searchQuery, statusFilter);
            } else {
                properties = propertyDAO.getAllPropertiesForAdmin(statusFilter, page, pageSize);
                totalProperties = propertyDAO.countAllPropertiesForAdmin(statusFilter);
            }
            
            // Get user and property type details for each property
            Map<Integer, User> landlordMap = new HashMap<>();
            Map<Integer, PropertyType> propertyTypeMap = new HashMap<>();
            
            for (Property property : properties) {
                // Get landlord info
                if (!landlordMap.containsKey(property.getLandlordId())) {
                    User landlord = userDAO.getById(property.getLandlordId());
                    landlordMap.put(property.getLandlordId(), landlord);
                }
                
                // Get property type info
                if (!propertyTypeMap.containsKey(property.getTypeId())) {
                    PropertyType propertyType = propertyTypeDAO.getById(property.getTypeId());
                    propertyTypeMap.put(property.getTypeId(), propertyType);
                }
            }
            
            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalProperties / pageSize);
            
            // Get statistics
            int pendingCount = propertyDAO.countPropertiesByStatus(false);
            int approvedCount = propertyDAO.countPropertiesByStatus(true);
            
            // Set attributes
            request.setAttribute("properties", properties);
            request.setAttribute("landlordMap", landlordMap);
            request.setAttribute("propertyTypeMap", propertyTypeMap);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProperties", totalProperties);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("approvedCount", approvedCount);
            
            request.getRequestDispatcher("/view/admin/posts.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách bài đăng");
            request.getRequestDispatcher("/view/admin/posts.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            if ("approve".equals(action)) {
                approveProperty(request, response);
            } else if ("reject".equals(action)) {
                rejectProperty(request, response);
            } else if ("bulk-approve".equals(action)) {
                bulkApproveProperties(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/posts");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu");
            response.sendRedirect(request.getContextPath() + "/admin/posts");
        }
    }
    
    private void viewProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String propertyIdStr = request.getParameter("id");
        if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/posts");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            PropertyDAO propertyDAO = new PropertyDAO();
            UsersDao userDAO = new UsersDao();
            PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
            
            Property property = propertyDAO.getById(propertyId);
            if (property == null) {
                request.setAttribute("error", "Không tìm thấy bài đăng");
                response.sendRedirect(request.getContextPath() + "/admin/posts");
                return;
            }
            
            User landlord = userDAO.getById(property.getLandlordId());
            PropertyType propertyType = propertyTypeDAO.getById(property.getTypeId());
            
            request.setAttribute("property", property);
            request.setAttribute("landlord", landlord);
            request.setAttribute("propertyType", propertyType);
            
            request.getRequestDispatcher("/view/admin/post-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/posts");
        }
    }
    
    private void approveProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String propertyIdStr = request.getParameter("propertyId");
        if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/posts");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            PropertyDAO propertyDAO = new PropertyDAO();
            
            boolean success = propertyDAO.updatePublicStatus(propertyId, true);
            
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("success", "Đã duyệt bài đăng thành công");
            } else {
                session.setAttribute("error", "Không thể duyệt bài đăng");
            }
            
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "ID bài đăng không hợp lệ");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/posts");
    }
    
    private void rejectProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String propertyIdStr = request.getParameter("propertyId");
        if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/posts");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            PropertyDAO propertyDAO = new PropertyDAO();
            
            boolean success = propertyDAO.updatePublicStatus(propertyId, false);
            
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("success", "Đã từ chối bài đăng");
            } else {
                session.setAttribute("error", "Không thể từ chối bài đăng");
            }
            
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "ID bài đăng không hợp lệ");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/posts");
    }
    
    private void bulkApproveProperties(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String[] propertyIds = request.getParameterValues("propertyIds");
        if (propertyIds == null || propertyIds.length == 0) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Vui lòng chọn ít nhất một bài đăng");
            response.sendRedirect(request.getContextPath() + "/admin/posts");
            return;
        }
        
        PropertyDAO propertyDAO = new PropertyDAO();
        int successCount = 0;
        
        for (String propertyIdStr : propertyIds) {
            try {
                int propertyId = Integer.parseInt(propertyIdStr);
                if (propertyDAO.updatePublicStatus(propertyId, true)) {
                    successCount++;
                }
            } catch (NumberFormatException e) {
                // Skip invalid IDs
            }
        }
        
        HttpSession session = request.getSession();
        if (successCount > 0) {
            session.setAttribute("success", "Đã duyệt " + successCount + " bài đăng thành công");
        } else {
            session.setAttribute("error", "Không thể duyệt bài đăng nào");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/posts");
    }
}
