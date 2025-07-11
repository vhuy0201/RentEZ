package Model;

import java.util.Date;
import java.util.List;

public class Bill {

    private int billId;
    private int propertyId;
    private int renterId;
    private String billingPeriod;
    private Double totalAmount;
    private Date dueDate;
    private String status; // 'Pending', 'Paid', 'Unpaid', 'Overdue'
    
    // Additional properties for display purposes
    private List<BillDetail> billDetails;
    private Property property;
    private String renterName;

    // Constructors
    public Bill() {
    }

    public Bill(int billId, int propertyId, int renterId, String billingPeriod, Double totalAmount, Date dueDate, String status) {
        this.billId = billId;
        this.propertyId = propertyId;
        this.renterId = renterId;
        this.billingPeriod = billingPeriod;
        this.totalAmount = totalAmount;
        this.dueDate = dueDate;
        this.status = status;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
    }

    public String getBillingPeriod() {
        return billingPeriod;
    }

    public void setBillingPeriod(String billingPeriod) {
        this.billingPeriod = billingPeriod;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    // Legacy method for backward compatibility
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<BillDetail> getBillDetails() {
        return billDetails;
    }

    public void setBillDetails(List<BillDetail> billDetails) {
        this.billDetails = billDetails;
    }

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }
    
    public String getRenterName() {
        return renterName;
    }
    
    public void setRenterName(String renterName) {
        this.renterName = renterName;
    }
}
