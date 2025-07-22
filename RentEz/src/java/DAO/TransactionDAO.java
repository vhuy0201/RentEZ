package DAO;

import Connection.DBConnection;
import DTO.TransactionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Transaction operations
 */
public class TransactionDAO {
    
    private Connection connection;
    
    public TransactionDAO() {
        this.connection = DBConnection.getConnection();
    }
    
    /**
     * Create a new transaction record
     */
    public boolean createTransaction(TransactionDTO transaction) {
        String sql = "INSERT INTO transactions (user_id, amount, transaction_type, payment_method, " +
                    "status, description, transaction_date, reference_id, bank_code, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, transaction.getUserId());
            pstmt.setDouble(2, transaction.getAmount());
            pstmt.setString(3, transaction.getTransactionType());
            pstmt.setString(4, transaction.getPaymentMethod());
            pstmt.setString(5, transaction.getStatus());
            pstmt.setString(6, transaction.getDescription());
            pstmt.setTimestamp(7, new Timestamp(transaction.getTransactionDate().getTime()));
            pstmt.setString(8, transaction.getReferenceId());
            pstmt.setString(9, transaction.getBankCode());
            pstmt.setTimestamp(10, new Timestamp(transaction.getCreatedAt().getTime()));
            pstmt.setTimestamp(11, new Timestamp(transaction.getUpdatedAt().getTime()));
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get transaction by ID
     */
    public TransactionDTO getTransactionById(Integer transactionId) {
        String sql = "SELECT * FROM transactions WHERE transaction_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, transactionId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToTransaction(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Get transactions by user ID
     */
    public List<TransactionDTO> getTransactionsByUserId(Integer userId) {
        return getTransactionsByUserId(userId, 0, 50); // Default limit
    }
    
    /**
     * Get transactions by user ID with pagination
     */
    public List<TransactionDTO> getTransactionsByUserId(Integer userId, int offset, int limit) {
        String sql = "SELECT * FROM transactions WHERE user_id = ? " +
                    "ORDER BY transaction_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        List<TransactionDTO> transactions = new ArrayList<>();
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, offset);
            pstmt.setInt(3, limit);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transactions;
    }
    
    /**
     * Get recent transactions by user ID
     */
    public List<TransactionDTO> getRecentTransactionsByUserId(Integer userId, int limit) {
        String sql = "SELECT TOP(?) * FROM transactions WHERE user_id = ? " +
                    "ORDER BY transaction_date DESC";
        
        List<TransactionDTO> transactions = new ArrayList<>();
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            pstmt.setInt(2, userId);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                transactions.add(mapResultSetToTransaction(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return transactions;
    }
    
    /**
     * Update transaction status
     */
    public boolean updateTransactionStatus(Integer transactionId, String status) {
        String sql = "UPDATE transactions SET status = ?, updated_at = ? WHERE transaction_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(3, transactionId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Check if transaction with reference ID exists
     */
    public boolean existsByReferenceId(String referenceId) {
        String sql = "SELECT COUNT(*) FROM transactions WHERE reference_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, referenceId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Get total transaction amount by user and type
     */
    public Double getTotalAmountByUserAndType(Integer userId, String transactionType) {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM transactions " +
                    "WHERE user_id = ? AND transaction_type = ? AND status = 'Completed'";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setString(2, transactionType);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    /**
     * Map ResultSet to TransactionDTO
     */
    private TransactionDTO mapResultSetToTransaction(ResultSet rs) throws SQLException {
        TransactionDTO transaction = new TransactionDTO();
        
        transaction.setTransactionId(rs.getInt("transaction_id"));
        transaction.setUserId(rs.getInt("user_id"));
        transaction.setAmount(rs.getDouble("amount"));
        transaction.setTransactionType(rs.getString("transaction_type"));
        transaction.setPaymentMethod(rs.getString("payment_method"));
        transaction.setStatus(rs.getString("status"));
        transaction.setDescription(rs.getString("description"));
        transaction.setTransactionDate(rs.getTimestamp("transaction_date"));
        transaction.setReferenceId(rs.getString("reference_id"));
        transaction.setBankCode(rs.getString("bank_code"));
        transaction.setCreatedAt(rs.getTimestamp("created_at"));
        transaction.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        return transaction;
    }
}
