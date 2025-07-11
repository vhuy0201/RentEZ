package DTO;

import java.sql.Timestamp;
import java.sql.Date;

public class UserTier {
    private int userTierId;
    private int userId;
    private String userFullname;
    private int tierId;
    private String tierName;
    private Date startDate;
    private Date endDate;
    private String status;
    private double amountPaid;
    private Timestamp createdDate;
    
    // Constructors
    public UserTier() {}
    
    // Getters and Setters
    public int getUserTierId() {
        return userTierId;
    }
    
    public void setUserTierId(int userTierId) {
        this.userTierId = userTierId;
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
    
    public int getTierId() {
        return tierId;
    }
    
    public void setTierId(int tierId) {
        this.tierId = tierId;
    }
    
    public String getTierName() {
        return tierName;
    }
    
    public void setTierName(String tierName) {
        this.tierName = tierName;
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
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public double getAmountPaid() {
        return amountPaid;
    }
    
    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }
    
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
}
