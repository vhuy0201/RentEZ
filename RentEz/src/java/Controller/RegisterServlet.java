/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDao;
import Model.User;
import Util.Common;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet responsible for handling user registration functionality
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method. 
     * Redirects to register page
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User already logged in, redirect to home page
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Show register page
            request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes user registration form submission
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        // Validate form data
        boolean isValid = true;
        String errorMessage = "";
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            isValid = false;
            errorMessage = "Passwords do not match";
        }
        
        // Check if email already exists
        UserDao userDao = new UserDao();
        User existingUser = userDao.getByEmail(email);
        if (existingUser != null) {
            isValid = false;
            errorMessage = "Email already registered";
        }
        
        if (isValid) {
            try {                // Create new user
                User newUser = new User();
                newUser.setName(name);
                newUser.setEmail(email);
                // Encrypt password with MD5 before storing
                newUser.setPassword(Util.Common.encryptMD5(password));
                newUser.setPhone(phone);
                newUser.setAddress(address);
                newUser.setRole(role);
                
                // Insert user into database
                boolean result = userDao.insert(newUser);
                
                if (result) {
                    // Registration successful, get the user with assigned ID
                    User createdUser = userDao.getByEmail(email);
                    
                    // Create session for new user
                    HttpSession session = request.getSession();
                    session.setAttribute("user", createdUser);
                    
                    // Redirect to home page or dashboard
                    response.sendRedirect(request.getContextPath() + "/");
                } else {
                    // Database error
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
                }
            } catch (Exception e) {
                // Handle exceptions
                request.setAttribute("error", "Registration failed: " + e.getMessage());
                request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
            }
        } else {
            // Validation failed, return to register page with error
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Register Servlet handles user registration and account creation";
    }
}