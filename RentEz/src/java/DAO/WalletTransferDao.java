package DAO;
import Connection.DBConnection;
import Model.WalletTransfer;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
public class WalletTransferDao {

    public List<WalletTransfer> getTransfersByUserId(int userID) {
        List<WalletTransfer> walletTransfers = new ArrayList<>();
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM WalletTransfer WHERE UserID = ? ORDER BY WalletTransferID DESC");
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WalletTransfer walletTransfer = new WalletTransfer();
                walletTransfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                walletTransfer.setTransCode(rs.getString("TransCode"));
                try {
                    LocalDateTime dateTime = LocalDateTime.parse(rs.getString("TimeCode"), inputFormat);
                    walletTransfer.setTimeCode(dateTime.format(outputFormat));
                } catch (Exception e) {
                    walletTransfer.setTimeCode(rs.getString("TimeCode"));
                }
                walletTransfer.setUserID(userID);
                walletTransfer.setAmount(rs.getDouble("Amount"));
                walletTransfer.setContent(rs.getString("Content"));
                walletTransfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                walletTransfers.add(walletTransfer);
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return walletTransfers;
    }

    public List<WalletTransfer> getRecentTransfersByUserId(int userID, int limit) {
        List<WalletTransfer> walletTransfers = new ArrayList<>();
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT TOP " + limit + " * FROM WalletTransfer WHERE UserID = ? ORDER BY WalletTransferID DESC");
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WalletTransfer walletTransfer = new WalletTransfer();
                walletTransfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                walletTransfer.setTransCode(rs.getString("TransCode"));
                try {
                    LocalDateTime dateTime = LocalDateTime.parse(rs.getString("TimeCode"), inputFormat);
                    walletTransfer.setTimeCode(dateTime.format(outputFormat));
                } catch (Exception e) {
                    walletTransfer.setTimeCode(rs.getString("TimeCode"));
                }
                walletTransfer.setUserID(userID);
                walletTransfer.setAmount(rs.getDouble("Amount"));
                walletTransfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                walletTransfers.add(walletTransfer);
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return walletTransfers;
    }

    public boolean create(WalletTransfer walletTransfer) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO WalletTransfer (TransCode, TimeCode, UserID, Amount, IsRefunded) VALUES (?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, walletTransfer.getTransCode());
            ps.setString(2, walletTransfer.getTimeCode());
            ps.setInt(3, walletTransfer.getUserID());
            ps.setDouble(4, walletTransfer.getAmount());
            ps.setBoolean(5, walletTransfer.isIsRefunded());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    walletTransfer.setWalletTransferID(generatedKeys.getInt(1));
                }
            }

            ps.close();
            con.close();
            return affectedRows > 0;
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return false;
    }

    public static List<WalletTransfer> getWalletTransfersByUserID(int userID) {
        List<WalletTransfer> walletTransfers = new ArrayList<>();
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("Select * from WalletTransfer where UserID = ?");
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WalletTransfer walletTransfer = new WalletTransfer();
                walletTransfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                walletTransfer.setTransCode(rs.getString("TransCode"));
                LocalDateTime dateTime = LocalDateTime.parse(rs.getString("TimeCode"), inputFormat);
                walletTransfer.setTimeCode(dateTime.format(outputFormat));
                walletTransfer.setUserID(userID);
                walletTransfer.setAmount(rs.getDouble("Amount"));
                walletTransfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                walletTransfers.add(walletTransfer);
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return walletTransfers;
    }

    public static WalletTransfer getWalletTransfersByID(int walletTransferID) {
        WalletTransfer walletTransfer = new WalletTransfer();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("Select * from WalletTransfer where WalletTransferID = ?");
            ps.setInt(1, walletTransferID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                walletTransfer.setTransCode(rs.getString("WalletTransferID"));
                walletTransfer.setTimeCode(rs.getString("TransCode"));
                walletTransfer.setUserID(rs.getInt("TimeCode"));
                walletTransfer.setAmount(rs.getDouble("Amount"));
                walletTransfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                return walletTransfer;
            }
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return walletTransfer;
    }

    public static int addWalletTransfer(WalletTransfer walletTransfer) {
        int status = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO WalletTransfer VALUES (?,?,?,?,?)");
            ps.setString(1, walletTransfer.getTransCode());
            ps.setString(2, walletTransfer.getTimeCode());
            ps.setInt(3, walletTransfer.getUserID());
            ps.setDouble(4, walletTransfer.getAmount());
            ps.setBoolean(5, walletTransfer.isIsRefunded());
            status = ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return status;
    }

    public static int updateWalletTransfer(int walletTransferID) {
        int status = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("update WalletTransfer set IsRefunded = 1 where WalletTransferID = ?");
            ps.setInt(1, walletTransferID);
            status = ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return status;
    }

    public WalletTransfer getLastTransfersByUserId(int userID) {
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        WalletTransfer walletTransfer = new WalletTransfer();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT TOP 1 * FROM WalletTransfer WHERE UserID = ? ORDER BY WalletTransferID DESC");
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                walletTransfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                walletTransfer.setTransCode(rs.getString("TransCode"));
                try {
                    LocalDateTime dateTime = LocalDateTime.parse(rs.getString("TimeCode"), inputFormat);
                    walletTransfer.setTimeCode(dateTime.format(outputFormat));
                } catch (Exception e) {
                    walletTransfer.setTimeCode(rs.getString("TimeCode"));
                }
                walletTransfer.setUserID(userID);
                walletTransfer.setAmount(rs.getDouble("Amount"));
                walletTransfer.setIsRefunded(rs.getBoolean("IsRefunded"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return walletTransfer;
    }

}
