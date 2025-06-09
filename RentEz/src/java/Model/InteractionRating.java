package Model;

import java.util.Date;

public class InteractionRating {
    private int ratingId;
    private int renterId;
    private int landlordId;
    private int rating;  // 1-5 rating
    private String comment;
    private Date ratingDate;

    // Constructors
    public InteractionRating() {
    }

    public InteractionRating(int ratingId, int renterId, int landlordId, int rating, String comment, Date ratingDate) {
        this.ratingId = ratingId;
        this.renterId = renterId;
        this.landlordId = landlordId;
        this.rating = rating;
        this.comment = comment;
        this.ratingDate = ratingDate;
    }

    // Getters and Setters
    public int getRatingId() {
        return ratingId;
    }

    public void setRatingId(int ratingId) {
        this.ratingId = ratingId;
    }

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
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

    public Date getRatingDate() {
        return ratingDate;
    }

    public void setRatingDate(Date ratingDate) {
        this.ratingDate = ratingDate;
    }
}
