package Model;

import java.util.Date;

public class UserTier {

    private int userTierId;
    private int userId;
    private int tierId;
    private Date startDate;
    private Date endDate;
    private String status; // 'Active', 'Expired'

    // Constructors
    public UserTier() {
    }

    public UserTier(int userTierId, int userId, int tierId, Date startDate, Date endDate, String status) {
        this.userTierId = userTierId;
        this.userId = userId;
        this.tierId = tierId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

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

    public int getTierId() {
        return tierId;
    }

    public void setTierId(int tierId) {
        this.tierId = tierId;
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
}
