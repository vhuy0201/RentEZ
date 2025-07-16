package DAO;

import Connection.DBConnection;
import Model.Payment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    
    public boolean create(Payment payment) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Payment (PayerID, PayeeID, Amount, PaymentDate, PaymentMethod, Status, ReferenceID, ReferenceType, WalletTransferID, TransCode, TimeCode, IsRefunded) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, payment.getPayerId());
            pstmt.setInt(2, payment.getPayeeId()); // Nullable
            pstmt.setDouble(3, payment.getAmount());
            pstmt.setDate(4, new java.sql.Date(payment.getPaymentDate().getTime()));
            pstmt.setString(5, payment.getPaymentMethod());
            pstmt.setString(6, payment.getStatus());
            pstmt.setInt(7, payment.getReferenceId());
            pstmt.setString(8, payment.getReferenceType());
            pstmt.setInt(9, payment.getWalletTransferId()); // Nullable
            pstmt.setString(10, payment.getTransCode());
            pstmt.setString(11, payment.getTimeCode());
            pstmt.setBoolean(12, payment.isIsRefunded());
            
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    payment.setPaymentId(generatedKeys.getInt(1));
                }
            }
            
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public boolean insert(Payment payment) {
        return create(payment);
    }

    public List<Payment> getPaymentsByPayerId(int payerId) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Payment WHERE PayerID = ? ORDER BY PaymentDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, payerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                payments.add(payment);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return payments;
    }

    public List<Payment> getPaymentsByPayeeId(int payeeId) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Payment WHERE PayeeID = ? ORDER BY PaymentDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, payeeId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                payments.add(payment);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return payments;
    }

    public Payment getById(int paymentId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Payment WHERE PaymentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, paymentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                conn.close();
                return payment;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    private Payment extractPaymentFromResultSet(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("PaymentID"));
        payment.setPayerId(rs.getInt("PayerID"));
        payment.setPayeeId(rs.getInt("PayeeID"));
        payment.setAmount(rs.getDouble("Amount"));
        payment.setPaymentDate(rs.getDate("PaymentDate"));
        payment.setPaymentMethod(rs.getString("PaymentMethod"));
        payment.setStatus(rs.getString("Status"));
        payment.setReferenceId(rs.getInt("ReferenceID"));
        payment.setReferenceType(rs.getString("ReferenceType"));
        payment.setWalletTransferId(rs.getInt("WalletTransferID"));
        payment.setTransCode(rs.getString("TransCode"));
        payment.setTimeCode(rs.getString("TimeCode"));
        payment.setIsRefunded(rs.getBoolean("IsRefunded"));
        return payment;
    }

    public boolean update(Payment payment) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Payment SET PayerID = ?, PayeeID = ?, Amount = ?, PaymentDate = ?, PaymentMethod = ?, Status = ?, ReferenceID = ?, ReferenceType = ?, WalletTransferID = ?, TransCode = ?, TimeCode = ?, IsRefunded = ? WHERE PaymentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, payment.getPayerId());
            pstmt.setInt(2, payment.getPayeeId()); // Nullable
            pstmt.setDouble(3, payment.getAmount());
            pstmt.setDate(4, new java.sql.Date(payment.getPaymentDate().getTime()));
            pstmt.setString(5, payment.getPaymentMethod());
            pstmt.setString(6, payment.getStatus());
            pstmt.setInt(7, payment.getReferenceId());
            pstmt.setString(8, payment.getReferenceType());
            pstmt.setInt(9, payment.getWalletTransferId()); // Nullable
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
