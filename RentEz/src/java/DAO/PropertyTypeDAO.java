package DAO;

import Connection.DBConnection;
import Model.PropertyType;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyTypeDAO {

    public boolean insert(PropertyType propertyType) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO PropertyType (TypeName, Description, Status) VALUES (?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, propertyType.getTypeName());
            pstmt.setString(2, propertyType.getDescription());
            pstmt.setBoolean(3, propertyType.isStatus());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public PropertyType getById(int typeId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM PropertyType WHERE TypeID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, typeId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                PropertyType propertyType = new PropertyType();
                propertyType.setTypeId(rs.getInt("TypeID"));
                propertyType.setTypeName(rs.getString("TypeName"));
                propertyType.setDescription(rs.getString("Description"));
                propertyType.setStatus(rs.getBoolean("Status"));
                conn.close();
                return propertyType;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(PropertyType propertyType) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE PropertyType SET TypeName = ?, Description = ? WHERE TypeID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, propertyType.getTypeName());
            pstmt.setString(2, propertyType.getDescription());
            pstmt.setInt(3, propertyType.getTypeId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int typeId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE PropertyType SET Status = ? WHERE TypeID = ?";
        try {
            PropertyType pro = getById(typeId);
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, !pro.isStatus()); // Đặt trạng thái thành false
            pstmt.setInt(2, typeId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public List<PropertyType> getAll() {
        List<PropertyType> propertyTypes = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM PropertyType ORDER BY TypeName"; // Lấy tất cả và sắp xếp theo tên
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PropertyType propertyType = new PropertyType();
                propertyType.setTypeId(rs.getInt("TypeID"));
                propertyType.setTypeName(rs.getString("TypeName"));
                propertyType.setDescription(rs.getString("Description"));
                propertyType.setStatus(rs.getBoolean("Status"));
                propertyTypes.add(propertyType);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAll PropertyType: " + e);
        }
        return propertyTypes;
    }
    
    /**
     * Get only active property types
     */
    public List<PropertyType> getAllActive() {
        List<PropertyType> propertyTypes = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM PropertyType WHERE Status = 1 ORDER BY TypeName";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PropertyType propertyType = new PropertyType();
                propertyType.setTypeId(rs.getInt("TypeID"));
                propertyType.setTypeName(rs.getString("TypeName"));
                propertyType.setDescription(rs.getString("Description"));
                propertyType.setStatus(rs.getBoolean("Status"));
                propertyTypes.add(propertyType);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAllActive PropertyType: " + e);
        }
        return propertyTypes;
    }
    
    
    public List<PropertyType> getFilteredPropertyTypes(String search, String statusFilter, int page, int pageSize) {
        List<PropertyType> propertyTypes = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder("SELECT * FROM PropertyType WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (TypeName LIKE ? OR Description LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND Status = ?");
            params.add(statusFilter);
        }
        
        sql.append(" ORDER BY TypeID DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PropertyType propertyType = new PropertyType();
                propertyType.setTypeId(rs.getInt("TypeID"));
                propertyType.setTypeName(rs.getString("TypeName"));
                propertyType.setDescription(rs.getString("Description"));
                propertyType.setStatus(rs.getBoolean("Status"));
                propertyTypes.add(propertyType);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getFilteredPropertyTypes: " + e);
        }
        return propertyTypes;
    }
    
    public int getTotalFilteredPropertyTypes(String search, String statusFilter) {
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM PropertyType WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (TypeName LIKE ? OR Description LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND Status = ?");
            params.add(statusFilter);
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                conn.close();
                return total;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getTotalFilteredPropertyTypes: " + e);
        }
        return 0;
    }
    
    public boolean deletePropertyType(int typeId) {
        return delete(typeId);
    }
}
