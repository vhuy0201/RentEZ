package DTO;

import java.sql.Timestamp;

public class PropertyType {
    private int typeId;
    private String typeName;
    private String description;
    private String status;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    // Constructors
    public PropertyType() {}
    
    public PropertyType(int typeId, String typeName, String description, String status) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.description = description;
        this.status = status;
    }
    
    // Getters and Setters
    public int getTypeId() {
        return typeId;
    }
    
    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }
    
    public String getTypeName() {
        return typeName;
    }
    
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
    
    public Timestamp getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }
}
