package DAO;

import Connection.DBConnection;
import Model.PropertyType;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyTypeDAO {

    public boolean insert(PropertyType propertyType) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO PropertyType (TypeID, TypeName) VALUES (?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyType.getTypeId());
            pstmt.setString(2, propertyType.getTypeName());
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
        String sql = "UPDATE PropertyType SET TypeName = ? WHERE TypeID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, propertyType.getTypeName());
            pstmt.setInt(2, propertyType.getTypeId());
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
        String sql = "DELETE FROM PropertyType WHERE TypeID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, typeId);
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
        String sql = "SELECT * FROM PropertyType";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PropertyType propertyType = new PropertyType();
                propertyType.setTypeId(rs.getInt("TypeID"));
                propertyType.setTypeName(rs.getString("TypeName"));
                propertyTypes.add(propertyType);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAll PropertyType: " + e);
        }
        return propertyTypes;
    }
}
