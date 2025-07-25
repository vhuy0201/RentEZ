package Controller;

import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Demo Servlet for testing Cloudinary image upload functionality
 * This servlet demonstrates how to upload images to Cloudinary
 */
@WebServlet(name = "CloudinaryUploadServlet", urlPatterns = {"/cloudinary-upload"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 30 // 30 MB
)
public class CloudinaryUploadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Cloudinary Upload Test</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }");
            out.println(".form-group { margin-bottom: 15px; }");
            out.println("label { display: block; margin-bottom: 5px; font-weight: bold; }");
            out.println("input[type='file'] { width: 100%; padding: 8px; }");
            out.println("input[type='submit'] { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }");
            out.println("input[type='submit']:hover { background-color: #45a049; }");
            out.println(".status { padding: 10px; margin: 10px 0; border-radius: 4px; }");
            out.println(".success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }");
            out.println(".error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Cloudinary Upload Test</h1>");
            
            // Check if Cloudinary is configured
            CloudinaryService cloudinaryService = CloudinaryService.getInstance();
            if (!cloudinaryService.isConfigured()) {
                out.println("<div class='status error'>");
                out.println("<strong>Warning:</strong> Cloudinary is not configured properly. ");
                out.println("Please update your cloudinary.properties file with valid credentials.");
                out.println("</div>");
            } else {
                out.println("<div class='status success'>");
                out.println("<strong>Success:</strong> Cloudinary is configured and ready to use.");
                out.println("</div>");
            }
            
            out.println("<form method='post' enctype='multipart/form-data'>");
            out.println("<div class='form-group'>");
            out.println("<label for='imageFile'>Choose Image File:</label>");
            out.println("<input type='file' id='imageFile' name='imageFile' accept='image/*' required>");
            out.println("</div>");
            out.println("<div class='form-group'>");
            out.println("<input type='submit' value='Upload to Cloudinary'>");
            out.println("</div>");
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Upload Result</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }");
            out.println(".result { padding: 20px; margin: 20px 0; border-radius: 8px; }");
            out.println(".success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }");
            out.println(".error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }");
            out.println("img { max-width: 100%; height: auto; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; }");
            out.println("a { color: #007bff; text-decoration: none; }");
            out.println("a:hover { text-decoration: underline; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Upload Result</h1>");
            
            try {
                CloudinaryService cloudinaryService = CloudinaryService.getInstance();
                
                if (!cloudinaryService.isConfigured()) {
                    out.println("<div class='result error'>");
                    out.println("<h3>Configuration Error</h3>");
                    out.println("<p>Cloudinary is not configured properly. Please check your cloudinary.properties file.</p>");
                    out.println("</div>");
                    return;
                }
                
                // Get uploaded file
                Part filePart = request.getPart("imageFile");
                if (filePart == null || filePart.getSize() == 0) {
                    out.println("<div class='result error'>");
                    out.println("<h3>No File Selected</h3>");
                    out.println("<p>Please select an image file to upload.</p>");
                    out.println("</div>");
                    return;
                }
                
                String fileName = filePart.getSubmittedFileName();
                
                // Upload to Cloudinary
                String imageUrl = cloudinaryService.uploadImage(filePart.getInputStream(), fileName, "rentez/test");
                
                out.println("<div class='result success'>");
                out.println("<h3>Upload Successful!</h3>");
                out.println("<p><strong>Original filename:</strong> " + fileName + "</p>");
                out.println("<p><strong>Cloudinary URL:</strong></p>");
                out.println("<p><a href='" + imageUrl + "' target='_blank'>" + imageUrl + "</a></p>");
                out.println("<p><strong>Preview:</strong></p>");
                out.println("<img src='" + imageUrl + "' alt='Uploaded Image' />");
                out.println("</div>");
                
            } catch (Exception e) {
                out.println("<div class='result error'>");
                out.println("<h3>Upload Failed</h3>");
                out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
                out.println("</div>");
            }
            
            out.println("<p><a href='" + request.getContextPath() + "/cloudinary-upload'>← Upload Another Image</a></p>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Cloudinary Upload Test Servlet";
    }
}
