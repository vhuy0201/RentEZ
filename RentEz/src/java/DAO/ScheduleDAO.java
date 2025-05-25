package DAO;

import Connection.DBConnection;
import Model.Schedule;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleDAO {
    
    public boolean insert(Schedule schedule) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Schedule (RenterID, LandlordID, PropertyID, ScheduleDateTime, Status) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, schedule.getRenterId());
            pstmt.setInt(2, schedule.getLandlordId());
            pstmt.setInt(3, schedule.getPropertyId());
            pstmt.setTimestamp(4, new java.sql.Timestamp(schedule.getScheduleDateTime().getTime()));
            pstmt.setString(5, schedule.getStatus());
            
            int rows = pstmt.executeUpdate();
            
            // Get generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    schedule.setScheduleId(generatedKeys.getInt(1));
                }
            }
            
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Schedule getById(int scheduleId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Schedule WHERE ScheduleID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, scheduleId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("ScheduleID"));
                schedule.setRenterId(rs.getInt("RenterID"));
                schedule.setLandlordId(rs.getInt("LandlordID"));
                schedule.setPropertyId(rs.getInt("PropertyID"));
                schedule.setScheduleDateTime(rs.getTimestamp("ScheduleDateTime"));
                schedule.setStatus(rs.getString("Status"));
                conn.close();
                return schedule;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Schedule schedule) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Schedule SET RenterID = ?, LandlordID = ?, PropertyID = ?, "
                + "ScheduleDateTime = ?, Status = ? WHERE ScheduleID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, schedule.getRenterId());
            pstmt.setInt(2, schedule.getLandlordId());
            pstmt.setInt(3, schedule.getPropertyId());
            pstmt.setTimestamp(4, new java.sql.Timestamp(schedule.getScheduleDateTime().getTime()));
            pstmt.setString(5, schedule.getStatus());
            pstmt.setInt(6, schedule.getScheduleId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int scheduleId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Schedule WHERE ScheduleID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, scheduleId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public List<Schedule> getSchedulesByRenterId(int renterId) {
        Connection conn = DBConnection.getConnection();
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM Schedule WHERE RenterID = ? ORDER BY ScheduleDateTime DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, renterId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("ScheduleID"));
                schedule.setRenterId(rs.getInt("RenterID"));
                schedule.setLandlordId(rs.getInt("LandlordID"));
                schedule.setPropertyId(rs.getInt("PropertyID"));
                schedule.setScheduleDateTime(rs.getTimestamp("ScheduleDateTime"));
                schedule.setStatus(rs.getString("Status"));
                schedules.add(schedule);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return schedules;
    }
    
    public List<Schedule> getSchedulesByLandlordId(int landlordId) {
        Connection conn = DBConnection.getConnection();
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM Schedule WHERE LandlordID = ? ORDER BY ScheduleDateTime DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("ScheduleID"));
                schedule.setRenterId(rs.getInt("RenterID"));
                schedule.setLandlordId(rs.getInt("LandlordID"));
                schedule.setPropertyId(rs.getInt("PropertyID"));
                schedule.setScheduleDateTime(rs.getTimestamp("ScheduleDateTime"));
                schedule.setStatus(rs.getString("Status"));
                schedules.add(schedule);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return schedules;
    }
    
    public List<Schedule> getSchedulesByPropertyId(int propertyId) {
        Connection conn = DBConnection.getConnection();
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM Schedule WHERE PropertyID = ? ORDER BY ScheduleDateTime DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("ScheduleID"));
                schedule.setRenterId(rs.getInt("RenterID"));
                schedule.setLandlordId(rs.getInt("LandlordID"));
                schedule.setPropertyId(rs.getInt("PropertyID"));
                schedule.setScheduleDateTime(rs.getTimestamp("ScheduleDateTime"));
                schedule.setStatus(rs.getString("Status"));
                schedules.add(schedule);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return schedules;
    }
    
    public boolean updateStatus(int scheduleId, String status) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Schedule SET Status = ? WHERE ScheduleID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, scheduleId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public List<Schedule> getUpcomingSchedules(int userId, boolean isLandlord) {
        Connection conn = DBConnection.getConnection();
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM Schedule WHERE " + 
                    (isLandlord ? "LandlordID" : "RenterID") + 
                    " = ? AND Status = 'Confirmed' AND ScheduleDateTime > GETDATE() " +
                    "ORDER BY ScheduleDateTime ASC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt("ScheduleID"));
                schedule.setRenterId(rs.getInt("RenterID"));
                schedule.setLandlordId(rs.getInt("LandlordID"));
                schedule.setPropertyId(rs.getInt("PropertyID"));
                schedule.setScheduleDateTime(rs.getTimestamp("ScheduleDateTime"));
                schedule.setStatus(rs.getString("Status"));
                schedules.add(schedule);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return schedules;
    }
}
