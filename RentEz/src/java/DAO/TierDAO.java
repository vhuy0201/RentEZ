package DAO;

import Connection.DBConnection;
import Model.Tier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TierDAO {
    
    public boolean create(Tier tier) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Tier (TierName, Price, PriorityLevel, Description) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, tier.getTierName());
            pstmt.setDouble(2, tier.getPrice());
            pstmt.setInt(3, tier.getPriorityLevel());
            pstmt.setString(4, tier.getDescription());

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    tier.setTierId(generatedKeys.getInt(1));
                }
            }

            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public boolean insert(Tier tier) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Tier (TierID, TierName, Price, PriorityLevel, Description) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tier.getTierId());
            pstmt.setString(2, tier.getTierName());
            pstmt.setDouble(3, tier.getPrice());
            pstmt.setInt(4, tier.getPriorityLevel());
            pstmt.setString(5, tier.getDescription());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Tier getById(int tierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Tier WHERE TierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tierId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Tier tier = new Tier();
                tier.setTierId(rs.getInt("TierID"));
                tier.setTierName(rs.getString("TierName"));
                tier.setPrice(rs.getDouble("Price"));
                tier.setPriorityLevel(rs.getInt("PriorityLevel"));
                tier.setDescription(rs.getString("Description"));
                conn.close();
                return tier;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public List<Tier> getAllTiers() {
        List<Tier> tiers = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Tier ORDER BY PriorityLevel ASC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Tier tier = new Tier();
                tier.setTierId(rs.getInt("TierID"));
                tier.setTierName(rs.getString("TierName"));
                tier.setPrice(rs.getDouble("Price"));
                tier.setPriorityLevel(rs.getInt("PriorityLevel"));
                tier.setDescription(rs.getString("Description"));
                tiers.add(tier);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return tiers;
    }

    public List<Tier> getAvailableTiers() {
        List<Tier> tiers = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Tier WHERE Price > 0 ORDER BY PriorityLevel ASC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Tier tier = new Tier();
                tier.setTierId(rs.getInt("TierID"));
                tier.setTierName(rs.getString("TierName"));
                tier.setPrice(rs.getDouble("Price"));
                tier.setPriorityLevel(rs.getInt("PriorityLevel"));
                tier.setDescription(rs.getString("Description"));
                tiers.add(tier);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return tiers;
    }

    public boolean update(Tier tier) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Tier SET TierName = ?, Price = ?, PriorityLevel = ?, Description = ? WHERE TierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, tier.getTierName());
            pstmt.setDouble(2, tier.getPrice());
            pstmt.setInt(3, tier.getPriorityLevel());
            pstmt.setString(4, tier.getDescription());
            pstmt.setInt(5, tier.getTierId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int tierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Tier WHERE TierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tierId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public boolean deleteTier(int tierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Tier SET Status = 'inactive' WHERE TierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tierId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error in deleteTier: " + e);
            return false;
        }
    }
}
