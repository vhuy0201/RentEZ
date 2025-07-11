package DAO;

import Connection.DBConnection;
import Model.BillDetail;
import Model.FeeCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDetailDAO {

    public boolean insert(BillDetail billDetail) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO BillDetail (BillID, CategoryID, UsageValue, Amount) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, billDetail.getBillId());
            pstmt.setInt(2, billDetail.getCategoryId());
            pstmt.setDouble(3, billDetail.getUsageValue());
            pstmt.setDouble(4, billDetail.getAmount());

            int rows = pstmt.executeUpdate();

            // Get the generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    billDetail.setBillDetailId(generatedKeys.getInt(1));
                }
            }

            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error inserting bill detail: " + e);
            return false;
        }
    }

    public BillDetail getById(int billDetailId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT bd.*, fc.Name as CategoryName, fc.UnitPrice, fc.Unit "
                + "FROM BillDetail bd "
                + "LEFT JOIN FeeCategory fc ON bd.CategoryID = fc.CategoryID "
                + "WHERE bd.BillDetailID = ?";
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

                // Set fee category details
                FeeCategory feeCategory = new FeeCategory();
                feeCategory.setCategoryId(rs.getInt("CategoryID"));
                feeCategory.setName(rs.getString("CategoryName"));
                feeCategory.setUnitPrice(rs.getDouble("UnitPrice"));
                feeCategory.setUnit(rs.getString("Unit"));
                billDetail.setFeeCategory(feeCategory);

                conn.close();
                return billDetail;
            }
        } catch (Exception e) {
            System.out.println("Error getting bill detail by ID: " + e);
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
            System.out.println("Error updating bill detail: " + e);
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
            System.out.println("Error deleting bill detail: " + e);
            return false;
        }
    }

    public List<BillDetail> getBillDetailByBillId(int billId) {
        Connection conn = DBConnection.getConnection();
        List<BillDetail> billDetails = new ArrayList<>();
        String sql = "SELECT bd.*, fc.Name as CategoryName, fc.UnitPrice, fc.Unit "
                + "FROM BillDetail bd "
                + "LEFT JOIN FeeCategory fc ON bd.CategoryID = fc.CategoryID "
                + "WHERE bd.BillID = ?";
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

                // Set fee category details
                FeeCategory feeCategory = new FeeCategory();
                feeCategory.setCategoryId(rs.getInt("CategoryID"));
                feeCategory.setName(rs.getString("CategoryName"));
                feeCategory.setUnitPrice(rs.getDouble("UnitPrice"));
                feeCategory.setUnit(rs.getString("Unit"));
                billDetail.setFeeCategory(feeCategory);

                billDetails.add(billDetail);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error getting bill details by bill ID: " + e);
        }
        return billDetails;
    }

    public boolean deleteByBillId(int billId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM BillDetail WHERE BillID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, billId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows >= 0; // Return true even if no rows deleted (empty bill)
        } catch (Exception e) {
            System.out.println("Error deleting bill details by bill ID: " + e);
            return false;
        }
    }
}
