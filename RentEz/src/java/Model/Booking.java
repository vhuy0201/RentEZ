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
    private String contractDocuments;

    // Constructors
    public Booking() {
    }

    public Booking(int bookingId, int renterId, int propertyId, Date startDate, Date endDate, double totalPrice,
            String status, String contractDocuments) {
        this.bookingId = bookingId;
        this.renterId = renterId;
        this.propertyId = propertyId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.contractDocuments = contractDocuments;
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
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContractDocuments() {
        return contractDocuments;
    }

    public void setContractDocuments(String contractDocuments) {
        this.contractDocuments = contractDocuments;
    }
}
