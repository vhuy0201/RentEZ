package DAO;

import Connection.DBConnection;
import Model.InteractionRating;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InteractionRatingDAO {
    
    public boolean insert(InteractionRating rating) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO InteractionRating (RenterID, LandlordID, Rating, Comment, RatingDate) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, rating.getRenterId());
            pstmt.setInt(2, rating.getLandlordId());
            pstmt.setInt(3, rating.getRating());
            pstmt.setString(4, rating.getComment());
            pstmt.setDate(5, new java.sql.Date(rating.getRatingDate().getTime()));
            
            int rows = pstmt.executeUpdate();
            
            // Get generated ID
            if (rows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    rating.setRatingId(generatedKeys.getInt(1));
                }
            }
            
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public InteractionRating getById(int ratingId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM InteractionRating WHERE RatingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ratingId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                InteractionRating rating = new InteractionRating();
                rating.setRatingId(rs.getInt("RatingID"));
                rating.setRenterId(rs.getInt("RenterID"));
                rating.setLandlordId(rs.getInt("LandlordID"));
                rating.setRating(rs.getInt("Rating"));
                rating.setComment(rs.getString("Comment"));
                rating.setRatingDate(rs.getDate("RatingDate"));
                conn.close();
                return rating;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public boolean update(InteractionRating rating) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE InteractionRating SET RenterID = ?, LandlordID = ?, Rating = ?, "
                + "Comment = ?, RatingDate = ? WHERE RatingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, rating.getRenterId());
            pstmt.setInt(2, rating.getLandlordId());
            pstmt.setInt(3, rating.getRating());
            pstmt.setString(4, rating.getComment());
            pstmt.setDate(5, new java.sql.Date(rating.getRatingDate().getTime()));
            pstmt.setInt(6, rating.getRatingId());
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }

    public boolean delete(int ratingId) {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM InteractionRating WHERE RatingID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ratingId);
            int rows = pstmt.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return false;
        }
    }
    
    public List<InteractionRating> getRatingsByLandlordId(int landlordId) {
        Connection conn = DBConnection.getConnection();
        List<InteractionRating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM InteractionRating WHERE LandlordID = ? ORDER BY RatingDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                InteractionRating rating = new InteractionRating();
                rating.setRatingId(rs.getInt("RatingID"));
                rating.setRenterId(rs.getInt("RenterID"));
                rating.setLandlordId(rs.getInt("LandlordID"));
                rating.setRating(rs.getInt("Rating"));
                rating.setComment(rs.getString("Comment"));
                rating.setRatingDate(rs.getDate("RatingDate"));
                ratings.add(rating);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return ratings;
    }
    
    public List<InteractionRating> getRatingsByRenterId(int renterId) {
        Connection conn = DBConnection.getConnection();
        List<InteractionRating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM InteractionRating WHERE RenterID = ? ORDER BY RatingDate DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, renterId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                InteractionRating rating = new InteractionRating();
                rating.setRatingId(rs.getInt("RatingID"));
                rating.setRenterId(rs.getInt("RenterID"));
                rating.setLandlordId(rs.getInt("LandlordID"));
                rating.setRating(rs.getInt("Rating"));
                rating.setComment(rs.getString("Comment"));
                rating.setRatingDate(rs.getDate("RatingDate"));
                ratings.add(rating);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return ratings;
    }
    
    public double getAverageLandlordRating(int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT AVG(Rating) as AverageRating FROM InteractionRating WHERE LandlordID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                double averageRating = rs.getDouble("AverageRating");
                conn.close();
                return averageRating;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return 0.0;
    }
}
