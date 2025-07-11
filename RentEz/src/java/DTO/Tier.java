package DTO;

import java.sql.Timestamp;

public class Tier {
    private int tierId;
    private String tierName;
    private String description;
    private double price;
    private int duration; // in days
    private String benefits;
    private String status;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    // Constructors
    public Tier() {}
    
    public Tier(int tierId, String tierName, String description, double price, int duration, String status) {
        this.tierId = tierId;
        this.tierName = tierName;
        this.description = description;
        this.price = price;
        this.duration = duration;
        this.status = status;
    }
    
    // Getters and Setters
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
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public int getDuration() {
        return duration;
    }
    
    public void setDuration(int duration) {
        this.duration = duration;
    }
    
    public String getBenefits() {
        return benefits;
    }
    
    public void setBenefits(String benefits) {
        this.benefits = benefits;
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
