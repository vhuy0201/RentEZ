package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.Message;
import Connection.DBConnection;

public class MessageDAO {
    
    public List<Message> getMessagesBetweenUsers(int user1Id, int user2Id) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM Message WHERE " +
                    "((senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?)) " +
                    "ORDER BY sendDate ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, user1Id);
            stmt.setInt(2, user2Id);
            stmt.setInt(3, user2Id);
            stmt.setInt(4, user1Id);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("messageId"));
                message.setSenderId(rs.getInt("senderId"));
                message.setReceiverId(rs.getInt("receiverId"));
                message.setPropertyId(rs.getInt("propertyId"));
                message.setContent(rs.getString("content"));
                message.setSendDate(rs.getTimestamp("sendDate"));
                message.setReadStatus(rs.getBoolean("readStatus"));
                message.setNegotiation(rs.getBoolean("isNegotiation"));
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
    
    public List<Message> getConversationsByUserId(int userId) {
        List<Message> conversations = new ArrayList<>();
        String sql = "WITH LastMessages AS ( " +
                    "SELECT *, " +
                    "ROW_NUMBER() OVER (PARTITION BY " +
                    "CASE WHEN senderId < receiverId THEN CAST(senderId AS VARCHAR) + '-' + CAST(receiverId AS VARCHAR) + '-' + CAST(propertyId AS VARCHAR) " +
                    "ELSE CAST(receiverId AS VARCHAR) + '-' + CAST(senderId AS VARCHAR) + '-' + CAST(propertyId AS VARCHAR) END " +
                    "ORDER BY sendDate DESC) as rn " +
                    "FROM Messages WHERE senderId = ? OR receiverId = ? " +
                    ") " +
                    "SELECT * FROM LastMessages WHERE rn = 1 ORDER BY sendDate DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("messageId"));
                message.setSenderId(rs.getInt("senderId"));
                message.setReceiverId(rs.getInt("receiverId"));
                message.setPropertyId(rs.getInt("propertyId"));
                message.setContent(rs.getString("content"));
                message.setSendDate(rs.getTimestamp("sendDate"));
                message.setReadStatus(rs.getBoolean("readStatus"));
                message.setNegotiation(rs.getBoolean("isNegotiation"));
                conversations.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return conversations;
    }
    
    public boolean sendMessage(Message message) {
        String sql = "INSERT INTO Message (senderId, receiverId, propertyId, content, sendDate, readStatus, isNegotiation) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, message.getSenderId());
            stmt.setInt(2, message.getReceiverId());
            stmt.setInt(3, message.getPropertyId());
            stmt.setString(4, message.getContent());
            stmt.setTimestamp(5, new Timestamp(message.getSendDate().getTime()));
            stmt.setBoolean(6, message.isReadStatus());
            stmt.setBoolean(7, message.isNegotiation());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean markAsRead(int messageId) {
        String sql = "UPDATE Messages SET readStatus = 1 WHERE messageId = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, messageId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean markConversationAsRead(int userId, int otherUserId, int propertyId) {
        String sql = "UPDATE Messages SET readStatus = 1 WHERE receiverId = ? AND senderId = ? AND propertyId = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, otherUserId);
            stmt.setInt(3, propertyId);
            return stmt.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getUnreadMessageCount(int userId) {
        String sql = "SELECT COUNT(*) FROM Messages WHERE receiverId = ? AND readStatus = 0";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public Message getMessageById(int messageId) {
        String sql = "SELECT * FROM Messages WHERE messageId = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, messageId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("messageId"));
                message.setSenderId(rs.getInt("senderId"));
                message.setReceiverId(rs.getInt("receiverId"));
                message.setPropertyId(rs.getInt("propertyId"));
                message.setContent(rs.getString("content"));
                message.setSendDate(rs.getTimestamp("sendDate"));
                message.setReadStatus(rs.getBoolean("readStatus"));
                message.setNegotiation(rs.getBoolean("isNegotiation"));
                return message;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public List<Message> getRecentMessages(int userId, int limit) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Messages WHERE receiverId = ? AND readStatus = 0 ORDER BY sendDate DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            stmt.setInt(2, userId);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("messageId"));
                message.setSenderId(rs.getInt("senderId"));
                message.setReceiverId(rs.getInt("receiverId"));
                message.setPropertyId(rs.getInt("propertyId"));
                message.setContent(rs.getString("content"));
                message.setSendDate(rs.getTimestamp("sendDate"));
                message.setReadStatus(rs.getBoolean("readStatus"));
                message.setNegotiation(rs.getBoolean("isNegotiation"));
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
}