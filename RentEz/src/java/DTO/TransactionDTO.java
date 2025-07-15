package DTO;

import java.util.Date;

/**
 * Transaction Data Transfer Object
 * Represents a financial transaction in the system
 */
public class TransactionDTO {
    private Integer transactionId;
    private Integer userId;
    private Double amount;
    private String transactionType; // DEPOSIT, WITHDRAW, PAYMENT, REFUND
    private String paymentMethod; // VNPay, MoMo, Bank Transfer, etc.
    private String status; // Pending, Completed, Failed, Cancelled
    private String description;
    private Date transactionDate;
    private String referenceId; // External transaction ID (VNPay TransactionNo, etc.)
    private String bankCode;
    private Date createdAt;
    private Date updatedAt;
    
    // Constructors
    public TransactionDTO() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }
    
    public TransactionDTO(Integer userId, Double amount, String transactionType, 
                         String paymentMethod, String status, String description) {
        this();
        this.userId = userId;
        this.amount = amount;
        this.transactionType = transactionType;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.description = description;
        this.transactionDate = new Date();
    }
    
    // Getters and Setters
    public Integer getTransactionId() {
        return transactionId;
    }
    
    public void setTransactionId(Integer transactionId) {
        this.transactionId = transactionId;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public Double getAmount() {
        return amount;
    }
    
    public void setAmount(Double amount) {
        this.amount = amount;
    }
    
    public String getTransactionType() {
        return transactionType;
    }
    
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
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
    
    public Date getTransactionDate() {
        return transactionDate;
    }
    
    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
    
    public String getReferenceId() {
        return referenceId;
    }
    
    public void setReferenceId(String referenceId) {
        this.referenceId = referenceId;
    }
    
    public String getBankCode() {
        return bankCode;
    }
    
    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "TransactionDTO{" +
                "transactionId=" + transactionId +
                ", userId=" + userId +
                ", amount=" + amount +
                ", transactionType='" + transactionType + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", status='" + status + '\'' +
                ", description='" + description + '\'' +
                ", transactionDate=" + transactionDate +
                ", referenceId='" + referenceId + '\'' +
                ", bankCode='" + bankCode + '\'' +
                '}';
    }
}
