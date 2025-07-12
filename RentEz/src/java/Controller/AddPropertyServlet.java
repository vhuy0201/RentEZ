package Controller;

import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.PropertyDAO;
import Model.Booking;
import Model.Location;
import Model.Property;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.sql.Timestamp;

@WebServlet(name = "AddPropertiesServlet", urlPatterns = {"/addProperty"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddPropertyServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get session to retrieve LandlordID
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            // Get parameters from the form
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String stateProvince = request.getParameter("stateProvince");
            String country = request.getParameter("country");
            String zipCode = (request.getParameter("ZipCode"));
            double price = Double.parseDouble(request.getParameter("price"));
            double size = Double.parseDouble(request.getParameter("size"));
            int numberOfBedrooms = Integer.parseInt(request.getParameter("numberOfBedrooms"));
            int numberOfBathrooms = Integer.parseInt(request.getParameter("numberOfBathrooms"));
            String availabilityStatus = request.getParameter("availabilityStatus");
            int priorityLevel = Integer.parseInt(request.getParameter("priorityLevel"));

            // Handle image upload
            String imagePath = handleFileUpload(request);

            // Create and save Location
            Location location = new Location();
            location.setAddress(address);
            location.setCity(city);
            location.setStateProvince(stateProvince);
            location.setCountry(country);
            location.setZipCode(zipCode);
            LocationDAO locationDAO = new LocationDAO();
            int locationId = locationDAO.insertLocation(location); // Assume this returns the generated LocationID
            if (locationId == -1) {
                request.setAttribute("error", "Failed to save location. Please try again.");
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                return;
            }

            // Create Property object
            Property property = new Property();
            property.setTitle(title);
            property.setDescription(description);
            property.setTypeId(typeId); // TypeID from form, assumed to reference PropertyType table
            property.setLocationId(locationId); // Newly created LocationID
            property.setLandlordId(user.getUserId()); // From session
            property.setPrice(price);
            property.setSize(size);
            property.setNumberOfBedrooms(numberOfBedrooms);
            property.setNumberOfBathrooms(numberOfBathrooms);
            property.setAvailabilityStatus(availabilityStatus);
            property.setPriorityLevel(priorityLevel);
            property.setAvatar(imagePath);

            // Insert the property using PropertyDAO
            PropertyDAO propertyDAO = new PropertyDAO();
            int propertyId = propertyDAO.addProperty(property);

            // Set response message
            if (propertyId == -1) {
                request.setAttribute("error", "Failed to add property. Please try again.");
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                return;
            }

            // Handle Booking creation if booking parameters are present
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String totalPriceStr = request.getParameter("totalPrice");
            String depositAmountStr = request.getParameter("depositAmount");
            String monthlyRentStr = request.getParameter("monthlyRent");
            String penaltyClause = request.getParameter("penaltyClause");
            String termsAndConditions = request.getParameter("termsAndConditions");

            if (startDateStr != null && !startDateStr.isEmpty()) {
                Booking booking = new Booking();
                booking.setRenterId(0); // Null equivalent for int, indicating no renter yet
                booking.setPropertyId(propertyId); // Link to newly created property
                booking.setStartDate(Timestamp.valueOf(startDateStr + " 00:00:00"));
                booking.setEndDate(Timestamp.valueOf(endDateStr + " 00:00:00"));
                booking.setTotalPrice(Double.parseDouble(totalPriceStr));
                booking.setStatus("Pending"); // Default status
                booking.setDepositAmount(Double.parseDouble(depositAmountStr));
                booking.setMonthlyRent(Double.parseDouble(monthlyRentStr));
                booking.setPenaltyClause(penaltyClause);
                booking.setTermsAndConditions(termsAndConditions);
                booking.setCreatedAt(new Date()); // Current timestamp
                booking.setSignedAt(null); // Null as specified
                booking.setSignedByRenter(false); // 0 equivalent, as specified
                booking.setSignedByLandlord(false); // Default, landlord hasn't signed yet

                BookingDAO bookingDAO = new BookingDAO();
                boolean bookingSuccess = bookingDAO.insert(booking);
                if (!bookingSuccess) {
                    request.setAttribute("error", "Property added, but failed to create associated booking. Please try again.");
                    request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                    return;
                }
            }
            session.setAttribute("successMessage", "Property added successfully!");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs.");
            request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
        }
    }

    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = null;
        for (Part part : request.getParts()) {
            if ("propertyImage".equals(part.getName())) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    // Generate unique filename
                    String fileExtension = "";
                    int lastDotIndex = submittedFileName.lastIndexOf('.');
                    if (lastDotIndex > 0) {
                        fileExtension = submittedFileName.substring(lastDotIndex);
                    }
                    fileName = System.currentTimeMillis() + "_" + submittedFileName.replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
                    String filePath = uploadPath + File.separator + fileName;
                    part.write(filePath);
                    break;
                }
            }
        }
        return fileName != null ? UPLOAD_DIR + "/" + fileName : null;
    }
    @Override
    public String getServletInfo() {
        return "Add Property Servlet handles property creation with type, location, and landlord details.";
    }
}
