package Model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String role; // 'Landlord', 'Renter', 'Both'
    private String password;
    private String CardIdFront;
    private String CardIdBack;

    public User() {
    }

    public User(int userId, String name, String email, String phone, String address, String role, String password, String CardIdFront, String CardIdBack) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.password = password;
        this.CardIdFront = CardIdFront;
        this.CardIdBack = CardIdBack;
    }

    public String getCardIdFront() {
        return CardIdFront;
    }

    public void setCardIdFront(String CardIdFront) {
        this.CardIdFront = CardIdFront;
    }

    public String getCardIdBack() {
        return CardIdBack;
    }

    public void setCardIdBack(String CardIdBack) {
        this.CardIdBack = CardIdBack;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
}
