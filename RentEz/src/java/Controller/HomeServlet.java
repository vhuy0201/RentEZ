/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.PropertyDAO;
import DAO.PropertyTypeDAO;
import DAO.LocationDAO;
import DAO.UserDao;
import DAO.UserFavoriteDAO;
import Model.Property;
import Model.PropertyType;
import Model.Location;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.HashMap;
import java.util.Set;


public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDAO = new UserDao();
        PropertyDAO propertyDAO = new PropertyDAO();
        PropertyTypeDAO propertyTypeDAO = new PropertyTypeDAO();
        LocationDAO locationDAO = new LocationDAO();

        // Get all users
        List<User> users = userDAO.getAll();
        request.setAttribute("users", users);

        // Get all properties
        List<Property> allProperties = propertyDAO.getAll();
        
        // Get featured properties (limit to 6)
        List<Property> featuredProperties = new ArrayList<>();
        int count = 0;
        for (Property property : allProperties) {
            if ("Available".equals(property.getAvailabilityStatus()) && count < 6) {
                featuredProperties.add(property);
                count++;
            }
        }
        
        // Create a map to store property types by ID
        HashMap<Integer, String> propertyTypes = new HashMap<>();
        // Create a map to store locations by ID
        HashMap<Integer, Location> locations = new HashMap<>();
        
        // Retrieve property types and locations for each featured property
        for (Property property : featuredProperties) {
            // Get property type
            if (!propertyTypes.containsKey(property.getTypeId())) {
                PropertyType type = propertyTypeDAO.getById(property.getTypeId());
                if (type != null) {
                    propertyTypes.put(property.getTypeId(), type.getTypeName());
                } else {
                    propertyTypes.put(property.getTypeId(), "Unknown");
                }
            }
            
            // Get location
            if (!locations.containsKey(property.getLocationId())) {
                Location location = locationDAO.getById(property.getLocationId());
                if (location != null) {
                    locations.put(property.getLocationId(), location);
                }
            }
        }
          // Pass data to JSP
        request.setAttribute("featuredProperties", featuredProperties);
        request.setAttribute("propertyTypes", propertyTypes);
        request.setAttribute("locations", locations);
        
        // Get all property types for search form
        List<PropertyType> allPropertyTypes = propertyTypeDAO.getAll();
        request.setAttribute("allPropertyTypes", allPropertyTypes);
          // Get all cities for search form
        List<String> allCities = locationDAO.getAllCities();
        request.setAttribute("allCities", allCities);

        // Check user favorites if logged in
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Set<Integer> userFavorites = new HashSet<>();
        
        if (currentUser != null) {
            UserFavoriteDAO favoriteDAO = new UserFavoriteDAO();
            for (Property property : featuredProperties) {
                if (favoriteDAO.isFavorited(currentUser.getUserId(), property.getPropertyId())) {
                    userFavorites.add(property.getPropertyId());
                }
            }
        }

        request.setAttribute("userFavorites", userFavorites);

        // Forward to JSP
        request.getRequestDispatcher("view/guest/page/homepage.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
