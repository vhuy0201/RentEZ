package Controller;

import DAO.BookingDAO;
import DAO.PropertyDAO;
import DAO.UsersDao;
import DAO.LocationDAO;
import DTO.BookingDTO;
import Model.Booking;
import Model.Property;
import Model.User;
import Model.Location;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling viewing rental contracts/bookings
 */
@WebServlet(name = "ViewContractsServlet", urlPatterns = {"/view-contracts"})
public class ViewContractsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        BookingDAO bookingDAO = new BookingDAO();
        PropertyDAO propertyDAO = new PropertyDAO();
        UsersDao userDAO = new UsersDao();
        LocationDAO locationDAO = new LocationDAO();
        
        // Get bookings based on user role
        List<Booking> bookings;
        if ("Landlord".equals(currentUser.getRole())) {
            bookings = bookingDAO.getBookingsForLandlord(currentUser.getUserId());
        } else {
            bookings = bookingDAO.getBookingsByRenterId(currentUser.getUserId());
        }
        
        // Enrich the Booking objects with property and user info
        List<BookingDTO> enrichedBookings = new ArrayList<>();
        
        for (Booking booking : bookings) {
            BookingDTO bookingDTO = new BookingDTO(booking);
            
            // Get property details
            Property property = propertyDAO.getById(booking.getPropertyId());
            if (property != null) {
                // Get location for property
                Location location = locationDAO.getById(property.getLocationId());
                bookingDTO.setProperty(property);
                bookingDTO.setLocation(location);
            }
            
            // Get landlord details (from property)
            if (property != null) {
                User landlord = userDAO.getById(property.getLandlordId());
                if (landlord != null) {
                    bookingDTO.setLandlord(landlord);
                }
            }
            
            // Get renter details
            User renter = userDAO.getById(booking.getRenterId());
            if (renter != null) {
                bookingDTO.setRenter(renter);
            }
            
            enrichedBookings.add(bookingDTO);
        }
        
        // Categorize bookings by status
        List<BookingDTO> pendingBookings = new ArrayList<>();
        List<BookingDTO> confirmedBookings = new ArrayList<>();
        List<BookingDTO> completedBookings = new ArrayList<>();
        List<BookingDTO> cancelledBookings = new ArrayList<>();
        
        for (BookingDTO bookingDTO : enrichedBookings) {
            String status = bookingDTO.getStatus();
            switch (status) {
                case "Pending":
                    pendingBookings.add(bookingDTO);
                    break;
                case "Confirmed":
                    confirmedBookings.add(bookingDTO);
                    break;
                case "Completed":
                    completedBookings.add(bookingDTO);
                    break;
                case "Cancelled":
                    cancelledBookings.add(bookingDTO);
                    break;
            }
        }
        
        // Set attributes for JSP
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("allBookings", enrichedBookings);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("confirmedBookings", confirmedBookings);
        request.setAttribute("completedBookings", completedBookings);
        request.setAttribute("cancelledBookings", cancelledBookings);
        
        // Forward to JSP
        request.getRequestDispatcher("/view/common/view-contracts.jsp").forward(request, response);
    }
}
