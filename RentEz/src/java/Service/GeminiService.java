package Service;

import java.io.IOException;
import java.net.URL;
import java.util.Scanner;
import javax.net.ssl.HttpsURLConnection;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class GeminiService {

    private final String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
    private final String apiImgUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-preview-image-generation:generateContent";
    private final String apiKey = "AIzaSyARZh7ZkALP9zrvJ5l99vAFfILIQWtHU0k";

    public String validateContent(String content) throws IOException {
        String urlStr = apiUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        String requestBody = "{"
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(content) + "\"}]}],"
                + "\"generationConfig\":{"
                + "\"response_mime_type\":\"application/json\","
                + "\"response_schema\":{"
                + "\"type\":\"object\","
                + "\"properties\":{"
                + "\"is_valid\":{\"type\":\"boolean\",\"description\":\"True nếu nội dung hợp lệ, False nếu có công kích, thô tục, phân biệt chủng tộc hoặc phản cảm, độc hại.\"},"
                + "\"reason\":{\"type\":\"string\",\"description\":\"Giải thích ngắn gọn lý do vì sao nội dung hợp lệ hoặc không hợp lệ.\"}"
                + "},"
                + "\"required\":[\"is_valid\",\"reason\"]"
                + "}"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            throw new IOException("Gemini API error: " + code);
        }

        StringBuilder response = new StringBuilder();
        try (Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8.name())) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        return response.toString();
    }

    public String improvePropertyPost(
            String title,
            String description,
            String propertyType,
            double pricePerMonth,
            double area,
            int bedrooms,
            int bathrooms
    ) throws IOException {
        String urlStr = apiUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        String prompt = "Bạn là một người cho thuê nhà chuyên nghiệp, có uy tín. "
                + "Hãy xem xét và cải thiện lại bài đăng cho thuê nhà dưới đây để tối ưu khả năng thu hút khách thuê. "
                + "Thông tin bài đăng: "
                + "Tiêu đề: \"" + escapeJson(title) + "\"; "
                + "Mô tả chi tiết: \"" + escapeJson(description) + "\"; "
                + "Loại bất động sản: " + escapeJson(propertyType) + "; "
                + "Giá cho thuê 1 tháng: " + pricePerMonth + " triệu VNĐ; "
                + "Diện tích: " + area + " m2; "
                + "Số phòng ngủ: " + bedrooms + "; "
                + "Số phòng tắm: " + bathrooms + ". "
                + "Hãy cải thiện lại tiêu đề và mô tả chi tiết, nhấn mạnh các ưu điểm, sự chuyên nghiệp, phù hợp với khách thuê, trình bày hấp dẫn, rõ ràng. "
                + "Trả về kết quả dưới dạng JSON với 2 trường: 'title' (tiêu đề đã cải thiện) và 'content' (mô tả chi tiết đã cải thiện).";

        String requestBody = "{"
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(prompt) + "\"}]}],"
                + "\"generationConfig\":{"
                + "\"response_mime_type\":\"application/json\","
                + "\"response_schema\":{"
                + "\"type\":\"object\","
                + "\"properties\":{"
                + "\"title\":{\"type\":\"string\",\"description\":\"Tiêu đề đã cải thiện\"},"
                + "\"content\":{\"type\":\"string\",\"description\":\"Mô tả chi tiết đã cải thiện\"}"
                + "},"
                + "\"required\":[\"title\",\"content\"]"
                + "}"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            throw new IOException("Gemini API error: " + code);
        }

        StringBuilder response = new StringBuilder();
        try (Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8.name())) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        return response.toString();
    }

    public byte[] generateEnhancedImageByGemini(String prompt, byte[] originalImage, int height, int width) throws IOException {
        String urlStr = apiImgUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        // Chuyển ảnh gốc sang base64
        String base64Image = Base64.getEncoder().encodeToString(originalImage);

        String mimeType = "image/png";
        if (originalImage.length > 3 && originalImage[0] == (byte) 0xFF && originalImage[1] == (byte) 0xD8) {
            mimeType = "image/jpeg";
        }

        // Prompt hướng dẫn AI làm đẹp ảnh
        String fullPrompt = prompt
                + " Đây là ảnh gốc, hãy làm đẹp lại ảnh này với màu sắc tươi sáng, ánh sáng hài hòa, tổng thể bắt mắt và chuyên nghiệp hơn để thu hút khách thuê nhà."
                + " Ảnh gốc dưới đây (base64):";

        String requestBody = "{"
                + "\"contents\":[{"
                + "\"role\":\"user\","
                + "\"parts\":["
                + "{\"text\":\"" + escapeJson(fullPrompt) + "\"},"
                + "{\"inline_data\":{"
                + "\"mime_type\":\"" + mimeType + "\","
                + "\"data\":\"" + base64Image + "\""
                + "}}"
                + "]"
                + "}],"
                + "\"generationConfig\":{"
                + "\"response_mime_type\":\"image/png\","
                + "\"imageConfig\":{"
                + "\"height\":" + height + ","
                + "\"width\":" + width
                + "}"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            StringBuilder error = new StringBuilder();
            try (Scanner scanner = new Scanner(conn.getErrorStream(), StandardCharsets.UTF_8.name())) {
                while (scanner.hasNextLine()) {
                    error.append(scanner.nextLine());
                }
            }
            throw new IOException("Gemini API error: " + code + " - " + error.toString());
        }

        // Đọc dữ liệu ảnh trả về
        try (java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream(); java.io.InputStream is = conn.getInputStream()) {
            byte[] buffer = new byte[4096];
            int len;
            while ((len = is.read(buffer)) != -1) {
                baos.write(buffer, 0, len);
            }
            return baos.toByteArray();
        }
    }

    public byte[] generateImageByGemini(String prompt, int height, int width) throws IOException {
        String urlStr = apiImgUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        String requestBody = "{"
                + "\"model\":\"gemini-2.0-flash-preview-image-generation\","
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(prompt) + "\"}]}],"
                + "\"config\":{"
                + "\"responseModalities\":[\"TEXT\",\"IMAGE\"]"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            StringBuilder error = new StringBuilder();
            try (Scanner scanner = new Scanner(conn.getErrorStream(), StandardCharsets.UTF_8.name())) {
                while (scanner.hasNextLine()) {
                    error.append(scanner.nextLine());
                }
            }
            throw new IOException("Gemini API error: " + code + " - " + error.toString());
        }

        StringBuilder response = new StringBuilder();
        try (Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8.name())) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        // Parse JSON để lấy base64 image
        org.json.JSONObject json = new org.json.JSONObject(response.toString());
        org.json.JSONArray parts = json.getJSONArray("candidates")
                .getJSONObject(0)
                .getJSONObject("content")
                .getJSONArray("parts");

        for (int i = 0; i < parts.length(); i++) {
            org.json.JSONObject part = parts.getJSONObject(i);
            if (part.has("inlineData")) {
                String base64 = part.getJSONObject("inlineData").getString("data");
                return java.util.Base64.getDecoder().decode(base64);
            }
        }
        throw new IOException("No image found in response");
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
