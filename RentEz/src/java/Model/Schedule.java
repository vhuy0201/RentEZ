package Model;

import java.util.Date;

public class Schedule {
    private int scheduleId;
    private int renterId;
    private int landlordId;
    private int propertyId;
    private Date scheduleDateTime;
    private String status;  // 'Pending', 'Confirmed', 'Cancelled'

    // Constructors
    public Schedule() {
    }

    public Schedule(int scheduleId, int renterId, int landlordId, int propertyId, Date scheduleDateTime, String status) {
        this.scheduleId = scheduleId;
        this.renterId = renterId;
        this.landlordId = landlordId;
        this.propertyId = propertyId;
        this.scheduleDateTime = scheduleDateTime;
        this.status = status;
    }

    // Getters and Setters
    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
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

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public Date getScheduleDateTime() {
        return scheduleDateTime;
    }

    public void setScheduleDateTime(Date scheduleDateTime) {
        this.scheduleDateTime = scheduleDateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
