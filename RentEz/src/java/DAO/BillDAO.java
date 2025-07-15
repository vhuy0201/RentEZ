package DAO;

import Connection.DBConnection;
import Model.Bill;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public boolean insert(Bill bill) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Bill (BillID, PropertyID, RenterID, BillingPeriod, TotalAmount, DueDate, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bill.getBillId());
            pstmt.setInt(2, bill.getPropertyId());
            pstmt.setInt(3, bill.getRenterId());
            pstmt.setString(4, bill.getBillingPeriod());
            pstmt.setDouble(5, bill.getTotalAmount());
            pstmt.setDate(6, new java.sql.Date(bill.getDueDate().getTime()));
            pstmt.setString(7, bill.getStatus());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
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
            System.out.println("Error: " + e);
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
        String sql = "SELECT b.* FROM Bill b " +
                    "JOIN Property p ON b.PropertyID = p.PropertyID " +
                    "WHERE p.LandlordID = ? ORDER BY b.DueDate DESC";
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
        String sql = "UPDATE Bill SET PropertyID = ?, RenterID = ?, BillingPeriod = ?, TotalAmount = ?, DueDate = ?, Status = ? WHERE BillID = ?";
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
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int billId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM Bill WHERE BillID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
}
