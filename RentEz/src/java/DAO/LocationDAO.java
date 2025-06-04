package DAO;

import Connection.DBConnection;
import Model.Location;
import java.sql.*;

public class LocationDAO {
    public boolean insert(Location location) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Location (LocationID, Address, City, StateProvince, Country, ZipCode) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, location.getLocationId());
            pstmt.setString(2, location.getAddress());
            pstmt.setString(3, location.getCity());
            pstmt.setString(4, location.getStateProvince());
            pstmt.setString(5, location.getCountry());
            pstmt.setString(6, location.getZipCode());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Location getById(int locationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Location WHERE LocationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, locationId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("LocationID"));
                location.setAddress(rs.getString("Address"));
                location.setCity(rs.getString("City"));
                location.setStateProvince(rs.getString("StateProvince"));
                location.setCountry(rs.getString("Country"));
                location.setZipCode(rs.getString("ZipCode"));
                conn.close();
                return location;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Location location) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Location SET Address = ?, City = ?, StateProvince = ?, Country = ?, ZipCode = ? WHERE LocationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, location.getAddress());
            pstmt.setString(2, location.getCity());
            pstmt.setString(3, location.getStateProvince());
            pstmt.setString(4, location.getCountry());
            pstmt.setString(5, location.getZipCode());
            pstmt.setInt(6, location.getLocationId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int locationId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Location WHERE LocationID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, locationId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
