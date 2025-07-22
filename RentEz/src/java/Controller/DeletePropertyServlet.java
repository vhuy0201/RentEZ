package Controller;

import DAO.PropertyDAO;
import Model.Property;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeletePropertyServlet", urlPatterns = {"/deleteProperty"})
public class DeletePropertyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String propertyIdStr = request.getParameter("propertyId");
        
        if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
            session.setAttribute("error", "ID bất động sản không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            
            // Lấy thông tin property để kiểm tra quyền sở hữu
            PropertyDAO propertyDAO = new PropertyDAO();
            Property property = propertyDAO.getById(propertyId);
            
            if (property == null) {
                session.setAttribute("error", "Không tìm thấy bất động sản.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Kiểm tra quyền sở hữu
            if (property.getLandlordId() != user.getUserId()) {
                session.setAttribute("error", "Bạn không có quyền xóa bất động sản này.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }
            
            // Soft delete: chuyển publicStatus về false thay vì xóa khỏi database
            boolean success = propertyDAO.softDeleteProperty(propertyId);
            
            if (success) {
                session.setAttribute("successMessage", "Tin đăng đã được ẩn thành công! Bạn có thể khôi phục lại tin đăng này bất cứ lúc nào.");
            } else {
                session.setAttribute("error", "Không thể ẩn tin đăng. Vui lòng thử lại.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID bất động sản không hợp lệ.");
        } catch (Exception e) {
            System.err.println("Error in DeletePropertyServlet: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra khi ẩn tin đăng. Vui lòng thử lại.");
        }
        
        response.sendRedirect(request.getContextPath() + "/viewProperties");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Servlet handles soft deletion of properties by setting publicStatus to false.";
    }
}
