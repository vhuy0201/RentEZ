package websocket;

import DAO.MessageDAO;
import DAO.UserDao;
import Model.Message;
import Model.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/chat/{userId}")
public class MessageEndpoint {
    
    // Map để theo dõi các phiên hoạt động theo userId
    private static final Map<Integer, Session> activeSessions = new ConcurrentHashMap<>();
    private static final Gson gson = new Gson();
    
    @OnOpen
    public void onOpen(Session session, @PathParam("userId") int userId) {
        // Lưu phiên làm việc vào map
        activeSessions.put(userId, session);
        System.out.println("Session opened for user: " + userId);
    }
      @OnMessage
    public void onMessage(String message, Session session, @PathParam("userId") int senderId) {
        try {
            JsonObject jsonMessage = gson.fromJson(message, JsonObject.class);
            int receiverId = jsonMessage.get("receiverId").getAsInt();
            int propertyId = jsonMessage.get("propertyId").getAsInt();
            String content = jsonMessage.get("content").getAsString();
            
            // Tạo đối tượng tin nhắn mới
            Message newMessage = new Message();
            newMessage.setSenderId(senderId);
            newMessage.setReceiverId(receiverId);
            newMessage.setPropertyId(propertyId);
            newMessage.setContent(content);
            newMessage.setSendDate(new Date());
            newMessage.setReadStatus(false);
            
            // Lưu tin nhắn vào cơ sở dữ liệu
            MessageDAO messageDAO = new MessageDAO();
            newMessage = messageDAO.save(newMessage);
            
            // Chuyển đổi tin nhắn thành JSON để gửi lại
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("messageId", newMessage.getMessageId());
            jsonResponse.addProperty("senderId", newMessage.getSenderId());
            jsonResponse.addProperty("receiverId", newMessage.getReceiverId());
            jsonResponse.addProperty("propertyId", newMessage.getPropertyId());
            jsonResponse.addProperty("content", newMessage.getContent());
            jsonResponse.addProperty("sendDate", newMessage.getSendDate().getTime());
            jsonResponse.addProperty("readStatus", newMessage.isReadStatus());
            
            // Lấy thông tin người gửi
            UserDao userDao = new UserDao();
            User sender = userDao.getById(senderId);
            if (sender != null) {
                jsonResponse.addProperty("senderName", sender.getName());
                jsonResponse.addProperty("senderAvatar", sender.getAvatar());
            }
            
            // Gửi tin nhắn đến người nhận (nếu đang online)
            Session receiverSession = activeSessions.get(receiverId);
            if (receiverSession != null && receiverSession.isOpen()) {
                receiverSession.getBasicRemote().sendText(jsonResponse.toString());
            }
            
            // Gửi tin nhắn lại cho người gửi để xác nhận
            session.getBasicRemote().sendText(jsonResponse.toString());
            
        } catch (Exception e) {
            System.err.println("Error processing message: " + e.getMessage());
            e.printStackTrace();
            
            try {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "Failed to process message");
                session.getBasicRemote().sendText(errorResponse.toString());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    @OnClose
    public void onClose(Session session, @PathParam("userId") int userId) {
        // Xóa phiên từ map khi đóng kết nối
        activeSessions.remove(userId);
        System.out.println("Session closed for user: " + userId);
    }
    
    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("Error in chat websocket: " + throwable.getMessage());
        throwable.printStackTrace();
    }
    
    // Phương thức kiểm tra trạng thái online của người dùng
    public static boolean isUserOnline(int userId) {
        Session session = activeSessions.get(userId);
        return session != null && session.isOpen();
    }
      // Phương thức lấy danh sách các người dùng đang online
    public static Set<Integer> getOnlineUsers() {
        return Collections.unmodifiableSet(activeSessions.keySet());
    }
    
    // Phương thức gửi tin nhắn đến người dùng cụ thể
    public static void sendMessage(int userId, String content, int senderId) {
        try {
            Session receiverSession = activeSessions.get(userId);
            if (receiverSession != null && receiverSession.isOpen()) {
                JsonObject jsonMessage = new JsonObject();
                jsonMessage.addProperty("senderId", senderId);
                jsonMessage.addProperty("content", content);
                jsonMessage.addProperty("timestamp", new Date().getTime());
                
                // Lấy thông tin người gửi
                UserDao userDao = new UserDao();
                User sender = userDao.getById(senderId);
                if (sender != null) {
                    jsonMessage.addProperty("senderName", sender.getName());
                    jsonMessage.addProperty("senderAvatar", sender.getAvatar());
                }
                
                receiverSession.getBasicRemote().sendText(jsonMessage.toString());
            }
        } catch (IOException e) {
            System.err.println("Error sending message to user " + userId + ": " + e.getMessage());
            e.printStackTrace();
        }
    }
}
