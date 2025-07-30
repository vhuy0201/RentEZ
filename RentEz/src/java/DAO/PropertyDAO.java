package DAO;

import Connection.DBConnection;
import Model.Property;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {

    public boolean insert(Property property) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Property (Title, Description, TypeID, LocationID, LandlordID, Price, Size, NumberOfBedrooms, NumberOfBathrooms, AvailabilityStatus, PriorityLevel, Avatar,PublicStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
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
            pstmt.setBoolean(13, property.isPublicStatus());
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
        String sql = "SELECT * FROM Property WHERE PublicStatus = 1";
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
                property.setPublicStatus(rs.getBoolean("PublicStatus"));
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
                property.setPublicStatus(rs.getBoolean("PublicStatus"));
                properties.add(property);
            }
          conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
      return properties;
    }
      
    public List<Property> searchProperties(String keyword, String location, String roomType, Double minPrice, Double maxPrice) {
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
        
        // Thêm điều kiện tìm kiếm theo giá tối thiểu
        if (minPrice != null && minPrice > 0) {
            sqlBuilder.append(" AND p.Price >= ?");
        }
        
        // Thêm điều kiện tìm kiếm theo giá tối đa
        if (maxPrice != null && maxPrice > 0) {
            sqlBuilder.append(" AND p.Price <= ?");
        }
        
        // Thêm điều kiện chỉ lấy các phòng còn trống
        sqlBuilder.append(" AND p.AvailabilityStatus = 'Available'");
        
        // Thêm điều kiện chỉ lấy các bài đăng đã được duyệt
        sqlBuilder.append(" AND p.PublicStatus = 1");
        
        // Sắp xếp theo mức độ ưu tiên (1 là ưu tiên nhất, 2, 3...) và giá
        sqlBuilder.append(" ORDER BY p.PriorityLevel ASC, p.Price ASC");
        
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
            
            // Thiết lập tham số cho giá tối thiểu
            if (minPrice != null && minPrice > 0) {
                pstmt.setDouble(paramIndex++, minPrice);
            }
            
            // Thiết lập tham số cho giá tối đa
            if (maxPrice != null && maxPrice > 0) {
                pstmt.setDouble(paramIndex++, maxPrice);
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
        String sql = "INSERT INTO Property (Title, Description, TypeID, LocationID, LandlordID, Price, Size, NumberOfBedrooms, NumberOfBathrooms, AvailabilityStatus, PriorityLevel, Avatar,PublicStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
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
            pstmt.setBoolean(13, property.isPublicStatus());
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int generatedId = rs.getInt(1);
                        conn.close();
                        return generatedId;
                    }
                }
            }
            conn.close();
            return -1; 
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return -1;
        }
    }
    
    // Methods for AdminDashboardServlet
    public int getTotalProperties() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Property";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                conn.close();
                return total;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getTotalProperties: " + e);
        }
        return 0;
    }
    
    public List<Property> getRecentProperties(int limit) {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP (?) * FROM Property ORDER BY PropertyID DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
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
                property.setPublicStatus(rs.getBoolean("PublicStatus"));
                properties.add(property);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getRecentProperties: " + e);
        }
        return properties;
    }
    
    public int getRentedPropertiesCount() {
        int count = 0;
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Property WHERE AvailabilityStatus = 'Rented'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getRentedPropertiesCount: " + e);
        }
        return count;
    }
    
    public int getAvailablePropertiesCount() {
        int count = 0;
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Property WHERE AvailabilityStatus = 'Available'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAvailablePropertiesCount: " + e);
        }
        return count;
    }
    
    // Admin methods for managing posts
    public List<Property> getAllPropertiesForAdmin(String statusFilter, int page, int pageSize) {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, l.Address " +
            "FROM Property p " +
            "LEFT JOIN Location l ON p.LocationID = l.LocationID "
        );
        
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if ("pending".equals(statusFilter)) {
                sql.append("WHERE p.PublicStatus = 0 ");
            } else if ("approved".equals(statusFilter)) {
                sql.append("WHERE p.PublicStatus = 1 ");
            }
        }
        
        sql.append("ORDER BY p.PropertyID DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int offset = (page - 1) * pageSize;
            pstmt.setInt(1, offset);
            pstmt.setInt(2, pageSize);
            
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
                property.setPublicStatus(rs.getBoolean("PublicStatus"));
                property.setAddress(rs.getString("Address"));
                properties.add(property);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAllPropertiesForAdmin: " + e);
        }
        return properties;
    }
    
    public int countAllPropertiesForAdmin(String statusFilter) {
        int count = 0;
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Property p ");
        
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if ("pending".equals(statusFilter)) {
                sql.append("WHERE p.PublicStatus = 0");
            } else if ("approved".equals(statusFilter)) {
                sql.append("WHERE p.PublicStatus = 1");
            }
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in countAllPropertiesForAdmin: " + e);
        }
        return count;
    }
    
    public List<Property> searchPropertiesForAdmin(String searchQuery, String statusFilter, int page, int pageSize) {
        List<Property> properties = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, l.Address " +
            "FROM Property p " +
            "LEFT JOIN Location l ON p.LocationID = l.LocationID " +
            "WHERE (p.Title LIKE ? OR p.Description LIKE ? OR l.Address LIKE ?) "
        );
        
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if ("pending".equals(statusFilter)) {
                sql.append("AND p.PublicStatus = 0 ");
            } else if ("approved".equals(statusFilter)) {
                sql.append("AND p.PublicStatus = 1 ");
            }
        }
        
        sql.append("ORDER BY p.PropertyID DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            String searchPattern = "%" + searchQuery + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            
            int offset = (page - 1) * pageSize;
            pstmt.setInt(4, offset);
            pstmt.setInt(5, pageSize);
            
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
                property.setPublicStatus(rs.getBoolean("PublicStatus"));
                property.setAddress(rs.getString("Address"));
                properties.add(property);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in searchPropertiesForAdmin: " + e);
        }
        return properties;
    }
    
    public int countSearchPropertiesForAdmin(String searchQuery, String statusFilter) {
        int count = 0;
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) " +
            "FROM Property p " +
            "LEFT JOIN Location l ON p.LocationID = l.LocationID " +
            "WHERE (p.Title LIKE ? OR p.Description LIKE ? OR l.Address LIKE ?) "
        );
        
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if ("pending".equals(statusFilter)) {
                sql.append("AND p.PublicStatus = 0");
            } else if ("approved".equals(statusFilter)) {
                sql.append("AND p.PublicStatus = 1");
            }
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            String searchPattern = "%" + searchQuery + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in countSearchPropertiesForAdmin: " + e);
        }
        return count;
    }
    
    public boolean updatePublicStatus(int propertyId, boolean publicStatus) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Property SET PublicStatus = ? WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, publicStatus);
            pstmt.setInt(2, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error in updatePublicStatus: " + e);
            return false;
        }
    }
    
    public int countPropertiesByStatus(boolean publicStatus) {
        int count = 0;
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Property WHERE PublicStatus = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, publicStatus);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in countPropertiesByStatus: " + e);
        }
        return count;
    }
    public boolean updateAvailabilityStatus(int propertyId, String status) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Property SET AvailabilityStatus = ? WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    /**
     * Soft delete property by setting publicStatus to false
     * This allows the property to be hidden from public view but not permanently deleted
     */
    public boolean softDeleteProperty(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Property SET PublicStatus = 0 WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error in softDeleteProperty: " + e);
            return false;
        }
    }
    
    /**
     * Restore property by setting publicStatus back to true
     * This allows landlords to restore hidden properties
     */
    public boolean restoreProperty(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Property SET PublicStatus = 1 WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error in restoreProperty: " + e);
            return false;
        }
    }
    
    /**
     * Check if property is public (publicStatus = true)
     */
    public boolean isPropertyPublic(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT PublicStatus FROM Property WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            boolean isPublic = false;
            if (rs.next()) {
                isPublic = rs.getBoolean("PublicStatus");
            }
            conn.close();
            return isPublic;
        } catch (Exception e) {
            System.out.println("Error in isPropertyPublic: " + e);
            return true; // Default to public for safety
        }
    }
    
    /**
     * Permanently delete property (hard delete)
     * This completely removes the property from the database
     * Should only be used for properties that are already soft deleted
     */
    public boolean permanentDeleteProperty(int propertyId) {
        Connection conn = DBConnection.getConnection();
        try {
            // Start transaction
            conn.setAutoCommit(false);
            
            // Delete related records first (to maintain referential integrity)
            // Delete property images
            String deleteImagesSQL = "DELETE FROM PropertyImage WHERE PropertyID = ?";
            PreparedStatement pstmt1 = conn.prepareStatement(deleteImagesSQL);
            pstmt1.setInt(1, propertyId);
            pstmt1.executeUpdate();
            
            // Delete bookings
            String deleteBookingsSQL = "DELETE FROM Booking WHERE PropertyID = ?";
            PreparedStatement pstmt2 = conn.prepareStatement(deleteBookingsSQL);
            pstmt2.setInt(1, propertyId);
            pstmt2.executeUpdate();
            
            // Delete the property itself
            String deletePropertySQL = "UPDATE Property SET AvailabilityStatus = ? WHERE PropertyID = ?";
            PreparedStatement pstmt3 = conn.prepareStatement(deletePropertySQL);
            pstmt3.setString(1, "Deleted");
            pstmt3.setInt(2, propertyId);
            int rows = pstmt3.executeUpdate();
            
            // Commit transaction
            conn.commit();
            conn.close();
            return rows > 0;
            
        } catch (Exception e) {
            try {
                conn.rollback(); // Rollback on error
            } catch (SQLException rollbackEx) {
                System.out.println("Error in rollback: " + rollbackEx);
            }
            System.out.println("Error in permanentDeleteProperty: " + e);
            return false;
        }
    }
}
