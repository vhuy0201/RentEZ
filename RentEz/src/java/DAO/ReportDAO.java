
package DAO;

import Connection.DBConnection;
import Model.Report;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {
    public boolean insert(Report report) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Report (LandLordId, UserId, Content, IsApproved, Time) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, report.getLandLordID());
            pstmt.setInt(2, report.getUserId());
            pstmt.setString(3, report.getContent());
            pstmt.setBoolean(4, false);
            pstmt.setTimestamp(5, new Timestamp(report.getTime().getTime()));
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public boolean approveReport(int reportID) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Report SET IsApproved = 1 WHERE ReportId = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reportID);
            int result = pstmt.executeUpdate();
            conn.close();
            return result > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateReviewStatus: " + e);
        }
        
        return false;
    }
    
    public Report getById(int reportID) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Report WHERE ReportId = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reportID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Report report = new Report();
                report.setReportID(rs.getInt("ReportId"));
                report.setUserId(rs.getInt("UserId"));
                report.setContent(rs.getNString("Content"));
                report.setIsApproved(rs.getBoolean("IsApproved"));
                report.setTime(rs.getTimestamp("Time"));
                report.setLandLordID(rs.getInt("LandLordId"));
                conn.close();
                return report;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }
    
    public List<Report> getAll() {
        Connection conn = DBConnection.getConnection();
        List<Report> list = new ArrayList<>();
        String sql = "SELECT * FROM Report ORDER BY Time DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Report report = new Report();
                report.setReportID(rs.getInt("ReportId"));
                report.setUserId(rs.getInt("UserId"));
                report.setContent(rs.getNString("Content"));
                report.setIsApproved(rs.getBoolean("IsApproved"));
                report.setTime(rs.getTimestamp("Time"));
                report.setLandLordID(rs.getInt("LandLordId"));
                list.add(report);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return list;
    }
    
    public boolean delete(int reportID) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Report WHERE ReportId = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reportID);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
