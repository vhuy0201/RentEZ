package DAO;

import Connection.DBConnection;
import Model.Property;
import java.sql.*;

public class PropertyDAO {
    public boolean insert(Property property) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Property (PropertyID, Title, Description, TypeID, LocationID, LandlordID, Price, Size, NumberOfBedrooms, NumberOfBathrooms, AvailabilityStatus, PriorityLevel) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, property.getPropertyId());
            pstmt.setString(2, property.getTitle());
            pstmt.setString(3, property.getDescription());
            pstmt.setInt(4, property.getTypeId());
            pstmt.setInt(5, property.getLocationId());
            pstmt.setInt(6, property.getLandlordId());
            pstmt.setDouble(7, property.getPrice());
            pstmt.setDouble(8, property.getSize());
            pstmt.setInt(9, property.getNumberOfBedrooms());
            pstmt.setInt(10, property.getNumberOfBathrooms());
            pstmt.setString(11, property.getAvailabilityStatus());
            pstmt.setInt(12, property.getPriorityLevel());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    public Property getById(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Property WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
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
                conn.close();
                return property;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Property property) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Property SET Title = ?, Description = ?, TypeID = ?, LocationID = ?, LandlordID = ?, Price = ?, Size = ?, NumberOfBedrooms = ?, NumberOfBathrooms = ?, AvailabilityStatus = ?, PriorityLevel = ? WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, property.getTitle());
            pstmt.setString(2, property.getDescription());
            pstmt.setInt(3, property.getTypeId());
            pstmt.setInt(4, property.getLocationId());
            pstmt.setInt(5, property.getLandlordId());
            pstmt.setDouble(6, property.getPrice());
            pstmt.setDouble(7, property.getSize());
            pstmt.setInt(8, property.getNumberOfBedrooms());
            pstmt.setInt(9, property.getNumberOfBathrooms());
            pstmt.setString(10, property.getAvailabilityStatus());
            pstmt.setInt(11, property.getPriorityLevel());
            pstmt.setInt(12, property.getPropertyId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Property WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
