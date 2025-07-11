package Util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Random;

public class Common {

    public static String encryptMD5(String sToEncrypt) {
        try {
            byte[] bytes = sToEncrypt.getBytes(StandardCharsets.UTF_8);

            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md5.digest(bytes);

            StringBuilder hashString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hashString.append('0');
                }
                hashString.append(hex);
            }

            return hashString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    public static String generateTimeCode(int sequence) {
        // Lấy ngày hiện tại
        Date now = new Date();
        // Định dạng ngày theo yyyyMMdd
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(now);

        // Tạo chuỗi số thứ tự dạng 3 chữ số, ví dụ 1 -> 001
        String seqStr = String.format("%03d", sequence);

        // Ghép lại
        return dateStr + seqStr;
    }
 
}
