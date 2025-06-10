/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDao;
import Model.User;
import Util.Common;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet responsible for handling user login functionality
 */
public class LoginServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * Redirects to login page or home page depending on whether user is already logged in
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is already logged in
        if (session != null && session.getAttribute("user") != null) {
            // User already logged in, redirect to appropriate dashboard based on role
            User user = (User) session.getAttribute("user");
            redirectBasedOnRole(response, user);
        } else {
            // No active session, show login page
            request.getRequestDispatcher("view/guest/page/login.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Authenticates user credentials and creates a session on successful login
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // Check if "remember me" is selected
        
        UserDao userDao = new UserDao();
        User authenticatedUser = authenticateUser(userDao, email, password);
        
        if (authenticatedUser != null) {
            // Authentication successful
            // Create a session and add user to it
            HttpSession session = request.getSession();
            session.setAttribute("user", authenticatedUser);
            
            // Lưu thêm thông tin landlord nếu vai trò là "landlord"
            if ("landlord".equalsIgnoreCase(authenticatedUser.getRole())) {
                session.setAttribute("landlordId", authenticatedUser.getUserId());
                session.setAttribute("landlordName", authenticatedUser.getName()!= null 
                    ? authenticatedUser.getName(): "Người dùng");
            }
            
            // If remember me is checked, extend session timeout (e.g., to 7 days)
            if (remember != null) {
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days in seconds
            }
            redirectBasedOnRole(response, authenticatedUser);
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("view/guest/page/login.jsp").forward(request, response);
        }
    }
      /**
     * Authenticates user credentials against the database
     * 
     * @param userDao The UserDao instance to use for database access
     * @param email The email provided by the user
     * @param password The password provided by the user
     * @return User object if authentication is successful, null otherwise
     */    private User authenticateUser(UserDao userDao, String email, String password) {
        // Get user by email
        User user = userDao.getByEmail(email);
        
        // Encrypt the provided password with MD5 for comparison
        String encryptedPassword = Util.Common.encryptMD5(password);
        
        // Check if user exists and password matches
        if (user != null && user.getPassword().equals(encryptedPassword)) {
            return user;
        }
        
        // No matching user found or password does not match
        return null;
    }
    
    /**
     * Redirects user to appropriate dashboard based on role
     * 
     * @param response The HttpServletResponse object
     * @param user The authenticated User object
     * @throws IOException if an I/O error occurs
     */
    private void redirectBasedOnRole(HttpServletResponse response, User user) throws IOException {
        String role = user.getRole();
        
        switch (role.toLowerCase()) {
            case "landlord":
                response.sendRedirect("landLordHomeServlet");
                break;
            case "renter":
                response.sendRedirect("view/guest/page/homepage.jsp");
                break;
            case "admin":
                response.sendRedirect("view/admin/dashboard.jsp");
                break;
            default:
                // Default to home page if role is not recognized
                response.sendRedirect("HomeServlet");
                break;
        }
    }


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Login Servlet handles user authentication and session management";
    }
}
