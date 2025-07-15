package Controller;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.UsersDao;
import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import Model.User;
import Model.Booking;
import Model.Property;
import DTO.BookingDTO;
import Model.Location;
import Model.PropertyType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings", "/admin/booking-detail"})
public class AdminBookingServlet extends HttpServlet {
    
    private BookingDAO bookingDAO;
    private UsersDao userDAO;
    private PropertyDAO propertyDAO;
    private LocationDAO locationDAO;
    private PropertyTypeDAO propertyTypeDAO;
    
    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
        userDAO = new UsersDao();
        propertyDAO = new PropertyDAO();
        locationDAO = new LocationDAO();
        propertyTypeDAO = new PropertyTypeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        
        String servletPath = request.getServletPath();
        
        if ("/admin/bookings".equals(servletPath)) {
            showBookingManagement(request, response);
        } else if ("/admin/booking-detail".equals(servletPath)) {
            showBookingDetail(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "export":
                    exportBookings(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/bookings");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/bookings?error=1");
        }
    }
    
    private void showBookingManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get all bookings with details - in a real application, you would implement pagination and filtering
            List<BookingDTO> bookings = getAllBookingsWithDetails();
            
            // Get booking statistics
            Map<String, Integer> bookingStats = getBookingStatistics(bookings);
            double totalBookingValue = calculateTotalBookingValue(bookings);
            
            // Set attributes
            request.setAttribute("bookingDTOs", bookings);
            request.setAttribute("confirmedBookings", bookingStats.get("confirmed"));
            request.setAttribute("pendingBookings", bookingStats.get("pending"));
            request.setAttribute("cancelledBookings", bookingStats.get("cancelled"));
            request.setAttribute("totalBookingValue", totalBookingValue);
            
            request.getRequestDispatcher("/view/admin/booking-management.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void showBookingDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            
            Booking booking = bookingDAO.getById(bookingId);
            
            if (booking != null) {
                // Create BookingDTO with all related data
                BookingDTO bookingDTO = new BookingDTO();
                bookingDTO.setBooking(booking);
                
                // Get related data
                User renter = userDAO.getById(booking.getRenterId());
                bookingDTO.setRenter(renter);
                
                Property property = propertyDAO.getById(booking.getPropertyId());
                bookingDTO.setProperty(property);
                
                Location location = locationDAO.getById(property.getLocationId());
                bookingDTO.setLocation(location);
                
                PropertyType propertyType = propertyTypeDAO.getById(property.getTypeId());
                bookingDTO.setType(propertyType);
                
                if (property != null) {
                    User landlord = userDAO.getById(property.getLandlordId());
                    bookingDTO.setLandlord(landlord);
                }
                
                // Set attributes
                request.setAttribute("bookingDTO", bookingDTO);
                
                request.getRequestDispatcher("/view/admin/booking-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/bookings?error=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void exportBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<BookingDTO> bookings = getAllBookingsWithDetails();
            
            // Set response headers for CSV download
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"bookings.csv\"");
            
            // Generate CSV content
            StringBuilder csvContent = new StringBuilder();
            csvContent.append("ID,Người thuê,Bất động sản,Ngày bắt đầu,Ngày kết thúc,Giá thuê hàng tháng,Tổng giá,Trạng thái\n");
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            
            for (BookingDTO bookingDTO : bookings) {
                User renter = bookingDTO.getRenter();
                Property property = bookingDTO.getProperty();
                
                csvContent.append(bookingDTO.getBookingId()).append(",")
                         .append(renter != null ? renter.getName() : "N/A").append(",")
                         .append(property != null ? property.getTitle() : "N/A").append(",")
                         .append(bookingDTO.getStartDate() != null ? dateFormat.format(bookingDTO.getStartDate()) : "N/A").append(",")
                         .append(bookingDTO.getEndDate() != null ? dateFormat.format(bookingDTO.getEndDate()) : "N/A").append(",")
                         .append(bookingDTO.getMonthlyRent()).append(",")
                         .append(bookingDTO.getTotalPrice()).append(",")
                         .append(bookingDTO.getStatus())
                         .append("\n");
            }
            
            response.getWriter().write(csvContent.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/bookings?error=export");
        }
    }
    
    // Helper methods
    private List<BookingDTO> getAllBookingsWithDetails() {
        List<Booking> bookings = bookingDAO.getAllBookings();
        List<BookingDTO> bookingDTOs = new ArrayList<>();
        
        for (Booking booking : bookings) {
            BookingDTO bookingDTO = new BookingDTO();
            
            // Set booking
            bookingDTO.setBooking(booking);
            
            // Set renter
            User renter = userDAO.getById(booking.getRenterId());
            bookingDTO.setRenter(renter);
            
            // Set property
            Property property = propertyDAO.getById(booking.getPropertyId());
            bookingDTO.setProperty(property);
            
            Location location = locationDAO.getById(property.getLocationId());
            bookingDTO.setLocation(location);
            // Set landlord (from property)
            if (property != null) {
                User landlord = userDAO.getById(property.getLandlordId());
                bookingDTO.setLandlord(landlord);
            }
            
            bookingDTOs.add(bookingDTO);
        }
        
        return bookingDTOs;
    }
    
    private Map<String, Integer> getBookingStatistics(List<BookingDTO> bookings) {
        Map<String, Integer> stats = new HashMap<>();
        int confirmed = 0;
        int pending = 0;
        int cancelled = 0;
        
        for (BookingDTO booking : bookings) {
            String status = booking.getStatus().toLowerCase();
            if (status.equals("confirmed")) {
                confirmed++;
            } else if (status.equals("pending")) {
                pending++;
            } else if (status.equals("cancelled")) {
                cancelled++;
            }
        }
        
        stats.put("confirmed", confirmed);
        stats.put("pending", pending);
        stats.put("cancelled", cancelled);
        
        return stats;
    }
    
    private double calculateTotalBookingValue(List<BookingDTO> bookings) {
        double total = 0;
        for (BookingDTO booking : bookings) {
            total += booking.getTotalPrice();
        }
        return total;
    }
}
