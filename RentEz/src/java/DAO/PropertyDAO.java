package DAO;

import Connection.DBConnection;
import Model.Property;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {

    public boolean insert(Property property) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Property (Title, Description, TypeID, LocationID, LandlordID, Price, Size, NumberOfBedrooms, NumberOfBathrooms, AvailabilityStatus, PriorityLevel, Avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            pstmt.setString(12, property.getAvatar());
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
                property.setAvatar(rs.getString("Avatar"));
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
        String sql = "UPDATE Property SET Title = ?, Description = ?, TypeID = ?, LocationID = ?, LandlordID = ?, Price = ?, Size = ?, NumberOfBedrooms = ?, NumberOfBathrooms = ?, AvailabilityStatus = ?, PriorityLevel = ?, Avatar = ? WHERE PropertyID = ?";
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
            pstmt.setString(12, property.getAvatar());
            pstmt.setInt(13, property.getPropertyId());
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

    public List<Property> getAll() {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Property";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
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


    public List<Property> getPropertiesByLandlordId(int landlordId) {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Property WHERE LandlordID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
          conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
      return properties;
    }
      
    public List<Property> searchProperties(String keyword, String location, String roomType) {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sqlBuilder = new StringBuilder("SELECT p.* FROM Property p");
        
        // Join với bảng Location nếu cần tìm kiếm theo địa điểm
        if (location != null && !location.equals("all")) {
            sqlBuilder.append(" JOIN Location l ON p.LocationID = l.LocationID");
        }
        
        sqlBuilder.append(" WHERE 1=1");
        
        // Thêm điều kiện tìm kiếm theo từ khóa (trong tiêu đề hoặc mô tả)
        if (keyword != null && !keyword.isEmpty()) {
            sqlBuilder.append(" AND (p.Title LIKE ? OR p.Description LIKE ?)");
        }
          // Thêm điều kiện tìm kiếm theo loại phòng
        if (roomType != null && !roomType.equals("all")) {
            sqlBuilder.append(" AND p.TypeID = (SELECT TypeID FROM PropertyType WHERE TypeName = ?)");
        }
        
        // Thêm điều kiện tìm kiếm theo thành phố
        if (location != null && !location.equals("all")) {
            sqlBuilder.append(" AND l.City LIKE ?");
        }
        
        // Thêm điều kiện chỉ lấy các phòng còn trống
        sqlBuilder.append(" AND p.AvailabilityStatus = 'Available'");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            int paramIndex = 1;
            
            // Thiết lập tham số cho từ khóa
            if (keyword != null && !keyword.isEmpty()) {
                String keywordParam = "%" + keyword + "%";
                pstmt.setString(paramIndex++, keywordParam);
                pstmt.setString(paramIndex++, keywordParam);
            }
            
            // Thiết lập tham số cho loại phòng
            if (roomType != null && !roomType.equals("all")) {
                pstmt.setString(paramIndex++, roomType);
            }
            
            // Thiết lập tham số cho thành phố
            if (location != null && !location.equals("all")) {
                pstmt.setString(paramIndex++, "%" + location + "%");
            }
            
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
            System.out.println("Error in searchProperties: " + e);
        }

        return properties;
    }
    
    public int addProperty(Property property) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Property (Title, Description, TypeID, LocationID, LandlordID, Price, Size, NumberOfBedrooms, NumberOfBathrooms, AvailabilityStatus, PriorityLevel, Avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            pstmt.setString(12, property.getAvatar());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return 0;
        }
    }
}
