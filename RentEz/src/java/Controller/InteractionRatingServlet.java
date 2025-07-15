package Controller;

import DAO.InteractionRatingDAO;
import DAO.NotificationDAO;
import DAO.UsersDao;
import Model.InteractionRating;
import Model.Notification;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 * Controller to handle interaction ratings between landlords and renters
 */
@WebServlet(name = "InteractionRatingServlet", urlPatterns = {"/ratings"})
public class InteractionRatingServlet extends HttpServlet {

    private final InteractionRatingDAO ratingDAO = new InteractionRatingDAO();
    private final UsersDao userDAO = new UsersDao();

    /**
     * Handles the HTTP GET method - displays rating pages and AJAX requests
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        if ("viewLandlordRatings".equals(action)) {
            String landlordIdStr = request.getParameter("landlordId");
            int landlordId = Integer.parseInt(landlordIdStr);
            
            // Get landlord user
            User landlord = userDAO.getById(landlordId);
            request.setAttribute("landlord", landlord);
            
            // Get detailed ratings for this landlord
            List<Map<String, Object>> detailedRatings = ratingDAO.getDetailedRatingsForLandlord(landlordId);
            request.setAttribute("ratings", detailedRatings);
            
            // Get rating statistics
            Map<String, Object> ratingStats = ratingDAO.getLandlordRatingStatistics(landlordId);
            request.setAttribute("ratingStats", ratingStats);
            
            // Check if current user can rate this landlord (i.e., is a renter and hasn't rated before)
            boolean canRate = false;
            if ("Renter".equals(currentUser.getRole())) {
                canRate = !ratingDAO.hasRated(currentUser.getUserId(), landlordId);
            }
            request.setAttribute("canRate", canRate);
            
            // Forward to view page
            request.getRequestDispatcher("/view/common/landlord-ratings.jsp").forward(request, response);
        } else if ("getLandlordRatingStats".equals(action)) {
            // AJAX request for landlord rating statistics
            String landlordIdStr = request.getParameter("landlordId");
            int landlordId = Integer.parseInt(landlordIdStr);
            
            Map<String, Object> ratingStats = ratingDAO.getLandlordRatingStatistics(landlordId);
            
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("averageRating", ratingStats.get("averageRating"));
            jsonResponse.put("totalRatings", ratingStats.get("totalRatings"));
            
            Map<Integer, Integer> distribution = (Map<Integer, Integer>) ratingStats.get("distribution");
            JSONObject distJson = new JSONObject();
            distribution.forEach((key, value) -> distJson.put(key.toString(), value));
            jsonResponse.put("distribution", distJson);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
            out.flush();
        } else {
            // Default view - shows user's ratings
            if ("Landlord".equals(currentUser.getRole())) {
                // For landlords - show their received ratings
                List<Map<String, Object>> detailedRatings = ratingDAO.getDetailedRatingsForLandlord(currentUser.getUserId());
                request.setAttribute("ratings", detailedRatings);
                
                Map<String, Object> ratingStats = ratingDAO.getLandlordRatingStatistics(currentUser.getUserId());
                request.setAttribute("ratingStats", ratingStats);
                
                request.getRequestDispatcher("/view/common/my-ratings.jsp").forward(request, response);
            } else {
                // For renters - show the ratings they've given
                List<InteractionRating> ratings = ratingDAO.getRatingsByRenterId(currentUser.getUserId());
                request.setAttribute("ratings", ratings);
                request.getRequestDispatcher("/view/common/my-ratings.jsp").forward(request, response);
            }
        }
    }

    /**
     * Handles the HTTP POST method - submit new ratings
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        if ("submitRating".equals(action)) {
            String landlordIdStr = request.getParameter("landlordId");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");
            
            // Validate input
            if (landlordIdStr == null || ratingStr == null || comment == null) {
                request.setAttribute("error", "Missing required fields");
                response.sendRedirect(request.getContextPath() + "/ratings");
                return;
            }
            
            try {
                int landlordId = Integer.parseInt(landlordIdStr);
                int ratingValue = Integer.parseInt(ratingStr);
                
                // Validate rating value
                if (ratingValue < 1 || ratingValue > 5) {
                    request.setAttribute("error", "Invalid rating value");
                    response.sendRedirect(request.getContextPath() + "/ratings");
                    return;
                }
                
                // Check if user is a renter
                if (!"Renter".equals(currentUser.getRole())) {
                    request.setAttribute("error", "Only renters can submit ratings");
                    response.sendRedirect(request.getContextPath() + "/ratings");
                    return;
                }
                
                // Check if renter has already rated this landlord
                if (ratingDAO.hasRated(currentUser.getUserId(), landlordId)) {
                    request.setAttribute("error", "You have already rated this landlord");
                    response.sendRedirect(request.getContextPath() + "/ratings?action=viewLandlordRatings&landlordId=" + landlordId);
                    return;
                }
                  // Create and save the rating
                InteractionRating rating = new InteractionRating();
                rating.setRenterId(currentUser.getUserId());
                rating.setLandlordId(landlordId);
                rating.setRating(ratingValue);
                rating.setComment(comment);
                rating.setRatingDate(new Date());
                
                boolean success = ratingDAO.insert(rating);
                
                if (success) {
                    request.setAttribute("success", "Rating submitted successfully");
                    
                    // Send notification to landlord about the new rating
                    try {
                        NotificationDAO notificationDAO = new NotificationDAO();
                        Notification notification = new Notification();
                        notification.setUserId(landlordId);
                        
                        // Create a personalized notification message including the rating value
                        StringBuilder message = new StringBuilder();
                        message.append(currentUser.getName()).append(" đã đánh giá bạn ");
                        message.append(ratingValue).append(" sao. ");
                        
                        // Add a different message based on rating value
                        if (ratingValue >= 4) {
                            message.append("Thật tuyệt vời!");
                        } else if (ratingValue == 3) {
                            message.append("Cảm ơn vì đánh giá của bạn.");
                        } else {
                            message.append("Hãy xem đánh giá để cải thiện dịch vụ.");
                        }
                        
                        notification.setMessage(message.toString());
                        notification.setSentDate(new Date());
                        notification.setIsRead(false);
                        notification.setReferenceId(rating.getRatingId());
                        notification.setReferenceType("rating");
                        
                        notificationDAO.insert(notification);
                    } catch (Exception e) {
                        System.out.println("Error sending notification: " + e.getMessage());
                    }
                } else {
                    request.setAttribute("error", "Failed to submit rating");
                }
                
                // Redirect back to the landlord's ratings page
                response.sendRedirect(request.getContextPath() + "/ratings?action=viewLandlordRatings&landlordId=" + landlordId);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid input");
                response.sendRedirect(request.getContextPath() + "/ratings");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/ratings");
        }
    }
}
