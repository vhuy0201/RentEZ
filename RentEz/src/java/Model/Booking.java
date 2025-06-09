package Model;

import java.util.Date;

public class Booking {

    private int bookingId;
    private int renterId;
    private int propertyId;
    private Date startDate;
    private Date endDate;
    private double totalPrice;
    private String status; // 'Pending', 'Confirmed', 'Cancelled', 'Completed'
    private double depositAmount;
    private double monthlyRent;
    private String penaltyClause;
    private String termsAndConditions;
    private Date createdAt;
    private Date signedAt;
    private boolean signedByRenter;
    private boolean signedByLandlord;

    // Constructors
    public Booking() {
    }

    public Booking(int bookingId, int renterId, int propertyId, Date startDate, Date endDate, double totalPrice,
            String status, double depositAmount, double monthlyRent, String penaltyClause, String termsAndConditions,
            Date createdAt, Date signedAt, boolean signedByRenter, boolean signedByLandlord) {
        this.bookingId = bookingId;
        this.renterId = renterId;
        this.propertyId = propertyId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.depositAmount = depositAmount;
        this.monthlyRent = monthlyRent;
        this.penaltyClause = penaltyClause;
        this.termsAndConditions = termsAndConditions;
        this.createdAt = createdAt;
        this.signedAt = signedAt;
        this.signedByRenter = signedByRenter;
        this.signedByLandlord = signedByLandlord;
    }

    // Getters and Setters
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

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getDepositAmount() {
        return depositAmount;
    }

    public void setDepositAmount(double depositAmount) {
        this.depositAmount = depositAmount;
    }

    public double getMonthlyRent() {
        return monthlyRent;
    }

    public void setMonthlyRent(double monthlyRent) {
        this.monthlyRent = monthlyRent;
    }

    public String getPenaltyClause() {
        return penaltyClause;
    }

    public void setPenaltyClause(String penaltyClause) {
        this.penaltyClause = penaltyClause;
    }

    public String getTermsAndConditions() {
        return termsAndConditions;
    }

    public void setTermsAndConditions(String termsAndConditions) {
        this.termsAndConditions = termsAndConditions;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getSignedAt() {
        return signedAt;
    }

    public void setSignedAt(Date signedAt) {
        this.signedAt = signedAt;
    }

    public boolean isSignedByRenter() {
        return signedByRenter;
    }

    public void setSignedByRenter(boolean signedByRenter) {
        this.signedByRenter = signedByRenter;
    }

    public boolean isSignedByLandlord() {
        return signedByLandlord;
    }

    public void setSignedByLandlord(boolean signedByLandlord) {
        this.signedByLandlord = signedByLandlord;
    }
}
