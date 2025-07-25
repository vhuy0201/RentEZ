package Controller;

import DAO.PropertyImageDAO;
import Model.PropertyImage;
import Model.User;
import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet for managing PropertyImage operations
 * Handles viewing, deleting property images
 */
@WebServlet(name = "PropertyImageServlet", urlPatterns = {"/propertyImage"})
public class PropertyImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            viewPropertyImages(request, response);
        } else if ("delete".equals(action)) {
            deletePropertyImage(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * View property images as JSON response
     */
    private void viewPropertyImages(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String propertyIdStr = request.getParameter("propertyId");
            if (propertyIdStr == null || propertyIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required");
                return;
            }

            int propertyId = Integer.parseInt(propertyIdStr);
            
            PropertyImageDAO propertyImageDAO = new PropertyImageDAO();
            List<PropertyImage> images = propertyImageDAO.getByPropertyId(propertyId);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{");
                out.println("  \"success\": true,");
                out.println("  \"images\": [");
                
                for (int i = 0; i < images.size(); i++) {
                    PropertyImage image = images.get(i);
                    out.println("    {");
                    out.println("      \"imageId\": " + image.getImageId() + ",");
                    out.println("      \"propertyId\": " + image.getPropertyId() + ",");
                    out.println("      \"imageURL\": \"" + escapeJson(image.getImageURL()) + "\"");
                    out.print("    }");
                    
                    if (i < images.size() - 1) {
                        out.println(",");
                    } else {
                        out.println();
                    }
                }
                
                out.println("  ]");
                out.println("}");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Property ID format");
        } catch (Exception e) {
            System.err.println("Error viewing property images: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving images");
        }
    }

    /**
     * Delete a property image
     */
    private void deletePropertyImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        try {
            String imageIdStr = request.getParameter("imageId");
            if (imageIdStr == null || imageIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image ID is required");
                return;
            }

            int imageId = Integer.parseInt(imageIdStr);
            
            PropertyImageDAO propertyImageDAO = new PropertyImageDAO();
            PropertyImage image = propertyImageDAO.getById(imageId);
            
            if (image == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                return;
            }

            // TODO: Add authorization check - verify user owns the property
            // For now, we'll just delete the image
            
            // Delete from Cloudinary if it's a Cloudinary URL
            if (image.getImageURL() != null && image.getImageURL().contains("cloudinary.com")) {
                try {
                    CloudinaryService cloudinaryService = CloudinaryService.getInstance();
                    String publicId = cloudinaryService.extractPublicId(image.getImageURL());
                    if (publicId != null) {
                        cloudinaryService.deleteImage(publicId);
                    }
                } catch (Exception e) {
                    System.err.println("Error deleting image from Cloudinary: " + e.getMessage());
                }
            }
            
            // Delete from database
            boolean deleted = propertyImageDAO.delete(imageId);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{");
                out.println("  \"success\": " + deleted + ",");
                out.println("  \"message\": \"" + (deleted ? "Image deleted successfully" : "Failed to delete image") + "\"");
                out.println("}");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Image ID format");
        } catch (Exception e) {
            System.err.println("Error deleting property image: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting image");
        }
    }

    /**
     * Escape special characters for JSON
     */
    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }

    @Override
    public String getServletInfo() {
        return "Property Image Servlet handles property image operations";
    }
}
