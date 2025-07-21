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
            if (action != null) {
                switch (action) {
                    case "view-detail":
                        viewPaymentDetail(request, response);
                        break;
                    case "print-detail":
                        printPaymentDetail(request, response);
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/admin/payment-history");
                }
            } else {
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
          
            String search = request.getParameter("search");
            String statusFilter = request.getParameter("status");
            String typeFilter = request.getParameter("type");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            
         
            int page = 1;
            int pageSize = 15;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
            
        
            List<Payment> payments = paymentDAO.getFilteredPayments(search, statusFilter, typeFilter, 
                                                                   dateFrom, dateTo, page, pageSize);
            
            
            for (Payment payment : payments) {
                User payer = userDAO.getById(payment.getPayerId());
                if (payer != null) {
                    request.setAttribute("user_" + payment.getPaymentId(), payer);
                }
                
               
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
            
          
            double totalAmount = paymentDAO.getTotalAmount(search, statusFilter, typeFilter, dateFrom, dateTo);
            double totalRefunded = paymentDAO.getTotalRefunded(search, statusFilter, typeFilter, dateFrom, dateTo);
            
           
            int completedPayments = paymentDAO.getCountByStatus("Completed", search, typeFilter, dateFrom, dateTo);
            int pendingPayments = paymentDAO.getCountByStatus("Pending", search, typeFilter, dateFrom, dateTo);
            
           
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
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            
            Payment payment = paymentDAO.getById(paymentId);
            
            if (payment != null) {
             
                User payer = userDAO.getById(payment.getPayerId());
                if (payer != null) {
                    request.setAttribute("payer", payer);
                }
                
                if (payment.getPayeeId() > 0) {
                    User payee = userDAO.getById(payment.getPayeeId());
                    if (payee != null) {
                        request.setAttribute("payee", payee);
                    }
                }
                
                
                request.setAttribute("payment", payment);
                request.getRequestDispatcher("/view/admin/payment-detail-template.jsp").include(request, response);
            } else {
                response.getWriter().write("<div class='p-4 text-center text-red-600'><i class='fas fa-exclamation-circle text-3xl mb-3'></i><p>Không tìm thấy giao dịch</p></div>");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("<div class='p-4 text-center text-red-600'><i class='fas fa-exclamation-triangle text-3xl mb-3'></i><p>ID giao dịch không hợp lệ</p></div>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<div class='p-4 text-center text-red-600'><i class='fas fa-exclamation-triangle text-3xl mb-3'></i><p>Đã xảy ra lỗi khi tải thông tin chi tiết</p></div>");
        }
    }
    
    private void printPaymentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            
            Payment payment = paymentDAO.getById(paymentId);
            
            if (payment != null) {
                
                User payer = userDAO.getById(payment.getPayerId());
                if (payer != null) {
                    request.setAttribute("payer", payer);
                }
                
                
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
