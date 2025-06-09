package Model;

import java.util.Date;

public class Notification {
    private int notificationId;
    private int userId;
    private String message;
    private Date sentDate;
    private boolean isRead;
    private Integer referenceId;
    private String referenceType;  // 'Booking', 'Schedule', 'Payment', 'Message', 'Bill'

    // Constructors
    public Notification() {
    }

    public Notification(int notificationId, int userId, String message, Date sentDate, boolean isRead, 
            Integer referenceId, String referenceType) {
        this.notificationId = notificationId;
        this.userId = userId;
        this.message = message;
        this.sentDate = sentDate;
        this.isRead = isRead;
        this.referenceId = referenceId;
        this.referenceType = referenceType;
    }

    // Getters and Setters
    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getSentDate() {
        return sentDate;
    }

    public void setSentDate(Date sentDate) {
        this.sentDate = sentDate;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Integer getReferenceId() {
        return referenceId;
    }

    public void setReferenceId(Integer referenceId) {
        this.referenceId = referenceId;
    }

    public String getReferenceType() {
        return referenceType;
    }

    public void setReferenceType(String referenceType) {
        this.referenceType = referenceType;
    }
}
