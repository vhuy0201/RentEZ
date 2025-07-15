package Controller;

import DAO.UserDao;
import DAO.WalletDAO;
import Model.GoogleAccount;
import Model.User;
import Model.Wallet;
import Util.GoogleLogin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * Handles Google OAuth login flow
 */
@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/login-google", "/login-google-callback"})
public class GoogleLoginServlet extends HttpServlet {

    /** 
     * Handles the HTTP GET method for initiating Google login and processing the callback
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        // Initial Google login request
        if ("/login-google".equals(servletPath)) {
            // Redirect to Google OAuth page
            response.sendRedirect(GoogleLogin.getLoginUrl());
        } 
        // Callback from Google after user grants permission
        else if ("/login-google-callback".equals(servletPath)) {
            // Get the authorization code from Google
            String code = request.getParameter("code");
            
            if (code == null || code.isEmpty()) {
                // If no code is received, redirect to login page with error
                request.setAttribute("error", "Failed to authenticate with Google. Please try again.");
                request.getRequestDispatcher("/view/guest/page/login.jsp").forward(request, response);
                return;
            }
            
            try {
                // Exchange code for access token
                String accessToken = GoogleLogin.getToken(code);
                
                // Get user info from Google
                GoogleAccount googleAccount = GoogleLogin.getUserInfo(accessToken);
                
                // Check if user with this Google email exists
                UserDao userDao = new UserDao();
                User user = userDao.getByGoogleEmail(googleAccount.getEmail());
                
                // If user doesn't exist, create a new user
                if (user == null) {
                    user = userDao.createFromGoogleAccount(googleAccount);
                    WalletDAO walletDAO = new WalletDAO();
                    Wallet newWallet = new Wallet();
                    newWallet.setUserId(user.getUserId());
                    newWallet.setBalance(0.0); // Initial balance is 0
                    newWallet.setLastUpdated(new Date());
                    
                    // Save wallet to database
                    walletDAO.create(newWallet);
                    if (user == null) {
                        // If user creation failed, redirect to login page with error
                        request.setAttribute("error", "Failed to create user account. Please try again.");
                        request.getRequestDispatcher("/view/guest/page/login.jsp").forward(request, response);
                        return;
                    }
                }
                
                // Set user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Redirect to homepage or dashboard after successful login
                response.sendRedirect(request.getContextPath() + "/");
                
            } catch (Exception e) {
                // If any error occurs, redirect to login page with error
                request.setAttribute("error", "An error occurred during Google authentication: " + e.getMessage());
                request.getRequestDispatcher("/view/guest/page/login.jsp").forward(request, response);
            }
        }
    }
}