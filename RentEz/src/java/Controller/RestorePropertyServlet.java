package Controller;

import DAO.PropertyDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/restoreProperty")
public class RestorePropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        propertyDAO = new PropertyDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            if (user == null) {
                session.setAttribute("errorMessage", "Bạn cần đăng nhập để thực hiện chức năng này.");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            String propertyIdStr = request.getParameter("propertyId");

            if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "ID bất động sản không hợp lệ.");
                response.sendRedirect(request.getContextPath() + "/viewProperties");
                return;
            }

            int propertyId = Integer.parseInt(propertyIdStr);


            // Restore the property
            boolean success = propertyDAO.restoreProperty(propertyId);

            if (success) {
                session.setAttribute("successMessage", "Tin đăng đã được khôi phục thành công!");
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi khôi phục tin đăng. Vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/viewProperties");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/viewProperties");
    }
}
