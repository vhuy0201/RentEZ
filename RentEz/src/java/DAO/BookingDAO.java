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

    public List<Booking> getAllBookings() {
        Connection conn = DBConnection.getConnection();
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking ORDER BY CreatedAt DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
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

    public List<Booking> getFilteredBookings(String search, String statusFilter, String dateFrom, String dateTo, int page, int pageSize) {
        Connection conn = DBConnection.getConnection();
        List<Booking> bookings = new ArrayList<>();
        
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT * FROM Booking WHERE 1=1");
        
        // Add search filter if provided
        if (search != null && !search.isEmpty()) {
            sqlBuilder.append(" AND (BookingID LIKE ? OR BookingID IN (SELECT PropertyID FROM Property WHERE Title LIKE ?))");
        }
        
        // Add status filter if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sqlBuilder.append(" AND Status = ?");
        }
        
        // Add date range filter if provided
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sqlBuilder.append(" AND StartDate >= ?");
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sqlBuilder.append(" AND EndDate <= ?");
        }
        
        // Add pagination
        sqlBuilder.append(" ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            int paramIndex = 1;
            
            // Set search parameters if provided
            if (search != null && !search.isEmpty()) {
                String searchTerm = "%" + search + "%";
                pstmt.setString(paramIndex++, searchTerm);
                pstmt.setString(paramIndex++, searchTerm);
            }
            
            // Set status parameter if provided
            if (statusFilter != null && !statusFilter.isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            
            // Set date range parameters if provided
            if (dateFrom != null && !dateFrom.isEmpty()) {
                pstmt.setDate(paramIndex++, java.sql.Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                pstmt.setDate(paramIndex++, java.sql.Date.valueOf(dateTo));
            }
            
            // Set pagination parameters
            pstmt.setInt(paramIndex++, (page - 1) * pageSize);
            pstmt.setInt(paramIndex++, pageSize);
            
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

    public int getTotalFilteredBookings(String search, String statusFilter, String dateFrom, String dateTo) {
        Connection conn = DBConnection.getConnection();
        int total = 0;
        
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT COUNT(*) AS total FROM Booking WHERE 1=1");
        
        // Add search filter if provided
        if (search != null && !search.isEmpty()) {
            sqlBuilder.append(" AND (BookingID LIKE ? OR BookingID IN (SELECT PropertyID FROM Property WHERE Title LIKE ?))");
        }
        
        // Add status filter if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sqlBuilder.append(" AND Status = ?");
        }
        
        // Add date range filter if provided
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sqlBuilder.append(" AND StartDate >= ?");
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sqlBuilder.append(" AND EndDate <= ?");
        }
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            int paramIndex = 1;
            
            // Set search parameters if provided
            if (search != null && !search.isEmpty()) {
                String searchTerm = "%" + search + "%";
                pstmt.setString(paramIndex++, searchTerm);
                pstmt.setString(paramIndex++, searchTerm);
            }
            
            // Set status parameter if provided
            if (statusFilter != null && !statusFilter.isEmpty()) {
                pstmt.setString(paramIndex++, statusFilter);
            }
            
            // Set date range parameters if provided
            if (dateFrom != null && !dateFrom.isEmpty()) {
                pstmt.setDate(paramIndex++, java.sql.Date.valueOf(dateFrom));
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                pstmt.setDate(paramIndex++, java.sql.Date.valueOf(dateTo));
            }
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return total;
    }

    public int getBookingsCountByStatus(String status) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        String sql = "SELECT COUNT(*) AS count FROM Booking WHERE Status = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return count;
    }

    public double getTotalBookingValue() {
        Connection conn = DBConnection.getConnection();
        double total = 0;
        String sql = "SELECT SUM(TotalPrice) AS total FROM Booking WHERE Status = 'Confirmed'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("total");
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return total;
    }
    
    public int getActiveBookingsCount() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Booking WHERE Status = 'Confirmed' AND EndDate >= GETDATE()";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getActiveBookingsCount: " + e);
        }
        
        return 0;
    }
    
    public int getExpiringBookingsCount() {
        Connection conn = DBConnection.getConnection();
        // Bookings expiring within next 30 days
        String sql = "SELECT COUNT(*) FROM Booking WHERE Status = 'Confirmed' AND EndDate BETWEEN GETDATE() AND DATEADD(day, 30, GETDATE())";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getExpiringBookingsCount: " + e);
        }
        
        return 0;
    }
    
    public int getConfirmedBookingsCount() {
        return getBookingsCountByStatus("Confirmed");
    }
    
    public int getPendingBookingsCount() {
        return getBookingsCountByStatus("Pending");
    }
    
    public int getCancelledBookingsCount() {
        return getBookingsCountByStatus("Cancelled");
    }
}
