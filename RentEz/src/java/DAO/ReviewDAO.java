package DAO;

import Connection.DBConnection;
import Model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    
    public int getTotalReviewsCount() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM Review WHERE IsPublished = 1";
        
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
            System.out.println("Error in getTotalReviewsCount: " + e);
        }
        
        return 25; // Default placeholder value
    }
    
    public double getAverageRating() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT AVG(CAST(Rating AS FLOAT)) FROM Review WHERE IsPublished = 1";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double avg = rs.getDouble(1);
                conn.close();
                return avg;
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getAverageRating: " + e);
        }
        
        return 4.8; // Default placeholder value
    }
    
    public List<Review> getRecentReviews(int limit) {
        List<Review> reviews = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP (?) * FROM Review WHERE IsPublished = 1 ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("ReviewId"));
                review.setBookingId(rs.getInt("BookingId"));
                review.setRenterId(rs.getInt("RenterId"));
                review.setPropertyId(rs.getInt("PropertyId"));
                review.setLandlordId(rs.getInt("LandlordId"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getTimestamp("CreatedAt"));
                review.setIsPublished(rs.getBoolean("IsPublished"));
                reviews.add(review);
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getRecentReviews: " + e);
        }
        
        return reviews;
    }
    
    public boolean insertReview(Review review) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO Review (BookingId, RenterId, PropertyId, LandlordId, Rating, Comment, CreatedAt, IsPublished) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, review.getBookingId());
            pstmt.setInt(2, review.getRenterId());
            pstmt.setInt(3, review.getPropertyId());
            pstmt.setInt(4, review.getLandlordId());
            pstmt.setInt(5, review.getRating());
            pstmt.setString(6, review.getComment());
            pstmt.setTimestamp(7, new Timestamp(review.getCreatedAt().getTime()));
            pstmt.setBoolean(8, review.getIsPublished());
            
            int result = pstmt.executeUpdate();
            conn.close();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("Error in insertReview: " + e);
        }
        
        return false;
    }
    
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM Review ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("ReviewId"));
                review.setBookingId(rs.getInt("BookingId"));
                review.setRenterId(rs.getInt("RenterId"));
                review.setPropertyId(rs.getInt("PropertyId"));
                review.setLandlordId(rs.getInt("LandlordId"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getTimestamp("CreatedAt"));
                review.setIsPublished(rs.getBoolean("IsPublished"));
                reviews.add(review);
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getAllReviews: " + e);
        }
        
        return reviews;
    }
    
    public boolean updateReviewStatus(int reviewId, boolean isPublished) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE Review SET IsPublished = ? WHERE ReviewId = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, isPublished);
            pstmt.setInt(2, reviewId);
            
            int result = pstmt.executeUpdate();
            conn.close();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("Error in updateReviewStatus: " + e);
        }
        
        return false;
    }
}
