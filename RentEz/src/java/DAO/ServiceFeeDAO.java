package DAO;

import Connection.DBConnection;
import Model.ServiceFee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceFeeDAO {
    
    public List<ServiceFee> getFilteredServiceFees(String search, String typeFilter, String statusFilter, int page, int pageSize) {
        List<ServiceFee> serviceFees = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT * FROM ServiceFee WHERE 1=1");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (FeeName LIKE ? OR Description LIKE ?)");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND FeeType = ?");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND Status = ?");
        }
        
        sql.append(" ORDER BY CreatedDate DESC LIMIT ? OFFSET ?");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            
            pstmt.setInt(paramIndex++, pageSize);
            pstmt.setInt(paramIndex, (page - 1) * pageSize);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ServiceFee serviceFee = new ServiceFee();
                serviceFee.setFeeId(rs.getInt("FeeID"));
                serviceFee.setFeeName(rs.getString("FeeName"));
                serviceFee.setDescription(rs.getString("Description"));
                serviceFee.setAmount(rs.getDouble("Amount"));
                serviceFee.setFeeType(rs.getString("FeeType"));
                serviceFee.setStatus(rs.getString("Status"));
                serviceFee.setCreatedDate(rs.getTimestamp("CreatedDate"));
                serviceFee.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
                serviceFees.add(serviceFee);
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return serviceFees;
    }
    
    public int getTotalFilteredServiceFees(String search, String typeFilter, String statusFilter) {
        Connection conn = DBConnection.getConnection();
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM ServiceFee WHERE 1=1");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (FeeName LIKE ? OR Description LIKE ?)");
        }
        if (typeFilter != null && !typeFilter.trim().isEmpty()) {
            sql.append(" AND FeeType = ?");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND Status = ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (typeFilter != null && !typeFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, typeFilter);
            }
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
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
    
    public boolean createServiceFee(ServiceFee serviceFee) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO ServiceFee (FeeName, Description, Amount, FeeType, Status, CreatedDate) VALUES (?, ?, ?, ?, ?, NOW())";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, serviceFee.getFeeName());
            pstmt.setString(2, serviceFee.getDescription());
            pstmt.setDouble(3, serviceFee.getAmount());
            pstmt.setString(4, serviceFee.getFeeType());
            pstmt.setString(5, serviceFee.getStatus());
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public ServiceFee getServiceFeeById(int feeId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM ServiceFee WHERE FeeID = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, feeId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                ServiceFee serviceFee = new ServiceFee();
                serviceFee.setFeeId(rs.getInt("FeeID"));
                serviceFee.setFeeName(rs.getString("FeeName"));
                serviceFee.setDescription(rs.getString("Description"));
                serviceFee.setAmount(rs.getDouble("Amount"));
                serviceFee.setFeeType(rs.getString("FeeType"));
                serviceFee.setStatus(rs.getString("Status"));
                serviceFee.setCreatedDate(rs.getTimestamp("CreatedDate"));
                serviceFee.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
                conn.close();
                return serviceFee;
            }
            
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean updateServiceFee(ServiceFee serviceFee) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE ServiceFee SET FeeName = ?, Description = ?, Amount = ?, FeeType = ?, Status = ?, UpdatedDate = NOW() WHERE FeeID = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, serviceFee.getFeeName());
            pstmt.setString(2, serviceFee.getDescription());
            pstmt.setDouble(3, serviceFee.getAmount());
            pstmt.setString(4, serviceFee.getFeeType());
            pstmt.setString(5, serviceFee.getStatus());
            pstmt.setInt(6, serviceFee.getFeeId());
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteServiceFee(int feeId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM ServiceFee WHERE FeeID = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, feeId);
            
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
