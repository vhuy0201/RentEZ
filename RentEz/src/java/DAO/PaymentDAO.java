package DAO;

import Connection.DBConnection;
import Model.Payment;
import java.sql.*;

public class PaymentDAO {
    public boolean insert(Payment payment) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Payment (PaymentID, PayerID, PayeeID, Amount, PaymentDate, PaymentMethod, Status, ReferenceID, ReferenceType, WalletTransferID, TransCode, TimeCode, IsRefunded) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, payment.getPaymentId());
            pstmt.setInt(2, payment.getPayerId());
            pstmt.setObject(3, payment.getPayeeId()); // Nullable
            pstmt.setDouble(4, payment.getAmount());
            pstmt.setDate(5, new java.sql.Date(payment.getPaymentDate().getTime()));
            pstmt.setString(6, payment.getPaymentMethod());
            pstmt.setString(7, payment.getStatus());
            pstmt.setInt(8, payment.getReferenceId());
            pstmt.setString(9, payment.getReferenceType());
            pstmt.setObject(10, payment.getWalletTransferId()); // Nullable
            pstmt.setString(11, payment.getTransCode());
            pstmt.setString(12, payment.getTimeCode());
            pstmt.setBoolean(13, payment.isIsRefunded());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Payment getById(int paymentId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Payment WHERE PaymentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, paymentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("PaymentID"));
                payment.setPayerId(rs.getInt("PayerID"));
                payment.setPayeeId(rs.getObject("PayeeID") != null ? rs.getInt("PayeeID") : null);
                payment.setAmount(rs.getDouble("Amount"));
                payment.setPaymentDate(rs.getDate("PaymentDate"));
                payment.setPaymentMethod(rs.getString("PaymentMethod"));
                payment.setStatus(rs.getString("Status"));
                payment.setReferenceId(rs.getInt("ReferenceID"));
                payment.setReferenceType(rs.getString("ReferenceType"));
                payment.setWalletTransferId(rs.getObject("WalletTransferID") != null ? rs.getInt("WalletTransferID") : null);
                payment.setTransCode(rs.getString("TransCode"));
                payment.setTimeCode(rs.getString("TimeCode"));
                payment.setIsRefunded(rs.getBoolean("IsRefunded"));
                conn.close();
                return payment;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Payment payment) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Payment SET PayerID = ?, PayeeID = ?, Amount = ?, PaymentDate = ?, PaymentMethod = ?, Status = ?, ReferenceID = ?, ReferenceType = ?, WalletTransferID = ?, TransCode = ?, TimeCode = ?, IsRefunded = ? WHERE PaymentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, payment.getPayerId());
            pstmt.setObject(2, payment.getPayeeId()); // Nullable
            pstmt.setDouble(3, payment.getAmount());
            pstmt.setDate(4, new java.sql.Date(payment.getPaymentDate().getTime()));
            pstmt.setString(5, payment.getPaymentMethod());
            pstmt.setString(6, payment.getStatus());
            pstmt.setInt(7, payment.getReferenceId());
            pstmt.setString(8, payment.getReferenceType());
            pstmt.setObject(9, payment.getWalletTransferId()); // Nullable
            pstmt.setString(10, payment.getTransCode());
            pstmt.setString(11, payment.getTimeCode());
            pstmt.setBoolean(12, payment.isIsRefunded());
            pstmt.setInt(13, payment.getPaymentId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int paymentId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Payment WHERE PaymentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, paymentId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
