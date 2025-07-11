package Controller;

import DAO.NotificationDAO;
import DAO.ScheduleDAO;
import DAO.UsersDao;
import Model.Notification;
import Model.Schedule;
import Model.User;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ScheduleViewingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String propertyDetailUrl = request.getContextPath() + "/property-detail?id=" + request.getParameter("propertyId");
        String message = "";

        if (currentUser == null) {
            message = "Vui lòng đăng nhập để đặt lịch xem nhà.";
            response.sendRedirect(request.getContextPath() + "/login?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }

        try {            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            int landlordId = Integer.parseInt(request.getParameter("landlordId"));
            String scheduleDateStr = request.getParameter("scheduleDate");
            String scheduleTimeStr = request.getParameter("scheduleTime");
            
            if (scheduleDateStr == null || scheduleDateStr.isEmpty()) {
                message = "Ngày xem không được để trống.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }
            
            if (scheduleTimeStr == null || scheduleTimeStr.isEmpty()) {
                message = "Giờ xem không được để trống.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }
            
            // Combine date and time
            String scheduleDateTimeStr = scheduleDateStr + " " + scheduleTimeStr;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date scheduleDateTime = sdf.parse(scheduleDateTimeStr);

            // Validate if the schedule date is not in the past
            Date today = new Date();            if (scheduleDateTime.before(today)) {
                message = "Không thể chọn ngày trong quá khứ.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            ScheduleDAO scheduleDAO = new ScheduleDAO();
            
            // Check existing schedules by same user for same property
            boolean scheduleExists = false;
            List<Schedule> userSchedules = scheduleDAO.getSchedulesByRenterId(currentUser.getUserId());
            for (Schedule existing : userSchedules) {
                if (existing.getPropertyId() == propertyId) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String existingDate = dateFormat.format(existing.getScheduleDateTime());
                    String newDate = dateFormat.format(scheduleDateTime);
                    
                    if (existingDate.equals(newDate) && !existing.getStatus().equalsIgnoreCase("Cancelled")) {
                        scheduleExists = true;
                        break;
                    }
                }
            }            if (scheduleExists) {
                message = "Bạn đã có lịch xem cho bất động sản này vào ngày đã chọn.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            Schedule schedule = new Schedule();
            schedule.setRenterId(currentUser.getUserId());
            schedule.setLandlordId(landlordId);
            schedule.setPropertyId(propertyId);
            schedule.setScheduleDateTime(scheduleDateTime);
            schedule.setStatus("Pending");            if (scheduleDAO.insert(schedule)) {
                message = "Đặt lịch xem nhà thành công vào ngày " + 
                        new SimpleDateFormat("dd/MM/yyyy").format(scheduleDateTime) + " lúc " + 
                        new SimpleDateFormat("HH:mm").format(scheduleDateTime) + "! Chủ nhà sẽ sớm liên hệ với bạn.";
                
                // Send notification to landlord
                try {
                    NotificationDAO notifDAO = new NotificationDAO();
                    UsersDao userDao = new UsersDao();
                    User landlord = userDao.getById(landlordId);
                    
                    if (landlord != null) {                        // Create notification for landlord
                        String notifMessage = "Người dùng " + currentUser.getName() + " đã đặt lịch xem nhà của bạn vào ngày " 
                                + new SimpleDateFormat("dd/MM/yyyy").format(scheduleDateTime) + " lúc "
                                + new SimpleDateFormat("HH:mm").format(scheduleDateTime);
                        
                        Notification notification = new Notification();
                        notification.setUserId(landlordId);
                        notification.setMessage(notifMessage);
                        notification.setSentDate(new Date());
                        notification.setIsRead(false);
                        notification.setReferenceId(schedule.getScheduleId());
                        notification.setReferenceType("Schedule");
                        
                        notifDAO.insert(notification);
                        
                        // Also create a notification for the renter
                        Notification renterNotif = new Notification();
                        renterNotif.setUserId(currentUser.getUserId());
                        renterNotif.setMessage("Bạn đã đặt lịch xem nhà vào ngày " + 
                                new SimpleDateFormat("dd/MM/yyyy").format(scheduleDateTime) + " lúc " + 
                                new SimpleDateFormat("HH:mm").format(scheduleDateTime) + 
                                ". Chủ nhà sẽ liên hệ với bạn.");
                        renterNotif.setSentDate(new Date());
                        renterNotif.setIsRead(false);
                        renterNotif.setReferenceId(schedule.getScheduleId());
                        renterNotif.setReferenceType("Schedule");
                        
                        notifDAO.insert(renterNotif);
                    }
                } catch (Exception ex) {
                    System.out.println("Error sending notification: " + ex.getMessage());
                    ex.printStackTrace();
                }
            } else {
                message = "Đặt lịch xem nhà thất bại. Vui lòng thử lại.";
            }
        } catch (NumberFormatException e) {
            message = "ID bất động sản hoặc ID chủ nhà không hợp lệ.";
            e.printStackTrace();
        } catch (ParseException e) {
            message = "Định dạng ngày không hợp lệ.";
            e.printStackTrace();        } catch (Exception e) {
            message = "Đã xảy ra lỗi trong quá trình xử lý yêu cầu.";
            e.printStackTrace();
        }        redirectWithMessage(response, propertyDetailUrl, message);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }    @Override
    public String getServletInfo() {
        return "Handles scheduling a property viewing";
    }
    
    // Helper method to redirect with message parameter
    private void redirectWithMessage(HttpServletResponse response, String url, String message) throws IOException {
        if (url.contains("?")) {
            response.sendRedirect(url + "&scheduleMessage=" + URLEncoder.encode(message, "UTF-8"));
        } else {
            response.sendRedirect(url + "?scheduleMessage=" + URLEncoder.encode(message, "UTF-8"));
        }
    }
}
