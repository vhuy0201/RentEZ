package Model;

public class FeeCategory {

    private int categoryId;
    private String name;
    private double unitPrice;
    private String unit;

    // Constructors
    public FeeCategory() {
    }

    public FeeCategory(int categoryId, String name, double unitPrice, String unit) {
        this.categoryId = categoryId;
        this.name = name;
        this.unitPrice = unitPrice;
        this.unit = unit;
    }

    // Getters and Setters
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
