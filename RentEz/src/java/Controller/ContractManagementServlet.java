package Controller;

import DAO.BookingDAO;
import DAO.PropertyDAO;
import DAO.UserDao;
import DAO.NotificationDAO;
import Model.Booking;
import Model.Property;
import Model.User;
import Model.Notification;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling contract management actions (renew, cancel)
 */
@WebServlet(name = "ContractManagementServlet", urlPatterns = {"/contract-management"})
public class ContractManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String bookingIdParam = request.getParameter("bookingId");

        if (action == null || bookingIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                    + URLEncoder.encode("Thiếu thông tin yêu cầu", "UTF-8"));
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdParam);
            BookingDAO bookingDAO = new BookingDAO();
            Booking booking = bookingDAO.getById(bookingId);

            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                        + URLEncoder.encode("Không tìm thấy hợp đồng", "UTF-8"));
                return;
            }

            // Check user permissions
            PropertyDAO propertyDAO = new PropertyDAO();
            Property property = propertyDAO.getById(booking.getPropertyId());

            boolean hasPermission = false;
            if ("Landlord".equals(currentUser.getRole()) && property != null
                    && property.getLandlordId() == currentUser.getUserId()) {
                hasPermission = true;
            } else if ("Renter".equals(currentUser.getRole())
                    && booking.getRenterId() == currentUser.getUserId()) {
                hasPermission = true;
            }

            if (!hasPermission) {
                response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                        + URLEncoder.encode("Bạn không có quyền thực hiện thao tác này", "UTF-8"));
                return;
            }

            switch (action) {
                case "renew":
                    handleRenewal(request, response, booking, currentUser);
                    break;
                case "cancel":
                    handleCancellation(request, response, booking, currentUser);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                            + URLEncoder.encode("Thao tác không hợp lệ", "UTF-8"));
                    break;
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                    + URLEncoder.encode("ID hợp đồng không hợp lệ", "UTF-8"));
        }
    }

    private void handleRenewal(HttpServletRequest request, HttpServletResponse response,
            Booking originalBooking, User currentUser)
            throws ServletException, IOException {

        String newEndDateParam = request.getParameter("newEndDate");
        String renewalTermsParam = request.getParameter("renewalTerms");

        if (newEndDateParam == null || newEndDateParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                    + URLEncoder.encode("Vui lòng chọn ngày kết thúc mới", "UTF-8"));
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date newEndDate = sdf.parse(newEndDateParam);
            Date today = new Date();

            // Validate new end date
            if (newEndDate.before(today)) {
                response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                        + URLEncoder.encode("Ngày kết thúc mới phải sau ngày hiện tại", "UTF-8"));
                return;
            }

            if (newEndDate.before(originalBooking.getEndDate())) {
                response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                        + URLEncoder.encode("Ngày kết thúc mới phải sau ngày kết thúc hiện tại", "UTF-8"));
                return;
            }

            // Create renewal booking
            BookingDAO bookingDAO = new BookingDAO();
            Booking renewalBooking = new Booking();

            // Copy data from original booking
            renewalBooking.setRenterId(originalBooking.getRenterId());
            renewalBooking.setPropertyId(originalBooking.getPropertyId());
            renewalBooking.setStartDate(originalBooking.getEndDate()); // Start from old end date
            renewalBooking.setEndDate(newEndDate);
            renewalBooking.setMonthlyRent(originalBooking.getMonthlyRent());
            renewalBooking.setDepositAmount(0); // No additional deposit for renewal

            // Calculate new total price
            long diffTime = newEndDate.getTime() - originalBooking.getEndDate().getTime();
            long diffMonths = diffTime / (24 * 60 * 60 * 1000 * 30); // Approximate months
            if (diffMonths == 0) {
                diffMonths = 1; // Minimum 1 month
            }
            double totalPrice = renewalBooking.getMonthlyRent() * (-diffMonths);
            renewalBooking.setTotalPrice(totalPrice);

            renewalBooking.setStatus("Pending");
            renewalBooking.setPenaltyClause(originalBooking.getPenaltyClause());

            // Set renewal terms
            String terms = renewalTermsParam != null && !renewalTermsParam.trim().isEmpty()
                    ? renewalTermsParam : "Gia hạn hợp đồng thuê nhà";
            renewalBooking.setTermsAndConditions(terms);

            renewalBooking.setCreatedAt(new Date());
            renewalBooking.setSignedByRenter(false);
            renewalBooking.setSignedByLandlord(false);

            boolean success = bookingDAO.insert(renewalBooking);

            if (success) {
                // Update original booking status to indicate renewal
                originalBooking.setStatus("Renewed");
                bookingDAO.update(originalBooking);

                // Create notifications
                createRenewalNotifications(renewalBooking, currentUser);

                response.sendRedirect(request.getContextPath() + "/view-contracts?success="
                        + URLEncoder.encode("Gia hạn hợp đồng thành công! Hợp đồng mới đang chờ ký kết.", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                        + URLEncoder.encode("Lỗi khi gia hạn hợp đồng", "UTF-8"));
            }

        } catch (ParseException e) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                    + URLEncoder.encode("Định dạng ngày không hợp lệ", "UTF-8"));
        }
    }

    private void handleCancellation(HttpServletRequest request, HttpServletResponse response,
            Booking booking, User currentUser)
            throws ServletException, IOException {

        String reason = request.getParameter("cancellationReason");
        if (reason == null || reason.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                    + URLEncoder.encode("Vui lòng nhập lý do hủy hợp đồng", "UTF-8"));
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        booking.setStatus("Cancelled");

        // Update terms to include cancellation reason
        String updatedTerms = booking.getTermsAndConditions()
                + "\n\nLý do hủy: " + reason
                + "\nNgày hủy: " + new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date())
                + "\nNgười hủy: " + currentUser.getName();
        booking.setTermsAndConditions(updatedTerms);

        boolean success = bookingDAO.update(booking);

        if (success) {
            // Create notifications
            createCancellationNotifications(booking, currentUser, reason);

            response.sendRedirect(request.getContextPath() + "/view-contracts?success="
                    + URLEncoder.encode("Hợp đồng đã được hủy thành công", "UTF-8"));
        } else {
            response.sendRedirect(request.getContextPath() + "/view-contracts?error="
                    + URLEncoder.encode("Lỗi khi hủy hợp đồng", "UTF-8"));
        }
    }

    private void createRenewalNotifications(Booking renewalBooking, User actionUser) {
        try {
            NotificationDAO notificationDAO = new NotificationDAO();
            UserDao userDAO = new UserDao();
            PropertyDAO propertyDAO = new PropertyDAO();

            Property property = propertyDAO.getById(renewalBooking.getPropertyId());
            User renter = userDAO.getById(renewalBooking.getRenterId());
            User landlord = property != null ? userDAO.getById(property.getLandlordId()) : null;

            if (property != null && renter != null && landlord != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                String endDateString = sdf.format(renewalBooking.getEndDate());

                if ("Landlord".equals(actionUser.getRole())) {
                    // Landlord initiated renewal, notify renter
                    Notification renterNotif = new Notification();
                    renterNotif.setUserId(renter.getUserId());
                    renterNotif.setMessage("Chủ nhà đã tạo hợp đồng gia hạn cho bất động sản "
                            + property.getTitle() + " đến ngày " + endDateString + ". Vui lòng xem xét và ký kết.");
                    renterNotif.setSentDate(new Date());
                    renterNotif.setIsRead(false);
                    renterNotif.setReferenceId(renewalBooking.getBookingId());
                    renterNotif.setReferenceType("Booking");
                    notificationDAO.insert(renterNotif);
                } else {
                    // Renter initiated renewal, notify landlord
                    Notification landlordNotif = new Notification();
                    landlordNotif.setUserId(landlord.getUserId());
                    landlordNotif.setMessage("Người thuê " + renter.getName()
                            + " đã tạo yêu cầu gia hạn hợp đồng cho bất động sản "
                            + property.getTitle() + " đến ngày " + endDateString + ". Vui lòng xem xét và ký kết.");
                    landlordNotif.setSentDate(new Date());
                    landlordNotif.setIsRead(false);
                    landlordNotif.setReferenceId(renewalBooking.getBookingId());
                    landlordNotif.setReferenceType("Booking");
                    notificationDAO.insert(landlordNotif);
                }
            }
        } catch (Exception e) {
            System.out.println("Error creating renewal notifications: " + e.getMessage());
        }
    }

    private void createCancellationNotifications(Booking booking, User actionUser, String reason) {
        try {
            NotificationDAO notificationDAO = new NotificationDAO();
            UserDao userDAO = new UserDao();
            PropertyDAO propertyDAO = new PropertyDAO();

            Property property = propertyDAO.getById(booking.getPropertyId());
            User renter = userDAO.getById(booking.getRenterId());
            User landlord = property != null ? userDAO.getById(property.getLandlordId()) : null;

            if (property != null && renter != null && landlord != null) {
                if ("Landlord".equals(actionUser.getRole())) {
                    // Landlord cancelled, notify renter
                    Notification renterNotif = new Notification();
                    renterNotif.setUserId(renter.getUserId());
                    renterNotif.setMessage("Chủ nhà đã hủy hợp đồng thuê bất động sản "
                            + property.getTitle() + ". Lý do: " + reason);
                    renterNotif.setSentDate(new Date());
                    renterNotif.setIsRead(false);
                    renterNotif.setReferenceId(booking.getBookingId());
                    renterNotif.setReferenceType("Booking");
                    notificationDAO.insert(renterNotif);
                } else {
                    // Renter cancelled, notify landlord
                    Notification landlordNotif = new Notification();
                    landlordNotif.setUserId(landlord.getUserId());
                    landlordNotif.setMessage("Người thuê " + renter.getName()
                            + " đã hủy hợp đồng thuê bất động sản "
                            + property.getTitle() + ". Lý do: " + reason);
                    landlordNotif.setSentDate(new Date());
                    landlordNotif.setIsRead(false);
                    landlordNotif.setReferenceId(booking.getBookingId());
                    landlordNotif.setReferenceType("Booking");
                    notificationDAO.insert(landlordNotif);
                }
            }
        } catch (Exception e) {
            System.out.println("Error creating cancellation notifications: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
