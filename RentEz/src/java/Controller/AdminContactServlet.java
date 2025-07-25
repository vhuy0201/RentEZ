package Controller;

import DAO.ContactMessageDAO;
import Model.ContactMessage;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Servlet to handle admin contact message management
 */
@WebServlet(name = "AdminContactServlet", urlPatterns = {"/admin/contact-messages"})
public class AdminContactServlet extends HttpServlet {
    
    private ContactMessageDAO contactMessageDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        contactMessageDAO = new ContactMessageDAO();
    }
    
    /**
     * Handle GET requests - show contact messages list
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);

        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            handleViewMessage(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteMessage(request, response);
        } else if ("export".equals(action)) {
            handleExportMessages(request, response);
        } else if ("stats".equals(action)) {
            handleGetStats(request, response);
        } else {
            handleListMessages(request, response);
        }
    }
    
    /**
     * Handle POST requests - process admin actions
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            handleDeleteMessage(request, response);
        } else if ("bulk-delete".equals(action)) {
            handleBulkDeleteMessages(request, response);
        }
    }
    
    /**
     * Handle listing contact messages with pagination and filtering
     */
    private void handleListMessages(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get pagination parameters
            int page = 1;
            int pageSize = 20;
            
            String pageParam = request.getParameter("page");
            String pageSizeParam = request.getParameter("pageSize");
            
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                pageSize = Integer.parseInt(pageSizeParam);
            }
            
            // Get filter parameters
            String subjectFilter = request.getParameter("subject");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            
            List<ContactMessage> messages;
            int totalMessages;
            
            // Apply filters
            if (subjectFilter != null && !subjectFilter.isEmpty() && !"all".equals(subjectFilter)) {
                messages = contactMessageDAO.searchContactMessagesBySubject(subjectFilter, page, pageSize);
                totalMessages = contactMessageDAO.getTotalContactMessagesCount(); // TODO: Add filtered count method
            } else if (startDateParam != null && endDateParam != null && 
                      !startDateParam.isEmpty() && !endDateParam.isEmpty()) {
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = new Date(sdf.parse(startDateParam).getTime());
                Date endDate = new Date(sdf.parse(endDateParam).getTime());
                
                messages = contactMessageDAO.getContactMessagesByDateRange(startDate, endDate, page, pageSize);
                totalMessages = contactMessageDAO.getTotalContactMessagesCount(); // TODO: Add filtered count method
            } else {
                messages = contactMessageDAO.getAllContactMessages(page, pageSize);
                totalMessages = contactMessageDAO.getTotalContactMessagesCount();
            }
            
            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalMessages / pageSize);
            
            // Get statistics
            List<ContactMessageDAO.SubjectStats> stats = contactMessageDAO.getContactMessageStatsBySubject();
            
            // Set attributes for JSP
            request.setAttribute("messages", messages);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalMessages", totalMessages);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("subjectFilter", subjectFilter);
            request.setAttribute("startDate", startDateParam);
            request.setAttribute("endDate", endDateParam);
            request.setAttribute("stats", stats);
            
            // Forward to JSP
            request.getRequestDispatcher("/view/admin/contact-messages.jsp").forward(request, response);
            
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
        }
    }
    
    /**
     * Handle viewing a specific contact message
     */
    private void handleViewMessage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int messageId = Integer.parseInt(request.getParameter("id"));
            ContactMessage message = contactMessageDAO.getContactMessageById(messageId);
            
            if (message != null) {
                request.setAttribute("message", message);
                request.getRequestDispatcher("/view/admin/contact-message-detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Message not found");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid message ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
        }
    }
    
    /**
     * Handle deleting a contact message
     */
    private void handleDeleteMessage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            int messageId = Integer.parseInt(request.getParameter("id"));
            boolean success = contactMessageDAO.deleteContactMessage(messageId);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Tin nhắn đã được xóa thành công.");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không thể xóa tin nhắn. Vui lòng thử lại.");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "ID tin nhắn không hợp lệ.");
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra khi xóa tin nhắn.");
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
    
    /**
     * Handle bulk deleting contact messages
     */
    private void handleBulkDeleteMessages(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            String[] messageIds = request.getParameterValues("messageIds");
            
            if (messageIds == null || messageIds.length == 0) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không có tin nhắn nào được chọn để xóa.");
                out.print(gson.toJson(jsonResponse));
                return;
            }
            
            int deletedCount = 0;
            
            for (String idStr : messageIds) {
                try {
                    int messageId = Integer.parseInt(idStr);
                    if (contactMessageDAO.deleteContactMessage(messageId)) {
                        deletedCount++;
                    }
                } catch (NumberFormatException e) {
                    // Skip invalid IDs
                }
            }
            
            if (deletedCount > 0) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Đã xóa " + deletedCount + " tin nhắn thành công.");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không thể xóa tin nhắn nào. Vui lòng thử lại.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra khi xóa tin nhắn.");
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
    
    /**
     * Handle exporting contact messages to CSV
     */
    private void handleExportMessages(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Set response headers for CSV download
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"contact_messages.csv\"");
            
            PrintWriter out = response.getWriter();
            
            // Write CSV header
            out.println("ID,Họ,Tên,Email,Điện thoại,Chủ đề,Tin nhắn,Đồng ý chính sách,Ngày tạo");
            
            // Get all messages (you might want to add pagination for large datasets)
            List<ContactMessage> messages = contactMessageDAO.getAllContactMessages(1, Integer.MAX_VALUE);
            
            // Write CSV data
            for (ContactMessage message : messages) {
                out.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\"\n",
                    message.getMessageID(),
                    escapeCsv(message.getFirstName()),
                    escapeCsv(message.getLastName()),
                    escapeCsv(message.getEmail()),
                    escapeCsv(message.getPhone()),
                    escapeCsv(message.getSubjectDisplayText()),
                    escapeCsv(message.getMessage()),
                    message.isPrivacyPolicyAccepted() ? "Có" : "Không",
                    message.getCreatedAt()
                );
            }
            
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error exporting data");
        }
    }
    
    /**
     * Handle getting statistics
     */
    private void handleGetStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        
        try {
            List<ContactMessageDAO.SubjectStats> stats = contactMessageDAO.getContactMessageStatsBySubject();
            int totalMessages = contactMessageDAO.getTotalContactMessagesCount();
            
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("totalMessages", totalMessages);
            jsonResponse.add("subjectStats", gson.toJsonTree(stats));
            
            out.print(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            e.printStackTrace();
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error getting statistics");
            out.print(gson.toJson(jsonResponse));
        }
        
        out.flush();
    }
    
    /**
     * Escape CSV values
     */
    private String escapeCsv(String value) {
        if (value == null) {
            return "";
        }
        return value.replaceAll("\"", "\"\"");
    }
    
    @Override
    public String getServletInfo() {
        return "Admin contact message management servlet";
    }
}
