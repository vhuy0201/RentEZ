package Model;

import java.util.Date;

public class Message {

    private int messageId;
    private int senderId;
    private int receiverId;
    private int propertyId;
    private String content;
    private Date sendDate;
    private boolean readStatus;

    // Constructors
    public Message() {
    }

    public Message(int messageId, int senderId, int receiverId, int propertyId, String content, Date sendDate, boolean readStatus) {
        this.messageId = messageId;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.propertyId = propertyId;
        this.content = content;
        this.sendDate = sendDate;
        this.readStatus = readStatus;
    }

    // Getters and Setters
    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSendDate() {
        return sendDate;
    }

    public void setSendDate(Date sendDate) {
        this.sendDate = sendDate;
    }

    public boolean isReadStatus() {
        return readStatus;
    }

    public void setReadStatus(boolean readStatus) {
        this.readStatus = readStatus;
    }
}
