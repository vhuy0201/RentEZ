package Model;

public class WalletTransfer {
    private String transCode, timeCode, content;
    private int userID, walletTransferID;
    private boolean isRefunded;
    private float amount;
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    public int getWalletTransferID() {
        return walletTransferID;
    }

    public void setWalletTransferID(int walletTransferID) {
        this.walletTransferID = walletTransferID;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
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

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public boolean isIsRefunded() {
        return isRefunded;
    }

    public void setIsRefunded(boolean isRefunded) {
        this.isRefunded = isRefunded;
    }
    
    
}
