package DAO;

import Connection.DBConnection;
import Model.FeeCategory;
import java.sql.*;

public class CategoryDAO {
    public boolean insert(FeeCategory category) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Category (CategoryID, Name, UnitPrice, Unit) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, category.getCategoryId());
            pstmt.setString(2, category.getName());
            pstmt.setDouble(3, category.getUnitPrice());
            pstmt.setString(4, category.getUnit());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public FeeCategory getById(int categoryId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Category WHERE CategoryID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                FeeCategory category = new FeeCategory();
                category.setCategoryId(rs.getInt("CategoryID"));
                category.setName(rs.getString("Name"));
                category.setUnitPrice(rs.getDouble("UnitPrice"));
                category.setUnit(rs.getString("Unit"));
                conn.close();
                return category;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(FeeCategory category) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Category SET Name = ?, UnitPrice = ?, Unit = ? WHERE CategoryID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getName());
            pstmt.setDouble(2, category.getUnitPrice());
            pstmt.setString(3, category.getUnit());
            pstmt.setInt(4, category.getCategoryId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int categoryId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Category WHERE CategoryID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
