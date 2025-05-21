package DAO;

import Connection.DBConnection;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    public boolean insert(User user) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO [User] (UserID, Name, Email, Phone, Address, Role, Password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, user.getUserId());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            pstmt.setString(7, user.getPassword());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public User getById(int userId) {
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
                conn.close();
                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(User user) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE [User] SET Name = ?, Email = ?, Phone = ?, Address = ?, Role = ?, Password = ? WHERE UserID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());
            pstmt.setString(6, user.getPassword());
            pstmt.setInt(7, user.getUserId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM [User] WHERE UserID = ?";
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
    public List<User> getAll() {
        List<User> users = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM [User]";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setName(rs.getString("Name"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setPassword(rs.getString("Password"));
                users.add(user);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return users;
    }
}
