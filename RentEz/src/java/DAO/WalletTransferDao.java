package DAO;

import Connection.DBConnection;
import Model.WalletTransfer;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class WalletTransferDao {

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
                walletTransfer.setWalletTransferID(rs.getInt(1));
                walletTransfer.setTransCode(rs.getString(2));
                walletTransfer.setContent(rs.getString(3));
                LocalDateTime dateTime = LocalDateTime.parse(rs.getString(4), inputFormat);
                walletTransfer.setTimeCode(dateTime.format(outputFormat));
                walletTransfer.setUserID(userID);
                walletTransfer.setAmount(rs.getFloat(6));
                walletTransfer.setIsRefunded(rs.getBoolean(7));
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
                walletTransfer.setTransCode(rs.getString(2));
                walletTransfer.setContent(rs.getString(3));
                walletTransfer.setTimeCode(rs.getString(4));
                walletTransfer.setUserID(rs.getInt(5));
                walletTransfer.setAmount(rs.getFloat(6));
                walletTransfer.setIsRefunded(rs.getBoolean(7));
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
            PreparedStatement ps = con.prepareStatement("INSERT INTO WalletTransfer VALUES (?,?,?,?,?,?)");
            ps.setString(1, walletTransfer.getTransCode());
            ps.setString(2, walletTransfer.getContent());
            ps.setString(3, walletTransfer.getTimeCode());
            ps.setInt(4, walletTransfer.getUserID());
            ps.setFloat(5, walletTransfer.getAmount());
            ps.setBoolean(6, walletTransfer.isIsRefunded());
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
}
