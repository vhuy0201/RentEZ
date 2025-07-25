/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.NotificationDAO;
import DAO.ReportDAO;
import DAO.UsersDao;
import Model.Notification;
import Model.Report;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class ReportServlet extends HttpServlet {
    User user;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        user = (User) session.getAttribute("user");
        String actor = user.getRole();
        switch (actor) {
            case "Admin" -> {
                adminGet(request, response);
            }
            
            case "Renter" -> {
                renterGet(request, response);
            }
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        user = (User) session.getAttribute("user");
        String actor = user.getRole();
        switch (actor) {
            case "Admin" -> {
                adminPost(request, response);
            }
            
            case "Renter" -> {
                renterPost(request, response);
            }
        }
    }
    
    private void adminGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getUserReports" -> {
                ReportDAO dao = new ReportDAO();
                List<Report> reports = dao.getAll();
                HashMap<Integer, User> users = new UsersDao().getUserReports();
                request.setAttribute("reports", reports);
                request.setAttribute("users", users);
                request.getRequestDispatcher("view/admin/userReport.jsp").forward(request, response);
            }
            
            case "getReportDetail" -> {
                ReportDAO dao = new ReportDAO();
                UsersDao userDao = new UsersDao();
                int reportID = Integer.parseInt(request.getParameter("id"));
                Report report = dao.getById(reportID);
                User renter = userDao.getById(report.getUserId());
                User landLord = userDao.getById(report.getLandLordID());
                request.setAttribute("renter", renter);
                request.setAttribute("landLord", landLord);
                request.setAttribute("report", report);
                
                request.getRequestDispatcher("view/admin/reportDetail.jsp").forward(request, response);
            }
        }
    }
    
    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "approve" -> {
                int reportID = Integer.parseInt(request.getParameter("reportID"));
                Report report = new ReportDAO().getById(reportID);
                new ReportDAO().approveReport(reportID);
                Notification notification = new Notification();
                notification.setUserId(report.getUserId());
                notification.setMessage("Đơn tố cáo của bạn đã được duyệt!");
                notification.setSentDate(new Date());
                notification.setIsRead(false);
                notification.setReferenceId(reportID);
                notification.setReferenceType("Report");
                new NotificationDAO().insert(notification);
                response.sendRedirect("ReportServlet?action=getUserReports");
            }
            
            case "delete" -> {
                int reportID = Integer.parseInt(request.getParameter("reportID"));
                new ReportDAO().delete(reportID);
                response.sendRedirect("ReportServlet?action=getUserReports");
            }
        }
    }
    
    private void renterGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    private void renterPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "create" -> {
                // Lấy dữ liệu từ form
                String content = request.getParameter("content");
                String landLordIdStr = request.getParameter("landLordId");
                int landLordId = Integer.parseInt(landLordIdStr);
                
                int userId = user.getUserId();
                java.util.Date now = new java.util.Date();
                // Tạo đối tượng Report
                Model.Report report = new Model.Report();
                report.setReportID(0); // auto increment nếu có
                report.setLandLordID(landLordId);
                report.setUserId(userId);
                report.setContent(content);
                report.setIsApproved(false);
                report.setTime(now);
                // Lưu vào DB
                DAO.ReportDAO dao = new DAO.ReportDAO();
                dao.insert(report);
                response.sendRedirect("property-detail?id=" + request.getParameter("propertyID"));
            }
        }
    }
}
