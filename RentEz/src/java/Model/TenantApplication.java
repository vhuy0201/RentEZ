package Model;

import java.util.Date;

public class TenantApplication {

    private int applicationId;
    private int renterId;
    private int propertyId;
    private Date applicationDate;
    private String status; // 'Pending', 'Approved', 'Rejected'

    // Constructors
    public TenantApplication() {
    }

    public TenantApplication(int applicationId, int renterId, int propertyId, Date applicationDate, String status) {
        this.applicationId = applicationId;
        this.renterId = renterId;
        this.propertyId = propertyId;
        this.applicationDate = applicationDate;
        this.status = status;
    }

    // Getters and Setters
    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
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

    public Date getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(Date applicationDate) {
        this.applicationDate = applicationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
