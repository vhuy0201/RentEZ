package Controller;

import DAO.NotificationDAO;
import DAO.PropertyDAO;
import DAO.ScheduleDAO;
import DAO.UserDao;
import Model.Notification;
import Model.Property;
import Model.Schedule;
import Model.User;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling schedule updates (confirm/cancel)
 */
@WebServlet(name = "UpdateScheduleServlet", urlPatterns = {"/updateSchedule"})
public class UpdateScheduleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?message=" + 
                URLEncoder.encode("Vui lòng đăng nhập để thực hiện thao tác này.", "UTF-8"));
            return;
        }
        
        String scheduleIdStr = request.getParameter("scheduleId");
        String action = request.getParameter("action");
        String message = "";
        
        if (scheduleIdStr == null || scheduleIdStr.isEmpty() || action == null || action.isEmpty()) {
            message = "Thông tin không hợp lệ. Vui lòng thử lại.";
            redirectWithMessage(response, request.getContextPath() + "/schedules", message);
            return;
        }
        
        try {
            int scheduleId = Integer.parseInt(scheduleIdStr);
            ScheduleDAO scheduleDAO = new ScheduleDAO();
            Schedule schedule = scheduleDAO.getById(scheduleId);
            
            if (schedule == null) {
                message = "Không tìm thấy lịch xem nhà.";
                redirectWithMessage(response, request.getContextPath() + "/schedules", message);
                return;
            }
            
            // Verify the user has permission to update this schedule
            boolean hasPermission = false;
            if ("Landlord".equals(currentUser.getRole()) && currentUser.getUserId() == schedule.getLandlordId()) {
                hasPermission = true;
            } else if (currentUser.getUserId() == schedule.getRenterId()) {
                // Renters can only cancel their own schedules
                hasPermission = "cancel".equals(action);
            }
            
            if (!hasPermission) {
                message = "Bạn không có quyền thực hiện thao tác này.";
                redirectWithMessage(response, request.getContextPath() + "/schedules", message);
                return;
            }
            
            // Process the action
            boolean success = false;
            String newStatus = "";
            if ("confirm".equals(action)) {
                newStatus = "Confirmed";
                success = scheduleDAO.updateStatus(scheduleId, newStatus);
                message = success ? "Đã xác nhận lịch xem nhà thành công." : "Không thể xác nhận lịch xem nhà.";
            } else if ("cancel".equals(action)) {
                newStatus = "Cancelled";
                success = scheduleDAO.updateStatus(scheduleId, newStatus);
                message = success ? "Đã hủy lịch xem nhà thành công." : "Không thể hủy lịch xem nhà.";
            }
            
            // Create notification for the action
            if (success) {
                createNotifications(schedule, newStatus, currentUser);
            }
            
        } catch (NumberFormatException e) {
            message = "ID lịch xem nhà không hợp lệ.";
        } catch (Exception e) {
            message = "Đã xảy ra lỗi trong quá trình xử lý yêu cầu: " + e.getMessage();
            e.printStackTrace();
        }
        
        // Redirect back to schedules page with message
        redirectWithMessage(response, request.getContextPath() + "/schedules", message);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to schedules page if accessed directly via GET
        response.sendRedirect(request.getContextPath() + "/schedules");
    }
    
    private void createNotifications(Schedule schedule, String newStatus, User actionUser) {
        try {
            NotificationDAO notifDAO = new NotificationDAO();
            UserDao userDAO = new UserDao();
            PropertyDAO propertyDAO = new PropertyDAO();
            
            User renter = userDAO.getById(schedule.getRenterId());
            User landlord = userDAO.getById(schedule.getLandlordId());
            Property property = propertyDAO.getById(schedule.getPropertyId());
            
            if (renter != null && landlord != null && property != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy 'lúc' HH:mm");
                String scheduleDateString = sdf.format(schedule.getScheduleDateTime());
                
                // Create different notifications based on status and who performed the action
                if ("Landlord".equals(actionUser.getRole())) {
                    // Landlord performed the action, notify the renter
                    Notification renterNotif = new Notification();
                    renterNotif.setUserId(renter.getUserId());
                    
                    if ("Confirmed".equals(newStatus)) {
                        renterNotif.setMessage("Chủ nhà đã xác nhận lịch xem bất động sản " + 
                                property.getTitle() + " vào ngày " + scheduleDateString);
                    } else {
                        renterNotif.setMessage("Chủ nhà đã từ chối lịch xem bất động sản " + 
                                property.getTitle() + " vào ngày " + scheduleDateString);
                    }
                    
                    renterNotif.setSentDate(new Date());
                    renterNotif.setIsRead(false);
                    renterNotif.setReferenceId(schedule.getScheduleId());
                    renterNotif.setReferenceType("Schedule");
                    
                    notifDAO.insert(renterNotif);
                } else {
                    // Renter cancelled their schedule, notify the landlord
                    Notification landlordNotif = new Notification();
                    landlordNotif.setUserId(landlord.getUserId());
                    landlordNotif.setMessage("Người thuê " + renter.getName() + " đã hủy lịch xem bất động sản " + 
                            property.getTitle() + " vào ngày " + scheduleDateString);
                    landlordNotif.setSentDate(new Date());
                    landlordNotif.setIsRead(false);
                    landlordNotif.setReferenceId(schedule.getScheduleId());
                    landlordNotif.setReferenceType("Schedule");
                    
                    notifDAO.insert(landlordNotif);
                }
            }
        } catch (Exception e) {
            System.out.println("Error creating notifications: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private void redirectWithMessage(HttpServletResponse response, String url, String message) 
            throws IOException {
        if (url.contains("?")) {
            response.sendRedirect(url + "&message=" + URLEncoder.encode(message, "UTF-8"));
        } else {
            response.sendRedirect(url + "?message=" + URLEncoder.encode(message, "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle schedule updates";
    }
}
