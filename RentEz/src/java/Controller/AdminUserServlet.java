package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;
import DAO.AdminsUserDAO;
import Model.User;
import Util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users", "/admin/user-action"})
public class AdminUserServlet extends HttpServlet {

    private AdminsUserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new AdminsUserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is admin
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Kiểm tra có phải request API lấy thông tin user không
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getUserData(request, response);
            return;
        }

        showUserManagement(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is admin
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "create":
                    createUser(request, response);
                    break;
                case "edit":
                    editUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=1");
        }
    }

    private void showUserManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get filter parameters
            String search = request.getParameter("search");
            String roleFilter = request.getParameter("role");
            String statusFilter = request.getParameter("status");

            // Get pagination parameters
            int page = 1;
            int pageSize = 10;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }

            // Get filtered users
            List<User> users = userDAO.getFilteredUsers(search, roleFilter, statusFilter, page, pageSize);
            int totalUsers = userDAO.getTotalFilteredUsers(search, roleFilter, statusFilter);
            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

            // Set attributes
            request.setAttribute("users", users);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("roleFilter", roleFilter);
            request.setAttribute("statusFilter", statusFilter);

            request.getRequestDispatcher("/view/admin/user-management.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String role = request.getParameter("roleId");

        // Hash password
        String hashedPassword = PasswordUtil.hashPassword(password);

        User newUser = new User();
        newUser.setName(name);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setAddress(address);
        newUser.setPassword(hashedPassword);
        newUser.setRole(role);

        boolean success = userDAO.createUser(newUser);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/users?success=create");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=create");
        }
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String role = request.getParameter("roleId");

        User user = userDAO.getUserById(userId);
        if (user != null) {
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);

            // Update password only if provided
            if (password != null && !password.trim().isEmpty()) {
                String hashedPassword = PasswordUtil.hashPassword(password);
                user.setPassword(hashedPassword);
            }

            boolean success = userDAO.updateUser(user);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=edit");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=edit");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=notfound");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));

        boolean success = userDAO.deleteUser(userId);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/users?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=delete");
        }
    }

    private void getUserData(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                PrintWriter out = response.getWriter();
                Gson gson = new Gson();
                String userJson = gson.toJson(user);
                out.print(userJson);
                out.flush();
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("User not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error fetching user data");
        }
    }
}
