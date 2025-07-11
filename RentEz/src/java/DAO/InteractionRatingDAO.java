package DAO;

import Connection.DBConnection;
import Model.InteractionRating;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    
    /**
     * Get detailed ratings with renter information
     * @param landlordId The ID of the landlord
     * @return List of maps containing rating details
     */
    public List<Map<String, Object>> getDetailedRatingsForLandlord(int landlordId) {
        List<Map<String, Object>> detailedRatings = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        
        String sql = "SELECT r.*, u.Name as RenterName, u.Avatar as RenterAvatar " +
                   "FROM InteractionRating r JOIN [User] u ON r.RenterID = u.UserID " +
                   "WHERE r.LandlordID = ? ORDER BY r.RatingDate DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> ratingDetail = new HashMap<>();
                
                ratingDetail.put("ratingId", rs.getInt("RatingID"));
                ratingDetail.put("renterId", rs.getInt("RenterID"));
                ratingDetail.put("landlordId", rs.getInt("LandlordID"));
                ratingDetail.put("rating", rs.getInt("Rating"));
                ratingDetail.put("comment", rs.getString("Comment"));
                ratingDetail.put("ratingDate", rs.getDate("RatingDate"));
                ratingDetail.put("renterName", rs.getString("RenterName"));
                ratingDetail.put("renterAvatar", rs.getString("RenterAvatar"));
                
                detailedRatings.add(ratingDetail);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("Error getting detailed ratings: " + e);
        }
        
        return detailedRatings;
    }
    
    /**
     * Check if a renter has already rated a landlord
     * @param renterId The ID of the renter
     * @param landlordId The ID of the landlord
     * @return boolean indicating if a rating exists
     */
    public boolean hasRated(int renterId, int landlordId) {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM InteractionRating WHERE RenterID = ? AND LandlordID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, renterId);
            pstmt.setInt(2, landlordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count > 0;
            }
        } catch (Exception e) {
            System.out.println("Error checking if renter has rated landlord: " + e);
        }
        return false;
    }
    
    /**
     * Get rating statistics for a landlord
     * @param landlordId The ID of the landlord
     * @return Map containing statistical data
     */
    public Map<String, Object> getLandlordRatingStatistics(int landlordId) {
        Map<String, Object> stats = new HashMap<>();
        Connection conn = DBConnection.getConnection();
        
        try {
            // Get average rating
            String avgSql = "SELECT AVG(CAST(Rating AS FLOAT)) FROM InteractionRating WHERE LandlordID = ?";
            PreparedStatement avgPstmt = conn.prepareStatement(avgSql);
            avgPstmt.setInt(1, landlordId);
            ResultSet avgRs = avgPstmt.executeQuery();
            
            if (avgRs.next()) {
                stats.put("averageRating", avgRs.getDouble(1));
            } else {
                stats.put("averageRating", 0.0);
            }
            
            // Get rating distribution
            String distSql = "SELECT Rating, COUNT(*) as Count FROM InteractionRating " +
                           "WHERE LandlordID = ? GROUP BY Rating ORDER BY Rating DESC";
            PreparedStatement distPstmt = conn.prepareStatement(distSql);
            distPstmt.setInt(1, landlordId);
            ResultSet distRs = distPstmt.executeQuery();
            
            Map<Integer, Integer> distribution = new HashMap<>();
            for (int i = 1; i <= 5; i++) {
                distribution.put(i, 0); // Initialize with zero for all ratings
            }
            
            while (distRs.next()) {
                distribution.put(distRs.getInt("Rating"), distRs.getInt("Count"));
            }
            stats.put("distribution", distribution);
            
            // Get total count
            String countSql = "SELECT COUNT(*) FROM InteractionRating WHERE LandlordID = ?";
            PreparedStatement countPstmt = conn.prepareStatement(countSql);
            countPstmt.setInt(1, landlordId);
            ResultSet countRs = countPstmt.executeQuery();
            
            if (countRs.next()) {
                stats.put("totalRatings", countRs.getInt(1));
            } else {
                stats.put("totalRatings", 0);
            }
            
            conn.close();
        } catch (Exception e) {
            System.out.println("Error getting landlord rating statistics: " + e);
        }
        
        return stats;
    }
}
