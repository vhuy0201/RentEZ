package Controller;

import java.io.IOException;
import java.util.List;

import DAO.PropertyTypeDAO;
import Model.User;
import Model.PropertyType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminPropertyTypeServlet", urlPatterns = {"/admin/property-types", "/admin/property-type-action"})
public class AdminPropertyTypeServlet extends HttpServlet {
    
    private PropertyTypeDAO propertyTypeDAO;
    
    @Override
    public void init() throws ServletException {
        propertyTypeDAO = new PropertyTypeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Kiểm tra có phải request API lấy thông tin property type không
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getPropertyTypeData(request, response);
            return;
        }
        
        String servletPath = request.getServletPath();
        
        if ("/admin/property-types".equals(servletPath)) {
            showPropertyTypeManagement(request, response);
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
                    createPropertyType(request, response);
                    break;
                case "edit":
                    editPropertyType(request, response);
                    break;
                case "delete":
                    deletePropertyType(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/property-types");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/property-types?error=1");
        }
    }
    
    private void showPropertyTypeManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get filter parameters
            String search = request.getParameter("search");
            String statusFilter = request.getParameter("status");
            
            // Get pagination parameters
            int page = 1;
            int pageSize = 10;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            // Get filtered property types
            List<PropertyType> propertyTypes = propertyTypeDAO.getFilteredPropertyTypes(search, statusFilter, page, pageSize);
            int totalPropertyTypes = propertyTypeDAO.getTotalFilteredPropertyTypes(search, statusFilter);
            int totalPages = (int) Math.ceil((double) totalPropertyTypes / pageSize);
            
            // Set attributes
            request.setAttribute("propertyTypes", propertyTypes);
            request.setAttribute("totalPropertyTypes", totalPropertyTypes);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("statusFilter", statusFilter);
            
            request.getRequestDispatcher("/view/admin/property-type-management.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void createPropertyType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String typeName = request.getParameter("typeName");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        
        PropertyType newPropertyType = new PropertyType();
        newPropertyType.setTypeName(typeName);
        newPropertyType.setDescription(description);
        newPropertyType.setStatus(true);
        
        boolean success = propertyTypeDAO.insert(newPropertyType);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/property-types?success=create");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/property-types?error=create");
        }
    }
    
    private void editPropertyType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        String typeName = request.getParameter("typeName");
        String description = request.getParameter("description");
        
        PropertyType propertyType = propertyTypeDAO.getById(typeId);
        if (propertyType != null) {
            propertyType.setTypeName(typeName);
            propertyType.setDescription(description);
            
            boolean success = propertyTypeDAO.update(propertyType);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/property-types?success=edit");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/property-types?error=edit");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/property-types?error=notfound");
        }
    }
    
    private void deletePropertyType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        
        boolean success = propertyTypeDAO.deletePropertyType(typeId);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/property-types?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/property-types?error=delete");
        }
    }
    
    private void getPropertyTypeData(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            PropertyType propertyType = propertyTypeDAO.getById(typeId);
            
            if (propertyType != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                // Chuyển đổi đối tượng PropertyType thành JSON
                StringBuilder json = new StringBuilder("{");
                json.append("\"typeId\":").append(propertyType.getTypeId()).append(",");
                json.append("\"typeName\":\"").append(propertyType.getTypeName().replace("\"", "\\\"")).append("\",");
                json.append("\"description\":\"").append(propertyType.getDescription() != null ? 
                        propertyType.getDescription().replace("\"", "\\\"") : "").append("\",");
                json.append("\"status\":").append(propertyType.isStatus());
                json.append("}");
                
                response.getWriter().write(json.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Property type not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error fetching property type data");
        }
    }
}
