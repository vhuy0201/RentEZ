package Service;

import DAO.NotificationDAO;
import Model.Notification;
import java.util.Date;
import java.util.List;

/**
 * Service class for handling notification-related business logic
 */
public class NotificationService {
    
    private final NotificationDAO notificationDAO;
    
    public NotificationService() {
        this.notificationDAO = new NotificationDAO();
    }
    
    /**
     * Creates a new notification for a user
     * 
     * @param userId The ID of the user to receive the notification
     * @param message The notification message
     * @param referenceId Optional ID of the referenced entity (booking, payment, etc.)
     * @param referenceType Type of reference (Booking, Payment, Message, etc.)
     * @return True if the notification was created successfully
     */
    public boolean createNotification(int userId, String message, Integer referenceId, String referenceType) {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setMessage(message);
        notification.setSentDate(new Date()); // Current time
        notification.setIsRead(false);
        notification.setReferenceId(referenceId);
        notification.setReferenceType(referenceType);
        
        return notificationDAO.insert(notification);
    }
    
    /**
     * Creates a booking notification
     * 
     * @param userId User to notify
     * @param message Notification message
     * @param bookingId Booking reference ID
     * @return True if successful
     */
    public boolean createBookingNotification(int userId, String message, int bookingId) {
        return createNotification(userId, message, bookingId, "Booking");
    }
    
    /**
     * Creates a payment notification
     * 
     * @param userId User to notify
     * @param message Notification message
     * @param paymentId Payment reference ID
     * @return True if successful
     */
    public boolean createPaymentNotification(int userId, String message, int paymentId) {
        return createNotification(userId, message, paymentId, "Payment");
    }
    
    /**
     * Creates a message notification
     * 
     * @param userId User to notify
     * @param message Notification message
     * @param messageId Message reference ID
     * @return True if successful
     */
    public boolean createMessageNotification(int userId, String message, int messageId) {
        return createNotification(userId, message, messageId, "Message");
    }
    
    /**
     * Creates a schedule/viewing notification
     * 
     * @param userId User to notify
     * @param message Notification message
     * @param scheduleId Schedule reference ID
     * @return True if successful
     */
    public boolean createScheduleNotification(int userId, String message, int scheduleId) {
        return createNotification(userId, message, scheduleId, "Schedule");
    }
    
    /**
     * Creates a bill notification
     * 
     * @param userId User to notify
     * @param message Notification message
     * @param billId Bill reference ID
     * @return True if successful
     */
    public boolean createBillNotification(int userId, String message, int billId) {
        return createNotification(userId, message, billId, "Bill");
    }
    
    /**
     * Creates a system notification with no specific reference
     * 
     * @param userId User to notify
     * @param message Notification message
     * @return True if successful
     */
    public boolean createSystemNotification(int userId, String message) {
        return createNotification(userId, message, null, "System");
    }
    
    /**
     * Get all notifications for a user
     * 
     * @param userId The user ID
     * @return List of notifications
     */
    public List<Notification> getUserNotifications(int userId) {
        return notificationDAO.getNotificationsByUserId(userId);
    }
    
    /**
     * Get unread notifications for a user
     * 
     * @param userId The user ID
     * @return List of unread notifications
     */
    public List<Notification> getUnreadNotifications(int userId) {
        return notificationDAO.getUnreadNotificationsByUserId(userId);
    }
    
    /**
     * Get count of unread notifications
     * 
     * @param userId The user ID
     * @return Count of unread notifications
     */
    public int getUnreadCount(int userId) {
        return notificationDAO.getUnreadCount(userId);
    }
    
    /**
     * Mark a notification as read
     * 
     * @param notificationId The notification ID
     * @return True if successful
     */
    public boolean markAsRead(int notificationId) {
        Notification notification = notificationDAO.getById(notificationId);
        if (notification != null) {
            notification.setIsRead(true);
            return notificationDAO.update(notification);
        }
        return false;
    }
    
    /**
     * Mark all notifications for a user as read
     * 
     * @param userId The user ID
     * @return True if successful
     */
    public boolean markAllAsRead(int userId) {
        List<Notification> unreadNotifications = getUnreadNotifications(userId);
        boolean allSuccess = true;
        
        for (Notification notification : unreadNotifications) {
            notification.setIsRead(true);
            boolean success = notificationDAO.update(notification);
            if (!success) {
                allSuccess = false;
            }
        }
        
        return allSuccess;
    }
    
    /**
     * Delete a notification
     * 
     * @param notificationId The notification ID
     * @return True if successful
     */
    public boolean deleteNotification(int notificationId) {
        return notificationDAO.delete(notificationId);
    }
    
    /**
     * Get a notification by ID
     * 
     * @param notificationId The notification ID
     * @return The notification object
     */
    public Notification getNotificationById(int notificationId) {
        return notificationDAO.getById(notificationId);
    }
}
