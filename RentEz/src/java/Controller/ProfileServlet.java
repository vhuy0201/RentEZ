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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.UUID;

/**
 * Servlet responsible for handling user profile operations including profile
 * updates and password changes
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig

public class ProfileServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method. Displays the user profile page
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

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward to profile page
        request.getRequestDispatcher("/view/common/profile.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method. Processes profile update and
     * password change requests
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get user from session
        User sessionUser = (User) session.getAttribute("user");
        UserDao userDao = new UserDao();

        // Get action parameter to determine what operation to perform
        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            // Handle profile update
            updateProfile(request, response, sessionUser, userDao, session);
        } else if ("changePassword".equals(action)) {
            // Handle password change
            changePassword(request, response, sessionUser, userDao);
        } else {
            // Invalid action, redirect to profile page
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    /**
     * Updates the user profile information
     *
     * @param request servlet request
     * @param response servlet response
     * @param user current user
     * @param userDao data access object for users
     * @param session current session
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void updateProfile(HttpServletRequest request, HttpServletResponse response, User user, UserDao userDao, HttpSession session)
            throws ServletException, IOException {
        // Get updated values from form
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Update user object
        user.setName(name);
        user.setPhone(phone);
        user.setAddress(address);
        String uploadPath = getServletContext().getRealPath("/") + "view/guest/asset/img";
        // Handle avatar upload
        Part filePart = request.getPart("avatar");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        // Generate a unique filename to prevent overwriting
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();            // Đường dẫn đầy đủ của file sẽ được lưu
        String filePath = uploadPath + File.separator + originalFileName;
        filePart.write(filePath);
        user.setAvatar("view/guest/asset/img/" + originalFileName);
        // Save updates to database
        boolean updated = userDao.update(user);

        if (updated) {
            // Update successful, update session user
            session.setAttribute("user", user);

            // Set success message
            request.setAttribute("profileMessage", "Profile information updated successfully.");
            request.setAttribute("profileMessageType", "success");
        } else {
            // Update failed
            request.setAttribute("profileMessage", "Failed to update profile information. Please try again.");
            request.setAttribute("profileMessageType", "danger");
        }

        // Forward back to profile page
        request.getRequestDispatcher("/view/common/profile.jsp").forward(request, response);
    }

    /**
     * Changes the user's password
     *
     * @param request servlet request
     * @param response servlet response
     * @param user current user
     * @param userDao data access object for users
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response, User user, UserDao userDao)
            throws ServletException, IOException {
        // Get password values from form
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Encrypt current password for comparison
        String encryptedCurrentPassword = Common.encryptMD5(currentPassword);

        // Validate form data
        boolean isValid = true;
        String errorMessage = "";

        // Check if current password matches stored password
        if (!user.getPassword().equals(encryptedCurrentPassword)) {
            isValid = false;
            errorMessage = "Current password is incorrect.";
        }

        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            isValid = false;
            errorMessage = "New password and confirmation do not match.";
        }

        // Check password requirements
        if (newPassword.length() < 8) {
            isValid = false;
            errorMessage = "Password must be at least 8 characters long.";
        }

        // Check for uppercase letters, lowercase letters, and numbers
        boolean hasUppercase = !newPassword.equals(newPassword.toLowerCase());
        boolean hasLowercase = !newPassword.equals(newPassword.toUpperCase());
        boolean hasDigit = newPassword.matches(".*\\d.*");

        if (!hasUppercase || !hasLowercase || !hasDigit) {
            isValid = false;
            errorMessage = "Password must contain at least one uppercase letter, one lowercase letter, and one number.";
        }

        if (isValid) {
            // Update user's password with MD5 encryption
            user.setPassword(Common.encryptMD5(newPassword));
            boolean updated = userDao.update(user);

            if (updated) {
                // Password change successful
                request.setAttribute("passwordMessage", "Password changed successfully.");
                request.setAttribute("passwordMessageType", "success");
            } else {
                // Password change failed
                request.setAttribute("passwordMessage", "Failed to change password. Please try again.");
                request.setAttribute("passwordMessageType", "danger");
            }
        } else {
            // Form validation failed
            request.setAttribute("passwordMessage", errorMessage);
            request.setAttribute("passwordMessageType", "danger");
        }

        // Set tab parameter to show change password tab
        response.sendRedirect(request.getContextPath() + "/profile?tab=changePassword");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Profile Servlet handles user profile updates and password changes";
    }
}
