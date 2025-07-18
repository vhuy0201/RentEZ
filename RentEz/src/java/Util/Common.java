package Util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
 
}
