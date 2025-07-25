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

    /**
     * Get payments by payer ID
     */
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

    /**
     * Get payments by payee ID
     */
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

    /**
     * Extract Payment object from ResultSet
     */
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
    
    // Admin methods for payment history
    public List<Payment> getFilteredPayments(String search, String statusFilter, String typeFilter, 
                                            String dateFrom, String dateTo, int page, int pageSize) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT p.*, u.Name as PayerName ");
        sql.append("FROM Payment p ");
        sql.append("LEFT JOIN [User] u ON p.PayerID = u.UserID ");
        sql.append("WHERE 1=1 ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Name LIKE ? OR p.TransCode LIKE ?)");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND p.Status = ?");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND p.ReferenceType = ?");
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate >= ?");
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate <= ?");
        }
        
        sql.append(" ORDER BY p.PaymentDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
            }
            
            pstmt.setInt(paramIndex++, (page - 1) * pageSize);
            pstmt.setInt(paramIndex, pageSize);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
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
                payment.setTransCode(rs.getString("TransCode"));
                payment.setIsRefunded(rs.getBoolean("IsRefunded"));
                payments.add(payment);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }
    
    public int getTotalFilteredPayments(String search, String statusFilter, String typeFilter, 
                                       String dateFrom, String dateTo) {
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Payment p ");
        sql.append("LEFT JOIN [User] u ON p.PayerID = u.UserID ");
        sql.append("WHERE 1=1 ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Name LIKE ? OR p.TransCode LIKE ?)");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND p.Status = ?");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND p.ReferenceType = ?");
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate >= ?");
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate <= ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
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
    
    public double getTotalAmount(String search, String statusFilter, String typeFilter, 
                                String dateFrom, String dateTo) {
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT SUM(p.Amount) FROM Payment p ");
        sql.append("LEFT JOIN [User] u ON p.PayerID = u.UserID ");
        sql.append("WHERE 1=1 ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Name LIKE ? OR p.TransCode LIKE ?)");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND p.Status = ?");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND p.ReferenceType = ?");
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate >= ?");
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate <= ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    public double getTotalRefunded(String search, String statusFilter, String typeFilter, 
                                  String dateFrom, String dateTo) {
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT SUM(p.Amount) FROM Payment p ");
        sql.append("LEFT JOIN [User] u ON p.PayerID = u.UserID ");
        sql.append("WHERE p.IsRefunded = 1 ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Name LIKE ? OR p.TransCode LIKE ?)");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND p.Status = ?");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND p.ReferenceType = ?");
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate >= ?");
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate <= ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    public boolean processRefund(int paymentId, String refundReason) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Payment SET IsRefunded = 1, Status = 'Refunded' WHERE PaymentID = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, paymentId);
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Payment> getAllFilteredPayments(String search, String statusFilter, String typeFilter, String dateFrom, String dateTo) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT p.*, u.Name as PayerName ");
        sql.append("FROM Payment p ");
        sql.append("LEFT JOIN [User] u ON p.PayerID = u.UserID ");
        sql.append("WHERE 1=1 ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Name LIKE ? OR p.TransCode LIKE ?)");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND p.Status = ?");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND p.ReferenceType = ?");
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate >= ?");
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate <= ?");
        }
        
        sql.append(" ORDER BY p.PaymentDate DESC");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("PaymentID"));
                payment.setAmount(rs.getDouble("Amount"));
                payment.setPaymentMethod(rs.getString("PaymentMethod"));
                payment.setStatus(rs.getString("Status"));
                payment.setReferenceType(rs.getString("ReferenceType"));
                payment.setPaymentDate(rs.getDate("PaymentDate"));
                payment.setTransCode(rs.getString("TransCode"));
                payments.add(payment);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }
    
    public double getTotalRevenue() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE Status = 'Paid' AND IsRefunded = 0";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    public List<Payment> getRecentPayments(int limit) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP (?) p.*, u.Name as PayerName FROM Payment p LEFT JOIN [User] u ON p.PayerID = u.UserID ORDER BY p.PaymentDate DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("PaymentID"));
                payment.setAmount(rs.getDouble("Amount"));
                payment.setPaymentMethod(rs.getString("PaymentMethod"));
                payment.setStatus(rs.getString("Status"));
                payment.setReferenceType(rs.getString("ReferenceType"));
                payment.setPaymentDate(rs.getDate("PaymentDate"));
                payments.add(payment);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }
    
    public double getMonthlyRevenue() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE YEAR(PaymentDate) = YEAR(GETDATE()) AND MONTH(PaymentDate) = MONTH(GETDATE()) AND Status = 'Completed' AND IsRefunded = 0";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    public double getQuarterlyRevenue() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE YEAR(PaymentDate) = YEAR(GETDATE()) AND DATEPART(quarter, PaymentDate) = DATEPART(quarter, GETDATE()) AND Status = 'Completed' AND IsRefunded = 0";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    public double getYearlyRevenue() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE YEAR(PaymentDate) = YEAR(GETDATE()) AND Status = 'Completed' AND IsRefunded = 0";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    public List<Double> getMonthlyRevenueStats(int months) {
        List<Double> monthlyStats = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT MONTH(PaymentDate) as Month, SUM(Amount) as Revenue " +
                    "FROM Payment " +
                    "WHERE PaymentDate >= DATEADD(month, -?, GETDATE()) " +
                    "AND Status = 'Completed' AND IsRefunded = 0 " +
                    "GROUP BY YEAR(PaymentDate), MONTH(PaymentDate) " +
                    "ORDER BY YEAR(PaymentDate), MONTH(PaymentDate)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, months);
            ResultSet rs = pstmt.executeQuery();
            
            // Initialize with zeros for all months
            for (int i = 0; i < months; i++) {
                monthlyStats.add(0.0);
            }
            
            while (rs.next()) {
                double revenue = rs.getDouble("Revenue");
                monthlyStats.add(revenue);
            }
            
            // Keep only the last 'months' entries
            while (monthlyStats.size() > months) {
                monthlyStats.remove(0);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlyStats;
    }
    
    public List<String> getMonthLabels(int months) {
        List<String> labels = new ArrayList<>();
        java.util.Calendar cal = java.util.Calendar.getInstance();
        String[] monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        
        for (int i = months - 1; i >= 0; i--) {
            cal.add(java.util.Calendar.MONTH, -i);
            labels.add(monthNames[cal.get(java.util.Calendar.MONTH)]);
            cal = java.util.Calendar.getInstance(); // Reset for next iteration
        }
        
        return labels;
    }
    
    public int getCountByStatus(String status, String search, String typeFilter, 
                                  String dateFrom, String dateTo) {
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Payment p ");
        sql.append("LEFT JOIN [User] u ON p.PayerID = u.UserID ");
        sql.append("WHERE p.Status = ? ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.Name LIKE ? OR p.TransCode LIKE ?)");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND p.ReferenceType = ?");
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate >= ?");
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND p.PaymentDate <= ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            pstmt.setString(paramIndex++, status);
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(dateTo));
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
    
    // =============== LANDLORD SPECIFIC METHODS ===============
    
    /**
     * Get total revenue for a specific landlord (payee)
     */
    public double getTotalRevenueByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE PayeeID = ? AND Status = 'Completed' AND IsRefunded = 0";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    /**
     * Get monthly revenue for a specific landlord
     */
    public double getMonthlyRevenueByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE PayeeID = ? AND YEAR(PaymentDate) = YEAR(GETDATE()) AND MONTH(PaymentDate) = MONTH(GETDATE()) AND Status = 'Completed' AND IsRefunded = 0";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    /**
     * Get quarterly revenue for a specific landlord
     */
    public double getQuarterlyRevenueByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE PayeeID = ? AND YEAR(PaymentDate) = YEAR(GETDATE()) AND DATEPART(quarter, PaymentDate) = DATEPART(quarter, GETDATE()) AND Status = 'Completed' AND IsRefunded = 0";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    /**
     * Get yearly revenue for a specific landlord
     */
    public double getYearlyRevenueByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT SUM(Amount) FROM Payment WHERE PayeeID = ? AND YEAR(PaymentDate) = YEAR(GETDATE()) AND Status = 'Completed' AND IsRefunded = 0";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double total = rs.getDouble(1);
                conn.close();
                return total;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    /**
     * Get monthly revenue statistics for a specific landlord (for chart)
     */
    public List<Double> getMonthlyRevenueStatsByLandlord(int landlordId, int months) {
        List<Double> monthlyStats = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        // Get current date
        java.util.Calendar cal = java.util.Calendar.getInstance();
        
        String sql = "SELECT " +
                    "YEAR(PaymentDate) as Year, " +
                    "MONTH(PaymentDate) as Month, " +
                    "SUM(Amount) as Revenue " +
                    "FROM Payment " +
                    "WHERE PayeeID = ? " +
                    "AND PaymentDate >= DATEADD(month, -?, GETDATE()) " +
                    "AND Status = 'Completed' AND IsRefunded = 0 " +
                    "GROUP BY YEAR(PaymentDate), MONTH(PaymentDate) " +
                    "ORDER BY YEAR(PaymentDate), MONTH(PaymentDate)";
                    
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            pstmt.setInt(2, months);
            ResultSet rs = pstmt.executeQuery();
            
            // Initialize array with zeros for all months
            Double[] revenueArray = new Double[months];
            for (int i = 0; i < months; i++) {
                revenueArray[i] = 0.0;
            }
            
            // Fill actual data
            while (rs.next()) {
                int year = rs.getInt("Year");
                int month = rs.getInt("Month");
                double revenue = rs.getDouble("Revenue");
                
                // Calculate the index in our array
                java.util.Calendar currentCal = java.util.Calendar.getInstance();
                java.util.Calendar dateCal = java.util.Calendar.getInstance();
                dateCal.set(year, month - 1, 1); // month is 0-indexed in Calendar
                
                int monthsFromNow = (currentCal.get(java.util.Calendar.YEAR) - dateCal.get(java.util.Calendar.YEAR)) * 12 
                                  + currentCal.get(java.util.Calendar.MONTH) - dateCal.get(java.util.Calendar.MONTH);
                
                int index = months - 1 - monthsFromNow;
                if (index >= 0 && index < months) {
                    revenueArray[index] = revenue;
                }
            }
            
            // Convert array to list
            for (Double revenue : revenueArray) {
                monthlyStats.add(revenue);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Fill with zeros if error
            for (int i = 0; i < months; i++) {
                monthlyStats.add(0.0);
            }
        }
        
        return monthlyStats;
    }
    
    /**
     * Get recent payments for a specific landlord
     */
    public List<Payment> getRecentPaymentsByLandlord(int landlordId, int limit) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP (?) p.*, u.Name as PayerName " +
                    "FROM Payment p " +
                    "LEFT JOIN [User] u ON p.PayerID = u.UserID " +
                    "WHERE p.PayeeID = ? " +
                    "ORDER BY p.PaymentDate DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            pstmt.setInt(2, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                payments.add(payment);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }
    
    /**
     * Get total number of transactions for a landlord
     */
    public int getTotalTransactionsByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Payment WHERE PayeeID = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
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
    
    /**
     * Get completed transactions count for a landlord
     */
    public int getCompletedTransactionsByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Payment WHERE PayeeID = ? AND Status = 'Completed'";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
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
    
    /**
     * Get pending transactions count for a landlord
     */
    public int getPendingTransactionsByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Payment WHERE PayeeID = ? AND Status = 'Pending'";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
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
    
    /**
     * Get average transaction amount for a landlord
     */
    public double getAverageTransactionByLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT AVG(Amount) FROM Payment WHERE PayeeID = ? AND Status = 'Completed'";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double avg = rs.getDouble(1);
                conn.close();
                return avg;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
}
