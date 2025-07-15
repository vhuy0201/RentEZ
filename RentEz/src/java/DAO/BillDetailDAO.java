/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Connection.DBConnection;
import Model.BillDetail;
import Model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDetailDAO {

    public boolean insert(BillDetail billDetail) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO BillDetail (BillDetailID, BillID, CategoryID, UsageValue, Amount) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billDetail.getBillDetailId());
            pstmt.setInt(2, billDetail.getBillId());
            pstmt.setInt(3, billDetail.getCategoryId());
            pstmt.setDouble(4, billDetail.getUsageValue());
            pstmt.setDouble(5, billDetail.getAmount());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public BillDetail getById(int billDetailId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM BillDetail WHERE BillDetailID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billDetailId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setBillDetailId(rs.getInt("BillDetailID"));
                billDetail.setBillId(rs.getInt("BillID"));
                billDetail.setCategoryId(rs.getInt("CategoryID"));
                billDetail.setUsageValue(rs.getDouble("UsageValue"));
                billDetail.setAmount(rs.getDouble("Amount"));
                conn.close();
                return billDetail;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(BillDetail billDetail) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE BillDetail SET BillID = ?, CategoryID = ?, UsageValue = ?, Amount = ? WHERE BillDetailID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billDetail.getBillId());
            pstmt.setInt(2, billDetail.getCategoryId());
            pstmt.setDouble(3, billDetail.getUsageValue());
            pstmt.setDouble(4, billDetail.getAmount());
            pstmt.setInt(5, billDetail.getBillDetailId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int billDetailId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM BillDetail WHERE BillDetailID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billDetailId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public List<BillDetail> getBillDetailByBillId(int billId) {
        Connection conn = DBConnection.getConnection();
        List<BillDetail> billDetails = new ArrayList<>();
        String sql = "SELECT * FROM BillDetail WHERE BillID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setBillDetailId(rs.getInt("BillDetailID"));
                billDetail.setBillId(rs.getInt("BillID"));
                billDetail.setCategoryId(rs.getInt("CategoryID"));
                billDetail.setUsageValue(rs.getDouble("UsageValue"));
                billDetail.setAmount(rs.getDouble("Amount"));
                billDetails.add(billDetail);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return billDetails;
    }
}
