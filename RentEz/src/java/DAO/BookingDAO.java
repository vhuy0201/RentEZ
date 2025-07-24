package DAO;

import Connection.DBConnection;
import Model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean insert(Booking booking) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Booking (RenterID, PropertyID, StartDate, EndDate, TotalPrice, Status, "
                + "DepositAmount, MonthlyRent, PenaltyClause, TermsAndConditions, CreatedAt, SignedAt, "
                + "SignedByRenter, SignedByLandlord) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, booking.getRenterId());
            pstmt.setInt(2, booking.getPropertyId());
            pstmt.setDate(3, new java.sql.Date(booking.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(booking.getEndDate().getTime()));
            pstmt.setDouble(5, booking.getTotalPrice());
            pstmt.setString(6, booking.getStatus());
            pstmt.setDouble(7, booking.getDepositAmount());
            pstmt.setDouble(8, booking.getMonthlyRent());
            pstmt.setString(9, booking.getPenaltyClause());
            pstmt.setString(10, booking.getTermsAndConditions());

            // Handle SignedAt (it can be null)
            if (booking.getSignedAt() != null) {
                pstmt.setTimestamp(11, new java.sql.Timestamp(booking.getSignedAt().getTime()));
            } else {
                pstmt.setNull(11, java.sql.Types.TIMESTAMP);
            }

            pstmt.setBoolean(12, booking.isSignedByRenter());
            pstmt.setBoolean(13, booking.isSignedByLandlord());

            int rows = pstmt.executeUpdate();

            // Get the generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    booking.setBookingId(generatedKeys.getInt(1));
                }
            }

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
                booking.setDepositAmount(rs.getDouble("DepositAmount"));
                booking.setMonthlyRent(rs.getDouble("MonthlyRent"));
                booking.setPenaltyClause(rs.getString("PenaltyClause"));
                booking.setTermsAndConditions(rs.getString("TermsAndConditions"));
                booking.setCreatedAt(rs.getTimestamp("CreatedAt"));
                booking.setSignedAt(rs.getTimestamp("SignedAt"));
                booking.setSignedByRenter(rs.getBoolean("SignedByRenter"));
                booking.setSignedByLandlord(rs.getBoolean("SignedByLandlord"));
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
        String sql = "UPDATE Booking SET RenterID = ?, PropertyID = ?, StartDate = ?, EndDate = ?, "
                + "TotalPrice = ?, Status = ?, DepositAmount = ?, MonthlyRent = ?, PenaltyClause = ?, "
                + "TermsAndConditions = ?, SignedAt = ?, SignedByRenter = ?, SignedByLandlord = ? "
                + "WHERE BookingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, booking.getRenterId());
            pstmt.setInt(2, booking.getPropertyId());
            pstmt.setDate(3, new java.sql.Date(booking.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(booking.getEndDate().getTime()));
            pstmt.setDouble(5, booking.getTotalPrice());
            pstmt.setString(6, booking.getStatus());
            pstmt.setDouble(7, booking.getDepositAmount());
            pstmt.setDouble(8, booking.getMonthlyRent());
            pstmt.setString(9, booking.getPenaltyClause());
            pstmt.setString(10, booking.getTermsAndConditions());

            // Handle SignedAt (it can be null)
            if (booking.getSignedAt() != null) {
                pstmt.setTimestamp(11, new java.sql.Timestamp(booking.getSignedAt().getTime()));
            } else {
                pstmt.setNull(11, java.sql.Types.TIMESTAMP);
            }

            pstmt.setBoolean(12, booking.isSignedByRenter());
            pstmt.setBoolean(13, booking.isSignedByLandlord());
            pstmt.setInt(14, booking.getBookingId());

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

    public List<Booking> getBookingsByRenterId(int renterId) {
        Connection conn = DBConnection.getConnection();
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE RenterID = ? ORDER BY CreatedAt DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, renterId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setRenterId(rs.getInt("RenterID"));
                booking.setPropertyId(rs.getInt("PropertyID"));
                booking.setStartDate(rs.getDate("StartDate"));
                booking.setEndDate(rs.getDate("EndDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setStatus(rs.getString("Status"));
                booking.setDepositAmount(rs.getDouble("DepositAmount"));
                booking.setMonthlyRent(rs.getDouble("MonthlyRent"));
                booking.setPenaltyClause(rs.getString("PenaltyClause"));
                booking.setTermsAndConditions(rs.getString("TermsAndConditions"));
                booking.setCreatedAt(rs.getTimestamp("CreatedAt"));
                booking.setSignedAt(rs.getTimestamp("SignedAt"));
                booking.setSignedByRenter(rs.getBoolean("SignedByRenter"));
                booking.setSignedByLandlord(rs.getBoolean("SignedByLandlord"));
                bookings.add(booking);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return bookings;
    }

    public List<Booking> getBookingsByPropertyId(int propertyId) {
        Connection conn = DBConnection.getConnection();
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE PropertyID = ? ORDER BY CreatedAt DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setRenterId(rs.getInt("RenterID"));
                booking.setPropertyId(rs.getInt("PropertyID"));
                booking.setStartDate(rs.getDate("StartDate"));
                booking.setEndDate(rs.getDate("EndDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setStatus(rs.getString("Status"));
                booking.setDepositAmount(rs.getDouble("DepositAmount"));
                booking.setMonthlyRent(rs.getDouble("MonthlyRent"));
                booking.setPenaltyClause(rs.getString("PenaltyClause"));
                booking.setTermsAndConditions(rs.getString("TermsAndConditions"));
                booking.setCreatedAt(rs.getTimestamp("CreatedAt"));
                booking.setSignedAt(rs.getTimestamp("SignedAt"));
                booking.setSignedByRenter(rs.getBoolean("SignedByRenter"));
                booking.setSignedByLandlord(rs.getBoolean("SignedByLandlord"));
                bookings.add(booking);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return bookings;
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Booking SET Status = ? WHERE BookingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, bookingId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean updateSignStatus(int bookingId, boolean signedByRenter, boolean signedByLandlord) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Booking SET SignedByRenter = ?, SignedByLandlord = ?, SignedAt = ? WHERE BookingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, signedByRenter);
            pstmt.setBoolean(2, signedByLandlord);

            // If both have signed, update the signedAt timestamp
            if (signedByRenter && signedByLandlord) {
                pstmt.setTimestamp(3, new java.sql.Timestamp(new java.util.Date().getTime()));
            } else {
                pstmt.setNull(3, java.sql.Types.TIMESTAMP);
            }

            pstmt.setInt(4, bookingId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public List<Booking> getBookingsForLandlord(int landlordId) {
        Connection conn = DBConnection.getConnection();
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.* FROM Booking b JOIN Property p ON b.PropertyID = p.PropertyID "
                + "WHERE p.LandlordID = ? ORDER BY b.CreatedAt DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setRenterId(rs.getInt("RenterID"));
                booking.setPropertyId(rs.getInt("PropertyID"));
                booking.setStartDate(rs.getDate("StartDate"));
                booking.setEndDate(rs.getDate("EndDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setStatus(rs.getString("Status"));
                booking.setDepositAmount(rs.getDouble("DepositAmount"));
                booking.setMonthlyRent(rs.getDouble("MonthlyRent"));
                booking.setPenaltyClause(rs.getString("PenaltyClause"));
                booking.setTermsAndConditions(rs.getString("TermsAndConditions"));
                booking.setCreatedAt(rs.getTimestamp("CreatedAt"));
                booking.setSignedAt(rs.getTimestamp("SignedAt"));
                booking.setSignedByRenter(rs.getBoolean("SignedByRenter"));
                booking.setSignedByLandlord(rs.getBoolean("SignedByLandlord"));
                bookings.add(booking);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return bookings;
    }
}
