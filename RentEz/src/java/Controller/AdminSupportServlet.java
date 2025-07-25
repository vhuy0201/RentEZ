package Controller;

import java.io.IOException;
import java.util.List;

import DAO.SupportTicketDAO;
import DAO.ReviewDAO;
import Model.SupportTicket;
import Model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminSupportServlet", urlPatterns = {"/admin/support"})
public class AdminSupportServlet extends HttpServlet {
    
    private SupportTicketDAO supportDAO;
    private ReviewDAO reviewDAO;
    
    @Override
    public void init() throws ServletException {
        supportDAO = new SupportTicketDAO();
        reviewDAO = new ReviewDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "dashboard";
        }
        
        try {
            switch (action) {
                case "tickets":
                    showTickets(request, response);
                    break;
                case "reviews":
                    showReviews(request, response);
                    break;
                default:
                    showSupportDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void showSupportDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get summary statistics
        int openTickets = supportDAO.getOpenTicketsCount();
        int totalReviews = reviewDAO.getTotalReviewsCount();
        double averageRating = reviewDAO.getAverageRating();
        
        // Get recent items
        List<SupportTicket> recentTickets = supportDAO.getRecentTickets(5);
        List<Review> recentReviews = reviewDAO.getRecentReviews(5);
        
        request.setAttribute("openTickets", openTickets);
        request.setAttribute("totalReviews", totalReviews);
        request.setAttribute("averageRating", averageRating);
        request.setAttribute("recentTickets", recentTickets);
        request.setAttribute("recentReviews", recentReviews);
        
        request.getRequestDispatcher("/view/admin/support-dashboard.jsp").forward(request, response);
    }
    
    private void showTickets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<SupportTicket> tickets = supportDAO.getAllTickets();
        request.setAttribute("tickets", tickets);
        
        request.getRequestDispatcher("/view/admin/support-tickets.jsp").forward(request, response);
    }
    
    private void showReviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Review> reviews = reviewDAO.getAllReviews();
        request.setAttribute("reviews", reviews);
        
        request.getRequestDispatcher("/view/admin/support-reviews.jsp").forward(request, response);
    }
    

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "updateTicket":
                    updateTicket(request, response);
                    break;
                case "updateReview":
                    updateReview(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/support");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
    
    private void updateTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        String status = request.getParameter("status");
        String adminResponse = request.getParameter("adminResponse");
        
        boolean success = supportDAO.updateTicketStatus(ticketId, status, adminResponse);
        
        if (success) {
            request.getSession().setAttribute("message", "Ticket đã được cập nhật thành công!");
        } else {
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật ticket!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/support?action=tickets");
    }
    
    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        boolean isPublished = Boolean.parseBoolean(request.getParameter("isPublished"));
        
        boolean success = reviewDAO.updateReviewStatus(reviewId, isPublished);
        
        if (success) {
            request.getSession().setAttribute("message", "Đánh giá đã được cập nhật thành công!");
        } else {
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật đánh giá!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/support?action=reviews");
    }
}
