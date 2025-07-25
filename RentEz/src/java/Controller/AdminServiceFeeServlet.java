package Controller;

import java.io.IOException;
import java.util.List;

import DAO.FeeCategoryDAO;
import Model.User;
import Model.FeeCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminServiceFeeServlet", urlPatterns = {"/admin/service-fees", "/admin/service-fee-action"})
public class AdminServiceFeeServlet extends HttpServlet {
    
    private FeeCategoryDAO feeCategoryDAO;
    
    @Override
    public void init() throws ServletException {
        feeCategoryDAO = new FeeCategoryDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Kiểm tra có phải request API lấy thông tin fee category không
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getFeeCategoryData(request, response);
            return;
        }
        
        String servletPath = request.getServletPath();
        
        if ("/admin/service-fees".equals(servletPath)) {
            showServiceFeeManagement(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "create":
                    createServiceFee(request, response);
                    break;
                case "edit":
                    editServiceFee(request, response);
                    break;
                case "delete":
                    deleteServiceFee(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/service-fees");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/service-fees?error=1");
        }
    }
    
    private void showServiceFeeManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get filter parameters
            String search = request.getParameter("search");
            
            // Get fee categories
            List<FeeCategory> feeCategories;
            if (search != null && !search.trim().isEmpty()) {
                feeCategories = feeCategoryDAO.searchByName(search);
            } else {
                feeCategories = feeCategoryDAO.getAll();
            }
            int totalFeeCategories = feeCategories.size();
            
            // Set attributes
            request.setAttribute("feeCategories", feeCategories);
            request.setAttribute("totalFeeCategories", totalFeeCategories);
            request.setAttribute("search", search);
            
            request.getRequestDispatcher("/view/admin/service-fee-management.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void createServiceFee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String unit = request.getParameter("unit");
        
        FeeCategory newFeeCategory = new FeeCategory();
        newFeeCategory.setName(name);
        newFeeCategory.setUnitPrice(unitPrice);
        newFeeCategory.setUnit(unit);
        
        boolean success = feeCategoryDAO.create(newFeeCategory);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/service-fees?success=create");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/service-fees?error=create");
        }
    }
    
    private void editServiceFee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String name = request.getParameter("name");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String unit = request.getParameter("unit");
        
        FeeCategory feeCategory = feeCategoryDAO.getById(categoryId);
        if (feeCategory != null) {
            feeCategory.setName(name);
            feeCategory.setUnitPrice(unitPrice);
            feeCategory.setUnit(unit);
            
            boolean success = feeCategoryDAO.update(feeCategory);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/service-fees?success=edit");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/service-fees?error=edit");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/service-fees?error=notfound");
        }
    }
    
    private void deleteServiceFee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        
        boolean success = feeCategoryDAO.delete(categoryId);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/service-fees?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/service-fees?error=delete");
        }
    }
    
    private void getFeeCategoryData(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            FeeCategory feeCategory = feeCategoryDAO.getById(categoryId);
            
            if (feeCategory != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                // Chuyển đổi đối tượng FeeCategory thành JSON
                StringBuilder json = new StringBuilder("{");
                json.append("\"categoryId\":").append(feeCategory.getCategoryId()).append(",");
                json.append("\"name\":\"").append(feeCategory.getName().replace("\"", "\\\"")).append("\",");
                json.append("\"unitPrice\":").append(feeCategory.getUnitPrice()).append(",");
                json.append("\"unit\":\"").append(feeCategory.getUnit().replace("\"", "\\\"")).append("\"");
                json.append("}");
                
                response.getWriter().write(json.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Fee category not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error fetching fee category data");
        }
    }
}
