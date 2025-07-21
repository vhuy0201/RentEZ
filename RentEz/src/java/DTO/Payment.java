package DTO;

import java.sql.Timestamp;

public class Payment {
    private int paymentId;
    private int userId;
    private String userFullname;
    private double amount;
    private String paymentType;
    private String status;
    private String description;
    private Timestamp paymentDate;
    private String refundReason;
    private Timestamp refundDate;
    
    // Constructors
    public Payment() {}
    
    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUserFullname() {
        return userFullname;
    }
    
    public void setUserFullname(String userFullname) {
        this.userFullname = userFullname;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public String getPaymentType() {
        return paymentType;
    }
    
    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Timestamp getPaymentDate() {
        return paymentDate;
    }
    
    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }
    
    public String getRefundReason() {
        return refundReason;
    }
    
    public void setRefundReason(String refundReason) {
        this.refundReason = refundReason;
    }
    
    public Timestamp getRefundDate() {
        return refundDate;
    }
    
    public void setRefundDate(Timestamp refundDate) {
        this.refundDate = refundDate;
    }
}
