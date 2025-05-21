package DAO;

import Connection.DBConnection;
import Model.TenantApplication;
import java.sql.*;

public class TenantApplicationDAO {
    public boolean insert(TenantApplication tenantApplication) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO TenantApplication (ApplicationID, RenterID, PropertyID, ApplicationDate, Status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tenantApplication.getApplicationId());
            pstmt.setInt(2, tenantApplication.getRenterId());
            pstmt.setInt(3, tenantApplication.getPropertyId());
            pstmt.setDate(4, new java.sql.Date(tenantApplication.getApplicationDate().getTime()));
            pstmt.setString(5, tenantApplication.getStatus());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public TenantApplication getById(int applicationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM TenantApplication WHERE ApplicationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, applicationId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                TenantApplication tenantApplication = new TenantApplication();
                tenantApplication.setApplicationId(rs.getInt("ApplicationID"));
                tenantApplication.setRenterId(rs.getInt("RenterID"));
                tenantApplication.setPropertyId(rs.getInt("PropertyID"));
                tenantApplication.setApplicationDate(rs.getDate("ApplicationDate"));
                tenantApplication.setStatus(rs.getString("Status"));
                conn.close();
                return tenantApplication;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(TenantApplication tenantApplication) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE TenantApplication SET RenterID = ?, PropertyID = ?, ApplicationDate = ?, Status = ? WHERE ApplicationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, tenantApplication.getRenterId());
            pstmt.setInt(2, tenantApplication.getPropertyId());
            pstmt.setDate(3, new java.sql.Date(tenantApplication.getApplicationDate().getTime()));
            pstmt.setString(4, tenantApplication.getStatus());
            pstmt.setInt(5, tenantApplication.getApplicationId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int applicationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM TenantApplication WHERE ApplicationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, applicationId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
