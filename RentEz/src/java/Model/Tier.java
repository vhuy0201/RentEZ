package Model;

public class Tier {

    private int tierId;
    private String tierName;
    private double price;
    private int priorityLevel;
    private String description;

    // Constructors
    public Tier() {
    }

    public Tier(int tierId, String tierName, double price, int priorityLevel, String description) {
        this.tierId = tierId;
        this.tierName = tierName;
        this.price = price;
        this.priorityLevel = priorityLevel;
        this.description = description;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getPriorityLevel() {
        return priorityLevel;
    }

    public void setPriorityLevel(int priorityLevel) {
        this.priorityLevel = priorityLevel;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
