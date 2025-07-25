package Controller;

import Util.VNPayConfig;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.User;

/**
 * VNPay Payment Processing Servlet
 * Based on VNPay official demo code
 */
@WebServlet(name = "VNPayServlet", urlPatterns = {"/vnpay-payment"})
public class VNPayServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Check if user is logged in
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            
            if (currentUser == null) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("code", "01");
                errorResponse.addProperty("message", "Vui lòng đăng nhập để thực hiện thanh toán");
                response.getWriter().write(new Gson().toJson(errorResponse));
                return;
            }
            
            // Get payment parameters
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";
            
            // Get amount from request and convert to VNPay format (multiply by 100)
            String amountStr = request.getParameter("amount");
            if (amountStr == null || amountStr.trim().isEmpty()) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("code", "02");
                errorResponse.addProperty("message", "Số tiền không hợp lệ");
                response.getWriter().write(new Gson().toJson(errorResponse));
                return;
            }
            
            long amount = Long.parseLong(amountStr) * 100; // VNPay requires amount in cents
            String bankCode = request.getParameter("bankCode");
            
            // Generate transaction reference
            String vnp_TxnRef = VNPayConfig.getRandomNumber(8);
            String vnp_IpAddr = VNPayConfig.getIpAddress(request);
            String vnp_TmnCode = VNPayConfig.vnp_TmnCode;
            
            // Build VNPay parameters
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");
            
            if (bankCode != null && !bankCode.isEmpty()) {
                vnp_Params.put("vnp_BankCode", bankCode);
            }
            
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Nap tien vao vi RentEz - User: " + currentUser.getName() + " - TxnRef: " + vnp_TxnRef);
            vnp_Params.put("vnp_OrderType", orderType);

            // Set locale
            String locale = request.getParameter("language");
            if (locale != null && !locale.isEmpty()) {
                vnp_Params.put("vnp_Locale", locale);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            // Set create date and expire date
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            
            cld.add(Calendar.MINUTE, 15); // Expire after 15 minutes
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
            
            // Build hash data and query string
            List fieldNames = new ArrayList(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator itr = fieldNames.iterator();
            
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    // Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            
            String queryUrl = query.toString();
            String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;
            
            // Store transaction info in session for later verification
            session.setAttribute("vnpay_txnref", vnp_TxnRef);
            session.setAttribute("vnpay_amount", amountStr);
            session.setAttribute("vnpay_user_id", currentUser.getUserId());
            
            // Return success response with payment URL
            JsonObject successResponse = new JsonObject();
            successResponse.addProperty("code", "00");
            successResponse.addProperty("message", "success");
            successResponse.addProperty("data", paymentUrl);
            
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(successResponse));
            
        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("code", "99");
            errorResponse.addProperty("message", "Có lỗi xảy ra: " + e.getMessage());
            response.getWriter().write(new Gson().toJson(errorResponse));
        }
    }
}
