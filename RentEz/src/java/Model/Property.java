package Model;

public class Property {

    private int propertyId;
    private String title;
    private String description;
    private int typeId;
    private int locationId;
    private int landlordId;
    private double price;
    private double size;
    private int numberOfBedrooms;
    private int numberOfBathrooms;
    private String availabilityStatus;
    private int priorityLevel;
    private String avatar;
    
    // Additional fields for display purposes
    private String address; // For displaying location address from joined queries

    public Property() {
    }

    public Property(int propertyId, String title, String description, int typeId, int locationId, int landlordId,
            double price, double size, int numberOfBedrooms, int numberOfBathrooms, String availabilityStatus,
            int priorityLevel, String avatar) {
        this.propertyId = propertyId;
        this.title = title;
        this.description = description;
        this.typeId = typeId;
        this.locationId = locationId;
        this.landlordId = landlordId;
        this.price = price;
        this.size = size;
        this.numberOfBedrooms = numberOfBedrooms;
        this.numberOfBathrooms = numberOfBathrooms;
        this.availabilityStatus = availabilityStatus;
        this.priorityLevel = priorityLevel;
        this.avatar = avatar;
    }

    // Getters and Setters
    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getLandlordId() {
        return landlordId;
    }

    public void setLandlordId(int landlordId) {
        this.landlordId = landlordId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSize() {
        return size;
    }

    public void setSize(double size) {
        this.size = size;
    }

    public int getNumberOfBedrooms() {
        return numberOfBedrooms;
    }

    public void setNumberOfBedrooms(int numberOfBedrooms) {
        this.numberOfBedrooms = numberOfBedrooms;
    }

    public int getNumberOfBathrooms() {
        return numberOfBathrooms;
    }

    public void setNumberOfBathrooms(int numberOfBathrooms) {
        this.numberOfBathrooms = numberOfBathrooms;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public int getPriorityLevel() {
        return priorityLevel;
    }

    public void setPriorityLevel(int priorityLevel) {
        this.priorityLevel = priorityLevel;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
}
