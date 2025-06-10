package DAO;

import Connection.DBConnection;
import Model.Location;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
    
    public int insertLocation(Location location) {
    Connection conn = DBConnection.getConnection();
    String sql = "INSERT INTO Location (Address, City, StateProvince, Country, ZipCode) VALUES (?, ?, ?, ?, ?)";
    try {
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, location.getAddress());
        pstmt.setString(2, location.getCity());
        pstmt.setString(3, location.getStateProvince());
        pstmt.setString(4, location.getCountry());
        pstmt.setString(5, location.getZipCode());

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                conn.close();
                return generatedId;
            }
        }

        conn.close();
        return -1;
    } catch (Exception e) {
        System.out.println("Error: " + e);
        return -1;
    }
}

    public List<String> getAllCities() {
        List<String> cities = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT DISTINCT City FROM Location ORDER BY City";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String city = rs.getString("City");
                if (city != null && !city.isEmpty()) {
                    cities.add(city);
                }
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAllCities: " + e);
        }
        return cities;
    }
}
