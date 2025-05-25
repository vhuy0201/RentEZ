package Controller;

import DAO.LocationDAO;
import DAO.MessageDAO;
import DAO.PropertyDAO;
import DAO.UserDao;
import Model.Location;
import Model.Message;
import Model.Property;
import Model.User;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import websocket.MessageEndpoint;

public class MessageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Khởi tạo các DAO
            MessageDAO messageDAO = new MessageDAO();
            UserDao userDao = new UserDao();
            PropertyDAO propertyDAO = new PropertyDAO();
            
            // Lấy thông tin người dùng đang nhắn tin nếu được chỉ định
            String userIdParam = request.getParameter("userId");
            String propertyIdParam = request.getParameter("propertyId");
            
            int chatUserId = 0;
            int propertyId = 0;
            
            if (userIdParam != null && !userIdParam.isEmpty()) {
                chatUserId = Integer.parseInt(userIdParam);
            }
            
            if (propertyIdParam != null && !propertyIdParam.isEmpty()) {
                propertyId = Integer.parseInt(propertyIdParam);
            }
            
            // Lấy danh sách các cuộc trò chuyện gần đây
            List<Message> recentConversations = messageDAO.getRecentConversations(currentUser.getUserId());
            List<Map<String, Object>> conversationsList = new ArrayList<>();
            
            for (Message message : recentConversations) {
                Map<String, Object> conversationData = new HashMap<>();
                
                // Xác định ID người dùng khác trong cuộc trò chuyện
                int otherUserId = (message.getSenderId() == currentUser.getUserId()) ? 
                        message.getReceiverId() : message.getSenderId();
                
                // Lấy thông tin người dùng
                User otherUser = userDao.getById(otherUserId);
                
                // Lấy thông tin bất động sản
                Property property = propertyDAO.getById(message.getPropertyId());
                
                if (otherUser != null && property != null) {
                    conversationData.put("userId", otherUser.getUserId());
                    conversationData.put("userName", otherUser.getName());
                    conversationData.put("userAvatar", otherUser.getAvatar());
                    conversationData.put("propertyId", property.getPropertyId());
                    conversationData.put("propertyTitle", property.getTitle());
                    conversationData.put("lastMessage", message.getContent());
                    conversationData.put("lastMessageDate", message.getSendDate());
                    conversationData.put("isOnline", MessageEndpoint.isUserOnline(otherUserId));
                    conversationData.put("unreadCount", messageDAO.getUnreadCount(currentUser.getUserId()));
                    
                    conversationsList.add(conversationData);
                }
            }
            
            request.setAttribute("conversations", conversationsList);
              // Nếu có người dùng và bất động sản được chỉ định, lấy lịch sử chat
            if (chatUserId > 0 && propertyId > 0) {
                User chatUser = userDao.getById(chatUserId);
                Property property = propertyDAO.getById(propertyId);
                
                if (chatUser != null && property != null) {
                    List<Message> messages = messageDAO.getConversation(
                            currentUser.getUserId(), chatUserId, propertyId);
                    
                    // Lấy thông tin địa điểm của bất động sản
                    LocationDAO locationDAO = new LocationDAO();
                    Location propertyLocation = locationDAO.getById(property.getLocationId());
                    
                    request.setAttribute("chatUser", chatUser);
                    request.setAttribute("property", property);
                    request.setAttribute("propertyLocation", propertyLocation);
                    request.setAttribute("messages", messages);
                    request.setAttribute("currentUserId", currentUser.getUserId());
                }
            }
            
            // Chuyển hướng đến trang tin nhắn
            request.getRequestDispatcher("/view/common/message.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("error", "You must be logged in to send messages");
            
            PrintWriter out = response.getWriter();
            out.println(jsonResponse.toString());
            return;
        }
        
        try {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            // Đọc tham số từ request
            String action = request.getParameter("action");
            
            if ("markAsRead".equals(action)) {
                // Đánh dấu tin nhắn đã đọc
                int messageId = Integer.parseInt(request.getParameter("messageId"));
                
                MessageDAO messageDAO = new MessageDAO();
                messageDAO.markAsRead(messageId);
                
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("success", true);
                out.println(jsonResponse.toString());                  } else if ("getUnreadCount".equals(action)) {
                // Lấy số lượng tin nhắn chưa đọc
                MessageDAO messageDAO = new MessageDAO();
                int unreadCount = messageDAO.getUnreadCount(currentUser.getUserId());
                
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("unreadCount", unreadCount);
                out.println(jsonResponse.toString());
                
            } else if ("checkOnlineStatus".equals(action)) {
                // Kiểm tra trạng thái online của người dùng
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean isOnline = MessageEndpoint.isUserOnline(userId);
                
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("isOnline", isOnline);
                out.println(jsonResponse.toString());
                
            } else if ("sendMessage".equals(action)) {
                // Xử lý gửi tin nhắn mới
                int receiverId = Integer.parseInt(request.getParameter("receiverId"));
                int propertyId = Integer.parseInt(request.getParameter("propertyId"));
                String content = request.getParameter("content");
                
                // Tạo đối tượng Message mới
                Message message = new Message();
                message.setSenderId(currentUser.getUserId());
                message.setReceiverId(receiverId);
                message.setPropertyId(propertyId);
                message.setContent(content);
                message.setSendDate(new java.util.Date());
                message.setReadStatus(false);
                
                // Lưu tin nhắn vào database
                MessageDAO messageDAO = new MessageDAO();
                message = messageDAO.save(message);
                
                // Gửi thông báo websocket nếu có
                if (MessageEndpoint.isUserOnline(receiverId)) {
                    MessageEndpoint.sendMessage(receiverId, content, currentUser.getUserId());
                }
                
                // Chuyển hướng người dùng đến trang tin nhắn
                response.sendRedirect(request.getContextPath() + "/messages?userId=" + receiverId + "&propertyId=" + propertyId);
                return;
            } else {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("error", "Invalid action");
                out.println(jsonResponse.toString());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("error", e.getMessage());
            
            PrintWriter out = response.getWriter();
            out.println(jsonResponse.toString());
        }
    }
}
