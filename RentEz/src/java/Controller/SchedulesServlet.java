package Controller;

import DAO.NotificationDAO;
import DAO.PropertyDAO;
import DAO.ScheduleDAO;
import DAO.UsersDao;
import DAO.LocationDAO;
import DTO.ScheduleDTO;
import Model.Location;
import Model.Notification;
import Model.Property;
import Model.Schedule;
import Model.User;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling viewing and managing schedules
 */
@WebServlet(name = "SchedulesServlet", urlPatterns = {"/schedules"})
public class SchedulesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (currentUser == null) {
            request.getRequestDispatcher("/view/common/view-schedules.jsp").forward(request, response);
            return;
        }
        
        ScheduleDAO scheduleDAO = new ScheduleDAO();
        PropertyDAO propertyDAO = new PropertyDAO();
        UsersDao userDAO = new UsersDao();
        LocationDAO locationDAO = new LocationDAO();
        
        // Get schedules based on user role
        List<Schedule> schedules;
        if ("Landlord".equals(currentUser.getRole())) {
            schedules = scheduleDAO.getSchedulesByLandlordId(currentUser.getUserId());
        } else {
            schedules = scheduleDAO.getSchedulesByRenterId(currentUser.getUserId());
        }
          // Enriching the Schedule objects with property and user info
        List<ScheduleDTO> enrichedSchedules = new ArrayList<>();
        
        for (Schedule schedule : schedules) {
            ScheduleDTO scheduleDTO = new ScheduleDTO(schedule);
            
            // Get property details
            Property property = propertyDAO.getById(schedule.getPropertyId());
            if (property != null) {
                // Get location for property
                Location location = locationDAO.getById(property.getLocationId());
                property.setLocationId(location.getLocationId());
                scheduleDTO.setProperty(property);
                scheduleDTO.setLocation(location);
            }
            
            // Get landlord details
            User landlord = userDAO.getById(schedule.getLandlordId());
            if (landlord != null) {
                scheduleDTO.setLandlord(landlord);
            }
            
            // Get renter details (always load for both roles)
            User renter = userDAO.getById(schedule.getRenterId());
            if (renter != null) {
                scheduleDTO.setRenter(renter);
            }
            
            enrichedSchedules.add(scheduleDTO);
        }
        
        // Filter schedules by status
        List<ScheduleDTO> pendingSchedules = new ArrayList<>();
        List<ScheduleDTO> confirmedSchedules = new ArrayList<>();
        List<ScheduleDTO> cancelledSchedules = new ArrayList<>();
        
        for (ScheduleDTO scheduleDTO : enrichedSchedules) {
            String status = scheduleDTO.getStatus();
            if ("Pending".equals(status)) {
                pendingSchedules.add(scheduleDTO);
            } else if ("Confirmed".equals(status)) {
                confirmedSchedules.add(scheduleDTO);
            } else if ("Cancelled".equals(status)) {
                cancelledSchedules.add(scheduleDTO);
            }
        }
        
        // Set attributes for JSP
        request.setAttribute("schedules", enrichedSchedules);
        request.setAttribute("pendingSchedules", pendingSchedules);
        request.setAttribute("confirmedSchedules", confirmedSchedules);
        request.setAttribute("cancelledSchedules", cancelledSchedules);
        
        // Forward to JSP
        request.getRequestDispatcher("/view/common/view-schedules.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // In case any form is submitted directly to this servlet
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to manage schedules for property viewings";
    }
}
