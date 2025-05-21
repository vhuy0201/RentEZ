package Model;

import java.util.Date;

public class UserFavorite {

    private int favoriteId;
    private int userId;
    private int propertyId;
    private Date createdAt;

    // Constructors
    public UserFavorite() {
    }

    public UserFavorite(int favoriteId, int userId, int propertyId, Date createdAt) {
        this.favoriteId = favoriteId;
        this.userId = userId;
        this.propertyId = propertyId;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(int favoriteId) {
        this.favoriteId = favoriteId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
