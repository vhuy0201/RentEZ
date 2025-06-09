package DTO;

import Model.Location;
import Model.Property;
import Model.Schedule;
import Model.User;
import java.util.Date;

/**
 * Data Transfer Object that combines a Schedule with its related entities
 * for convenient display in the view
 */
public class ScheduleDTO {
    private Schedule schedule;
    private Property property;
    private User landlord;
    private User renter;
    private Location location;
    
    public ScheduleDTO() {
        
    }
    
    public ScheduleDTO(Schedule schedule) {
        this.schedule = schedule;
    }
    
    // Getters and Setters
    public Schedule getSchedule() {
        return schedule;
    }
    
    public void setSchedule(Schedule schedule) {
        this.schedule = schedule;
    }
    
    public Property getProperty() {
        return property;
    }
    
    public void setProperty(Property property) {
        this.property = property;
    }
    
    public User getLandlord() {
        return landlord;
    }
    
    public void setLandlord(User landlord) {
        this.landlord = landlord;
    }
    
    public User getRenter() {
        return renter;
    }
    
    public void setRenter(User renter) {
        this.renter = renter;
    }
    
    public Location getLocation() {
        return location;
    }
    
    public void setLocation(Location location) {
        this.location = location;
    }
    
    // Convenience methods for the view
    public int getScheduleId() {
        return schedule != null ? schedule.getScheduleId() : 0;
    }
    
    public int getRenterId() {
        return schedule != null ? schedule.getRenterId() : 0;
    }
    
    public int getLandlordId() {
        return schedule != null ? schedule.getLandlordId() : 0;
    }
    
    public int getPropertyId() {
        return schedule != null ? schedule.getPropertyId() : 0;
    }
    
    public Date getScheduleDateTime() {
        return schedule != null ? schedule.getScheduleDateTime() : null;
    }
    
    public String getStatus() {
        return schedule != null ? schedule.getStatus() : "";
    }
}
