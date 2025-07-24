package DAO;

import Connection.DBConnection;
import Model.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MessageDAO {

    public Message save(Message message) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Message (SenderID, ReceiverID, PropertyID, Content, SendDate, ReadStatus, IsNegotiation) "
                + "VALUES (?, ?, ?, ?, GETDATE(), ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, message.getSenderId());
            pstmt.setInt(2, message.getReceiverId());
            pstmt.setInt(3, message.getPropertyId());
            pstmt.setString(4, message.getContent());
            pstmt.setBoolean(5, message.isReadStatus());
            pstmt.setBoolean(6, message.isNegotiation());
            
            int rows = pstmt.executeUpdate();
            
            // Get the generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    message.setMessageId(generatedKeys.getInt(1));
                }
            }
            
            conn.close();
            return message;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return message;
        }
    }

    public Message getById(int messageId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Message WHERE MessageID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, messageId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("MessageID"));
                message.setSenderId(rs.getInt("SenderID"));
                message.setReceiverId(rs.getInt("ReceiverID"));
                message.setPropertyId(rs.getInt("PropertyID"));
                message.setContent(rs.getString("Content"));
                message.setSendDate(rs.getTimestamp("SendDate"));
                message.setReadStatus(rs.getBoolean("ReadStatus"));
                message.setNegotiation(rs.getBoolean("IsNegotiation"));
                
                conn.close();
                return message;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean markAsRead(int messageId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Message SET ReadStatus = 1 WHERE MessageID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, messageId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int messageId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Message WHERE MessageID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, messageId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    // Get messages between two users for a specific property
    public List<Message> getConversation(int user1Id, int user2Id, int propertyId) {
        Connection conn = DBConnection.getConnection();
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM Message WHERE ((SenderID = ? AND ReceiverID = ?) OR " +
                     "(SenderID = ? AND ReceiverID = ?)) AND PropertyID = ? ORDER BY SendDate";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user1Id);
            pstmt.setInt(2, user2Id);
            pstmt.setInt(3, user2Id);
            pstmt.setInt(4, user1Id);
            pstmt.setInt(5, propertyId);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("MessageID"));
                message.setSenderId(rs.getInt("SenderID"));
                message.setReceiverId(rs.getInt("ReceiverID"));
                message.setPropertyId(rs.getInt("PropertyID"));
                message.setContent(rs.getString("Content"));
                message.setSendDate(rs.getTimestamp("SendDate"));
                message.setReadStatus(rs.getBoolean("ReadStatus"));
                message.setNegotiation(rs.getBoolean("IsNegotiation"));
                messages.add(message);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return messages;
    }
    
    // Get recent conversations for a user (latest message per conversation)
    public List<Message> getRecentConversations(int userId) {
        Connection conn = DBConnection.getConnection();
       List<Message> conversations = new ArrayList<>();
        
        String sql = "WITH RankedMessages AS (" +
                    "SELECT *, ROW_NUMBER() OVER(PARTITION BY CASE " +
                    "   WHEN SenderID = ? THEN ReceiverID " +
                    "   WHEN ReceiverID = ? THEN SenderID END, PropertyID " +
                    "   ORDER BY SendDate DESC) as RowNum " +
                    "FROM Message " +
                    "WHERE SenderID = ? OR ReceiverID = ?) " +
                    "SELECT * FROM RankedMessages WHERE RowNum = 1 ORDER BY SendDate DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, userId);
            pstmt.setInt(4, userId);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("MessageID"));
                message.setSenderId(rs.getInt("SenderID"));
                message.setReceiverId(rs.getInt("ReceiverID"));
                message.setPropertyId(rs.getInt("PropertyID"));
                message.setContent(rs.getString("Content"));
                message.setSendDate(rs.getTimestamp("SendDate"));
                message.setReadStatus(rs.getBoolean("ReadStatus"));
                message.setNegotiation(rs.getBoolean("IsNegotiation"));
                
                // Use other user's ID as the key (for conversations)
                int otherUserId = message.getSenderId() == userId ? message.getReceiverId() : message.getSenderId();
                conversations.add(otherUserId, message);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return conversations;
    }
    
    // Count unread messages for a user
    public int getUnreadCount(int userId) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Message WHERE ReceiverID = ? AND ReadStatus = 0";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return count;
    }
    
    // Get negotiation messages for a property between two users
    public List<Message> getNegotiationMessages(int user1Id, int user2Id, int propertyId) {
        Connection conn = DBConnection.getConnection();
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM Message WHERE ((SenderID = ? AND ReceiverID = ?) OR " +
                     "(SenderID = ? AND ReceiverID = ?)) AND PropertyID = ? AND IsNegotiation = 1 " +
                     "ORDER BY SendDate";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user1Id);
            pstmt.setInt(2, user2Id);
            pstmt.setInt(3, user2Id);
            pstmt.setInt(4, user1Id);
            pstmt.setInt(5, propertyId);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("MessageID"));
                message.setSenderId(rs.getInt("SenderID"));
                message.setReceiverId(rs.getInt("ReceiverID"));
                message.setPropertyId(rs.getInt("PropertyID"));
                message.setContent(rs.getString("Content"));
                message.setSendDate(rs.getTimestamp("SendDate"));
                message.setReadStatus(rs.getBoolean("ReadStatus"));
                message.setNegotiation(rs.getBoolean("IsNegotiation"));
                messages.add(message);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return messages;
    }
}
