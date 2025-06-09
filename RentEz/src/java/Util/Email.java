package Util;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.DataHandler;

public class Email {    //Email: rentez.support@gmail.com
    //Password information here
    static final String from = "huybabytong.vn@gmail.com";
    static final String password = "ubva lode ucpi pkcx"; // Replace with actual password

    public static boolean sendEmail(String to, String tieuDe, String noiDung) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        //create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        //Phiên làm việc
        Session session = Session.getInstance(props, auth);

        //Tạo 1 tin nhắn
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //Tiêu đề email
            msg.setSubject(tieuDe);
            msg.setSentDate(new Date());
            //nội dung email
            msg.setContent(noiDung, "text/HTML; charset=UTF-8");
            Transport.send(msg);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }    public static String noiDungRegis(String key) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "\r\n"
                + "<h1>Welcome to RentEz - Your Property Rental Solution</h1>\r\n"
                + "<p>Your email verification code: " + key + "</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungForget(String email) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "\r\n"
                + "<h1>Hello!</h1>\r\n"
                + "<p>To reset your password, please click <a href='http://localhost:8080/RentEz/view/guest/page/passwordreset.jsp?email=" + email + "'>here</a> </p>\r\n"
                + "<p>For support, contact us at <a href='mailto:support@rentez.com'>support@rentez.com</a>.</p>\r\n"
                + "<p>RentEz Team.</p>\r\n"
                + "\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungResgisShipper(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - PROPERTY MANAGER REGISTRATION CONFIRMATION</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>Your registration information has been received.</p>\r\n"
                + "<p><b>*Note:</b></p>\r\n"
                + "<ul>\r\n"
                + "<li>Please check your email regularly to receive updates as soon as possible.</li>\r\n"
                + "<li>We will review your application and get back to you shortly.</li>\r\n"
                + "</ul>\r\n"
                + "<p>If you need additional support, please reply to this email or contact us at:</p>\r\n"
                + "<p>- Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<br/>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungChaoMungShipper(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - WELCOME PROPERTY MANAGER</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>Congratulations! You have been <b>approved</b> as a Property Manager Partner with RentEz!</p>\r\n"
                + "<p>We are excited to work with you.</p>\r\n"
                + "<p>If you need any additional information or support, please contact us via email or phone number below:</p>\r\n"
                + "<p>- Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<p>- Support Hotline: 1-800-RENTEZ</p>\r\n"
                + "<br/>\r\n"
                + "<p>We look forward to our journey together.</p>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungResgisRestaurant(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - PROPERTY OWNER REGISTRATION CONFIRMATION</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>Your property registration information has been received.</p>\r\n"
                + "<p>We wish you success in the verification process and look forward to welcoming you as an official Partner of RentEz.</p>\r\n"
                + "<br/>\r\n"
                + "<p><b>*Note:</b></p>\r\n"
                + "<ul>\r\n"
                + "<li>Please check your email regularly to receive notifications as soon as possible.</li>\r\n"
                + "<li>If there are any changes during the registration process, please contact us for assistance.</li>\r\n"
                + "</ul>\r\n"
                + "<p>If you need additional information, please contact us via email:</p>\r\n"
                + "<p>- Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<br/>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungChaoMungRestaurant(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - WELCOME PROPERTY OWNER</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>Congratulations! Your property has been <b>approved</b> as an official partner of RentEz!</p>\r\n"
                + "<br/>\r\n"
                + "<p>If you need additional information, please contact us via email or phone number below:</p>\r\n"
                + "<p>- Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<p>- Support Hotline: 1-800-RENTEZ</p>\r\n"
                + "<br/>\r\n"
                + "<p>We look forward to cooperating and partnering with you on this journey.</p>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungTuChoiRestaurant(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - PROPERTY PARTNERSHIP REJECTION NOTICE</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>We regret to inform you that after reviewing your property submission, we are <b>unable to approve</b> your request to become an official partner of RentEz at this time.</p>\r\n"
                + "<p>We appreciate your interest and desire to partner with us. However, your property does not currently meet our partnership criteria.</p>\r\n"
                + "<br/>\r\n"
                + "<p>If you have any questions or need additional information, please contact us via email or phone number below:</p>\r\n"
                + "<p>- Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<p>- Support Hotline: 1-800-RENTEZ</p>\r\n"
                + "<br/>\r\n"
                + "<p>We hope to have the opportunity to partner with you in the future.</p>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungTuChoiShipper(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - PROPERTY MANAGER PARTNERSHIP REJECTION NOTICE</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>We regret to inform you that after reviewing your application, we are <b>unable to approve</b> your request to become a Property Manager Partner with RentEz at this time.</p>\r\n"
                + "<p>We appreciate your interest and desire to partner with us. However, your profile does not currently meet our partnership criteria.</p>\r\n"
                + "<br/>\r\n"
                + "<p>If you have any questions or need additional information, please contact us via email or phone number below:</p>\r\n"
                + "<p>- Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<p>- Support Hotline: 1-800-RENTEZ</p>\r\n"
                + "<br/>\r\n"
                + "<p>We hope to have the opportunity to partner with you in the future.</p>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }    public static String noiDungThongBaoBan(String name) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<body>\r\n"
                + "<h1>RENTEZ - ACCOUNT SUSPENSION NOTICE</h1>\r\n"
                + "<p>Dear <b>" + name + "</b>,</p>\r\n"
                + "<p>We regret to inform you that your account has been <b>suspended</b> due to multiple serious violations in your partnership with RentEz.</p>\r\n"
                + "<p>This decision has been made to ensure service quality and safety for all parties involved.</p>\r\n"
                + "<p>If you have any questions or wish to appeal this decision, please contact our support team via email:</p>\r\n"
                + "<p>- Support Email: <a href='mailto:support@rentez.com'>support@rentez.com</a></p>\r\n"
                + "<p>We apologize for any inconvenience and appreciate your understanding.</p>\r\n"
                + "<p>Best regards,</p>\r\n"
                + "<p>RentEz Support Team</p>\r\n"
                + "</body>\r\n"
                + "</html>";
    }

}
