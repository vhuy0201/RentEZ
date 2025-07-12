package Controller;

import DAO.LocationDAO;
import DAO.PropertyDAO;
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

@WebServlet(name = "EditPropertyServlet", urlPatterns = {"/editProperty"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditPropertyServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập và vai trò landlord
        HttpSession session = request.getSession(false);

        // Lấy propertyId từ query parameter
        String propertyIdStr = request.getParameter("propertyId");
        if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Không tìm thấy bất động sản.");
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
            return;
        }

        int propertyId;
        try {
            propertyId = Integer.parseInt(propertyIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID bất động sản không hợp lệ.");
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin bất động sản
        PropertyDAO propertyDAO = new PropertyDAO();
        Property property = propertyDAO.getById(propertyId);
        if (property == null) {
            request.setAttribute("error", "Không tìm thấy bất động sản.");
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user.getUserId() != property.getLandlordId()) {
            request.setAttribute("error", "Bạn không có quyền chỉnh sửa bất động sản này.");
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin vị trí
        LocationDAO locationDAO = new LocationDAO();
        Location location = locationDAO.getById(property.getLocationId());
        if (location == null) {
            request.setAttribute("error", "Không tìm thấy thông tin vị trí của bất động sản.");
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
            return;
        }

        // Đưa dữ liệu vào request để hiển thị trên form
        request.setAttribute("property", property);
        request.setAttribute("location", location);
        request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            HttpSession session = request.getSession(false);

            User user = (User) session.getAttribute("user");
            String propertyIdStr = request.getParameter("propertyId");
            if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Không tìm thấy bất động sản.");
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            int propertyId;
            try {
                propertyId = Integer.parseInt(propertyIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID bất động sản không hợp lệ.");
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            PropertyDAO propertyDAO = new PropertyDAO();
            Property existingProperty = propertyDAO.getById(propertyId);
            if (existingProperty == null) {
                request.setAttribute("error", "Không tìm thấy bất động sản.");
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            // Lấy thông tin từ form
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String typeIdStr = request.getParameter("typeId");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String stateProvince = request.getParameter("stateProvince");
            String country = request.getParameter("country");
            String zipCode = request.getParameter("ZipCode");
            String priceStr = request.getParameter("price");
            String sizeStr = request.getParameter("size");
            String numberOfBedroomsStr = request.getParameter("numberOfBedrooms");
            String numberOfBathroomsStr = request.getParameter("numberOfBathrooms");
            String availabilityStatus = request.getParameter("availabilityStatus");
            String priorityLevelStr = request.getParameter("priorityLevel");

            // Kiểm tra các trường bắt buộc
            if (title == null || title.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || typeIdStr == null || typeIdStr.trim().isEmpty()
                    || address == null || address.trim().isEmpty()
                    || city == null || city.trim().isEmpty()
                    || stateProvince == null || stateProvince.trim().isEmpty()
                    || country == null || country.trim().isEmpty()
                    || priceStr == null || priceStr.trim().isEmpty()
                    || sizeStr == null || sizeStr.trim().isEmpty()
                    || numberOfBedroomsStr == null || numberOfBedroomsStr.trim().isEmpty()
                    || numberOfBathroomsStr == null || numberOfBathroomsStr.trim().isEmpty()
                    || availabilityStatus == null || availabilityStatus.trim().isEmpty()
                    || priorityLevelStr == null || priorityLevelStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
                request.setAttribute("property", existingProperty);
                LocationDAO locationDAO = new LocationDAO();
                request.setAttribute("location", locationDAO.getById(existingProperty.getLocationId()));
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi các giá trị số
            int typeId, numberOfBedrooms, numberOfBathrooms, priorityLevel, zipCodeValue;
            double price, size;
            try {
                typeId = Integer.parseInt(typeIdStr);
                zipCodeValue = zipCode != null && !zipCode.trim().isEmpty() ? Integer.parseInt(zipCode) : 0;
                price = Double.parseDouble(priceStr);
                size = Double.parseDouble(sizeStr);
                numberOfBedrooms = Integer.parseInt(numberOfBedroomsStr);
                numberOfBathrooms = Integer.parseInt(numberOfBathroomsStr);
                priorityLevel = Integer.parseInt(priorityLevelStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Định dạng số không hợp lệ (giá, diện tích, mã bưu điện, v.v.).");
                request.setAttribute("property", existingProperty);
                LocationDAO locationDAO = new LocationDAO();
                request.setAttribute("location", locationDAO.getById(existingProperty.getLocationId()));
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            // Kiểm tra giá trị hợp lệ
            if (typeId <= 0 || price < 0 || size < 0 || numberOfBedrooms < 0 || numberOfBathrooms < 0 || priorityLevel < 0) {
                request.setAttribute("error", "Các trường số phải là giá trị dương.");
                request.setAttribute("property", existingProperty);
                LocationDAO locationDAO = new LocationDAO();
                request.setAttribute("location", locationDAO.getById(existingProperty.getLocationId()));
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            if (!availabilityStatus.equals("Available") && !availabilityStatus.equals("Rented") && !availabilityStatus.equals("Not Available")) {
                request.setAttribute("error", "Trạng thái không hợp lệ.");
                request.setAttribute("property", existingProperty);
                LocationDAO locationDAO = new LocationDAO();
                request.setAttribute("location", locationDAO.getById(existingProperty.getLocationId()));
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            // Cập nhật Location
            Location location = new Location();
            location.setLocationId(existingProperty.getLocationId());
            location.setAddress(address);
            location.setCity(city);
            location.setStateProvince(stateProvince);
            location.setCountry(country);
            location.setZipCode(zipCode);

            LocationDAO locationDAO = new LocationDAO();
            boolean locationSuccess = locationDAO.update(location);
            if (!locationSuccess) {
                request.setAttribute("error", "Không thể cập nhật vị trí.");
                request.setAttribute("property", existingProperty);
                request.setAttribute("location", location);
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
                return;
            }

            // Cập nhật Property
            Property property = new Property();
            property.setPropertyId(propertyId);
            property.setTitle(title);
            property.setDescription(description);
            property.setTypeId(typeId);
            property.setLocationId(existingProperty.getLocationId());
            property.setLandlordId(user.getUserId());
            property.setPrice(price);
            property.setSize(size);
            property.setNumberOfBedrooms(numberOfBedrooms);
            property.setNumberOfBathrooms(numberOfBathrooms);
            property.setAvailabilityStatus(availabilityStatus);
            property.setPriorityLevel(priorityLevel);
            
            // Handle image upload - keep existing image if no new image is uploaded
            String imagePath = handleFileUpload(request);
            if (imagePath != null) {
                property.setAvatar(imagePath);
            } else {
                property.setAvatar(existingProperty.getAvatar()); // Keep existing avatar
            }

            boolean propertySuccess = propertyDAO.update(property);
            if (propertySuccess) {
                session.setAttribute("successMessage", "Cập nhật bất động sản thành công!");
                response.sendRedirect("viewProperties");
            } else {
                request.setAttribute("error", "Không thể cập nhật bất động sản.");
                request.setAttribute("property", property);
                request.setAttribute("location", location);
                request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Log lỗi chi tiết để debug
            e.printStackTrace();
            PropertyDAO propertyDAO = new PropertyDAO();
            String propertyIdStr = request.getParameter("propertyId");
            int propertyId = Integer.parseInt(propertyIdStr); // Đã kiểm tra trước đó nên không cần try-catch lại
            Property existingProperty = propertyDAO.getById(propertyId);
            LocationDAO locationDAO = new LocationDAO();
            Location location = locationDAO.getById(existingProperty.getLocationId());

            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.setAttribute("property", existingProperty);
            request.setAttribute("location", location);
            request.getRequestDispatcher("/view/landlord/page/editProperty.jsp").forward(request, response);
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
        return "Edit Property Servlet xử lý chỉnh sửa thông tin bất động sản.";
    }
}
