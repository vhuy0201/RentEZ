<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css">
        <!-- Vietnamese fonts -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/landlord/common/navigation.css"/>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'orange-dark': '#e65100',
                            'orange-primary': '#ff6d00',
                            'orange-light': '#ff9800',
                        }
                    }
                }
            }
        </script>
        <title>Chat Messenger</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }
            .chat-container {
                max-width: 600px;
                margin: 40px auto;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                padding: 20px;
            }
            .message-list {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-bottom: 20px;
                max-height: 400px;
                overflow-y: auto;
                padding-right: 8px;
                background: #f9f9fb;
            }
            .message {
                max-width: 70%;
                padding: 10px 16px;
                border-radius: 18px;
                font-size: 15px;
                position: relative;
                word-break: break-word;
                display: inline-block;
                white-space: pre-line;
                overflow-wrap: break-word;
            }
            .message.right {
                align-self: flex-end;
                background: #0078ff;
                color: #fff;
                border-bottom-right-radius: 4px;
            }
            .message.left {
                align-self: flex-start;
                background: #e4e6eb;
                color: #222;
                border-bottom-left-radius: 4px;
            }
            .chat-input {
                display: flex;
                gap: 10px;
            }
            .chat-input input {
                flex: 1;
                padding: 10px;
                border-radius: 20px;
                border: 1px solid #ccc;
                font-size: 15px;
            }
            .chat-input button {
                padding: 10px 20px;
                border-radius: 20px;
                border: none;
                background: #0078ff;
                color: #fff;
                font-size: 15px;
                cursor: pointer;
            }
        </style>
    </head>  
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Include Navigation -->
                <jsp:include page="../common/navigation.jsp" />
                <div class="chat-container">
                    <h2 style="text-align:center; margin-bottom:20px;">${receiver.name}</h2>
                    <div class="message-list">
                        <c:forEach var="msg" items="${messages}">
                            <c:choose>
                                <c:when test="${msg.senderId == receiver.userId}">
                                    <div class="message left">${msg.content}</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="message right">${msg.content}</div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="chat-input">
                        <input type="text" id="messageInput" placeholder="Nhập tin nhắn..." autocomplete="off" />
                        <button onclick="sendMessage()">Gửi</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Gửi tin nhắn (chỉ thêm vào giao diện, không gửi lên server)
            window.sendMessage = function () {
                var input = document.getElementById('messageInput');
                var text = input.value.trim();
                var receiverID = ${receiver.userId};
                if (text) {
                    fetch('MessageServlet', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: new URLSearchParams({
                            receiverID: receiverID,
                            content: text
                        })
                    })
                            .then(() => {
                                fetchMessages();
                                input.value = '';
                            })
                            .catch(error => console.error('Send error:', error));

                }
            };
            // ...existing code...
            // Thêm đoạn này trước khi addEventListener
            var chatInput = document.getElementById('messageInput');
            chatInput.addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    sendMessage();
                }
            });
            // ...existing code...

            // Hàm fetch tin nhắn từ servlet
            function fetchMessages() {
                var receiverID = ${receiver.userId};
                fetch('MessageServlet?action=getMessagesInterval&receiverID=' + receiverID)
                        .then(response => response.json())
                        .then(data => {
                            var messageList = document.querySelector('.message-list');
                            messageList.innerHTML = '';
                            data.forEach(function (msg) {
                                var msgDiv = document.createElement('div');
                                if (msg.senderId === receiverID) {
                                    msgDiv.className = 'message left';
                                } else {
                                    msgDiv.className = 'message right';
                                }
                                msgDiv.textContent = msg.content;
                                messageList.appendChild(msgDiv);
                            });
                            messageList.scrollTop = messageList.scrollHeight;
                        });
            }

            // Tự động fetch mỗi 2 giây
            setInterval(fetchMessages, 500);

            // Fetch lần đầu khi load trang
            window.onload = function () {
                fetchMessages();
            };

        </script>
    </body>
</html>
