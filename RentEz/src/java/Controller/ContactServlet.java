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

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet to handle contact form submissions
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {
    
    private ContactMessageDAO contactMessageDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        contactMessageDAO = new ContactMessageDAO();
    }
    
    /**
     * Handle GET requests - show contact form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to contact page
        response.sendRedirect(request.getContextPath() + "/view/guest/page/contact.jsp");
    }
    
    /**
     * Handle POST requests - process contact form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set response content type for JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Get form parameters
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");
            String privacyParam = request.getParameter("privacy");
            
            // Validate required fields
            if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty() ||
                privacyParam == null) {
                
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Vui lòng điền đầy đủ thông tin bắt buộc và đồng ý với chính sách bảo mật.");
                out.print(gson.toJson(jsonResponse));
                return;
            }
            
            // Validate email format
            if (!isValidEmail(email)) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Vui lòng nhập địa chỉ email hợp lệ.");
                out.print(gson.toJson(jsonResponse));
                return;
            }
            
            // Validate subject
            if (!isValidSubject(subject)) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Chủ đề không hợp lệ.");
                out.print(gson.toJson(jsonResponse));
                return;
            }
            
            // Convert privacy checkbox value
            boolean privacyPolicyAccepted = "on".equals(privacyParam) || "true".equals(privacyParam);
            
            if (!privacyPolicyAccepted) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Bạn phải đồng ý với chính sách bảo mật để tiếp tục.");
                out.print(gson.toJson(jsonResponse));
                return;
            }
            
            // Sanitize input
            firstName = sanitizeInput(firstName);
            lastName = sanitizeInput(lastName);
            email = sanitizeInput(email);
            phone = sanitizeInput(phone);
            message = sanitizeInput(message);
            
            // Create ContactMessage object
            ContactMessage contactMessage = new ContactMessage(
                firstName, lastName, email, phone, subject, message, privacyPolicyAccepted
            );
            
            // Save to database
            boolean success = contactMessageDAO.insertContactMessage(contactMessage);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi trong vòng 24 giờ.");
                
                // Log the successful submission
                System.out.println("New contact message received from: " + email + " - Subject: " + subject);
                
                // TODO: Send email notification to admin
                // sendEmailNotificationToAdmin(contactMessage);
                
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Có lỗi xảy ra khi gửi tin nhắn. Vui lòng thử lại sau.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau.");
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
    
    /**
     * Validate email format
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    /**
     * Validate subject
     */
    private boolean isValidSubject(String subject) {
        return subject.equals("general") || 
               subject.equals("support") || 
               subject.equals("business") || 
               subject.equals("complaint") || 
               subject.equals("suggestion") || 
               subject.equals("other");
    }
    
    /**
     * Sanitize input to prevent XSS attacks
     */
    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        return input.trim()
                   .replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("/", "&#x2F;");
    }
    
    /**
     * Send email notification to admin (placeholder for future implementation)
     */
    private void sendEmailNotificationToAdmin(ContactMessage contactMessage) {
        // TODO: Implement email notification
        // This could use JavaMail API to send notification emails to admin
        System.out.println("Email notification should be sent to admin for new contact message ID: " + contactMessage.getMessageID());
    }
    
    @Override
    public String getServletInfo() {
        return "Contact form submission servlet";
    }
}
