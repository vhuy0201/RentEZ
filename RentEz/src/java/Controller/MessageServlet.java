/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MessageDAO;
import DAO.UsersDao;
import Model.Message;
import Model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;


public class MessageServlet extends HttpServlet {
    User user;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        user = (User) session.getAttribute("user");
        String actor = user.getRole();
        switch (actor) {
            case "Landlord" -> {
                landLordGet(request, response);
            }
            
            case "Renter" -> {
                renterGet(request, response);
            }
        }
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        user = (User) session.getAttribute("user");

        String content = request.getParameter("content");
        int receiverID = Integer.parseInt(request.getParameter("receiverID"));

        if (content != null && !content.isEmpty()) {
            Message message = new Message();
            message.setContent(content);
            message.setSenderId(user.getUserId());
            message.setReceiverId(receiverID);
            message.setReadStatus(true);
            message.setSendDate(new Date());
            new MessageDAO().sendMessage(message);
        }
    }
    
    
    private void renterGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getLandLord" -> {
                List<User> userList = new UsersDao().getUsersHaveMessage(user.getUserId());
                request.setAttribute("users", userList);
                request.getRequestDispatcher("view/chat/userChat.jsp").forward(request, response);
            }
            
            case "getMessages" -> {
                int receiverID = Integer.parseInt(request.getParameter("receiverID"));
                User receiver = new UsersDao().getById(receiverID);
                List<Message> messages = new MessageDAO().getMessagesBetweenUsers(user.getUserId(), receiverID);
                request.setAttribute("receiver", receiver);
                request.setAttribute("messages", messages);
                request.getRequestDispatcher("view/chat/chat.jsp").forward(request, response);
            }
            case "getMessagesInterval" -> {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                int receiverID = Integer.parseInt(request.getParameter("receiverID"));

                List<Message> messages = new MessageDAO().getMessagesBetweenUsers(user.getUserId(), receiverID);

                Gson gson = new GsonBuilder()
                        .setDateFormat("yyyy-MM-dd HH:mm:ss")
                        .create();
                String data = gson.toJson(messages);

                try (PrintWriter out = response.getWriter()) {
                    out.write(data);
                    out.flush();
                }
            }
        }
    }
    
    private void landLordGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getUsers" -> {
                List<User> userList = new UsersDao().getUsersHaveMessage(user.getUserId());
                request.setAttribute("users", userList);
                request.getRequestDispatcher("view/landlord/page/userChat.jsp").forward(request, response);
            }
            
            case "getMessages" -> {
                int receiverID = Integer.parseInt(request.getParameter("receiverID"));
                User receiver = new UsersDao().getById(receiverID);
                List<Message> messages = new MessageDAO().getMessagesBetweenUsers(user.getUserId(), receiverID);
                request.setAttribute("receiver", receiver);
                request.setAttribute("messages", messages);
                request.getRequestDispatcher("view/landlord/page/chat.jsp").forward(request, response);
            }
            
            case "getMessagesInterval" -> {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                int receiverID = Integer.parseInt(request.getParameter("receiverID"));

                List<Message> messages = new MessageDAO().getMessagesBetweenUsers(user.getUserId(), receiverID);

                Gson gson = new GsonBuilder()
                        .setDateFormat("yyyy-MM-dd HH:mm:ss")
                        .create();
                String data = gson.toJson(messages);

                try (PrintWriter out = response.getWriter()) {
                    out.write(data);
                    out.flush();
                }
            }
        }
    }
}
