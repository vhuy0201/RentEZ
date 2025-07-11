package DAO;

import Connection.DBConnection;
import Model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminsUserDAO {
    
    public List<User> getFilteredUsers(String search, String roleFilter, String statusFilter, int page, int pageSize) {
        List<User> users = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT * FROM [User] WHERE 1=1");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (Name LIKE ? OR Email LIKE ? OR Phone LIKE ?)");
        }
        if (roleFilter != null && !roleFilter.trim().isEmpty()) {
            sql.append(" AND Role = ?");
        }
        
        sql.append(" ORDER BY UserID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (roleFilter != null && !roleFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, roleFilter);
            }
            
            pstmt.setInt(paramIndex++, (page - 1) * pageSize);
            pstmt.setInt(paramIndex, pageSize);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setName(rs.getString("Name"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setAvatar(rs.getString("Avatar"));
                user.setStatus(rs.getBoolean("Status"));
                users.add(user);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    public int getTotalFilteredUsers(String search, String roleFilter, String statusFilter) {
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [User] WHERE 1=1");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (Name LIKE ? OR Email LIKE ? OR Phone LIKE ?)");
        }
        if (roleFilter != null && !roleFilter.trim().isEmpty()) {
            sql.append(" AND Role = ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (roleFilter != null && !roleFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, roleFilter);
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public boolean createUser(User user) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO [User] (Name, Email, Phone, Address, Role, Password, Avatar,Status) VALUES (?, ?, ?, ?, ?, ?, ?,1)";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());
            pstmt.setString(6, user.getPassword());
            pstmt.setString(7, user.getAvatar());
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUserById(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM [User] WHERE UserID = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setName(rs.getString("Name"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setPassword(rs.getString("Password"));
                user.setAvatar(rs.getString("Avatar"));
                user.setStatus(rs.getBoolean("Status"));
                conn.close();
                return user;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean updateUser(User user) {
        Connection conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder("UPDATE [User] SET Name = ?, Email = ?, Phone = ?, Address = ?, Role = ?");
        
        if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
            sql.append(", Password = ?");
        }
        
        sql.append(" WHERE UserID = ?");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            pstmt.setString(paramIndex++, user.getName());
            pstmt.setString(paramIndex++, user.getEmail());
            pstmt.setString(paramIndex++, user.getPhone());
            pstmt.setString(paramIndex++, user.getAddress());
            pstmt.setString(paramIndex++, user.getRole());
            
            if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
                pstmt.setString(paramIndex++, user.getPassword());
            }
            
            pstmt.setInt(paramIndex, user.getUserId());
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteUser(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE [User] SET Status = ? WHERE UserID = ?";
        
        try {
            User user = getUserById(userId);
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, !user.isStatus());
            pstmt.setInt(2, userId);
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Dashboard statistics methods
    public int getTotalUsers() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM [User]";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public List<User> getRecentUsers(int limit) {
        List<User> users = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP (?) * FROM [User] ORDER BY UserID DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setName(rs.getString("Name"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setRole(rs.getString("Role"));
                users.add(user);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    public List<Integer> getMonthlyUserStats() {
        List<Integer> monthlyStats = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) as UserCount FROM [User] WHERE YEAR(GETDATE()) = YEAR(GETDATE()) GROUP BY MONTH(GETDATE()) ORDER BY MONTH(GETDATE())";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                monthlyStats.add(rs.getInt("UserCount"));
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return monthlyStats;
    }
    
    public int getActiveLandlordsCount() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM [User] WHERE Role = 'landlord' AND Status = 1";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public int getActiveRentersCount() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM [User] WHERE Role = 'renter' AND Status = 1";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    public List<Integer> getNewRentersPerMonth(int months) {
        List<Integer> newRenters = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        // Get new renters for the last N months
        String sql = "WITH MonthSeries AS ( " +
                     "    SELECT DATEADD(MONTH, -?, CAST(GETDATE() AS DATE)) + " +
                     "           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS MonthStart " +
                     "    FROM sys.objects " +
                     "    WHERE ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) <= ? " +
                     ") " +
                     "SELECT COALESCE(COUNT(u.UserID), 0) as NewRenters " +
                     "FROM MonthSeries ms " +
                     "LEFT JOIN [User] u ON u.Role = 'renter' " +
                     "    AND YEAR(u.CreatedAt) = YEAR(ms.MonthStart) " +
                     "    AND MONTH(u.CreatedAt) = MONTH(ms.MonthStart) " +
                     "GROUP BY ms.MonthStart " +
                     "ORDER BY ms.MonthStart";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, months - 1);
            pstmt.setInt(2, months);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                newRenters.add(rs.getInt("NewRenters"));
            }
            
            // If no data, fill with zeros
            while (newRenters.size() < months) {
                newRenters.add(0);
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getNewRentersPerMonth: " + e);
            // Fill with zeros if error
            for (int i = 0; i < months; i++) {
                newRenters.add(0);
            }
        }
        
        return newRenters;
    }
}
