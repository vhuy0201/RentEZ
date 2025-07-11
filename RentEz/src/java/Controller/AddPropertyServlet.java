package Controller;

import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.PropertyDAO;
import Model.Booking;
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
            // Xử lý upload ảnh chính
            Part mainImagePart = request.getPart("mainImage");
            String avatarPath = null;
            
            // Debug: In ra thông tin về file upload
            System.out.println("=== DEBUG IMAGE UPLOAD ===");
            System.out.println("mainImagePart: " + mainImagePart);
            if (mainImagePart != null) {
                System.out.println("File name: " + mainImagePart.getSubmittedFileName());
                System.out.println("File size: " + mainImagePart.getSize());
                System.out.println("Content type: " + mainImagePart.getContentType());
            }
            
            if (mainImagePart != null && mainImagePart.getSize() > 0) {
                try {
                    // Lấy tên file gốc
                    String fileName = Paths.get(mainImagePart.getSubmittedFileName()).getFileName().toString();
                    System.out.println("Original file name: " + fileName);
                    
                    // Đặt tên file duy nhất để tránh trùng
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    System.out.println("Unique file name: " + uniqueFileName);
                    
                    // Đường dẫn lưu file trên server
                    String uploadDir = getServletContext().getRealPath("/") + "view/guest/asset/img";
                    File dir = new File(uploadDir);
                    if (!dir.exists()) {
                        boolean created = dir.mkdirs();
                        System.out.println("Created upload directory: " + created);
                    }
                    System.out.println("Upload directory: " + uploadDir);
                    
                    // Lưu file
                    String filePath = uploadDir + File.separator + uniqueFileName;
                    System.out.println("Full file path: " + filePath);
                    mainImagePart.write(filePath);
                    
                    // Kiểm tra file đã được lưu
                    File savedFile = new File(filePath);
                    System.out.println("File saved successfully: " + savedFile.exists());
                    System.out.println("File size on disk: " + savedFile.length());
                    
                    // Đường dẫn để lưu vào DB (tương đối để show lên web)
                    avatarPath = "view/guest/asset/img/" + uniqueFileName;
                    System.out.println("Avatar path for DB: " + avatarPath);
                } catch (Exception e) {
                    System.out.println("Error saving image: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("No image uploaded or image is empty");
            }
            System.out.println("Final avatarPath: " + avatarPath);
            System.out.println("=== END DEBUG IMAGE UPLOAD ===");
            
            property.setAvatar(avatarPath);

            // Insert the property using PropertyDAO
            PropertyDAO propertyDAO = new PropertyDAO();
            int propertyId = propertyDAO.addProperty(property);

            // Set response message
            if (propertyId <= 0) {
                request.setAttribute("error", "Failed to add property. Please try again.");
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                return;
            }
            
            System.out.println("Property added successfully with ID: " + propertyId); // Debug log

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
