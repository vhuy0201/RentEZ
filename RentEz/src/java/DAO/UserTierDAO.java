package DAO;

import Connection.DBConnection;
import Model.UserTier;
import Model.Tier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserTierDAO {

    public boolean create(UserTier userTier) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO UserTier (UserID, TierID, StartDate, EndDate, Status) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, userTier.getUserId());
            pstmt.setInt(2, userTier.getTierId());
            pstmt.setDate(3, new java.sql.Date(userTier.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(userTier.getEndDate().getTime()));
            pstmt.setString(5, userTier.getStatus());

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    userTier.setUserTierId(generatedKeys.getInt(1));
                }
            }

            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean insert(UserTier userTier) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO UserTier (UserTierID, UserID, TierID, StartDate, EndDate, Status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTier.getUserTierId());
            pstmt.setInt(2, userTier.getUserId());
            pstmt.setInt(3, userTier.getTierId());
            pstmt.setDate(4, new java.sql.Date(userTier.getStartDate().getTime()));
            pstmt.setDate(5, new java.sql.Date(userTier.getEndDate().getTime()));
            pstmt.setString(6, userTier.getStatus());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public UserTier getById(int userTierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserTier WHERE UserTierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTierId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                UserTier userTier = new UserTier();
                userTier.setUserTierId(rs.getInt("UserTierID"));
                userTier.setUserId(rs.getInt("UserID"));
                userTier.setTierId(rs.getInt("TierID"));
                userTier.setStartDate(rs.getDate("StartDate"));
                userTier.setEndDate(rs.getDate("EndDate"));
                userTier.setStatus(rs.getString("Status"));
                conn.close();
                return userTier;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(UserTier userTier) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE UserTier SET UserID = ?, TierID = ?, StartDate = ?, EndDate = ?, Status = ? WHERE UserTierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTier.getUserId());
            pstmt.setInt(2, userTier.getTierId());
            pstmt.setDate(3, new java.sql.Date(userTier.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(userTier.getEndDate().getTime()));
            pstmt.setString(5, userTier.getStatus());
            pstmt.setInt(6, userTier.getUserTierId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int userTierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM UserTier WHERE UserTierID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userTierId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public UserTier getByUserId(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserTier WHERE UserID = ? AND Status = 'Active'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                UserTier userTier = new UserTier();
                userTier.setUserTierId(rs.getInt("UserTierID"));
                userTier.setUserId(rs.getInt("UserID"));
                userTier.setTierId(rs.getInt("TierID"));
                userTier.setStartDate(rs.getDate("StartDate"));
                userTier.setEndDate(rs.getDate("EndDate"));
                userTier.setStatus(rs.getString("Status"));
                conn.close();
                return userTier;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public UserTier getCurrentUserTier(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserTier WHERE UserID = ? AND Status = 'Active' AND EndDate >= GETDATE() ORDER BY EndDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                UserTier userTier = new UserTier();
                userTier.setUserTierId(rs.getInt("UserTierID"));
                userTier.setUserId(rs.getInt("UserID"));
                userTier.setTierId(rs.getInt("TierID"));
                userTier.setStartDate(rs.getDate("StartDate"));
                userTier.setEndDate(rs.getDate("EndDate"));
                userTier.setStatus(rs.getString("Status"));
                conn.close();
                return userTier;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public List<UserTier> getUserTierHistory(int userId) {
        List<UserTier> userTiers = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM UserTier WHERE UserID = ? ORDER BY StartDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                UserTier userTier = new UserTier();
                userTier.setUserTierId(rs.getInt("UserTierID"));
                userTier.setUserId(rs.getInt("UserID"));
                userTier.setTierId(rs.getInt("TierID"));
                userTier.setStartDate(rs.getDate("StartDate"));
                userTier.setEndDate(rs.getDate("EndDate"));
                userTier.setStatus(rs.getString("Status"));
                userTiers.add(userTier);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return userTiers;
    }

    public boolean expireOldTiers(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE UserTier SET Status = 'Expired' WHERE UserID = ? AND Status = 'Active'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public int getUserCurrentTierPriorityLevel(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT t.PriorityLevel FROM UserTier ut " +
                    "INNER JOIN Tier t ON ut.TierID = t.TierID " +
                    "WHERE ut.UserID = ? AND ut.Status = 'Active' AND ut.EndDate >= GETDATE() " +
                    "ORDER BY t.PriorityLevel ASC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int priorityLevel = rs.getInt("PriorityLevel");
                conn.close();
                return priorityLevel;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return 99; // Default lowest priority if no tier found
    }

    /**
     * Update expired tiers status automatically
     */
    public boolean updateExpiredTiers() {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE UserTier SET Status = 'Expired' WHERE Status = 'Active' AND EndDate < GETDATE()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    /**
     * Get count of active memberships for a specific tier
     */
    public int getActiveMembershipCountByTier(int tierId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) as count FROM UserTier WHERE TierID = ? AND Status = 'Active' AND EndDate >= GETDATE()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tierId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                conn.close();
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return 0;
    }

    /**
     * Get all user tiers with user information for admin view
     */
    public List<Object[]> getAllUserTiersWithUserInfo() {
        List<Object[]> userTiers = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT ut.UserTierID, ut.UserID, u.Name as UserName, u.Email, " +
                    "t.TierName, ut.StartDate, ut.EndDate, ut.Status " +
                    "FROM UserTier ut " +
                    "INNER JOIN [User] u ON ut.UserID = u.UserID " +
                    "INNER JOIN Tier t ON ut.TierID = t.TierID " +
                    "ORDER BY ut.StartDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Object[] row = new Object[8];
                row[0] = rs.getInt("UserTierID");
                row[1] = rs.getInt("UserID");
                row[2] = rs.getString("UserName");
                row[3] = rs.getString("Email");
                row[4] = rs.getString("TierName");
                row[5] = rs.getDate("StartDate");
                row[6] = rs.getDate("EndDate");
                row[7] = rs.getString("Status");
                userTiers.add(row);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return userTiers;
    }
}
