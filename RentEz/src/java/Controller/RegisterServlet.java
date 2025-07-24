/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDao;
import DAO.WalletDAO;
import Model.User;
import Model.Wallet;
import Util.Email;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.Random;

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

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes user registration form submission and email verification
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Handle verification code submission
        if ("verify".equals(action)) {
            verifyEmail(request, response);
            return;
        }
        
        // New registration process
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
            try {
                // Store user data in session temporarily
                HttpSession session = request.getSession();
                
                // Create new user object but don't save to database yet
                User newUser = new User();
                newUser.setName(name);
                newUser.setEmail(email);
                newUser.setPassword(Util.Common.encryptMD5(password));
                newUser.setPhone(phone);
                newUser.setAddress(address);
                newUser.setRole(role);
                
                // Store user data in session
                session.setAttribute("tempUser", newUser);
                
                // Generate verification code (6 digits)
                String verificationCode = generateVerificationCode();
                session.setAttribute("verificationCode", verificationCode);
                
                // Send verification email
                String emailSubject = "RentEz - Xác thực email đăng ký";
                String emailContent = Email.noiDungRegis(verificationCode);
                boolean emailSent = Email.sendEmail(email, emailSubject, emailContent);
                
                if (emailSent) {
                    // Show verification page
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("view/guest/page/verify.jsp").forward(request, response);
                } else {
                    // Email sending failed
                    request.setAttribute("error", "Không thể gửi email xác thực. Vui lòng thử lại.");
                    request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
                }
            } catch (Exception e) {
                // Handle exceptions
                request.setAttribute("error", "Đăng ký thất bại: " + e.getMessage());
                request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
            }
        } else {
            // Validation failed, return to register page with error
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
        }
    }    /**
     * Handle email verification code submission
     * 
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void verifyEmail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String storedCode = (String) session.getAttribute("verificationCode");
        User tempUser = (User) session.getAttribute("tempUser");
        
        if (storedCode == null || tempUser == null) {
            request.setAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại.");
            request.getRequestDispatcher("view/guest/page/register.jsp").forward(request, response);
            return;
        }
        
        // Collect codes from form
        String code1 = request.getParameter("code1");
        String code2 = request.getParameter("code2");
        String code3 = request.getParameter("code3");
        String code4 = request.getParameter("code4");
        String code5 = request.getParameter("code5");
        String code6 = request.getParameter("code6");
        
        String submittedCode = code1 + code2 + code3 + code4 + code5 + code6;
        String email = request.getParameter("email");
          // Validate verification code
        if (storedCode.equals(submittedCode)) {
            try {
                // Insert user into database
                UserDao userDao = new UserDao();
                boolean result = userDao.insert(tempUser);
                
                if (result) {
                    // Get the newly created user with ID
                    User createdUser = userDao.getByEmail(tempUser.getEmail());
                      // Create wallet for the new user
                    WalletDAO walletDAO = new WalletDAO();
                    Wallet newWallet = new Wallet();
                    newWallet.setUserId(createdUser.getUserId());
                    newWallet.setBalance(0.0); // Initial balance is 0
                    newWallet.setLastUpdated(new Date());
                    
                    // Save wallet to database
                    walletDAO.create(newWallet);
                    
                    // Remove verification data from session
                    session.removeAttribute("tempUser");
                    session.removeAttribute("verificationCode");
                    
                    // Create session for the verified user
                    session.setAttribute("user", createdUser);
                    
                    // Redirect to home page
                    response.sendRedirect(request.getContextPath() + "/");
                } else {
                    // Database error
                    request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                    request.setAttribute("email", email);
                    request.getRequestDispatcher("view/guest/page/verify.jsp").forward(request, response);
                }
            } catch (Exception e) {
                // Handle exceptions
                request.setAttribute("error", "Đăng ký thất bại: " + e.getMessage());
                request.setAttribute("email", email);
                request.getRequestDispatcher("view/guest/page/verify.jsp").forward(request, response);
            }
        } else {
            // Invalid verification code
            request.setAttribute("error", "Mã xác thực không chính xác. Vui lòng thử lại.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/guest/page/verify.jsp").forward(request, response);
        }
    }
    
    /**
     * Generate a random 6-digit verification code
     * 
     * @return a 6-digit verification code
     */
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // Generates a number between 100000 and 999999
        return String.valueOf(code);
    }
    
    /**
     * Updates the doGet method to handle resend verification code functionality
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if it's a resend request
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        
        if ("resend".equals(action) && email != null && !email.isEmpty()) {
            HttpSession session = request.getSession();
            User tempUser = (User) session.getAttribute("tempUser");
            
            if (tempUser != null && email.equals(tempUser.getEmail())) {
                // Generate new verification code
                String verificationCode = generateVerificationCode();
                session.setAttribute("verificationCode", verificationCode);
                
                // Send verification email again
                String emailSubject = "RentEz - Xác thực email đăng ký";
                String emailContent = Email.noiDungRegis(verificationCode);
                boolean emailSent = Email.sendEmail(email, emailSubject, emailContent);
                
                if (emailSent) {
                    // Show verification page with success message
                    request.setAttribute("email", email);
                    request.setAttribute("message", "Mã xác thực mới đã được gửi đến email của bạn.");
                    request.getRequestDispatcher("view/guest/page/verify.jsp").forward(request, response);
                    return;
                } else {
                    // Email sending failed
                    request.setAttribute("email", email);
                    request.setAttribute("error", "Không thể gửi email xác thực. Vui lòng thử lại.");
                    request.getRequestDispatcher("view/guest/page/verify.jsp").forward(request, response);
                    return;
                }
            }
        }
        
        // Default behavior - show register page for new registrations
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
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Register Servlet handles user registration, verification, and account creation";
    }
}