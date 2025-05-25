package DAO;

import Connection.DBConnection;
import Model.UserTier;
import java.sql.*;

public class UserTierDAO {
    public boolean insert(UserTier userTier) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO UserTier (UserTierID, UserID, TierID, StartDate, EndDate, Status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTier.getUserTierId());
            pstmt.setInt(2, userTier.getUserId());
            pstmt.setInt(3, userTier.getTierId());
            pstmt.setDate(4, new java.sql.Date(userTier.getStartDate().getTime()));
            pstmt.setDate(5, new java.sql.Date(userTier.getEndDate().getTime()));
            pstmt.setString(6, userTier.getStatus());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public UserTier getById(int userTierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserTier WHERE UserTierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTierId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                UserTier userTier = new UserTier();
                userTier.setUserTierId(rs.getInt("UserTierID"));
                userTier.setUserId(rs.getInt("UserID"));
                userTier.setTierId(rs.getInt("TierID"));
                userTier.setStartDate(rs.getDate("StartDate"));
                userTier.setEndDate(rs.getDate("EndDate"));
                userTier.setStatus(rs.getString("Status"));
                conn.close();
                return userTier;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(UserTier userTier) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE UserTier SET UserID = ?, TierID = ?, StartDate = ?, EndDate = ?, Status = ? WHERE UserTierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTier.getUserId());
            pstmt.setInt(2, userTier.getTierId());
            pstmt.setDate(3, new java.sql.Date(userTier.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(userTier.getEndDate().getTime()));
            pstmt.setString(5, userTier.getStatus());
            pstmt.setInt(6, userTier.getUserTierId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int userTierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM UserTier WHERE UserTierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTierId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public UserTier getByUserId(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserTier WHERE UserID = ? AND Status = 'Active'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                UserTier userTier = new UserTier();
                userTier.setUserTierId(rs.getInt("UserTierID"));
                userTier.setUserId(rs.getInt("UserID"));
                userTier.setTierId(rs.getInt("TierID"));
                userTier.setStartDate(rs.getDate("StartDate"));
                userTier.setEndDate(rs.getDate("EndDate"));
                userTier.setStatus(rs.getString("Status"));
                conn.close();
                return userTier;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }
}
