package Controller;

import DAO.UsersDao;
import Model.User;
import Util.Email;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet responsible for handling forgot password functionality
 * Sends password reset emails to users
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the forgot password form
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the forgot password page
        request.getRequestDispatcher("/view/guest/page/forgotpassword.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes the forgot password form submission and sends reset link
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the email from the form
        String email = request.getParameter("email");
        
        // Validate email exists in our system
        UsersDao userDao = new UsersDao();
        User user = userDao.getByEmail(email);
        
        if (user != null) {
            // Send password reset email
            boolean emailSent = sendPasswordResetEmail(email);
            
            if (emailSent) {
                // Success message
                request.setAttribute("message", "Password reset link has been sent to your email.");
                request.setAttribute("messageType", "success");
            } else {
                // Email sending failed
                request.setAttribute("message", "Failed to send password reset email. Please try again later.");
                request.setAttribute("messageType", "danger");
            }
        } else {
            // If email doesn't exist, still show success message for security reasons
            // This prevents user enumeration attacks
            request.setAttribute("message", "If your email exists in our system, a password reset link has been sent.");
            request.setAttribute("messageType", "info");
        }
        
        // Forward back to the forgot password page with message
        request.getRequestDispatcher("/view/guest/page/forgotpassword.jsp").forward(request, response);
    }

    /**
     * Sends a password reset email to the specified email address
     * 
     * @param email The email address to send the reset link to
     * @return true if email was sent successfully, false otherwise
     */
    private boolean sendPasswordResetEmail(String email) {
        String subject = "RentEz - Password Reset Request";
        String content = Email.noiDungForget(email);
        
        return Email.sendEmail(email, subject, content);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Forgot Password Servlet";
    }
}
