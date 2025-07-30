package Controller;

import DAO.BookingDAO;
import DAO.LocationDAO;
import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import DAO.WalletDAO;
import DAO.PaymentDAO;
import DAO.PropertyImageDAO;
import DAO.WalletTransferDao;
import DAO.UserTierDAO;
import DAO.TierDAO;
import Model.Booking;
import Model.Location;
import Model.Property;
import Model.PropertyType;
import Model.User;
import Model.UserTier;
import Model.Tier;
import Model.Wallet;
import Model.Payment;
import Model.WalletTransfer;
import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.Timestamp;

@WebServlet(name = "AddPropertiesServlet", urlPatterns = {"/addProperty"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 4, // 4MB
        maxFileSize = 1024 * 1024 * 20, // 20MB
        maxRequestSize = 1024 * 1024 * 100)   // 100MB
public class AddPropertyServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        // Load property types from database
        loadPropertyTypes(request);

        // Load current user's tier information
        if (currentUser != null) {
            loadUserTierInfo(request, currentUser);
        }

        request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
    }

    /**
     * Helper method to load property types from database
     */
    private void loadPropertyTypes(HttpServletRequest request) {
        PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
        List<PropertyType> propertyTypes = propertyTypeDAO.getAllActive(); // Chỉ lấy các loại đang hoạt động
        request.setAttribute("propertyTypes", propertyTypes);
    }

    /**
     * Helper method to load current user's tier information
     */
    private void loadUserTierInfo(HttpServletRequest request, User currentUser) {
        try {
            UserTierDAO userTierDAO = new UserTierDAO();
            TierDAO tierDAO = new TierDAO();

            // Get current user's tier
            UserTier currentUserTier = userTierDAO.getCurrentUserTier(currentUser.getUserId());
            Tier currentTier = null;

            if (currentUserTier != null) {
                currentTier = tierDAO.getById(currentUserTier.getTierId());
            }

            // Set attributes for JSP
            request.setAttribute("currentUserTier", currentUserTier);
            request.setAttribute("currentTier", currentTier);

        } catch (Exception e) {
            System.err.println("Error loading user tier info: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get session to retrieve LandlordID
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try {

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

            String aiGenImage1 = request.getParameter("aiGenImage1");
            String aiGenImage2 = request.getParameter("aiGenImage2");
            String aiGenImage3 = request.getParameter("aiGenImage3");

            // Handle avatar image upload
            String avatarPath = handleAvatarUpload(request);
            if (avatarPath == null) {
                request.setAttribute("error", "Failed to upload property avatar image. Please try again.");
                loadPropertyTypes(request);
                loadUserTierInfo(request, user);
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                return;
            }

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
                loadPropertyTypes(request); // Load property types for the form
                loadUserTierInfo(request, user);
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
            property.setPublicStatus(false);
            property.setAvatar(avatarPath);

            // Insert the property using PropertyDAO
            PropertyDAO propertyDAO = new PropertyDAO();
            int propertyId = propertyDAO.addProperty(property);

            // Set response message
            if (propertyId == -1) {
                request.setAttribute("error", "Failed to add property. Please try again.");
                loadPropertyTypes(request); // Load property types for the form
                loadUserTierInfo(request, user);
                request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                return;
            }

            if (propertyId != -1) {
                List<String> aiImageUrls = new ArrayList<>();
                if (aiGenImage1 != null && !aiGenImage1.isEmpty()) {
                    aiImageUrls.add(aiGenImage1);
                }
                if (aiGenImage2 != null && !aiGenImage2.isEmpty()) {
                    aiImageUrls.add(aiGenImage2);
                }
                if (aiGenImage3 != null && !aiGenImage3.isEmpty()) {
                    aiImageUrls.add(aiGenImage3);
                }
                if (!aiImageUrls.isEmpty()) {
                    PropertyImageDAO propertyImageDAO = new PropertyImageDAO();
                    boolean imagesInserted = propertyImageDAO.insertMultiple(propertyId, aiImageUrls);
                    if (!imagesInserted) {
                        System.err.println("Warning: Failed to insert AI images for property " + propertyId);
                    }
                }
            }

            // Handle Booking creation if booking parameters are present
            String startDateStr = "2024-01-01";
            String endDateStr = "2024-01-01";
            String totalPriceStr = request.getParameter("totalPrice");
            String depositAmountStr = request.getParameter("depositAmount");
            String monthlyRentStr = request.getParameter("monthlyRent");
            String penaltyClause = request.getParameter("penaltyClause");
            String termsAndConditions = request.getParameter("termsAndConditions");

            if (startDateStr != null && !startDateStr.isEmpty()) {
                Booking booking = new Booking();
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
                boolean bookingSuccess = bookingDAO.addProperty(booking);
                if (!bookingSuccess) {
                    request.setAttribute("error", "Property added, but failed to create associated booking. Please try again.");
                    loadPropertyTypes(request); // Load property types for the form
                    loadUserTierInfo(request, user);
                    request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                    return;
                }

                // Xử lý phí hệ thống 10% khi có booking
                try {
                    boolean feeProcessed = processSystemFee(booking.getTotalPrice(), propertyId, user);
                    if (!feeProcessed) {
                        request.setAttribute("error", "You do not have enough money to pay 10% service");
                        loadPropertyTypes(request); // Load property types for the form
                        loadUserTierInfo(request, user);
                        request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
                        return;
                    }
                } catch (Exception e) {
                    System.out.println("Warning: Exception during system fee processing: " + e.getMessage());
                }
            }
            session.setAttribute("successMessage", "Property added successfully!");
            response.sendRedirect(request.getContextPath() + "/viewProperties");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your inputs.");
            loadPropertyTypes(request); // Load property types for the form
            loadUserTierInfo(request, user);
            request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            loadPropertyTypes(request); // Load property types for the form
            loadUserTierInfo(request, user);
            request.getRequestDispatcher("/view/landlord/page/addProperty.jsp").forward(request, response);
        }
    }

    /**
     * Handle avatar image upload (single image for thumbnail)
     */
    private String handleAvatarUpload(HttpServletRequest request) throws IOException, ServletException {
        try {
            CloudinaryService cloudinaryService = CloudinaryService.getInstance();

            // Check if Cloudinary is configured
            if (!cloudinaryService.isConfigured()) {
                System.err.println("Cloudinary is not configured properly");
                return null;
            }

            for (Part part : request.getParts()) {
                if ("avatarImage".equals(part.getName())) {
                    String submittedFileName = part.getSubmittedFileName();
                    if (submittedFileName != null && !submittedFileName.isEmpty()) {
                        try {
                            // Upload to Cloudinary with avatar folder
                            String cloudinaryUrl = cloudinaryService.uploadAvatarImage(part.getInputStream(), submittedFileName);
                            return cloudinaryUrl;
                        } catch (Exception e) {
                            System.err.println("Error uploading avatar to Cloudinary: " + e.getMessage());
                            return null;
                        }
                    }
                }
            }
            return null;
        } catch (Exception e) {
            System.err.println("Error in handleAvatarUpload: " + e.getMessage());
            return null;
        }
    }

    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        try {
            CloudinaryService cloudinaryService = CloudinaryService.getInstance();

            // Check if Cloudinary is configured
            if (!cloudinaryService.isConfigured()) {
                System.err.println("Cloudinary is not configured properly");
                return null;
            }

            for (Part part : request.getParts()) {
                if ("propertyImage".equals(part.getName())) {
                    String submittedFileName = part.getSubmittedFileName();
                    if (submittedFileName != null && !submittedFileName.isEmpty()) {
                        try {
                            // Upload to Cloudinary
                            String cloudinaryUrl = cloudinaryService.uploadPropertyImage(part.getInputStream(), submittedFileName);
                            return cloudinaryUrl;
                        } catch (Exception e) {
                            System.err.println("Error uploading to Cloudinary: " + e.getMessage());
                            return null;
                        }
                    }
                }
            }
            return null;
        } catch (Exception e) {
            System.err.println("Error in handleFileUpload: " + e.getMessage());
            return null;
        }
    }

    /**
     * Process system fee transfer when booking is created Takes 10% of total
     * price and transfers to system account (userId 3)
     */
    private boolean processSystemFee(double totalPrice, int propertyId, User landlord) {

        try {
            double systemFeeAmount = totalPrice * 0.10; // 10% phí hệ thống
            int systemUserId = 3; // ID của hệ thống

            // Lấy wallet của hệ thống
            WalletDAO walletDAO = new WalletDAO();
            Wallet systemWallet = walletDAO.getWalletByUserId(systemUserId);
            Wallet landlordWallet = walletDAO.getWalletByUserId(landlord.getUserId());
            // Tạo wallet cho hệ thống nếu chưa có
            if (systemWallet == null) {
                systemWallet = new Wallet();
                systemWallet.setUserId(systemUserId);
                systemWallet.setBalance(systemFeeAmount);
                systemWallet.setLastUpdated(new Date());
                walletDAO.create(systemWallet);
            } else {
                // Cập nhật số dư hệ thống
                double newBalanceLandlord = landlordWallet.getBalance() - systemFeeAmount;
                if (newBalanceLandlord < 0) {
                    return false;
                } else {
                    walletDAO.updateBalance(systemUserId, newBalanceLandlord);
                    double newBalanceSystem = systemWallet.getBalance() + systemFeeAmount;
                    walletDAO.updateBalance(systemUserId, newBalanceSystem);
                }
            }

            // Tạo bản ghi WalletTransfer
            WalletTransfer transfer = new WalletTransfer();
            transfer.setUserID(systemUserId);
            transfer.setAmount(systemFeeAmount);
            transfer.setTransCode("SYS_FEE_" + System.currentTimeMillis());
            transfer.setTimeCode(String.valueOf(System.currentTimeMillis()));
            transfer.setContent("Phí hệ thống 10% từ property ID: " + propertyId + " của landlord: " + landlord.getName());
            transfer.setIsRefunded(false);

            WalletTransferDao transferDao = new WalletTransferDao();
            boolean transferSuccess = transferDao.create(transfer);

            // Tạo bản ghi Payment để theo dõi
            Payment payment = new Payment();
            payment.setPayerId(landlord.getUserId());
            payment.setPayeeId(systemUserId);
            payment.setAmount(-systemFeeAmount);
            payment.setPaymentDate(new Date());
            payment.setPaymentMethod("system_fee");
            payment.setStatus("Paid");
            payment.setReferenceId(propertyId);
            payment.setReferenceType("Wallet");
            payment.setWalletTransferId(transfer.getWalletTransferID());
            payment.setTransCode(transfer.getTransCode());
            payment.setTimeCode(transfer.getTimeCode());
            payment.setIsRefunded(false);

            PaymentDAO paymentDAO = new PaymentDAO();
            boolean paymentSuccess = paymentDAO.insert(payment);

            return transferSuccess && paymentSuccess;

        } catch (Exception e) {
            System.out.println("Error processing system fee: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String getServletInfo() {
        return "Add Property Servlet handles property creation with type, location, and landlord details.";
    }
}
