package DAO;

import Connection.DBConnection;
import Model.UserFavorite;
import java.sql.*;

public class UserFavoriteDAO {
    public boolean insert(UserFavorite userFavorite) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO UserFavorite (UserID, PropertyID) VALUES (?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userFavorite.getUserId());
            pstmt.setInt(2, userFavorite.getPropertyId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public UserFavorite getById(int favoriteId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserFavorite WHERE FavoriteID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, favoriteId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                UserFavorite userFavorite = new UserFavorite();
                userFavorite.setFavoriteId(rs.getInt("FavoriteID"));
                userFavorite.setUserId(rs.getInt("UserID"));
                userFavorite.setPropertyId(rs.getInt("PropertyID"));
                userFavorite.setCreatedAt(rs.getTimestamp("CreatedAt"));
                conn.close();
                return userFavorite;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(UserFavorite userFavorite) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE UserFavorite SET UserID = ?, PropertyID = ? WHERE FavoriteID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userFavorite.getUserId());
            pstmt.setInt(2, userFavorite.getPropertyId());
            pstmt.setInt(3, userFavorite.getFavoriteId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int favoriteId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM UserFavorite WHERE FavoriteID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, favoriteId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean deleteByUserAndProperty(int userId, int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM UserFavorite WHERE UserID = ? AND PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
