package Controller;

import DAO.MessageDAO;
import DAO.UserDao;
import DAO.PropertyDAO;
import DAO.NotificationDAO;
import Model.Message;
import Model.User;
import Model.Property;
import Model.Notification;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet responsible for handling message-related operations
 */
@WebServlet(name = "MessageServlet", urlPatterns = {"/messages"})
public class MessageServlet extends HttpServlet {
    
    private final MessageDAO messageDAO = new MessageDAO();
    private final UserDao userDAO = new UserDao();
    private final PropertyDAO propertyDAO = new PropertyDAO();
    private final NotificationDAO notificationDAO = new NotificationDAO();

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the chat interface or returns message data for AJAX requests
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */    @Override
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
        
        if ("getConversation".equals(action)) {
            // AJAX request to get conversation messages
            handleGetConversation(request, response, currentUser);
        } else if ("getConversations".equals(action)) {
            // AJAX request to get all conversations
            handleGetConversations(request, response, currentUser);
        } else {
            // Display the chat page
            int otherUserId = 0;
            int propertyId = 0;
            
            // Check if a specific conversation is requested
            String otherUserIdStr = request.getParameter("userId");
            String propertyIdStr = request.getParameter("propertyId");
            
            if (otherUserIdStr != null && !otherUserIdStr.isEmpty() && propertyIdStr != null && !propertyIdStr.isEmpty()) {
                try {
                    otherUserId = Integer.parseInt(otherUserIdStr);
                    propertyId = Integer.parseInt(propertyIdStr);
                    
                    // Get user information for display
                    User chatUser = userDAO.getById(otherUserId);
                    if (chatUser != null) {
                        request.setAttribute("chatUser", chatUser);
                    }
                    
                    // Get property information for display
                    Property property = propertyDAO.getById(propertyId);
                    if (property != null) {
                        request.setAttribute("property", property);
                    }
                    
                    // Get messages for this conversation
                    List<Message> messages = messageDAO.getConversation(currentUser.getUserId(), otherUserId, propertyId);
                    request.setAttribute("messages", messages);
                    
                    // Mark any unread messages as read
                    for (Message message : messages) {
                        if (message.getReceiverId() == currentUser.getUserId() && !message.isReadStatus()) {
                            messageDAO.markAsRead(message.getMessageId());
                        }
                    }
                } catch (NumberFormatException e) {
                    // Invalid user or property ID, ignore
                }
            }
            
            // Get all conversations for sidebar
            List<Message> conversations = messageDAO.getRecentConversations(currentUser.getUserId());
            List<Object> conversationList = new ArrayList<>();
            
            for (Message message : conversations) {
                Map<String, Object> conversationMap = new HashMap<>();
                
                // Determine the other user in the conversation
                int convoUserId = message.getSenderId() == currentUser.getUserId() ? message.getReceiverId() : message.getSenderId();
                User otherUser = userDAO.getById(convoUserId);
                
                if (otherUser != null) {
                    conversationMap.put("userId", otherUser.getUserId());
                    conversationMap.put("userName", otherUser.getName());
                    conversationMap.put("userAvatar", otherUser.getAvatar());
                }
                
                // Get property details
                Property property = propertyDAO.getById(message.getPropertyId());
                if (property != null) {
                    conversationMap.put("propertyId", property.getPropertyId());
                    conversationMap.put("propertyTitle", property.getTitle());
                }
                
                // Message details
                conversationMap.put("lastMessage", message.getContent());
                conversationMap.put("lastMessageDate", message.getSendDate());
                conversationMap.put("isRead", message.isReadStatus());
                conversationMap.put("isSentByMe", message.getSenderId() == currentUser.getUserId());
                
                // Date helpers for formatting
                Date today = new Date();
                Date yesterday = new Date(today.getTime() - 24 * 60 * 60 * 1000);
                conversationMap.put("isToday", isSameDay(message.getSendDate(), today));
                conversationMap.put("isYesterday", isSameDay(message.getSendDate(), yesterday));
                
                // Count unread messages
                int unreadCount = 0;
                if (message.getReceiverId() == currentUser.getUserId() && !message.isReadStatus()) {
                    unreadCount = 1; // At minimum the last message is unread
                }
                conversationMap.put("unreadCount", unreadCount);
                
                conversationList.add(conversationMap);
            }
            
            request.setAttribute("conversations", conversationList);
            request.getRequestDispatcher("/view/common/message.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes message sending
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */    @Override
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
        
        if ("sendMessage".equals(action)) {
            handleSendMessage(request, response, currentUser);
        } else if ("markAsRead".equals(action)) {
            handleMarkAsRead(request, response, currentUser);
        } else if ("checkOnlineStatus".equals(action)) {
            handleCheckOnlineStatus(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/messages");
        }
    }
    
    /**
     * Handle sending a new message
     */
    private void handleSendMessage(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws IOException {
        
        String receiverIdStr = request.getParameter("receiverId");
        String propertyIdStr = request.getParameter("propertyId");
        String content = request.getParameter("content");
        String isNegotiationStr = request.getParameter("isNegotiation");
        String isAjax = request.getParameter("isAjax");
        
        JSONObject jsonResponse = new JSONObject();
        boolean success = false;
        
        try {
            if (receiverIdStr != null && propertyIdStr != null && content != null && !content.trim().isEmpty()) {
                int receiverId = Integer.parseInt(receiverIdStr);
                int propertyId = Integer.parseInt(propertyIdStr);
                boolean isNegotiation = "true".equals(isNegotiationStr);
                
                Message message = new Message();
                message.setSenderId(currentUser.getUserId());
                message.setReceiverId(receiverId);
                message.setPropertyId(propertyId);
                message.setContent(content);
                message.setSendDate(new Date());
                message.setReadStatus(false);
                message.setNegotiation(isNegotiation);
                
                Message savedMessage = messageDAO.save(message);
                if (savedMessage.getMessageId() > 0) {
                    success = true;
                    
                    // Create a notification for the receiver
                    Notification notification = new Notification();
                    notification.setUserId(receiverId);
                    notification.setMessage("Bạn có một tin nhắn mới từ " + currentUser.getName());
                    notification.setSentDate(new Date());
                    notification.setIsRead(false);
                    notification.setReferenceId(savedMessage.getMessageId());
                    notification.setReferenceType("Message");
                    
                    notificationDAO.insert(notification);
                    
                    if ("true".equals(isAjax)) {
                        jsonResponse.put("messageId", savedMessage.getMessageId());
                        jsonResponse.put("sendDate", savedMessage.getSendDate().getTime());
                    }
                }
            }
        } catch (Exception e) {
            success = false;
            System.out.println("Error sending message: " + e.getMessage());
        }
        
        if ("true".equals(isAjax)) {
            jsonResponse.put("success", success);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
            out.flush();
        } else {
            // Redirect back to the conversation
            String redirectUrl = request.getContextPath() + "/messages";
            
            String receiverId = request.getParameter("receiverId");
            String propertyId = request.getParameter("propertyId");
            
            if (receiverId != null && propertyId != null) {
                redirectUrl += "?userId=" + receiverId + "&propertyId=" + propertyId;
            }
            
            response.sendRedirect(redirectUrl);
        }
    }
    
    /**
     * Handle marking a message as read
     */
    private void handleMarkAsRead(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws IOException {
        
        String messageIdStr = request.getParameter("messageId");
        String isAjax = request.getParameter("isAjax");
        
        JSONObject jsonResponse = new JSONObject();
        boolean success = false;
        
        try {
            int messageId = Integer.parseInt(messageIdStr);
            
            // Verify this is for the current user
            Message message = messageDAO.getById(messageId);
            if (message != null && message.getReceiverId() == currentUser.getUserId()) {
                success = messageDAO.markAsRead(messageId);
            }
        } catch (Exception e) {
            success = false;
            System.out.println("Error marking message as read: " + e.getMessage());
        }
        
        if ("true".equals(isAjax)) {
            jsonResponse.put("success", success);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse.toString());
            out.flush();
        } else {
            response.sendRedirect(request.getContextPath() + "/messages");
        }
    }
    
    /**
     * Handle getting messages for a specific conversation
     */
    private void handleGetConversation(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws IOException {
        
        String otherUserIdStr = request.getParameter("userId");
        String propertyIdStr = request.getParameter("propertyId");
        
        JSONObject jsonResponse = new JSONObject();
        
        try {
            int otherUserId = Integer.parseInt(otherUserIdStr);
            int propertyId = Integer.parseInt(propertyIdStr);
            
            List<Message> messages = messageDAO.getConversation(
                    currentUser.getUserId(), otherUserId, propertyId);
            
            JSONArray messagesArray = new JSONArray();
            for (Message message : messages) {
                JSONObject messageObj = new JSONObject();
                messageObj.put("messageId", message.getMessageId());
                messageObj.put("senderId", message.getSenderId());
                messageObj.put("receiverId", message.getReceiverId());
                messageObj.put("content", message.getContent());
                messageObj.put("sendDate", message.getSendDate().getTime());
                messageObj.put("isRead", message.isReadStatus());
                messageObj.put("isNegotiation", message.isNegotiation());
                messageObj.put("isSentByMe", message.getSenderId() == currentUser.getUserId());
                
                messagesArray.put(messageObj);
                
                // Mark message as read if it was received by the current user
                if (message.getReceiverId() == currentUser.getUserId() && !message.isReadStatus()) {
                    messageDAO.markAsRead(message.getMessageId());
                }
            }
            
            // Get the other user's info
            User otherUser = userDAO.getById(otherUserId);
            if (otherUser != null) {
                JSONObject userObj = new JSONObject();
                userObj.put("userId", otherUser.getUserId());
                userObj.put("name", otherUser.getName());
                userObj.put("avatar", otherUser.getAvatar());
                jsonResponse.put("user", userObj);
            }
            
            // Get the property info
            Property property = propertyDAO.getById(propertyId);
            if (property != null) {
                JSONObject propertyObj = new JSONObject();
                propertyObj.put("propertyId", property.getPropertyId());
                propertyObj.put("title", property.getTitle());
                propertyObj.put("thumbnail", "");
                jsonResponse.put("property", propertyObj);
            }
            
            jsonResponse.put("messages", messagesArray);
            jsonResponse.put("success", true);
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Error retrieving conversation: " + e.getMessage());
            System.out.println("Error retrieving conversation: " + e.getMessage());
        }
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
      /**
     * Handle getting all conversations for the current user
     */
    private void handleGetConversations(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws IOException {
        
        JSONObject jsonResponse = new JSONObject();
        
        try {
            List<Message> conversations = messageDAO.getRecentConversations(currentUser.getUserId());
            
            JSONArray conversationsArray = new JSONArray();
            for (Message message : conversations) {
                JSONObject conversationObj = new JSONObject();
                
                // Determine the other user in the conversation
                int otherUserId = (message.getSenderId() == currentUser.getUserId()) 
                        ? message.getReceiverId() : message.getSenderId();
                
                User otherUser = userDAO.getById(otherUserId);
                if (otherUser != null) {
                    conversationObj.put("userId", otherUser.getUserId());
                    conversationObj.put("name", otherUser.getName());
                    conversationObj.put("avatar", otherUser.getAvatar());
                }
                
                // Get property details
                Property property = propertyDAO.getById(message.getPropertyId());
                if (property != null) {
                    conversationObj.put("propertyId", property.getPropertyId());
                    conversationObj.put("propertyTitle", property.getTitle());
                    conversationObj.put("propertyThumbnail", "");
                }
                
                // Message details
                conversationObj.put("lastMessageId", message.getMessageId());
                conversationObj.put("lastMessage", message.getContent());
                conversationObj.put("lastMessageTime", message.getSendDate().getTime());
                conversationObj.put("isRead", message.isReadStatus());
                conversationObj.put("isSentByMe", message.getSenderId() == currentUser.getUserId());
                
                // Add date helpers for UI formatting
                Date messageDate = message.getSendDate();
                Date today = new Date();
                Date yesterday = new Date(today.getTime() - 24 * 60 * 60 * 1000);
                
                boolean isToday = isSameDay(messageDate, today);
                boolean isYesterday = isSameDay(messageDate, yesterday);
                
                conversationObj.put("isToday", isToday);
                conversationObj.put("isYesterday", isYesterday);
                
                // Get unread message count
                int unreadCount = 0;
                if (message.getReceiverId() == currentUser.getUserId() && !message.isReadStatus()) {
                    unreadCount = 1;  // At least the latest message is unread
                }
                conversationObj.put("unreadCount", unreadCount);
                
                conversationsArray.put(conversationObj);
            }
            
            jsonResponse.put("conversations", conversationsArray);
            jsonResponse.put("success", true);
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Error retrieving conversations: " + e.getMessage());
            System.out.println("Error retrieving conversations: " + e.getMessage());
        }
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    /**
     * Check if two dates are on the same day
     */
    private boolean isSameDay(Date date1, Date date2) {
        if (date1 == null || date2 == null) {
            return false;
        }
        java.util.Calendar cal1 = java.util.Calendar.getInstance();
        cal1.setTime(date1);
        java.util.Calendar cal2 = java.util.Calendar.getInstance();
        cal2.setTime(date2);
        return cal1.get(java.util.Calendar.YEAR) == cal2.get(java.util.Calendar.YEAR) &&
                cal1.get(java.util.Calendar.MONTH) == cal2.get(java.util.Calendar.MONTH) &&
                cal1.get(java.util.Calendar.DAY_OF_MONTH) == cal2.get(java.util.Calendar.DAY_OF_MONTH);
    }
    
    /**
     * Handle checking online status of a user
     */
    private void handleCheckOnlineStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        String userIdStr = request.getParameter("userId");
        JSONObject jsonResponse = new JSONObject();
        
        try {
            int userId = Integer.parseInt(userIdStr);
            
            // For simplicity, we'll consider a user online if they've been active in the last 5 minutes
            // In a production environment, you'd use a more sophisticated approach
            boolean isOnline = isUserOnline(userId);
            
            jsonResponse.put("isOnline", isOnline);
            jsonResponse.put("success", true);
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Error checking online status: " + e.getMessage());
        }
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    /**
     * Check if a user is online
     * This is a simplified implementation
     */
    private boolean isUserOnline(int userId) {
        // In a real implementation, you'd check against a session store or activity tracker
        // For now, we'll use servlet's built-in session management and consider all users offline
        // unless they're in one of the active sessions
        
        return false; // Simplified implementation
    }
}
