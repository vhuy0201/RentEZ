/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Connection.DBConnection;
import Model.PropertyImage;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
/**
 *
 * @author Haipro
 */
public class PropertyImageDAO {
    public boolean insert(PropertyImage propertyImage) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO PropertyImage (PropertyID, ImageURL) VALUES (?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyImage.getPropertyId());
            pstmt.setString(2, propertyImage.getImageURL());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public PropertyImage getById(int imageId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM PropertyImage WHERE ImageID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, imageId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                PropertyImage propertyImage = new PropertyImage();
                propertyImage.setImageId(rs.getInt("ImageID"));
                propertyImage.setPropertyId(rs.getInt("PropertyID"));
                propertyImage.setImageURL(rs.getString("ImageURL"));
                conn.close();
                return propertyImage;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public List<PropertyImage> getByPropertyId(int propertyId) {
        List<PropertyImage> images = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM PropertyImage WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PropertyImage propertyImage = new PropertyImage();
                propertyImage.setImageId(rs.getInt("ImageID"));
                propertyImage.setPropertyId(rs.getInt("PropertyID"));
                propertyImage.setImageURL(rs.getString("ImageURL"));
                images.add(propertyImage);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return images;
    }

    public boolean update(PropertyImage propertyImage) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE PropertyImage SET PropertyID = ?, ImageURL = ? WHERE ImageID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyImage.getPropertyId());
            pstmt.setString(2, propertyImage.getImageURL());
            pstmt.setInt(3, propertyImage.getImageId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int imageId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM PropertyImage WHERE ImageID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, imageId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    /**
     * Delete all images for a specific property
     * 
     * @param propertyId ID of the property
     * @return true if successful, false otherwise
     */
    public boolean deleteAllByPropertyId(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM PropertyImage WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows >= 0; // Return true even if no images were deleted
        } catch (Exception e) {
            System.out.println("Error deleting property images: " + e);
            return false;
        }
    }

    /**
     * Add multiple images for a property
     * 
     * @param propertyId ID of the property
     * @param imageUrls List of image URLs
     * @return true if all images were added successfully
     */
    public boolean insertMultiple(int propertyId, List<String> imageUrls) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO PropertyImage (PropertyID, ImageURL) VALUES (?, ?)";
        try {
            conn.setAutoCommit(false); // Start transaction
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            for (String imageUrl : imageUrls) {
                pstmt.setInt(1, propertyId);
                pstmt.setString(2, imageUrl);
                pstmt.addBatch();
            }
            
            int[] results = pstmt.executeBatch();
            conn.commit(); // Commit transaction
            conn.close();
            
            // Check if all inserts were successful
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            
            return true;
            
        } catch (Exception e) {
            System.out.println("Error adding multiple property images: " + e);
            try {
                conn.rollback(); // Rollback on error
            } catch (Exception ex) {
                System.out.println("Error rolling back transaction: " + ex);
            }
            return false;
        }
    }

    /**
     * Get the first image URL for a property (can be used as thumbnail)
     * 
     * @param propertyId ID of the property
     * @return First image URL or null if no images found
     */
    public String getFirstImageUrl(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP 1 ImageURL FROM PropertyImage WHERE PropertyID = ? ORDER BY ImageID";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String imageUrl = rs.getString("ImageURL");
                conn.close();
                return imageUrl;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error getting first property image: " + e);
        }
        return null;
    }

    /**
     * Count the number of images for a property
     * 
     * @param propertyId ID of the property
     * @return Number of images
     */
    public int countByPropertyId(int propertyId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) as count FROM PropertyImage WHERE PropertyID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                conn.close();
                return count;
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error counting property images: " + e);
        }
        return 0;
    }
}
