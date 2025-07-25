package Model;

import java.sql.Timestamp;

/**
 * ContactMessage model class representing contact messages from users
 * Maps to ContactMessage table in database
 */
public class ContactMessage {
    private int messageID;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String subject;
    private String message;
    private boolean privacyPolicyAccepted;
    private Timestamp createdAt;
    
    // Default constructor
    public ContactMessage() {
    }
    
    // Constructor with all fields
    public ContactMessage(int messageID, String firstName, String lastName, String email, 
                         String phone, String subject, String message, 
                         boolean privacyPolicyAccepted, Timestamp createdAt) {
        this.messageID = messageID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.message = message;
        this.privacyPolicyAccepted = privacyPolicyAccepted;
        this.createdAt = createdAt;
    }
    
    // Constructor without ID (for inserting new records)
    public ContactMessage(String firstName, String lastName, String email, 
                         String phone, String subject, String message, 
                         boolean privacyPolicyAccepted) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.message = message;
        this.privacyPolicyAccepted = privacyPolicyAccepted;
    }

    // Getters and Setters
    public int getMessageID() {
        return messageID;
    }

    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isPrivacyPolicyAccepted() {
        return privacyPolicyAccepted;
    }

    public void setPrivacyPolicyAccepted(boolean privacyPolicyAccepted) {
        this.privacyPolicyAccepted = privacyPolicyAccepted;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    // Utility method to get full name
    public String getFullName() {
        return firstName + " " + lastName;
    }
    
    // Utility method to get subject display text
    public String getSubjectDisplayText() {
        switch (subject) {
            case "general":
                return "Thông tin chung";
            case "support":
                return "Hỗ trợ kỹ thuật";
            case "business":
                return "Hợp tác kinh doanh";
            case "complaint":
                return "Khiếu nại";
            case "suggestion":
                return "Góp ý";
            case "other":
                return "Khác";
            default:
                return subject;
        }
    }
    
    @Override
    public String toString() {
        return "ContactMessage{" +
                "messageID=" + messageID +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                ", privacyPolicyAccepted=" + privacyPolicyAccepted +
                ", createdAt=" + createdAt +
                '}';
    }
}
