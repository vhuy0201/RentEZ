package Model;

public class PropertyImage {

    private int imageId;
    private int propertyId;
    private String imageURL;

    // Constructors
    public PropertyImage() {
    }

    public PropertyImage(int imageId, int propertyId, String imageURL) {
        this.imageId = imageId;
        this.propertyId = propertyId;
        this.imageURL = imageURL;
    }

    // Getters and Setters
    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
