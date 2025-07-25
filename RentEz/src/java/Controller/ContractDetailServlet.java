package Controller;

import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import DAO.UsersDao;
import Model.Booking;
import Model.Location;
import Model.Property;
import Model.PropertyType;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ContractDetailServlet", urlPatterns = {"/contract-detail"})
public class ContractDetailServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private UsersDao userDao;
    private PropertyDAO propertyDAO;
    private PropertyTypeDAO propertyTypeDAO;
    private LocationDAO locationDao;

    @Override
    public void init() throws ServletException {
        super.init();
        bookingDAO = new BookingDAO();
        userDao = new UsersDao();
        propertyDAO = new PropertyDAO();
        locationDao = new LocationDAO();
        propertyTypeDAO = new PropertyTypeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String bookingIdStr = request.getParameter("id");
        if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error=invalid_id");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            
            // Get booking details
            Booking booking = bookingDAO.getById(bookingId);
            User rentor = userDao.getById(booking.getRenterId());
            Property property = propertyDAO.getById(booking.getPropertyId());
            PropertyType propertytype = propertyTypeDAO.getById(property.getTypeId());
            User landlord = userDao.getById(property.getLandlordId());
            Location location = locationDao.getById(property.getLocationId());
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/view-contracts?error=not_found");
                return;
            }

            // Set booking data for JSP
            request.setAttribute("booking", booking);
            request.setAttribute("renter", rentor);
            request.setAttribute("property", property);
            request.setAttribute("landlord", landlord);
            request.setAttribute("location", location);
            request.setAttribute("propertyType", propertytype);
            
            // Forward to contract detail page
            request.getRequestDispatcher("/view/common/contract-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/view-contracts?error=system_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
