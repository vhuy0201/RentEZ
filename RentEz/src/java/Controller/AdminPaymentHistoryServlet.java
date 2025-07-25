package Controller;

import java.io.IOException;
import java.util.List;

import DAO.PaymentDAO;
import DAO.UsersDao;
import Model.User;
import Model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminPaymentHistoryServlet", urlPatterns = {"/admin/payment-history", "/admin/payment-action"})
public class AdminPaymentHistoryServlet extends HttpServlet {
    
    private PaymentDAO paymentDAO;
    private UsersDao userDAO;
    
    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
        userDAO = new UsersDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        String servletPath = request.getServletPath();
        
        if ("/admin/payment-history".equals(servletPath)) {
            showPaymentHistory(request, response);
        } else if ("/admin/payment-action".equals(servletPath)) {
            String action = request.getParameter("action");
            System.out.println("Payment action: " + action);
            if (action != null) {
                switch (action) {
                    case "view-detail":
                        viewPaymentDetail(request, response);
                        break;
                    case "print-detail":
                        printPaymentDetail(request, response);
                        break;
                    default:
                        System.out.println("Unknown action: " + action);
                        response.sendRedirect(request.getContextPath() + "/admin/payment-history");
                }
            } else {
                System.out.println("No action parameter provided");
                response.sendRedirect(request.getContextPath() + "/admin/payment-history");
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "view-detail":
                    viewPaymentDetail(request, response);
                    break;
                case "refund":
                    processRefund(request, response);
                    break;
//                case "export":
//                    exportPaymentHistory(request, response);
//                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/payment-history");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/payment-history?error=1");
        }
    }
    
    private void showPaymentHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get filter parameters
            String search = request.getParameter("search");
            String statusFilter = request.getParameter("status");
            String typeFilter = request.getParameter("type");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            
            // Get pagination parameters
            int page = 1;
            int pageSize = 15;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            // Get filtered payments
            List<Payment> payments = paymentDAO.getFilteredPayments(search, statusFilter, typeFilter, 
                                                                   dateFrom, dateTo, page, pageSize);
            
            // Map User information to each payment based on PayerId
            for (Payment payment : payments) {
                User payer = userDAO.getById(payment.getPayerId());
                if (payer != null) {
                    request.setAttribute("user_" + payment.getPaymentId(), payer);
                }
                
                // If payeeId exists, also map payee information
                if (payment.getPayeeId() > 0) {
                    User payee = userDAO.getById(payment.getPayeeId());
                    if (payee != null) {
                        request.setAttribute("payee_" + payment.getPaymentId(), payee);
                    }
                }
            }
            
            int totalPayments = paymentDAO.getTotalFilteredPayments(search, statusFilter, typeFilter, 
                                                                   dateFrom, dateTo);
            int totalPages = (int) Math.ceil((double) totalPayments / pageSize);
            
            // Get summary statistics
            double totalAmount = paymentDAO.getTotalAmount(search, statusFilter, typeFilter, dateFrom, dateTo);
            double totalRefunded = paymentDAO.getTotalRefunded(search, statusFilter, typeFilter, dateFrom, dateTo);
            
            // Get counts by status
            int completedPayments = paymentDAO.getCountByStatus("Completed", search, typeFilter, dateFrom, dateTo);
            int pendingPayments = paymentDAO.getCountByStatus("Pending", search, typeFilter, dateFrom, dateTo);
            
            // Set attributes
            request.setAttribute("payments", payments);
            request.setAttribute("totalPayments", totalPayments);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("completedPayments", completedPayments);
            request.setAttribute("pendingPayments", pendingPayments);
            request.setAttribute("totalRevenue", totalAmount);
            request.setAttribute("totalRefunded", totalRefunded);
            
