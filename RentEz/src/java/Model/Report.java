
package Model;

import java.util.Date;

public class Report {
    private int reportID;
    private int landLordID;
    private int userId;
    private String content;
    private boolean isApproved;
    private Date time;

    public Report() {
    }

    public Report(int reportID, int userId, String content, boolean isApproved, Date time, int landLordID) {
        this.reportID = reportID;
        this.userId = userId;
        this.content = content;
        this.isApproved = isApproved;
        this.time = time;
        this.landLordID = landLordID;
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getLandLordID() {
        return landLordID;
    }

    public void setLandLordID(int landLordID) {
        this.landLordID = landLordID;
    }

    @Override
    public String toString() {
        return "Report{" + "reportID=" + reportID + ", landLordID=" + landLordID + ", userId=" + userId + ", content=" + content + ", isApproved=" + isApproved + ", time=" + time + '}';
    } 
}
