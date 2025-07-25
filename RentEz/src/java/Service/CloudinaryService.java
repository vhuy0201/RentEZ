package Service;

import com.cloudinary.Cloudinary;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;
import org.apache.tomcat.jakartaee.commons.io.FileUtils;

/**
 * Service class for handling image uploads to Cloudinary
 * Provides centralized configuration and upload functionality
 */
public class CloudinaryService {
    
    private static CloudinaryService instance;
    private Cloudinary cloudinary;
    private String cloudName;
    private String apiKey;
    private String apiSecret;
    private boolean enabled;
    
    /**
     * Private constructor for singleton pattern
     */
    private CloudinaryService() {
        loadConfiguration();
        
    }
    
    /**
     * Load configuration from properties file
     */
    private void loadConfiguration() {
        Properties properties = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("cloudinary.properties")) {
            if (input != null) {
                properties.load(input);
                cloudName = properties.getProperty("cloudinary.cloud_name", "dkhphbo1k");
                apiKey = properties.getProperty("cloudinary.api_key", "882391754787486");
                apiSecret = properties.getProperty("cloudinary.api_secret", "88L_ZHsmfz2ZuBXTZX0U8GITgfc");
                enabled = Boolean.parseBoolean(properties.getProperty("cloudinary.enabled", "true"));
            } else {
                // Default values if properties file not found
                cloudName = "dkhphbo1k";
                apiKey = "882391754787486";
                apiSecret = "88L_ZHsmfz2ZuBXTZX0U8GITgfc";
                enabled = true;
            }
        } catch (IOException e) {
            System.err.println("Error loading Cloudinary configuration: " + e.getMessage());
            // Use default values
            cloudName = "dkhphbo1k";
            apiKey = "882391754787486";
            apiSecret = "88L_ZHsmfz2ZuBXTZX0U8GITgfc";
            enabled = true;
        }
        boolean isConfigured = isConfigured();
        if (enabled && isConfigured) {
            Map<String, String> config = new HashMap<>();
            config.put("cloud_name", cloudName);
            config.put("api_key", apiKey);
            config.put("api_secret", apiSecret);
            cloudinary = new Cloudinary(config);
        }
    }
    
    /**
     * Get singleton instance of CloudinaryService
     */
    public static synchronized CloudinaryService getInstance() {
        if (instance == null) {
            instance = new CloudinaryService();
        }
        return instance;
    }
    
    /**
     * Upload image from InputStream to Cloudinary
     * 
     * @param inputStream InputStream of the image file
     * @param fileName Original file name
     * @param folder Cloudinary folder to upload to (optional)
     * @return Secure URL of the uploaded image
     * @throws IOException if upload fails
     */
    public String uploadImage(InputStream inputStream, String fileName, String folder) throws IOException {
        File tempFile = null;
        try {
            // Create temporary file
            String fileExtension = "";
            if (fileName != null && fileName.contains(".")) {
                fileExtension = fileName.substring(fileName.lastIndexOf("."));
            }
            tempFile = File.createTempFile("upload_" + UUID.randomUUID().toString(), fileExtension);
            
            // Copy input stream to temporary file
            FileUtils.copyInputStreamToFile(inputStream, tempFile);
            
            // Configure upload options
            Map<String, Object> uploadOptions = new HashMap<>();
            uploadOptions.put("resource_type", "image");
            uploadOptions.put("quality", "auto");
            uploadOptions.put("fetch_format", "auto");
            
            // Add folder if specified
            if (folder != null && !folder.trim().isEmpty()) {
                uploadOptions.put("folder", folder);
            }
            
            // Upload to Cloudinary
            Map uploadResult = cloudinary.uploader().upload(tempFile, uploadOptions);
            
            // Return secure URL
            return (String) uploadResult.get("secure_url");
            
        } catch (Exception e) {
            throw new IOException("Failed to upload image to Cloudinary: " + e.getMessage(), e);
        } finally {
            // Clean up temporary file
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }
    
    /**
     * Upload image with default folder (rentez/properties)
     */
    public String uploadPropertyImage(InputStream inputStream, String fileName) throws IOException {
        return uploadImage(inputStream, fileName, "rentez/properties");
    }
    
    /**
     * Upload avatar image with default folder (rentez/avatars)
     */
    public String uploadAvatarImage(InputStream inputStream, String fileName) throws IOException {
        return uploadImage(inputStream, fileName, "rentez/avatars");
    }
    
    /**
     * Delete image from Cloudinary by public ID
     * 
     * @param publicId Public ID of the image to delete
     * @return true if deletion was successful
     */
    public boolean deleteImage(String publicId) {
        try {
            Map<String, Object> options = new HashMap<>();
            Map result = cloudinary.uploader().destroy(publicId, options);
            return "ok".equals(result.get("result"));
        } catch (Exception e) {
            System.err.println("Failed to delete image from Cloudinary: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Extract public ID from Cloudinary URL
     * 
     * @param cloudinaryUrl Full Cloudinary URL
     * @return Public ID or null if URL is invalid
     */
    public String extractPublicId(String cloudinaryUrl) {
        if (cloudinaryUrl == null || !cloudinaryUrl.contains("cloudinary.com")) {
            return null;
        }
        
        try {
            // Extract public ID from URL
            // Example: https://res.cloudinary.com/demo/image/upload/v1234567890/folder/filename.jpg
            String[] parts = cloudinaryUrl.split("/");
            for (int i = 0; i < parts.length; i++) {
                if ("upload".equals(parts[i]) && i + 1 < parts.length) {
                    // Skip version if present (starts with 'v' followed by numbers)
                    int startIndex = i + 1;
                    if (parts[startIndex].startsWith("v") && parts[startIndex].matches("v\\d+")) {
                        startIndex++;
                    }
                    
                    // Join remaining parts and remove file extension
                    StringBuilder publicId = new StringBuilder();
                    for (int j = startIndex; j < parts.length; j++) {
                        if (j > startIndex) {
                            publicId.append("/");
                        }
                        publicId.append(parts[j]);
                    }
                    
                    String result = publicId.toString();
                    // Remove file extension
                    if (result.contains(".")) {
                        result = result.substring(0, result.lastIndexOf("."));
                    }
                    return result;
                }
            }
        } catch (Exception e) {
            System.err.println("Error extracting public ID from URL: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Check if Cloudinary is properly configured
     */
    public boolean isConfigured() {
        return enabled 
            && cloudName.equals("dkhphbo1k") 
            && apiKey.equals("882391754787486") 
            && apiSecret.equals("88L_ZHsmfz2ZuBXTZX0U8GITgfc");
    }
}
