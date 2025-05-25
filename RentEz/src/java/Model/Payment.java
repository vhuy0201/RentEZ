package Model;

import java.util.Date;

public class Payment {
    private int paymentId;
    private int payerId;
    private Integer payeeId; // Nullable
    private double amount;
    private Date paymentDate;
    private String paymentMethod;
    private String status; // 'Paid', 'Pending', 'Failed'
    private int referenceId;
    private String referenceType; // 'Booking', 'Bill', 'Tier'
    private Integer walletTransferId; // Nullable
    private String transCode;
    private String timeCode;
    private boolean isRefunded;

    public Payment() {
    }

    public Payment(int paymentId, int payerId, Integer payeeId, double amount, Date paymentDate, String paymentMethod, String status, int referenceId, String referenceType, Integer walletTransferId, String transCode, String timeCode, boolean isRefunded) {
        this.paymentId = paymentId;
        this.payerId = payerId;
        this.payeeId = payeeId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.referenceId = referenceId;
        this.referenceType = referenceType;
        this.walletTransferId = walletTransferId;
        this.transCode = transCode;
        this.timeCode = timeCode;
        this.isRefunded = isRefunded;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getPayerId() {
        return payerId;
    }

    public void setPayerId(int payerId) {
        this.payerId = payerId;
    }

    public Integer getPayeeId() {
        return payeeId;
    }

    public void setPayeeId(Integer payeeId) {
        this.payeeId = payeeId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getReferenceId() {
        return referenceId;
    }

    public void setReferenceId(int referenceId) {
        this.referenceId = referenceId;
    }

    public String getReferenceType() {
        return referenceType;
    }

    public void setReferenceType(String referenceType) {
        this.referenceType = referenceType;
    }

    public Integer getWalletTransferId() {
        return walletTransferId;
    }

    public void setWalletTransferId(Integer walletTransferId) {
        this.walletTransferId = walletTransferId;
    }

    public String getTransCode() {
        return transCode;
    }

    public void setTransCode(String transCode) {
        this.transCode = transCode;
    }

    public String getTimeCode() {
        return timeCode;
    }

    public void setTimeCode(String timeCode) {
        this.timeCode = timeCode;
    }

    public boolean isIsRefunded() {
        return isRefunded;
    }

    public void setIsRefunded(boolean isRefunded) {
        this.isRefunded = isRefunded;
    }
    
}
