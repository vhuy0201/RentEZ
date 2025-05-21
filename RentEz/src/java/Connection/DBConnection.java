package Connection;

import java.sql.*;

public class DBConnection {
    private static String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static String username = "sa";
    private static String password = "123";
    private static String jdbcURL = "jdbc:sqlserver://DESKTOP-B30H0L1;databaseName=RentEZ;encrypt=true;trustServerCertificate=true;loginTimeout=30";
    //kết nối datebase dùng URL username, password. Thả ra lỗi 
    
    public static Connection getConnection(){
        Connection con = null;
        try{
            Class.forName(driverClass);
            con = (Connection) DriverManager.getConnection(jdbcURL, username, password);
        } catch (Exception e){
            System.out.println("Error: " + e);
        }
        return con;
    }
}
