package Model;

import java.util.Date;

public class Review {
    private int reviewId;
    private int bookingId;
    private int renterId;
    private int propertyId;
    private int landlordId;
    private int rating; // 1-5 stars
    private String comment;
    private Date createdAt;
    private boolean isPublished;
    
    // Constructors
    public Review() {
    }
    
    public Review(int bookingId, int renterId, int propertyId, int landlordId, int rating, String comment) {
        this.bookingId = bookingId;
        this.renterId = renterId;
        this.propertyId = propertyId;
        this.landlordId = landlordId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = new Date();
        this.isPublished = true;
    }
    
    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }
    
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }
    
    public int getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    
    public int getRenterId() {
        return renterId;
    }
    
    public void setRenterId(int renterId) {
        this.renterId = renterId;
    }
    
    public int getPropertyId() {
        return propertyId;
    }
    
    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }
    
    public int getLandlordId() {
        return landlordId;
    }
    
    public void setLandlordId(int landlordId) {
        this.landlordId = landlordId;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public boolean getIsPublished() {
        return isPublished;
    }
    
    public void setIsPublished(boolean isPublished) {
        this.isPublished = isPublished;
    }
}
