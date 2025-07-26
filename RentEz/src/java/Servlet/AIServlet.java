/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Service.GeminiService;
import Service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import org.json.JSONObject;

/**
 *
 * @author PC
 */
@WebServlet(name = "AIServlet", urlPatterns = {"/aiOptimizeProperty", "/aiEnhanceImage", "/aiGenImage"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AIServlet extends HttpServlet {

    private final GeminiService geminiService = new GeminiService();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AIServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AIServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/aiOptimizeProperty".equals(path)) {
            // Nhận JSON, gọi AI tối ưu tiêu đề & mô tả
            request.setCharacterEncoding("UTF-8");
            response.setContentType("application/json;charset=UTF-8");
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            JSONObject json = new JSONObject(sb.toString());

            // Lấy thông tin từ request
            String title = json.optString("title");
            String description = json.optString("description");
            String type = json.optString("propertyTypeName");
            String price = json.optString("price");
            String size = json.optString("size");
            String bedrooms = json.optString("bedrooms");
            String bathrooms = json.optString("bathrooms");

            String propertyType = type;

            // Chuyển đổi kiểu dữ liệu
            double pricePerMonth = 0;
            double area = 0;
            int bed = 0, bath = 0;
            try {
                pricePerMonth = Double.parseDouble(price);
                area = Double.parseDouble(size);
                bed = Integer.parseInt(bedrooms);
                bath = Integer.parseInt(bathrooms);
            } catch (Exception ex) {
            }

            String aiResult = geminiService.improvePropertyPost(
                    title, description, propertyType, pricePerMonth, area, bed, bath
            );

            JSONObject outer = new JSONObject(aiResult);
            String innerText = outer
                    .getJSONArray("candidates")
                    .getJSONObject(0)
                    .getJSONObject("content")
                    .getJSONArray("parts")
                    .getJSONObject(0)
                    .getString("text");

            // innerText là chuỗi JSON, cần parse tiếp
            JSONObject inner = new JSONObject(innerText);

            // Trả về đúng JSON {title, content}
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(inner.toString());
            return;
        }

        if ("/aiEnhanceImage".equals(path)) {
            // Nhận file ảnh, gọi AI làm đẹp ảnh
            response.setContentType("image/png");
            Part filePart = request.getPart("avatarImage");
            if (filePart == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No image uploaded");
                return;
            }
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            try (InputStream is = filePart.getInputStream()) {
                byte[] buffer = new byte[4096];
                int len;
                while ((len = is.read(buffer)) != -1) {
                    baos.write(buffer, 0, len);
                }
            }
            byte[] imageBytes = baos.toByteArray();

            String description = request.getParameter("description");
            if (description.isEmpty()) {
                description = "Làm đẹp ảnh đại diện bất động sản";
            }
            byte[] enhanced = geminiService.generateEnhancedImageByGemini(
                    description, imageBytes, 512, 512
            );

            response.setContentType("image/png");
            response.setContentLength(enhanced.length);
            try (OutputStream os = response.getOutputStream()) {
                os.write(enhanced);
            }
            return;
        }

        if ("/aiGenImage".equals(path)) {
            String prompt = request.getParameter("description");
            if (prompt == null || prompt.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu prompt");
                return;
            }
            int height = 512, width = 512;
            try {
                if (request.getParameter("height") != null) {
                    height = Integer.parseInt(request.getParameter("height"));
                }
                if (request.getParameter("width") != null) {
                    width = Integer.parseInt(request.getParameter("width"));
                }
            } catch (Exception ex) {

            }

            byte[] image = geminiService.generateImageByGemini(prompt, height, width);

            String cloudinaryUrl = null;
            try {
                CloudinaryService cloudinaryService = CloudinaryService.getInstance();
                if (!cloudinaryService.isConfigured()) {
                    System.err.println("Cloudinary is not configured properly");
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cloudinary config error");
                    return;
                }
                String fileName = "ai-gen-" + System.currentTimeMillis() + ".png";
                cloudinaryUrl = cloudinaryService.uploadAvatarImage(
                        new java.io.ByteArrayInputStream(image),
                        fileName
                );
            } catch (Exception e) {
                System.err.println("Error uploading to Cloudinary: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Upload Cloudinary error");
                return;
            }

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"url\":\"" + cloudinaryUrl + "\"}");
            return;
        }

        // Nếu không đúng endpoint
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
