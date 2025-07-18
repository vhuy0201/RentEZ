package DAO;
import Connection.DBConnection;
import Model.Wallet;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
public class WalletDAO {

    public boolean create(Wallet wallet) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Wallet (UserID, Balance, LastUpdated) VALUES (?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, wallet.getUserId());
            pstmt.setDouble(2, wallet.getBalance());
            pstmt.setDate(3, new java.sql.Date(wallet.getLastUpdated().getTime()));

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    wallet.setWalletId(generatedKeys.getInt(1));
                }
            }

            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean insert(Wallet wallet) {
        return create(wallet);
    }

    public Wallet getById(int walletId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Wallet WHERE WalletID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, walletId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Wallet wallet = new Wallet();
                wallet.setWalletId(rs.getInt("WalletID"));
                wallet.setUserId(rs.getInt("UserID"));
                wallet.setBalance(rs.getDouble("Balance"));
                wallet.setLastUpdated(rs.getDate("LastUpdated"));
                conn.close();
                return wallet;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Wallet wallet) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Wallet SET UserID = ?, Balance = ?, LastUpdated = ? WHERE WalletID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, wallet.getUserId());
            pstmt.setDouble(2, wallet.getBalance());
            pstmt.setDate(3, new java.sql.Date(wallet.getLastUpdated().getTime()));
            pstmt.setInt(4, wallet.getWalletId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int walletId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Wallet WHERE WalletID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, walletId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Wallet getWalletByUserId(int userId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Wallet WHERE UserID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Wallet wallet = new Wallet();
                wallet.setWalletId(rs.getInt("WalletID"));
                wallet.setUserId(rs.getInt("UserID"));
                wallet.setBalance(rs.getDouble("Balance"));
                wallet.setLastUpdated(rs.getDate("LastUpdated"));
                conn.close();
                return wallet;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public Wallet getByUserId(int userId) {
        return getWalletByUserId(userId);
    }

    public boolean updateBalance(int userId, Double newBalance) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Wallet SET Balance = ?, LastUpdated = GETDATE() WHERE UserID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, newBalance);
            pstmt.setInt(2, userId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
