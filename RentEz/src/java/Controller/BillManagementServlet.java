package Controller;

import DAO.BillDAO;
import DAO.BillDetailDAO;
import DAO.FeeCategoryDAO;
import DAO.BookingDAO;
import DAO.PropertyDAO;
import DAO.LocationDAO;
import DAO.UsersDao;
import Model.Bill;
import Model.BillDetail;
import Model.FeeCategory;
import Model.Booking;
import Model.Property;
import Model.Location;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "BillManagementServlet", urlPatterns = {"/billManagement"})
public class BillManagementServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAO();
    private BillDetailDAO billDetailDAO = new BillDetailDAO();
    private FeeCategoryDAO feeCategoryDAO = new FeeCategoryDAO();
    private BookingDAO bookingDAO = new BookingDAO();
    private PropertyDAO propertyDAO = new PropertyDAO();
    private LocationDAO locationDAO = new LocationDAO();
    private UsersDao usersDao = new UsersDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listBills(request, response, currentUser.getUserId());
                    break;
                case "view":
                    viewBill(request, response);
                    break;
                case "create":
                    showCreateBillForm(request, response, currentUser.getUserId());
                    break;
                case "edit":
                    showEditBillForm(request, response);
                    break;
                case "delete":
                    deleteBill(request, response);
                    break;
                case "generate":
                    generateMonthlyBills(request, response, currentUser.getUserId());
                    break;
                default:
                    listBills(request, response, currentUser.getUserId());
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/view/landlord/page/billManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "create";
        }

        try {
            switch (action) {
                case "create":
                    createBill(request, response);
                    break;
                case "update":
                    updateBill(request, response);
                    break;
                case "updateStatus":
                    updateBillStatus(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/billManagement");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/view/landlord/page/billManagement.jsp").forward(request, response);
        }
    }

    private void listBills(HttpServletRequest request, HttpServletResponse response, int landlordId)
            throws ServletException, IOException {
        List<Bill> bills = billDAO.getBillsForLandlord(landlordId);
        List<Bill> overdueBills = billDAO.getOverdueBills(landlordId);

        // Populate additional details for bills
        populateBillDetails(bills);
        populateBillDetails(overdueBills);

        // Calculate statistics
        int totalBills = bills.size();
        int paidBills = (int) bills.stream().filter(b -> "Paid".equals(b.getStatus())).count();
        int pendingBills = (int) bills.stream().filter(b -> "Pending".equals(b.getStatus())).count();
        int overdueBillsCount = overdueBills.size();

        double totalAmount = bills.stream().mapToDouble(Bill::getTotalAmount).sum();
        double paidAmount = bills.stream()
                .filter(b -> "Paid".equals(b.getStatus()))
                .mapToDouble(Bill::getTotalAmount).sum();
        double pendingAmount = bills.stream()
                .filter(b -> "Pending".equals(b.getStatus()))
                .mapToDouble(Bill::getTotalAmount).sum();

        request.setAttribute("bills", bills);
        request.setAttribute("overdueBills", overdueBills);
        request.setAttribute("totalBills", totalBills);
        request.setAttribute("paidBills", paidBills);
        request.setAttribute("pendingBills", pendingBills);
        request.setAttribute("overdueBillsCount", overdueBillsCount);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("paidAmount", paidAmount);
        request.setAttribute("pendingAmount", pendingAmount);

        request.getRequestDispatcher("/view/landlord/page/billManagement.jsp").forward(request, response);
    }

    private void viewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        Bill bill = billDAO.getById(billId);
        
        if (bill != null) {
            // Populate additional details first (Property, Location, User)
            populateBillDetails(bill);
            
            // Get bill details
            List<BillDetail> billDetails = billDetailDAO.getBillDetailByBillId(billId);
            
            // If billDetails exist, populate them with fee category information
            if (billDetails != null && !billDetails.isEmpty()) {
                for (BillDetail detail : billDetails) {
                    FeeCategory category = feeCategoryDAO.getById(detail.getCategoryId());
                    detail.setFeeCategory(category);
                }
                bill.setBillDetails(billDetails);
            } else {
                // If no billDetails exist, create a default one for rent
                Booking booking = bookingDAO.getByPropertyAndRenter(bill.getPropertyId(), bill.getRenterId());
                if (booking != null) {
                    // Set totalAmount based on monthly rent if not already set
                    if (bill.getTotalAmount() == 0) {
                        bill.setTotalAmount(booking.getMonthlyRent());
                    }
                }
            }
        }

        request.setAttribute("bill", bill);
        request.getRequestDispatcher("/view/landlord/page/billDetail.jsp").forward(request, response);
    }

    private void showCreateBillForm(HttpServletRequest request, HttpServletResponse response, int landlordId)
            throws ServletException, IOException {
        // Get active bookings for this landlord
        List<Booking> activeBookings = bookingDAO.getActiveBookingsByLandlordId(landlordId);
        List<FeeCategory> feeCategories = feeCategoryDAO.getAll();

        request.setAttribute("activeBookings", activeBookings);
        request.setAttribute("feeCategories", feeCategories);
        request.getRequestDispatcher("/view/landlord/page/createBill.jsp").forward(request, response);
    }

    private void showEditBillForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));
        Bill bill = billDAO.getById(billId);
        List<BillDetail> billDetails = billDetailDAO.getBillDetailByBillId(billId);
        List<FeeCategory> feeCategories = feeCategoryDAO.getAll();

        if (bill != null) {
            bill.setBillDetails(billDetails);
            // Populate additional details
            populateBillDetails(bill);
        }

        request.setAttribute("bill", bill);
        request.setAttribute("feeCategories", feeCategories);
        request.getRequestDispatcher("/view/landlord/page/editBill.jsp").forward(request, response);
    }

    private void createBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String billingPeriod = request.getParameter("billingPeriod");
        String dueDateStr = request.getParameter("dueDate");

        // Get booking information
        Booking booking = bookingDAO.getById(bookingId);


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dueDate = sdf.parse(dueDateStr);

        // Create bill
        Bill bill = new Bill();
        bill.setPropertyId(booking.getPropertyId());
        bill.setRenterId(booking.getRenterId());
        bill.setBillingPeriod(billingPeriod);
        bill.setDueDate(dueDate);
        bill.setStatus("Pending");

        // Calculate total amount from details
        String[] categoryIds = request.getParameterValues("categoryId");
        String[] usageValues = request.getParameterValues("usageValue");

        double totalAmount = booking.getMonthlyRent(); // Start with monthly rent
        if (categoryIds != null) {
            for (int i = 0; i < categoryIds.length; i++) {
                if (!categoryIds[i].isEmpty() && !usageValues[i].isEmpty()) {
                    int categoryId = Integer.parseInt(categoryIds[i]);
                    double usageValue = Double.parseDouble(usageValues[i]);

                    FeeCategory category = feeCategoryDAO.getById(categoryId);
                    double amount = category.getUnitPrice() * usageValue;
                    totalAmount += amount;
                }
            }
        }

        bill.setTotalAmount(totalAmount);

        if (billDAO.insert(bill)) {
            // Insert bill details
            if (categoryIds != null) {
                for (int i = 0; i < categoryIds.length; i++) {
                    if (!categoryIds[i].isEmpty() && !usageValues[i].isEmpty()) {
                        int categoryId = Integer.parseInt(categoryIds[i]);
                        double usageValue = Double.parseDouble(usageValues[i]);

                        FeeCategory category = feeCategoryDAO.getById(categoryId);
                        double amount = category.getUnitPrice() * usageValue;

                        BillDetail detail = new BillDetail();
                        detail.setBillId(bill.getBillId());
                        detail.setCategoryId(categoryId);
                        detail.setUsageValue(usageValue);
                        detail.setAmount(amount);

                        billDetailDAO.insert(detail);
                    }
                }
            }

            request.getSession().setAttribute("successMessage", "Tạo hóa đơn thành công!");
        } else {
            request.setAttribute("error", "Không thể tạo hóa đơn!");
        }

        response.sendRedirect(request.getContextPath() + "/billManagement");
    }

    private void updateBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        int billId = Integer.parseInt(request.getParameter("billId"));
        String billingPeriod = request.getParameter("billingPeriod");
        String dueDateStr = request.getParameter("dueDate");
        String status = request.getParameter("status");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dueDate = sdf.parse(dueDateStr);

        Bill bill = billDAO.getById(billId);
        if (bill != null) {
            bill.setBillingPeriod(billingPeriod);
            bill.setDueDate(dueDate);
            bill.setStatus(status);

            // Delete existing bill details
            billDetailDAO.deleteByBillId(billId);

            // Calculate total amount from details
            String[] categoryIds = request.getParameterValues("categoryId");
            String[] usageValues = request.getParameterValues("usageValue");

            double totalAmount = 0;
            if (categoryIds != null) {
                for (int i = 0; i < categoryIds.length; i++) {
                    if (!categoryIds[i].isEmpty() && !usageValues[i].isEmpty()) {
                        int categoryId = Integer.parseInt(categoryIds[i]);
                        double usageValue = Double.parseDouble(usageValues[i]);

                        FeeCategory category = feeCategoryDAO.getById(categoryId);
                        double amount = category.getUnitPrice() * usageValue;
                        totalAmount += amount;
                    }
                }
            }

            bill.setTotalAmount(totalAmount);

            if (billDAO.update(bill)) {
                // Insert new bill details
                if (categoryIds != null) {
                    for (int i = 0; i < categoryIds.length; i++) {
                        if (!categoryIds[i].isEmpty() && !usageValues[i].isEmpty()) {
                            int categoryId = Integer.parseInt(categoryIds[i]);
                            double usageValue = Double.parseDouble(usageValues[i]);

                            FeeCategory category = feeCategoryDAO.getById(categoryId);
                            double amount = category.getUnitPrice() * usageValue;

                            BillDetail detail = new BillDetail();
                            detail.setBillId(billId);
                            detail.setCategoryId(categoryId);
                            detail.setUsageValue(usageValue);
                            detail.setAmount(amount);

                            billDetailDAO.insert(detail);
                        }
                    }
                }

                request.getSession().setAttribute("successMessage", "Cập nhật hóa đơn thành công!");
            } else {
                request.setAttribute("error", "Không thể cập nhật hóa đơn!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/billManagement");
    }

    private void updateBillStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("billId"));
        String status = request.getParameter("status");

        Bill bill = billDAO.getById(billId);
        if (bill != null) {
            bill.setStatus(status);
            if (billDAO.update(bill)) {
                request.getSession().setAttribute("successMessage", "Cập nhật trạng thái hóa đơn thành công!");
            } else {
                request.setAttribute("error", "Không thể cập nhật trạng thái hóa đơn!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/billManagement");
    }

    private void deleteBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("id"));

        if (billDAO.delete(billId)) {
            request.getSession().setAttribute("successMessage", "Xóa hóa đơn thành công!");
        } else {
            request.setAttribute("error", "Không thể xóa hóa đơn!");
        }

        response.sendRedirect(request.getContextPath() + "/billManagement");
    }

    private void generateMonthlyBills(HttpServletRequest request, HttpServletResponse response, int landlordId)
            throws ServletException, IOException {
        // Get all active bookings for this landlord
        List<Booking> activeBookings = bookingDAO.getActiveBookingsByLandlordId(landlordId);

        int generatedCount = 0;
        for (Booking booking : activeBookings) {
            if (billDAO.generateMonthlyBills(booking.getPropertyId(), booking.getRenterId(), booking.getMonthlyRent())) {
                generatedCount++;
            }
        }

        if (generatedCount > 0) {
            request.getSession().setAttribute("successMessage",
                    "Đã tạo " + generatedCount + " hóa đơn hàng tháng mới!");
        } else {
            request.getSession().setAttribute("successMessage",
                    "Không có hóa đơn mới nào được tạo (có thể đã tồn tại).");
        }

        response.sendRedirect(request.getContextPath() + "/billManagement");
    }

    /**
     * Helper method to populate Bill objects with Property, Location, and User
     * information
     */
    private void populateBillDetails(List<Bill> bills) {
        for (Bill bill : bills) {
            populateBillDetails(bill);
        }
    }

    private void populateBillDetails(Bill bill) {
        // Get Property information
        Property property = propertyDAO.getById(bill.getPropertyId());
        if (property != null) {
            // Get Location information for address
            Location location = locationDAO.getById(property.getLocationId());
            if (location != null) {
                property.setAddress(location.getAddress());
            }
            bill.setProperty(property);
        }

        // Get Renter information
        User renter = usersDao.getById(bill.getRenterId());
        if (renter != null) {
            bill.setRenterName(renter.getName());
        }
    }
}
