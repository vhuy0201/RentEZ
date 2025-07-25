<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Danh sách người dùng đã nhắn tin</h2>
        <ul style="list-style: none; padding: 0;">
            <c:forEach var="u" items="${users}">
                <li style="margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px; display: flex; align-items: center;">
                    <a href="MessageServlet?action=getMessages&receiverID=${u.userId}" onclick="selectUser(${u.userId})" style="text-decoration: none; color: inherit; display: flex; align-items: center;">
                        <img src="${u.avatar}" alt="avatar" style="width:40px; height:40px; border-radius:50%; margin-right:10px; object-fit:cover;" onerror="this.src='https://ui-avatars.com/api/?name='+encodeURIComponent('${u.name}')">
                        <div>
                            <div style="font-weight:bold; font-size:16px;">${u.name}</div>
                            <div style="font-size:13px; color:#666;">${u.email} | ${u.phone}</div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
        <script>
            function selectUser(userId) {
                // Thực hiện hành động khi bấm vào user, ví dụ gọi ajax lấy tin nhắn
                // Có thể thay bằng window.location hoặc ajax
            }
        </script>
    </body>
</html>
