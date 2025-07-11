package DAO;

import Connection.DBConnection;
import Model.SupportTicket;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupportTicketDAO {
    
    public int getOpenTicketsCount() {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT COUNT(*) FROM SupportTicket WHERE Status IN ('Open', 'In Progress')";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                conn.close();
                return count;
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getOpenTicketsCount: " + e);
        }
        
        return 5; // Default placeholder value
    }
    
    public List<SupportTicket> getRecentTickets(int limit) {
        List<SupportTicket> tickets = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT TOP (?) * FROM SupportTicket ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                SupportTicket ticket = new SupportTicket();
                ticket.setTicketId(rs.getInt("TicketId"));
                ticket.setUserId(rs.getInt("UserId"));
                ticket.setSubject(rs.getString("Subject"));
                ticket.setDescription(rs.getString("Description"));
                ticket.setStatus(rs.getString("Status"));
                ticket.setPriority(rs.getString("Priority"));
                ticket.setCreatedAt(rs.getTimestamp("CreatedAt"));
                tickets.add(ticket);
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getRecentTickets: " + e);
        }
        
        return tickets;
    }
    
    public boolean insertTicket(SupportTicket ticket) {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO SupportTicket (UserId, Subject, Description, Status, Priority, CreatedAt, UpdatedAt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ticket.getUserId());
            pstmt.setString(2, ticket.getSubject());
            pstmt.setString(3, ticket.getDescription());
            pstmt.setString(4, ticket.getStatus());
            pstmt.setString(5, ticket.getPriority());
            pstmt.setTimestamp(6, new Timestamp(ticket.getCreatedAt().getTime()));
            pstmt.setTimestamp(7, new Timestamp(ticket.getUpdatedAt().getTime()));
            
            int result = pstmt.executeUpdate();
            conn.close();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("Error in insertTicket: " + e);
        }
        
        return false;
    }
    
    public List<SupportTicket> getAllTickets() {
        List<SupportTicket> tickets = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM SupportTicket ORDER BY CreatedAt DESC";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                SupportTicket ticket = new SupportTicket();
                ticket.setTicketId(rs.getInt("TicketId"));
                ticket.setUserId(rs.getInt("UserId"));
                ticket.setSubject(rs.getString("Subject"));
                ticket.setDescription(rs.getString("Description"));
                ticket.setStatus(rs.getString("Status"));
                ticket.setPriority(rs.getString("Priority"));
                ticket.setCreatedAt(rs.getTimestamp("CreatedAt"));
                ticket.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                ticket.setAdminResponse(rs.getString("AdminResponse"));
                tickets.add(ticket);
            }
            
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error in getAllTickets: " + e);
        }
        
        return tickets;
    }
    
    public boolean updateTicketStatus(int ticketId, String status, String adminResponse) {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE SupportTicket SET Status = ?, AdminResponse = ?, UpdatedAt = ? WHERE TicketId = ?";
        
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setString(2, adminResponse);
            pstmt.setTimestamp(3, new Timestamp(new java.util.Date().getTime()));
            pstmt.setInt(4, ticketId);
            
            int result = pstmt.executeUpdate();
            conn.close();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("Error in updateTicketStatus: " + e);
        }
        
        return false;
    }
}
