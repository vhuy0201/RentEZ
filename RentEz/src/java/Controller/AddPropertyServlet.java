package Controller;

import DAO.LocationDAO;
import DAO.PropertyDAO;
import Model.Location;
import Model.Property;
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
        if (session == null || session.getAttribute("landlordId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get session to retrieve LandlordID
            HttpSession session = request.getSession();
            Integer landlordId = (Integer) session.getAttribute("landlordId");
            if (landlordId == null) {
                request.setAttribute("error", "You must be logged in as a landlord to add a property.");
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                return;
            }
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
// Xử lý ảnh
//            String image = handleFileUpload(request);
//            Part filePart = request.getPart("image");
//            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            String uploadPath = getServletContext().getRealPath("/") + "view/guest/asset/img";
//
//            File uploadDir = new File(uploadPath);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdir();
//            }
//
//            String filePath = uploadPath + File.separator + fileName;
//            filePart.write(filePath);

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
            property.setLandlordId(landlordId); // From session
            property.setPrice(price);
            property.setSize(size);
            property.setNumberOfBedrooms(numberOfBedrooms);
            property.setNumberOfBathrooms(numberOfBathrooms);
            property.setAvailabilityStatus(availabilityStatus);
            property.setPriorityLevel(priorityLevel);
            property.setAvatar(null);

            // Insert the property using PropertyDAO
            PropertyDAO propertyDAO = new PropertyDAO();
            boolean propertySuccess = propertyDAO.insert(property);

            // Set response message
            if (propertySuccess) {
                session.setAttribute("successMessage", "Property added successfully!");
                response.sendRedirect(request.getContextPath() + "/viewProperties"); // Redirect to a page listing properties
            } else {
                request.setAttribute("error", "Failed to add property. Please try again.");
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs.");
            request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
        }
    }
    
//    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
//        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//        File uploadDir = new File(uploadPath);
//        if (!uploadDir.exists()) {
//            uploadDir.mkdir();
//        }
//
//        String fileName = null;
//        for (Part part : request.getParts()) {
//            String submittedFileName = part.getSubmittedFileName();
//            if (submittedFileName != null && !submittedFileName.isEmpty()) {
//                fileName = System.currentTimeMillis() + "_" + submittedFileName;
//                part.write(new File(uploadPath + File.separator + fileName));
//                break; // Only handle the first file for simplicity
//            }
//        }
//        return fileName != null ? UPLOAD_DIR + "/" + fileName : null;
//    }

    @Override
    public String getServletInfo() {
        return "Add Property Servlet handles property creation with type, location, and landlord details.";
    }
}
