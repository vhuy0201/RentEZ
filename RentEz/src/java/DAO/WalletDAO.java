package DAO;

import Connection.DBConnection;
import Model.Wallet;
import java.sql.*;

public class WalletDAO {
    public boolean insert(Wallet wallet) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Wallet (WalletID, UserID, Balance, LastUpdated) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, wallet.getWalletId());
            pstmt.setInt(2, wallet.getUserId());
            pstmt.setDouble(3, wallet.getBalance());
            pstmt.setTimestamp(4, new Timestamp(wallet.getLastUpdated().getTime()));
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
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
                wallet.setLastUpdated(rs.getTimestamp("LastUpdated"));
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
            pstmt.setTimestamp(3, new Timestamp(wallet.getLastUpdated().getTime()));
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
}
