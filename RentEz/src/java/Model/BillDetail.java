package Model;


public class BillDetail {

    private int billDetailId;
    private int billId;
    private int categoryId;
    private Double usageValue;
    private Double amount;
    
    // Additional property for display purposes
    private FeeCategory feeCategory;

    // Constructors
    public BillDetail() {
    }

    public BillDetail(int billDetailId, int billId, int categoryId, Double usageValue, Double amount) {
        this.billDetailId = billDetailId;
        this.billId = billId;
        this.categoryId = categoryId;
        this.usageValue = usageValue;
        this.amount = amount;
    }

    // Getters and Setters
    public int getBillDetailId() {
        return billDetailId;
    }

    public void setBillDetailId(int billDetailId) {
        this.billDetailId = billDetailId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Double getUsageValue() {
        return usageValue;
    }

    public void setUsageValue(Double usageValue) {
        this.usageValue = usageValue;
    }
    
    // Legacy method for backward compatibility
    public void setUsageValue(double usageValue) {
        this.usageValue = Double.valueOf(usageValue);
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }
    
    // Legacy method for backward compatibility
    public void setAmount(double amount) {
        this.amount = Double.valueOf(amount);
    }

    public FeeCategory getFeeCategory() {
        return feeCategory;
    }

    public void setFeeCategory(FeeCategory feeCategory) {
        this.feeCategory = feeCategory;
    }
}
