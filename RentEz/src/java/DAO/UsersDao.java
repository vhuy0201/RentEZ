package DAO;

import Connection.DBConnection;
import Model.GoogleAccount;
import Model.User;
import Util.Common;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

public class UsersDao {

    public boolean insert(User user) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO [User] (Name, Email, Phone, Address, Role, Password, Avatar, Status) VALUES (?, ?, ?, ?, ?, ?, ?,1)";
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
                user.setAvatar(rs.getString("Avatar"));
                user.setStatus(rs.getBoolean("Status"));
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
        String sql = "UPDATE [User] SET Name = ?, Email = ?, Phone = ?, Address = ?, Role = ?, Password = ?, Avatar = ? WHERE UserID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());
            pstmt.setString(6, user.getPassword());
            pstmt.setString(7, user.getAvatar());
            pstmt.setInt(8, user.getUserId());
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
                user.setAvatar(rs.getString("Avatar"));
                users.add(user);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return users;
    }

    public User getByEmail(String email) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM [User] WHERE Email = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
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
                conn.close();
                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    /**
     * Check if a user with Google account exists in the database
     *
     * @param googleEmail The email from Google account
     * @return User object if found, null otherwise
     */
    public User getByGoogleEmail(String googleEmail) {
        // We can reuse the existing getByEmail method since Google email is unique
        return getByEmail(googleEmail);
    }

    /**
     * Create a new user based on Google account information
     *
     * @param googleAccount The Google account data
     * @return The created User object
     */
    public User createFromGoogleAccount(GoogleAccount googleAccount) {
        User user = new User();
        user.setName(googleAccount.getName());
        user.setEmail(googleAccount.getEmail());
        // Set default values for fields not provided by Google
        user.setPhone("");
        user.setAddress("");
        // Default role for Google users (can be changed based on requirements)
        user.setRole("Renter");
        // Generate a random password for Google users (they will login via Google)
        String randomPassword = generateRandomPassword();
        // Encrypt the password using MD5
        user.setPassword(Common.encryptMD5(randomPassword));

        // Insert the user into the database
        if (insert(user)) {
            // Get the user with the assigned ID
            return getByEmail(user.getEmail());
        }
        return null;
    }

    public List<User> getUsersHaveMessage(int userId) {
        List<User> users = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "WITH RecentMessages AS (\n"
                + "    SELECT \n"
                + "        CASE \n"
                + "            WHEN senderId = " + userId + " THEN receiverId\n"
                + "            ELSE senderId\n"
                + "        END AS contactId,\n"
                + "        MAX(sendDate) AS lastMessageDate\n"
                + "    FROM Message\n"
                + "    WHERE senderId = " + userId + " OR receiverId = " + userId + "\n"
                + "    GROUP BY \n"
                + "        CASE \n"
                + "            WHEN senderId = " + userId + " THEN receiverId\n"
                + "            ELSE senderId\n"
                + "        END\n"
                + ")\n"
                + "\n"
                + "SELECT u.*\n"
                + "FROM RecentMessages rm\n"
                + "JOIN [User] u ON u.userId = rm.contactId\n"
                + "ORDER BY rm.lastMessageDate DESC;";
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
                user.setAvatar(rs.getString("Avatar"));
                users.add(user);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return users;
    }

    public HashMap<Integer, User> getUserReports() {
        HashMap<Integer, User> users = new HashMap<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT DISTINCT u.*\n"
                + "FROM [User] u\n"
                + "JOIN Report r ON u.UserID = r.UserId;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setName(rs.getString("Name"));
                user.setAvatar(rs.getString("Avatar"));
                users.put(user.getUserId(), user);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return users;
    }

    /**
     * Generate a random password for Google users
     *
     * @return Random string to use as password
     */
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_-+=";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 16; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
}
