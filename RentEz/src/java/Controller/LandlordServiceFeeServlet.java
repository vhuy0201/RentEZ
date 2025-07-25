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

@WebServlet(name = "LandlordServiceFeeServlet", urlPatterns = {"/landlord/page/service-fees", "/landlord/page/service-fee-action"})
public class LandlordServiceFeeServlet extends HttpServlet {
    
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
        
        
        // Check if this is an API request to get fee category data
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getFeeCategoryData(request, response);
            return;
        }
        
        String servletPath = request.getServletPath();
        
        if ("/landlord/page/service-fees".equals(servletPath)) {
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
                    response.sendRedirect(request.getContextPath() + "/landlord/page/service-fees");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/landlord/page/service-fees?error=Có+lỗi+xảy+ra");
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
            
            request.getRequestDispatcher("/view/landlord/page/service-fee-management.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void createServiceFee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            String unit = request.getParameter("unit");
            
            // Validate input
            if (name == null || name.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/landlord/page/service-fees?error=Tên+danh+mục+phí+không+được+để+trống");
                return;
            }
            
            if (unit == null || unit.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/landlord/page/service-fees?error=Đơn+vị+không+được+để+trống");
                return;
            }
            
            if (unitPrice < 0) {
                response.sendRedirect(request.getContextPath() + "/landlord/page/service-fees?error=Đơn+giá+phải+lớn+hơn+hoặc+bằng+0");
                return;
            }
            
            FeeCategory newFeeCategory = new FeeCategory();
            newFeeCategory.setName(name.trim());
            newFeeCategory.setUnitPrice(unitPrice);
            newFeeCategory.setUnit(unit.trim());
            
            boolean success = feeCategoryDAO.create(newFeeCategory);
            
            if (success) {
                showServiceFeeManagement(request, response);
            } else {
                showServiceFeeManagement(request, response);
            }
        } catch (NumberFormatException e) {
            showServiceFeeManagement(request, response);
        }
    }
    
    private void editServiceFee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String name = request.getParameter("name");
            double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            String unit = request.getParameter("unit");
            
            // Validate input
            if (name == null || name.trim().isEmpty()) {
                showServiceFeeManagement(request, response);
                return;
            }
            
            if (unit == null || unit.trim().isEmpty()) {
                showServiceFeeManagement(request, response);
                return;
            }
            
            if (unitPrice < 0) {
                showServiceFeeManagement(request, response);
                return;
            }
            
            FeeCategory feeCategory = feeCategoryDAO.getById(categoryId);
            if (feeCategory != null) {
                feeCategory.setName(name.trim());
                feeCategory.setUnitPrice(unitPrice);
                feeCategory.setUnit(unit.trim());
                
                boolean success = feeCategoryDAO.update(feeCategory);
                
                if (success) {
                    showServiceFeeManagement(request, response);
                } else {
                    showServiceFeeManagement(request, response);
                }
            } else {
                showServiceFeeManagement(request, response);
            }
        } catch (NumberFormatException e) {
            showServiceFeeManagement(request, response);
        }
    }
    
    private void deleteServiceFee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            
            boolean success = feeCategoryDAO.delete(categoryId);
            
            if (success) {
                showServiceFeeManagement(request, response);
            } else {
                showServiceFeeManagement(request, response);
            }
        } catch (NumberFormatException e) {
            showServiceFeeManagement(request, response);
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
                
                // Convert FeeCategory object to JSON
                StringBuilder json = new StringBuilder("{");
                json.append("\"categoryId\":").append(feeCategory.getCategoryId()).append(",");
                json.append("\"name\":\"").append(feeCategory.getName().replace("\"", "\\\"")).append("\",");
                json.append("\"unitPrice\":").append(feeCategory.getUnitPrice()).append(",");
                json.append("\"unit\":\"").append(feeCategory.getUnit().replace("\"", "\\\"")).append("\"");
                json.append("}");
                
                response.getWriter().write(json.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Fee category not found\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid category ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Error fetching fee category data\"}");
        }
    }
}
