package Controller;

import DAO.UserDao;
import Model.User;
import Util.Common;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet responsible for handling password reset functionality
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the reset password form
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the email from the request
        String email = request.getParameter("email");
        
        if (email == null || email.isEmpty()) {
            // If no email is provided, redirect to forgot password page
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }
        
        // Check if email exists in the system
        UserDao userDao = new UserDao();
        User user = userDao.getByEmail(email);
        
        if (user == null) {
            // If email doesn't exist, redirect to forgot password page
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }
        
        // Forward to the reset password page
        request.getRequestDispatcher("/view/guest/page/passwordreset.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes the password reset form submission
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
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate form data
        boolean isValid = true;
        String errorMessage = "";
        
        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            isValid = false;
            errorMessage = "Passwords do not match";
        }
        
        // Check if password meets requirements
        if (newPassword.length() < 8) {
            isValid = false;
            errorMessage = "Password must be at least 8 characters long";
        }
        
        // Check if email exists in our system
        UserDao userDao = new UserDao();
        User user = userDao.getByEmail(email);
        
        if (user == null) {
            isValid = false;
            errorMessage = "Invalid email address";
        }
          if (isValid) {
            // Update the user's password with MD5 encryption
            user.setPassword(Util.Common.encryptMD5(newPassword));
            boolean updated = userDao.update(user);
            
            if (updated) {
                // Success message
                request.setAttribute("message", "Your password has been successfully reset. You can now login with your new password.");
                request.setAttribute("messageType", "success");
                // Redirect to login page after 3 seconds
                response.setHeader("Refresh", "3;url=" + request.getContextPath() + "/view/guest/page/login.jsp");
            } else {
                // Password update failed
                request.setAttribute("message", "Failed to update password. Please try again later.");
                request.setAttribute("messageType", "danger");
            }
        } else {
            // Form validation failed
            request.setAttribute("message", errorMessage);
            request.setAttribute("messageType", "danger");
        }
        
        // Forward back to the reset password page with message
        request.getRequestDispatcher("/view/guest/page/passwordreset.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Reset Password Servlet";
    }
}
