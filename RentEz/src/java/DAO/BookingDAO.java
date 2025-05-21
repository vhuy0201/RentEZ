package DAO;

import Connection.DBConnection;
import Model.Booking;
import java.sql.*;

public class BookingDAO {

    public boolean insert(Booking booking) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Booking (BookingID, RenterID, PropertyID, StartDate, EndDate, TotalPrice, Status, ContractDocuments) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, booking.getBookingId());
            pstmt.setInt(2, booking.getRenterId());
            pstmt.setInt(3, booking.getPropertyId());
            pstmt.setDate(4, new java.sql.Date(booking.getStartDate().getTime()));
            pstmt.setDate(5, new java.sql.Date(booking.getEndDate().getTime()));
            pstmt.setDouble(6, booking.getTotalPrice());
            pstmt.setString(7, booking.getStatus());
            pstmt.setString(8, booking.getContractDocuments());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public Booking getById(int bookingId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Booking WHERE BookingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setRenterId(rs.getInt("RenterID"));
                booking.setPropertyId(rs.getInt("PropertyID"));
                booking.setStartDate(rs.getDate("StartDate"));
                booking.setEndDate(rs.getDate("EndDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setStatus(rs.getString("Status"));
                booking.setContractDocuments(rs.getString("ContractDocuments"));
                conn.close();
                return booking;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(Booking booking) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Booking SET RenterID = ?, PropertyID = ?, StartDate = ?, EndDate = ?, TotalPrice = ?, Status = ?, ContractDocuments = ? WHERE BookingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, booking.getRenterId());
            pstmt.setInt(2, booking.getPropertyId());
            pstmt.setDate(3, new java.sql.Date(booking.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(booking.getEndDate().getTime()));
            pstmt.setDouble(5, booking.getTotalPrice());
            pstmt.setString(6, booking.getStatus());
            pstmt.setString(7, booking.getContractDocuments());
            pstmt.setInt(8, booking.getBookingId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int bookingId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Booking WHERE BookingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
