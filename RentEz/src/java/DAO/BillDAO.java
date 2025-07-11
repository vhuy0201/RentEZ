package DAO;

import Connection.DBConnection;
import Model.Bill;
import Model.Property;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class BillDAO {

    public boolean insert(Bill bill) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Bill (PropertyID, RenterID, BillingPeriod, TotalAmount, DueDate, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, bill.getPropertyId());
            pstmt.setInt(2, bill.getRenterId());
            pstmt.setString(3, bill.getBillingPeriod());
            pstmt.setDouble(4, bill.getTotalAmount());
            pstmt.setDate(5, new java.sql.Date(bill.getDueDate().getTime()));
            pstmt.setString(6, bill.getStatus());

            int rows = pstmt.executeUpdate();

            // Get the generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    bill.setBillId(generatedKeys.getInt(1));
                }
            }

            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error inserting bill: " + e);
            return false;
        }
    }

    public Bill getById(int billId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Bill WHERE BillID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("BillID"));
                bill.setPropertyId(rs.getInt("PropertyID"));
                bill.setRenterId(rs.getInt("RenterID"));
                bill.setBillingPeriod(rs.getString("BillingPeriod"));
                bill.setTotalAmount(rs.getDouble("TotalAmount"));
                bill.setDueDate(rs.getDate("DueDate"));
                bill.setStatus(rs.getString("Status"));

                conn.close();
                return bill;
            }
        } catch (Exception e) {
            System.out.println("Error getting bill by ID: " + e);
        }
        return null;
    }

    /**
     * Get all bills for a specific renter
     */
    public List<Bill> getBillsByRenterId(int renterId) {
        List<Bill> bills = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Bill WHERE RenterID = ? ORDER BY DueDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, renterId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("BillID"));
                bill.setPropertyId(rs.getInt("PropertyID"));
                bill.setRenterId(rs.getInt("RenterID"));
                bill.setBillingPeriod(rs.getString("BillingPeriod"));
                bill.setTotalAmount(rs.getDouble("TotalAmount"));
                bill.setDueDate(rs.getDate("DueDate"));
                bill.setStatus(rs.getString("Status"));

                bills.add(bill);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return bills;
    }

    /**
     * Get all bills for properties owned by a landlord
     */
    public List<Bill> getBillsForLandlord(int landlordId) {
        List<Bill> bills = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT b.* FROM Bill b "
                + "INNER JOIN Property p ON b.PropertyID = p.PropertyID "
                + "WHERE p.LandlordID = ? ORDER BY b.DueDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("BillID"));
                bill.setPropertyId(rs.getInt("PropertyID"));
                bill.setRenterId(rs.getInt("RenterID"));
                bill.setBillingPeriod(rs.getString("BillingPeriod"));
                bill.setTotalAmount(rs.getDouble("TotalAmount"));
                bill.setDueDate(rs.getDate("DueDate"));
                bill.setStatus(rs.getString("Status"));

                bills.add(bill);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return bills;
    }

    public boolean update(Bill bill) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Bill SET PropertyID = ?, RenterID = ?, BillingPeriod = ?, "
                + "TotalAmount = ?, DueDate = ?, Status = ? WHERE BillID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bill.getPropertyId());
            pstmt.setInt(2, bill.getRenterId());
            pstmt.setString(3, bill.getBillingPeriod());
            pstmt.setDouble(4, bill.getTotalAmount());
            pstmt.setDate(5, new java.sql.Date(bill.getDueDate().getTime()));
            pstmt.setString(6, bill.getStatus());
            pstmt.setInt(7, bill.getBillId());

            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error updating bill: " + e);
            return false;
        }
    }

    public boolean delete(int billId) {
        Connection conn = DBConnection.getConnection();
        try {
            // First delete bill details
            String deleteBillDetails = "DELETE FROM BillDetail WHERE BillID = ?";
            PreparedStatement pstmt1 = conn.prepareStatement(deleteBillDetails);
            pstmt1.setInt(1, billId);
            pstmt1.executeUpdate();

            // Then delete the bill
            String deleteBill = "DELETE FROM Bill WHERE BillID = ?";
            PreparedStatement pstmt2 = conn.prepareStatement(deleteBill);
            pstmt2.setInt(1, billId);
            int rows = pstmt2.executeUpdate();

            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error deleting bill: " + e);
            return false;
        }
    }

    public List<Bill> getBillsByPropertyAndRenter(int propertyId, int renterId) {
        List<Bill> bills = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Bill WHERE PropertyID = ? AND RenterID = ? ORDER BY DueDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            pstmt.setInt(2, renterId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("BillID"));
                bill.setPropertyId(rs.getInt("PropertyID"));
                bill.setRenterId(rs.getInt("RenterID"));
                bill.setBillingPeriod(rs.getString("BillingPeriod"));
                bill.setTotalAmount(rs.getDouble("TotalAmount"));
                bill.setDueDate(rs.getDate("DueDate"));
                bill.setStatus(rs.getString("Status"));
                bills.add(bill);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error getting bills by property and renter: " + e);
        }
        return bills;
    }

    public boolean billExistsForPeriod(int propertyId, int renterId, String billingPeriod) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Bill WHERE PropertyID = ? AND RenterID = ? AND BillingPeriod = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            pstmt.setInt(2, renterId);
            pstmt.setString(3, billingPeriod);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error checking if bill exists: " + e);
        }
        return false;
    }

    public boolean generateMonthlyBills(int propertyId, int renterId, double monthlyRent) {
        Calendar cal = Calendar.getInstance();
        String currentMonth = String.format("%04d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1);
        
        // Check if bill already exists for this month
        if (billExistsForPeriod(propertyId, renterId, currentMonth)) {
            return false; // Bill already exists
        }

        // Set due date to the 5th of next month
        cal.add(Calendar.MONTH, 1);
        cal.set(Calendar.DAY_OF_MONTH, 5);
        
        Bill bill = new Bill();
        bill.setPropertyId(propertyId);
        bill.setRenterId(renterId);
        bill.setBillingPeriod(currentMonth);
        bill.setTotalAmount(monthlyRent);
        bill.setDueDate(cal.getTime());
        bill.setStatus("Pending");

        return insert(bill);
    }

    public List<Bill> getOverdueBills(int landlordId) {
        List<Bill> bills = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT b.* FROM Bill b "
                + "INNER JOIN Property p ON b.PropertyID = p.PropertyID "
                + "WHERE p.LandlordID = ? AND b.DueDate < GETDATE() AND b.Status != 'Paid' "
                + "ORDER BY b.DueDate ASC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("BillID"));
                bill.setPropertyId(rs.getInt("PropertyID"));
                bill.setRenterId(rs.getInt("RenterID"));
                bill.setBillingPeriod(rs.getString("BillingPeriod"));
                bill.setTotalAmount(rs.getDouble("TotalAmount"));
                bill.setDueDate(rs.getDate("DueDate"));
                bill.setStatus(rs.getString("Status"));

                bills.add(bill);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error getting overdue bills: " + e);
        }
        return bills;
    }
}
