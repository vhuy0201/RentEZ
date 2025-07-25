package DAO;

import Connection.DBConnection;
import Model.ContactMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {

    public boolean insertContactMessage(ContactMessage contactMessage) {
        String sql = "INSERT INTO ContactMessage (FirstName, LastName, Email, Phone, Subject, Message, PrivacyPolicyAccepted) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, contactMessage.getFirstName());
            pstmt.setString(2, contactMessage.getLastName());
            pstmt.setString(3, contactMessage.getEmail());
            pstmt.setString(4, contactMessage.getPhone());
            pstmt.setString(5, contactMessage.getSubject());
            pstmt.setString(6, contactMessage.getMessage());
            pstmt.setBoolean(7, contactMessage.isPrivacyPolicyAccepted());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get all contact messages with pagination
     * @param page Page number (starting from 1)
     * @param pageSize Number of records per page
     * @return List of ContactMessage objects
     */
    public List<ContactMessage> getAllContactMessages(int page, int pageSize) {
        List<ContactMessage> messages = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        
        String sql = "SELECT MessageID, FirstName, LastName, Email, Phone, Subject, Message, " +
                     "PrivacyPolicyAccepted, CreatedAt FROM ContactMessage " +
                     "ORDER BY CreatedAt DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, offset);
            pstmt.setInt(2, pageSize);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ContactMessage message = new ContactMessage();
                    message.setMessageID(rs.getInt("MessageID"));
                    message.setFirstName(rs.getString("FirstName"));
                    message.setLastName(rs.getString("LastName"));
                    message.setEmail(rs.getString("Email"));
                    message.setPhone(rs.getString("Phone"));
                    message.setSubject(rs.getString("Subject"));
                    message.setMessage(rs.getString("Message"));
                    message.setPrivacyPolicyAccepted(rs.getBoolean("PrivacyPolicyAccepted"));
                    message.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    
                    messages.add(message);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
    
    /**
     * Get total count of contact messages
     * @return Total number of contact messages
     */
    public int getTotalContactMessagesCount() {
        String sql = "SELECT COUNT(*) FROM ContactMessage";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * Get contact message by ID
     * @param messageID ID of the message
     * @return ContactMessage object or null if not found
     */
    public ContactMessage getContactMessageById(int messageID) {
        String sql = "SELECT MessageID, FirstName, LastName, Email, Phone, Subject, Message, " +
                     "PrivacyPolicyAccepted, CreatedAt FROM ContactMessage WHERE MessageID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, messageID);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ContactMessage message = new ContactMessage();
                    message.setMessageID(rs.getInt("MessageID"));
                    message.setFirstName(rs.getString("FirstName"));
                    message.setLastName(rs.getString("LastName"));
                    message.setEmail(rs.getString("Email"));
                    message.setPhone(rs.getString("Phone"));
                    message.setSubject(rs.getString("Subject"));
                    message.setMessage(rs.getString("Message"));
                    message.setPrivacyPolicyAccepted(rs.getBoolean("PrivacyPolicyAccepted"));
                    message.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    
                    return message;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Delete contact message by ID
     * @param messageID ID of the message to delete
     * @return true if deletion is successful, false otherwise
     */
    public boolean deleteContactMessage(int messageID) {
        String sql = "DELETE FROM ContactMessage WHERE MessageID = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, messageID);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Search contact messages by subject
     * @param subject Subject to search for
     * @param page Page number (starting from 1)
     * @param pageSize Number of records per page
     * @return List of ContactMessage objects
     */
    public List<ContactMessage> searchContactMessagesBySubject(String subject, int page, int pageSize) {
        List<ContactMessage> messages = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        
        String sql = "SELECT MessageID, FirstName, LastName, Email, Phone, Subject, Message, " +
                     "PrivacyPolicyAccepted, CreatedAt FROM ContactMessage " +
                     "WHERE Subject = ? " +
                     "ORDER BY CreatedAt DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, subject);
            pstmt.setInt(2, offset);
            pstmt.setInt(3, pageSize);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ContactMessage message = new ContactMessage();
                    message.setMessageID(rs.getInt("MessageID"));
                    message.setFirstName(rs.getString("FirstName"));
                    message.setLastName(rs.getString("LastName"));
                    message.setEmail(rs.getString("Email"));
                    message.setPhone(rs.getString("Phone"));
                    message.setSubject(rs.getString("Subject"));
                    message.setMessage(rs.getString("Message"));
                    message.setPrivacyPolicyAccepted(rs.getBoolean("PrivacyPolicyAccepted"));
                    message.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    
                    messages.add(message);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
    
    /**
     * Get contact messages by date range
     * @param startDate Start date
     * @param endDate End date
     * @param page Page number (starting from 1)
     * @param pageSize Number of records per page
     * @return List of ContactMessage objects
     */
    public List<ContactMessage> getContactMessagesByDateRange(Date startDate, Date endDate, int page, int pageSize) {
        List<ContactMessage> messages = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        
        String sql = "SELECT MessageID, FirstName, LastName, Email, Phone, Subject, Message, " +
                     "PrivacyPolicyAccepted, CreatedAt FROM ContactMessage " +
                     "WHERE CreatedAt BETWEEN ? AND ? " +
                     "ORDER BY CreatedAt DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            pstmt.setInt(3, offset);
            pstmt.setInt(4, pageSize);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ContactMessage message = new ContactMessage();
                    message.setMessageID(rs.getInt("MessageID"));
                    message.setFirstName(rs.getString("FirstName"));
                    message.setLastName(rs.getString("LastName"));
                    message.setEmail(rs.getString("Email"));
                    message.setPhone(rs.getString("Phone"));
                    message.setSubject(rs.getString("Subject"));
                    message.setMessage(rs.getString("Message"));
                    message.setPrivacyPolicyAccepted(rs.getBoolean("PrivacyPolicyAccepted"));
                    message.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    
                    messages.add(message);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
    
    /**
     * Get statistics of contact messages by subject
     * @return List of subject statistics
     */
    public List<SubjectStats> getContactMessageStatsBySubject() {
        List<SubjectStats> stats = new ArrayList<>();
        String sql = "SELECT Subject, COUNT(*) as MessageCount FROM ContactMessage GROUP BY Subject ORDER BY MessageCount DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                SubjectStats stat = new SubjectStats();
                stat.setSubject(rs.getString("Subject"));
                stat.setMessageCount(rs.getInt("MessageCount"));
                stats.add(stat);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }
    
    /**
     * Inner class for subject statistics
     */
    public static class SubjectStats {
        private String subject;
        private int messageCount;
        
        public String getSubject() {
            return subject;
        }
        
        public void setSubject(String subject) {
            this.subject = subject;
        }
        
        public int getMessageCount() {
            return messageCount;
        }
        
        public void setMessageCount(int messageCount) {
            this.messageCount = messageCount;
        }
        
        public String getSubjectDisplayText() {
            switch (subject) {
                case "general":
                    return "Thông tin chung";
                case "support":
                    return "Hỗ trợ kỹ thuật";
                case "business":
                    return "Hợp tác kinh doanh";
                case "complaint":
                    return "Khiếu nại";
                case "suggestion":
                    return "Góp ý";
                case "other":
                    return "Khác";
                default:
                    return subject;
            }
        }
    }
}
