package DTO;

import Model.Booking;
import Model.Location;
import Model.Property;
import Model.User;
import Model.PropertyType;
import java.util.Date;

/**
 * Data Transfer Object that combines a Booking with its related entities
 * for convenient display in the view
 */
public class BookingDTO {
    private Booking booking;
    private Property property;
    private User landlord;
    private User renter;
    private Location location;
    private PropertyType type;
    
    public BookingDTO() {
        
    }

    public PropertyType getType() {
        return type;
    }

    public void setType(PropertyType type) {
        this.type = type;
    }
    
    public BookingDTO(Booking booking) {
        this.booking = booking;
    }
    
    // Getters and Setters
    public Booking getBooking() {
        return booking;
    }
    
    public void setBooking(Booking booking) {
        this.booking = booking;
    }
    
    public Property getProperty() {
        return property;
    }
    
    public void setProperty(Property property) {
        this.property = property;
    }
    
    public User getLandlord() {
        return landlord;
    }
    
    public void setLandlord(User landlord) {
        this.landlord = landlord;
    }
    
    public User getRenter() {
        return renter;
    }
    
    public void setRenter(User renter) {
        this.renter = renter;
    }
    
    public Location getLocation() {
        return location;
    }
    
    public void setLocation(Location location) {
        this.location = location;
    }
    
    // Convenience methods for the view
    public int getBookingId() {
        return booking != null ? booking.getBookingId() : 0;
    }
    
    public int getRenterId() {
        return booking != null ? booking.getRenterId() : 0;
    }
    
    public int getPropertyId() {
        return booking != null ? booking.getPropertyId() : 0;
    }
    
    public Date getStartDate() {
        return booking != null ? booking.getStartDate() : null;
    }
    
    public Date getEndDate() {
        return booking != null ? booking.getEndDate() : null;
    }
    
    public double getTotalPrice() {
        return booking != null ? booking.getTotalPrice() : 0.0;
    }
    
    public String getStatus() {
        return booking != null ? booking.getStatus() : "";
    }
    
    public double getDepositAmount() {
        return booking != null ? booking.getDepositAmount() : 0.0;
    }
    
    public double getMonthlyRent() {
        return booking != null ? booking.getMonthlyRent() : 0.0;
    }
    
    public String getPenaltyClause() {
        return booking != null ? booking.getPenaltyClause() : "";
    }
    
    public String getTermsAndConditions() {
        return booking != null ? booking.getTermsAndConditions() : "";
    }
    
    public Date getCreatedAt() {
        return booking != null ? booking.getCreatedAt() : null;
    }
    
    public Date getSignedAt() {
        return booking != null ? booking.getSignedAt() : null;
    }
    
    public boolean isSignedByRenter() {
        return booking != null ? booking.isSignedByRenter() : false;
    }
    
    public boolean isSignedByLandlord() {
        return booking != null ? booking.isSignedByLandlord() : false;
    }
    
    public boolean isFullySigned() {
        return isSignedByRenter() && isSignedByLandlord();
    }
}
