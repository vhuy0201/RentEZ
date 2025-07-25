package Controller;

import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import Model.Property;
import Model.PropertyType;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ViewPropertyServlet", urlPatterns = {"/viewProperties"})
public class ViewPropertyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get session to retrieve LandlordID
        HttpSession session = request.getSession(false);

        User user = (User) session.getAttribute("user");
        try {
            // Retrieve properties for the landlord
            PropertyDAO propertyDAO = new PropertyDAO();
            List<Property> allProperties = propertyDAO.getPropertiesByLandlordId(user.getUserId()); // Get all properties by landlordId
            List<Property> filteredProperties = new ArrayList<>();
            PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
            Map<Integer, String> typeNames = new HashMap<>();

            // Filter properties by landlordId and retrieve TypeName
            for (Property property : allProperties) {
                if (property.getLandlordId() == user.getUserId()) {
                    filteredProperties.add(property);
                    PropertyType propertyType = propertyTypeDAO.getById(property.getTypeId());
                    if (propertyType != null) {
                        typeNames.put(property.getTypeId(), propertyType.getTypeName());
                    } else {
                        typeNames.put(property.getTypeId(), "Unknown");
                    }
                }
            }

            // Set properties list and type names as request attributes
            request.setAttribute("properties", filteredProperties);
            request.setAttribute("typeNames", typeNames);

            // Forward to viewProperty.jsp
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while retrieving properties. Please try again.");
            request.getRequestDispatcher("/view/landlord/page/viewProperty.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For now, redirect POST requests to doGet
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "View Property Servlet retrieves and displays properties for a logged-in landlord.";
    }
}
