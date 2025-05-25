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
}
