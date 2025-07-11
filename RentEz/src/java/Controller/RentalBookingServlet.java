package Controller;

import DAO.BookingDAO;
import DAO.PropertyDAO;
import DAO.NotificationDAO;
import Model.Booking;
import Model.Property;
import Model.User;
import Model.Notification;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Calendar;

public class RentalBookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String propertyDetailUrl = request.getContextPath() + "/property-detail?id=" + request.getParameter("propertyId");
        String message = "";

        if (currentUser == null) {
            message = "Vui lòng đăng nhập để thực hiện thuê nhà.";
            response.sendRedirect(request.getContextPath() + "/login?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }

        try {
            // Get and validate parameters
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            int landlordId = Integer.parseInt(request.getParameter("landlordId"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String depositAmountStr = request.getParameter("depositAmount");
            String monthlyRentStr = request.getParameter("monthlyRent");
            String totalPriceStr = request.getParameter("totalPrice");
            String termsAndConditions = request.getParameter("termsAndConditions");
            String penaltyClause = request.getParameter("penaltyClause");
            boolean signedByRenter = "true".equals(request.getParameter("signedByRenter"));
            boolean signedByLandlord = "true".equals(request.getParameter("signedByLandlord"));

            // Validate required fields
            if (startDateStr == null || startDateStr.isEmpty()) {
                message = "Ngày bắt đầu thuê không được để trống.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            if (endDateStr == null || endDateStr.isEmpty()) {
                message = "Ngày kết thúc thuê không được để trống.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            if (depositAmountStr == null || depositAmountStr.isEmpty()) {
                message = "Tiền cọc không được để trống.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            if (!signedByRenter) {
                message = "Bạn cần xác nhận đồng ý với hợp đồng thuê nhà.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            // Parse dates
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = dateFormat.parse(startDateStr);
            Date endDate = dateFormat.parse(endDateStr);

            // Validate dates
            Date currentDate = new Date();
            if (startDate.before(currentDate)) {
                message = "Ngày bắt đầu thuê không thể trong quá khứ.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            if (endDate.before(startDate) || endDate.equals(startDate)) {
                message = "Ngày kết thúc phải sau ngày bắt đầu.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            Calendar calStart = Calendar.getInstance();
            calStart.setTime(startDate);

            Calendar calEnd = Calendar.getInstance();
            calEnd.setTime(endDate);

            if (calStart.get(Calendar.YEAR) == calEnd.get(Calendar.YEAR)
                    && calStart.get(Calendar.MONTH) == calEnd.get(Calendar.MONTH)) {
                message = "Phải đặt ít nhất 2 tháng.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            // Parse amounts
            double depositAmount = Double.parseDouble(depositAmountStr);
            double monthlyRent = Double.parseDouble(monthlyRentStr);
            double totalPrice = Double.parseDouble(totalPriceStr);

            if (depositAmount <= 0) {
                message = "Tiền cọc phải lớn hơn 0.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            // Check if property exists and is available
            PropertyDAO propertyDAO = new PropertyDAO();
            Property property = propertyDAO.getById(propertyId);

            if (property == null) {
                message = "Không tìm thấy thông tin bất động sản.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            if (!"Available".equals(property.getAvailabilityStatus())) {
                message = "Bất động sản này hiện không có sẵn để thuê.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            // Check if user is trying to rent their own property
            if (property.getLandlordId() == currentUser.getUserId()) {
                message = "Bạn không thể thuê bất động sản của chính mình.";
                redirectWithMessage(response, propertyDetailUrl, message);
                return;
            }

            // Create new booking
            Booking booking = new Booking();
            booking.setRenterId(currentUser.getUserId());
            booking.setPropertyId(propertyId);
            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            booking.setTotalPrice(totalPrice);
            booking.setStatus("Pending"); // Initial status
            booking.setDepositAmount(depositAmount);
            booking.setMonthlyRent(monthlyRent);
            booking.setPenaltyClause(penaltyClause);
            booking.setTermsAndConditions(termsAndConditions);
            booking.setCreatedAt(new Date());
            booking.setSignedAt(new Date());
            booking.setSignedByRenter(signedByRenter);
            booking.setSignedByLandlord(signedByLandlord);

            // Save booking
            BookingDAO bookingDAO = new BookingDAO();
            boolean success = bookingDAO.insert(booking);

            if (success) {
                // Create notification for landlord
                try {
                    NotificationDAO notificationDAO = new NotificationDAO();
                    Notification notification = new Notification();
                    notification.setUserId(landlordId);
                    notification.setMessage("Bạn có yêu cầu thuê nhà mới cho bất động sản: " + property.getTitle());
                    notification.setReferenceType("Booking");
                    notification.setReferenceId(booking.getBookingId());
                    notification.setSentDate(new Date());
                    notification.setIsRead(false);

                    notificationDAO.insert(notification);
                } catch (Exception e) {
                    // Log error but don't fail the main operation
                    System.out.println("Error creating notification: " + e.getMessage());
                }

                message = "Gửi yêu cầu thuê nhà thành công! Chúng tôi sẽ liên hệ với bạn sớm nhất.";
                redirectWithMessage(response, propertyDetailUrl, message);
            } else {
                message = "Có lỗi xảy ra khi gửi yêu cầu thuê nhà. Vui lòng thử lại.";
                redirectWithMessage(response, propertyDetailUrl, message);
            }

        } catch (ParseException e) {
            message = "Định dạng ngày không hợp lệ.";
            redirectWithMessage(response, propertyDetailUrl, message);
        } catch (NumberFormatException e) {
            message = "Giá trị số không hợp lệ.";
            redirectWithMessage(response, propertyDetailUrl, message);
        } catch (Exception e) {
            System.out.println("Error in RentalBookingServlet: " + e.getMessage());
            e.printStackTrace();
            message = "Có lỗi xảy ra. Vui lòng thử lại sau.";
            redirectWithMessage(response, propertyDetailUrl, message);
        }
    }

    private void redirectWithMessage(HttpServletResponse response, String url, String message) throws IOException {
        String encodedMessage = URLEncoder.encode(message, "UTF-8");
        response.sendRedirect(url + "&message=" + encodedMessage);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to POST method
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling rental booking requests";
    }
}
