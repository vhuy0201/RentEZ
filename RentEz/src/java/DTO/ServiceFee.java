package DTO;

import java.sql.Timestamp;

public class ServiceFee {
    private int feeId;
    private String feeName;
    private String description;
    private double amount;
    private String feeType; // "fixed", "percentage", "monthly", etc.
    private String status;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    // Constructors
    public ServiceFee() {}
    
    public ServiceFee(int feeId, String feeName, String description, double amount, String feeType, String status) {
        this.feeId = feeId;
        this.feeName = feeName;
        this.description = description;
        this.amount = amount;
        this.feeType = feeType;
        this.status = status;
    }
    
    // Getters and Setters
    public int getFeeId() {
        return feeId;
    }
    
    public void setFeeId(int feeId) {
        this.feeId = feeId;
    }
    
    public String getFeeName() {
        return feeName;
    }
    
    public void setFeeName(String feeName) {
        this.feeName = feeName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public String getFeeType() {
        return feeType;
    }
    
    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
    
    public Timestamp getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }
}
