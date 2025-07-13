package Controller;

import Model.Notification;
import Model.User;
import Service.NotificationService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet responsible for handling notification-related operations
 */
@WebServlet(name = "NotificationServlet", urlPatterns = {"/notifications"})
public class NotificationServlet extends HttpServlet {

    private NotificationService notificationService;
    
    @Override
    public void init() {
        notificationService = new NotificationService();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the user's notifications page
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
        
        User user = (User) session.getAttribute("user");
        
        // Check if this is an AJAX request for notification count/data
        String action = request.getParameter("action");
        if (action != null) {
            handleAjaxRequest(action, user.getUserId(), request, response);
            return;
        }
        
        // Get all notifications for the user
        List<Notification> notifications = notificationService.getUserNotifications(user.getUserId());
        request.setAttribute("notifications", notifications);
        
        // Forward to notifications page
        request.getRequestDispatcher("/view/common/notifications.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes notification actions like mark-as-read or delete
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
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        if ("markAsRead".equals(action)) {
            handleMarkAsRead(request, response, user);
        } else if ("markAllAsRead".equals(action)) {
            handleMarkAllAsRead(request, response, user);
        } else if ("delete".equals(action)) {
            handleDeleteNotification(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/notifications");
        }
    }
    
    /**
     * Handle AJAX requests for notification data
     * 
     * @param action The requested action
     * @param userId The user ID
     * @param request The HTTP request
     * @param response The HTTP response
     * @throws IOException If an I/O error occurs
     */
    private void handleAjaxRequest(String action, int userId, HttpServletRequest request, 
            HttpServletResponse response) throws IOException {
        
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        
        JSONObject jsonResponse = new JSONObject();
        
        if ("getCount".equals(action)) {
            // Return unread notification count
            int count = notificationService.getUnreadCount(userId);
            jsonResponse.put("count", count);
            
        } else if ("getNotifications".equals(action)) {
            // Return recent notifications
            List<Notification> notifications = notificationService.getUnreadNotifications(userId);
            JSONArray notificationsArray = new JSONArray();
            
            // Limit to 5 most recent notifications
            int limit = Math.min(5, notifications.size());
            for (int i = 0; i < limit; i++) {
                Notification notification = notifications.get(i);
                JSONObject notificationObj = new JSONObject();
                notificationObj.put("id", notification.getNotificationId());
                notificationObj.put("message", notification.getMessage());
                notificationObj.put("date", notification.getSentDate().toString());
                notificationObj.put("referenceType", notification.getReferenceType());
                notificationObj.put("referenceId", notification.getReferenceId());
                notificationsArray.put(notificationObj);
            }
            
            jsonResponse.put("notifications", notificationsArray);
            jsonResponse.put("count", notificationService.getUnreadCount(userId));
        }
        
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    /**
     * Handle marking a notification as read
     * 
     * @param request The HTTP request
     * @param response The HTTP response
     * @param user The current user
     * @throws IOException If an I/O error occurs
     */
    private void handleMarkAsRead(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException {
        
        String notificationIdStr = request.getParameter("notificationId");
        String isAjax = request.getParameter("isAjax");
        
        try {
            int notificationId = Integer.parseInt(notificationIdStr);
            
            // Verify this notification belongs to the current user
            Notification notification = notificationService.getNotificationById(notificationId);
            if (notification != null && notification.getUserId() == user.getUserId()) {
                boolean success = notificationService.markAsRead(notificationId);
                
                if ("true".equals(isAjax)) {
                    // Return JSON response
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("success", success);
                    
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    out.print(jsonResponse.toString());
                    out.flush();
                } else {
                    // Redirect back to notifications page
                    response.sendRedirect(request.getContextPath() + "/notifications");
                }
            } else {
                // Unauthorized access
                if ("true".equals(isAjax)) {
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Unauthorized");
                    
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    out.print(jsonResponse.toString());
                    out.flush();
                } else {
                    response.sendRedirect(request.getContextPath() + "/notifications");
                }
            }
        } catch (NumberFormatException e) {
            if ("true".equals(isAjax)) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Invalid notification ID");
                
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                response.sendRedirect(request.getContextPath() + "/notifications");
            }
        }
    }
    
    /**
     * Handle marking all notifications as read
     * 
     * @param request The HTTP request
     * @param response The HTTP response
     * @param user The current user
     * @throws IOException If an I/O error occurs
     */
    private void handleMarkAllAsRead(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException {
        
        String isAjax = request.getParameter("isAjax");
        boolean success = notificationService.markAllAsRead(user.getUserId());
        
        if ("true".equals(isAjax)) {
            // Return JSON response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", success);
            
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            out.print(jsonResponse.toString());
            out.flush();
        } else {
            // Redirect back to notifications page
            response.sendRedirect(request.getContextPath() + "/notifications");
        }
    }
    
    /**
     * Handle deleting a notification
     * 
     * @param request The HTTP request
     * @param response The HTTP response
     * @param user The current user
     * @throws IOException If an I/O error occurs
     */
    private void handleDeleteNotification(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException {
        
        String notificationIdStr = request.getParameter("notificationId");
        String isAjax = request.getParameter("isAjax");
        
        try {
            int notificationId = Integer.parseInt(notificationIdStr);
            
            // Verify this notification belongs to the current user
            Notification notification = notificationService.getNotificationById(notificationId);
            if (notification != null && notification.getUserId() == user.getUserId()) {
                boolean success = notificationService.deleteNotification(notificationId);
                
                if ("true".equals(isAjax)) {
                    // Return JSON response
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("success", success);
                    
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    out.print(jsonResponse.toString());
                    out.flush();
                } else {
                    // Redirect back to notifications page
                    response.sendRedirect(request.getContextPath() + "/notifications");
                }
            } else {
                // Unauthorized access
                if ("true".equals(isAjax)) {
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Unauthorized");
                    
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    out.print(jsonResponse.toString());
                    out.flush();
                } else {
                    response.sendRedirect(request.getContextPath() + "/notifications");
                }
            }
        } catch (NumberFormatException e) {
            if ("true".equals(isAjax)) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Invalid notification ID");
                
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                response.sendRedirect(request.getContextPath() + "/notifications");
            }
        }
    }
}