            request.getRequestDispatcher("/view/admin/payment-history.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void viewPaymentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String paymentIdParam = request.getParameter("paymentId");          
            
            int paymentId;
            try {
                paymentId = Integer.parseInt(paymentIdParam.trim());
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/payment-history?error=invalid-id");
                return;
            }
            
            Payment payment = paymentDAO.getById(paymentId);
            
            if (payment != null) {
                // Get payer information
                User payer = null;
                try {
                    payer = userDAO.getById(payment.getPayerId());
                    if (payer != null) {
                        System.out.println("Payer found: " + payer.getName());
                        request.setAttribute("payer", payer);
                    } else {
                        System.out.println("Payer not found for ID: " + payment.getPayerId());
                    }
                } catch (Exception e) {
                    System.out.println("Error fetching payer: " + e.getMessage());
                }
                
                // If payeeId exists, also get payee information
                if (payment.getPayeeId() > 0) {
                    try {
                        User payee = userDAO.getById(payment.getPayeeId());
                        if (payee != null) {
                            request.setAttribute("payee", payee);
                        } else {
                            System.out.println("Payee not found for ID: " + payment.getPayeeId());
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching payee: " + e.getMessage());
                    }
                }
                
                request.setAttribute("payment", payment);
                System.out.println("Forwarding to payment-detail.jsp");
                
                // Forward to the full payment detail page
                request.getRequestDispatcher("/view/admin/payment-detail.jsp").forward(request, response);
                
            } else {
                System.out.println("Payment not found for ID: " + paymentId);
                response.sendRedirect(request.getContextPath() + "/admin/payment-history?error=not-found");
            }
        } catch (Exception e) {
            System.out.println("Exception in viewPaymentDetail: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/payment-history?error=system-error");
        }
    }
    
    private void printPaymentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            
            Payment payment = paymentDAO.getById(paymentId);
            
            if (payment != null) {
                // Get payer information
                User payer = userDAO.getById(payment.getPayerId());
                if (payer != null) {
                    request.setAttribute("payer", payer);
                }
                
                // If payeeId exists, also get payee information
                if (payment.getPayeeId() > 0) {
                    User payee = userDAO.getById(payment.getPayeeId());
                    if (payee != null) {
                        request.setAttribute("payee", payee);
                    }
                }

                
                request.setAttribute("payment", payment);
                request.getRequestDispatcher("/view/admin/payment-print-template.jsp").forward(request, response);
            } else {
                response.getWriter().write("<h2>Không tìm thấy giao dịch</h2>");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("<h2>ID giao dịch không hợp lệ</h2>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<h2>Đã xảy ra lỗi khi tải thông tin chi tiết</h2>");
        }
    }
    
    private void processRefund(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        String refundReason = request.getParameter("refundReason");
        
        boolean success = paymentDAO.processRefund(paymentId, refundReason);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/payment-history?success=refund");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/payment-history?error=refund");
        }
    }
    
//    private void exportPaymentHistory(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        // Get filter parameters
//        String search = request.getParameter("search");
//        String statusFilter = request.getParameter("status");
//        String typeFilter = request.getParameter("type");
//        String dateFrom = request.getParameter("dateFrom");
//        String dateTo = request.getParameter("dateTo");
//        
//        try {
//            // Set response headers for CSV download
//            response.setContentType("text/csv");
//            response.setHeader("Content-Disposition", "attachment; filename=\"payment_history.csv\"");
//            
//            // Get all payments for export
//            List<Payment> payments = paymentDAO.getAllFilteredPayments(search, statusFilter, typeFilter, dateFrom, dateTo);
//            
//            // Generate CSV content
//            StringBuilder csvContent = new StringBuilder();
//            csvContent.append("ID,Người thanh toán,Loại thanh toán,Số tiền,Trạng thái,Ngày thanh toán,Mô tả\n");
//            
//            for (Payment payment : payments) {
//                csvContent.append(payment.getPaymentId()).append(",")
//                         .append(payment.getUserFullname()).append(",")
//                         .append(payment.getPaymentType()).append(",")
//                         .append(payment.getAmount()).append(",")
//                         .append(payment.getStatus()).append(",")
//                         .append(payment.getPaymentDate()).append(",")
//                         .append("\"").append(payment.getDescription()).append("\"")
//                         .append("\n");
//            }
//            
//            response.getWriter().write(csvContent.toString());
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect(request.getContextPath() + "/admin/payment-history?error=export");
//        }
//    }
}
