package Controller;

import DAO.PropertyDAO;
import DAO.UserFavoriteDAO;
import DAO.LocationDAO;
import Model.Property;
import Model.User;
import Model.UserFavorite;
import Model.Location;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * Servlet for handling favorite property operations
 */
@WebServlet(name = "FavoriteServlet", urlPatterns = {"/favorites", "/favorite-action"})
public class FavoriteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load user's favorite properties
        loadFavoriteProperties(request, response, currentUser);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "add":
                    addToFavorites(request, response, currentUser);
                    break;
                case "remove":
                    removeFromFavorites(request, response, currentUser);
                    break;
                case "toggle":
                    toggleFavorite(request, response, currentUser);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/favorites");
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/favorites");
        }
    }

    /**
     * Load user's favorite properties
     */
    private void loadFavoriteProperties(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            UserFavoriteDAO favoriteDAO = new UserFavoriteDAO();
            LocationDAO locationDAO = new LocationDAO();

            // Get user's favorite properties
            List<Property> favoriteProperties = favoriteDAO.getFavoritePropertiesByUserId(currentUser.getUserId());

            // Get locations for properties
            Map<Integer, Location> locations = new HashMap<>();
            for (Property property : favoriteProperties) {
                if (!locations.containsKey(property.getLocationId())) {
                    Location location = locationDAO.getById(property.getLocationId());
                    if (location != null) {
                        locations.put(property.getLocationId(), location);
                    }
                }
            }

            // Set attributes
            request.setAttribute("favoriteProperties", favoriteProperties);
            request.setAttribute("locations", locations);
            request.setAttribute("totalFavorites", favoriteProperties.size());

            // Forward to favorites view
            request.getRequestDispatcher("/view/common/favorites.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/favorites?error="
                    + URLEncoder.encode("Lỗi khi tải danh sách yêu thích: " + e.getMessage(), "UTF-8"));
        }
    }

    /**
     * Add property to favorites
     */
    private void addToFavorites(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            String redirectUrl = request.getParameter("redirectUrl");
            
            UserFavoriteDAO favoriteDAO = new UserFavoriteDAO();
            PropertyDAO propertyDAO = new PropertyDAO();

            // Check if property exists
            Property property = propertyDAO.getById(propertyId);
            if (property == null) {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "error", "Bất động sản không tồn tại!"));
                return;
            }

            // Check if already favorited
            if (favoriteDAO.isFavorited(currentUser.getUserId(), propertyId)) {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "info", "Bất động sản đã có trong danh sách yêu thích!"));
                return;
            }

            // Add to favorites
            UserFavorite favorite = new UserFavorite();
            favorite.setUserId(currentUser.getUserId());
            favorite.setPropertyId(propertyId);
            favorite.setCreatedAt(new Date());

            boolean success = favoriteDAO.insert(favorite);

            if (success) {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "success", "Đã thêm vào danh sách yêu thích!"));
            } else {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "error", "Lỗi khi thêm vào danh sách yêu thích!"));
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(getRedirectUrl(request.getParameter("redirectUrl"), request, "error", "ID bất động sản không hợp lệ!"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(getRedirectUrl(request.getParameter("redirectUrl"), request, "error", "Lỗi hệ thống: " + e.getMessage()));
        }
    }

    /**
     * Remove property from favorites
     */
    private void removeFromFavorites(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            String redirectUrl = request.getParameter("redirectUrl");

            UserFavoriteDAO favoriteDAO = new UserFavoriteDAO();

            // Check if favorited
            if (!favoriteDAO.isFavorited(currentUser.getUserId(), propertyId)) {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "info", "Bất động sản không có trong danh sách yêu thích!"));
                return;
            }

            // Remove from favorites
            boolean success = favoriteDAO.deleteByUserAndProperty(currentUser.getUserId(), propertyId);

            if (success) {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "success", "Đã xóa khỏi danh sách yêu thích!"));
            } else {
                response.sendRedirect(getRedirectUrl(redirectUrl, request, "error", "Lỗi khi xóa khỏi danh sách yêu thích!"));
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(getRedirectUrl(request.getParameter("redirectUrl"), request, "error", "ID bất động sản không hợp lệ!"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(getRedirectUrl(request.getParameter("redirectUrl"), request, "error", "Lỗi hệ thống: " + e.getMessage()));
        }
    }

    /**
     * Toggle favorite status (add if not favorited, remove if favorited)
     */
    private void toggleFavorite(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        try {
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            UserFavoriteDAO favoriteDAO = new UserFavoriteDAO();

            if (favoriteDAO.isFavorited(currentUser.getUserId(), propertyId)) {
                // Remove from favorites
                request.setAttribute("action", "remove");
                removeFromFavorites(request, response, currentUser);
            } else {
                // Add to favorites
                request.setAttribute("action", "add");
                addToFavorites(request, response, currentUser);
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(getRedirectUrl(request.getParameter("redirectUrl"), request, "error", "ID bất động sản không hợp lệ!"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(getRedirectUrl(request.getParameter("redirectUrl"), request, "error", "Lỗi hệ thống: " + e.getMessage()));
        }
    }

    /**
     * Helper method to construct redirect URL with message
     */
    private String getRedirectUrl(String redirectUrl, HttpServletRequest request, String messageType, String message) {
        try {
            if (redirectUrl == null || redirectUrl.trim().isEmpty()) {
                redirectUrl = request.getContextPath() + "/favorites";
            }
            
            String separator = redirectUrl.contains("?") ? "&" : "?";
            return redirectUrl + separator + messageType + "=" + URLEncoder.encode(message, "UTF-8");
        } catch (Exception e) {
            return request.getContextPath() + "/favorites";
        }
    }
}
