package DAO;

import Connection.DBConnection;
import Model.UserFavorite;
import Model.Property;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
    }    public boolean deleteByUserAndProperty(int userId, int propertyId) {
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

    public List<UserFavorite> getFavoritesByUserId(int userId) {
        List<UserFavorite> favorites = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserFavorite WHERE UserID = ? ORDER BY CreatedAt DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                UserFavorite favorite = new UserFavorite();
                favorite.setFavoriteId(rs.getInt("FavoriteID"));
                favorite.setUserId(rs.getInt("UserID"));
                favorite.setPropertyId(rs.getInt("PropertyID"));
                favorite.setCreatedAt(rs.getTimestamp("CreatedAt"));
                favorites.add(favorite);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return favorites;
    }

    public List<Property> getFavoritePropertiesByUserId(int userId) {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT p.* FROM Property p " +
                    "INNER JOIN UserFavorite uf ON p.PropertyID = uf.PropertyID " +
                    "WHERE uf.UserID = ? " +
                    "ORDER BY uf.CreatedAt DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("PropertyID"));
                property.setTitle(rs.getString("Title"));
                property.setDescription(rs.getString("Description"));
                property.setTypeId(rs.getInt("TypeID"));
                property.setLocationId(rs.getInt("LocationID"));
                property.setLandlordId(rs.getInt("LandlordID"));
                property.setPrice(rs.getDouble("Price"));
                property.setSize(rs.getDouble("Size"));
                property.setNumberOfBedrooms(rs.getInt("NumberOfBedrooms"));
                property.setNumberOfBathrooms(rs.getInt("NumberOfBathrooms"));
                property.setAvailabilityStatus(rs.getString("AvailabilityStatus"));
                property.setPriorityLevel(rs.getInt("PriorityLevel"));
                property.setAvatar(rs.getString("Avatar"));
                properties.add(property);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return properties;
    }

    public boolean isFavorited(int userId, int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM UserFavorite WHERE UserID = ? AND PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, propertyId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count > 0;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return false;
    }

    public UserFavorite getFavoriteByUserAndProperty(int userId, int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserFavorite WHERE UserID = ? AND PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, propertyId);
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
}
