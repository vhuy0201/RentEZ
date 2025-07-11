package DAO;

import Connection.DBConnection;
import Model.FeeCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for FeeCategory operations
 */
public class FeeCategoryDAO {
    
    /**
     * Get all fee categories
     */
    public List<FeeCategory> getAll() {
        List<FeeCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category ORDER BY Name";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                FeeCategory category = extractFeeCategoryFromResultSet(rs);
                categories.add(category);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    /**
     * Get fee category by ID
     */
    public FeeCategory getById(int categoryId) {
        String sql = "SELECT * FROM Category WHERE CategoryID = ?";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractFeeCategoryFromResultSet(rs);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Create a new fee category
     */
    public boolean create(FeeCategory category) {
        String sql = "INSERT INTO Category (Name, UnitPrice, Unit) VALUES (?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, category.getName());
            ps.setDouble(2, category.getUnitPrice());
            ps.setString(3, category.getUnit());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        category.setCategoryId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Update an existing fee category
     */
    public boolean update(FeeCategory category) {
        String sql = "UPDATE Category SET Name = ?, UnitPrice = ?, Unit = ? WHERE CategoryID = ?";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setDouble(2, category.getUnitPrice());
            ps.setString(3, category.getUnit());
            ps.setInt(4, category.getCategoryId());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Delete a fee category
     */
    public boolean delete(int categoryId) {
        String sql = "DELETE FROM Category WHERE CategoryID = ?";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Get fee categories by name pattern
     */
    public List<FeeCategory> searchByName(String namePattern) {
        List<FeeCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE Name LIKE ? ORDER BY Name";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + namePattern + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FeeCategory category = extractFeeCategoryFromResultSet(rs);
                    categories.add(category);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    /**
     * Extract FeeCategory object from ResultSet
     */
    private FeeCategory extractFeeCategoryFromResultSet(ResultSet rs) throws SQLException {
        FeeCategory category = new FeeCategory();
        category.setCategoryId(rs.getInt("CategoryID"));
        category.setName(rs.getString("Name"));
        category.setUnitPrice(rs.getDouble("UnitPrice"));
        category.setUnit(rs.getString("Unit"));
        return category;
    }
}
