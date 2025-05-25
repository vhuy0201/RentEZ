package DAO;

import Connection.DBConnection;
import Model.Notification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    
    public boolean insert(Notification notification) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Notification (UserID, Message, SentDate, IsRead, ReferenceID, ReferenceType) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, notification.getUserId());
            pstmt.setString(2, notification.getMessage());
            pstmt.setTimestamp(3, new java.sql.Timestamp(notification.getSentDate().getTime()));
            pstmt.setBoolean(4, notification.isIsRead());
            
            // Handle ReferenceID (can be null)
            if (notification.getReferenceId() != null) {
                pstmt.setInt(5, notification.getReferenceId());
            } else {
                pstmt.setNull(5, java.sql.Types.INTEGER);
            }
            
            pstmt.setString(6, notification.getReferenceType());
            
            int rows = pstmt.executeUpdate();
            
            // Get generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    notification.setNotificationId(generatedKeys.getInt(1));
                }
            }
            
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Notification getById(int notificationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Notification WHERE NotificationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notificationId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(rs.getInt("NotificationID"));
                notification.setUserId(rs.getInt("UserID"));
                notification.setMessage(rs.getString("Message"));
                notification.setSentDate(rs.getTimestamp("SentDate"));
                notification.setIsRead(rs.getBoolean("IsRead"));
                
                int refId = rs.getInt("ReferenceID");
                if (!rs.wasNull()) {
                    notification.setReferenceId(refId);
                }
                
                notification.setReferenceType(rs.getString("ReferenceType"));
                conn.close();
                return notification;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Notification notification) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Notification SET UserID = ?, Message = ?, SentDate = ?, "
                + "IsRead = ?, ReferenceID = ?, ReferenceType = ? WHERE NotificationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notification.getUserId());
            pstmt.setString(2, notification.getMessage());
            pstmt.setTimestamp(3, new java.sql.Timestamp(notification.getSentDate().getTime()));
            pstmt.setBoolean(4, notification.isIsRead());
            
            // Handle ReferenceID (can be null)
            if (notification.getReferenceId() != null) {
                pstmt.setInt(5, notification.getReferenceId());
            } else {
                pstmt.setNull(5, java.sql.Types.INTEGER);
            }
            
            pstmt.setString(6, notification.getReferenceType());
            pstmt.setInt(7, notification.getNotificationId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int notificationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Notification WHERE NotificationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notificationId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public List<Notification> getNotificationsByUserId(int userId) {
        Connection conn = DBConnection.getConnection();
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notification WHERE UserID = ? ORDER BY SentDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(rs.getInt("NotificationID"));
                notification.setUserId(rs.getInt("UserID"));
                notification.setMessage(rs.getString("Message"));
                notification.setSentDate(rs.getTimestamp("SentDate"));
                notification.setIsRead(rs.getBoolean("IsRead"));
                
                int refId = rs.getInt("ReferenceID");
                if (!rs.wasNull()) {
                    notification.setReferenceId(refId);
                }
                
                notification.setReferenceType(rs.getString("ReferenceType"));
                notifications.add(notification);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return notifications;
    }
    
    public List<Notification> getUnreadNotificationsByUserId(int userId) {
        Connection conn = DBConnection.getConnection();
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notification WHERE UserID = ? AND IsRead = 0 ORDER BY SentDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(rs.getInt("NotificationID"));
                notification.setUserId(rs.getInt("UserID"));
                notification.setMessage(rs.getString("Message"));
                notification.setSentDate(rs.getTimestamp("SentDate"));
                notification.setIsRead(rs.getBoolean("IsRead"));
                
                int refId = rs.getInt("ReferenceID");
                if (!rs.wasNull()) {
                    notification.setReferenceId(refId);
                }
                
                notification.setReferenceType(rs.getString("ReferenceType"));
                notifications.add(notification);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return notifications;
    }
    
    public int getUnreadCount(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) as UnreadCount FROM Notification WHERE UserID = ? AND IsRead = 0";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("UnreadCount");
                conn.close();
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return 0;
    }
    
    public boolean markAsRead(int notificationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Notification SET IsRead = 1 WHERE NotificationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notificationId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public boolean markAllAsRead(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Notification SET IsRead = 1 WHERE UserID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
