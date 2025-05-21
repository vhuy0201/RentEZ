package Model;

public class BillDetail {

    private int billDetailId;
    private int billId;
    private int categoryId;
    private double usageValue;
    private double amount;

    // Constructors
    public BillDetail() {
    }

    public BillDetail(int billDetailId, int billId, int categoryId, double usageValue, double amount) {
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

    public double getUsageValue() {
        return usageValue;
    }

    public void setUsageValue(double usageValue) {
        this.usageValue = usageValue;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
