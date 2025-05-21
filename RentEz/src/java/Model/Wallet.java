package Model;

import java.util.Date;

public class Wallet {
    private int walletId;
    private int userId;
    private double balance;
    private Date lastUpdated;

    public Wallet() {
    }

    public Wallet(int walletId, int userId, double balance, Date lastUpdated) {
        this.walletId = walletId;
        this.userId = userId;
        this.balance = balance;
        this.lastUpdated = lastUpdated;
    }

    public int getWalletId() {
        return walletId;
    }

    public void setWalletId(int walletId) {
        this.walletId = walletId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
    
}
