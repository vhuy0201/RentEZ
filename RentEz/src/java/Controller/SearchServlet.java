package Controller;

import DAO.LocationDAO;
import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import DAO.UserFavoriteDAO;
import Model.Location;
import Model.Property;
import Model.PropertyType;
import Model.User;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy tham số từ request
        String searchKeyword = request.getParameter("searchKeyword");
        String roomType = request.getParameter("roomType");
        String location = request.getParameter("location");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        
        // Xử lý tham số giá
        Double minPrice = null;
        Double maxPrice = null;
        
        try {
            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            // Nếu có lỗi parse số, bỏ qua filter giá
            minPrice = null;
            maxPrice = null;
        }
        
        // Khởi tạo các DAO
        PropertyDAO propertyDAO = new PropertyDAO();
        LocationDAO locationDAO = new LocationDAO();
        PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
        
        // Tìm kiếm các phòng thỏa mãn điều kiện
        List<Property> searchResults = propertyDAO.searchProperties(searchKeyword, location, roomType, minPrice, maxPrice);
        
        // Lấy thông tin về locations để hiển thị địa chỉ
        Map<Integer, Location> locations = new HashMap<>();
        for (Property property : searchResults) {
            Location propertyLocation = locationDAO.getById(property.getLocationId());
            if (propertyLocation != null) {
                locations.put(property.getLocationId(), propertyLocation);
            }
        }        // Lấy thông tin về loại phòng
        Map<Integer, PropertyType> propertyTypes = new HashMap<>();
        List<PropertyType> allTypes = propertyTypeDAO.getAll();
        for (PropertyType type : allTypes) {
            propertyTypes.put(type.getTypeId(), type);
        }
          // Lấy danh sách các thành phố từ cơ sở dữ liệu
        List<String> allCities = locationDAO.getAllCities();
        
        // Check user favorites if logged in
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Set<Integer> userFavorites = new HashSet<>();
        
        if (currentUser != null) {
            UserFavoriteDAO favoriteDAO = new UserFavoriteDAO();
            for (Property property : searchResults) {
                if (favoriteDAO.isFavorited(currentUser.getUserId(), property.getPropertyId())) {
                    userFavorites.add(property.getPropertyId());
                }
            }
        }
        
        // Lưu thông tin vào request
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("locations", locations);
        request.setAttribute("propertyTypes", propertyTypes);
        request.setAttribute("allPropertyTypes", allTypes);
        request.setAttribute("allCities", allCities);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("selectedRoomType", roomType);
        request.setAttribute("selectedLocation", location);
        request.setAttribute("selectedMinPrice", minPrice);
        request.setAttribute("selectedMaxPrice", maxPrice);
        request.setAttribute("resultCount", searchResults.size());
        request.setAttribute("userFavorites", userFavorites);
        
        // Chuyển hướng đến trang kết quả tìm kiếm
        request.getRequestDispatcher("/view/guest/page/search-results.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
