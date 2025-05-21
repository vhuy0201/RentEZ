package Model;

public class Location {
    private int locationId;
    private String address;
    private String city;
    private String stateProvince;
    private String country;
    private String zipCode;

    public Location() {
    }

    public Location(int locationId, String address, String city, String stateProvince, String country, String zipCode) {
        this.locationId = locationId;
        this.address = address;
        this.city = city;
        this.stateProvince = stateProvince;
        this.country = country;
        this.zipCode = zipCode;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStateProvince() {
        return stateProvince;
    }

    public void setStateProvince(String stateProvince) {
        this.stateProvince = stateProvince;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    
}
