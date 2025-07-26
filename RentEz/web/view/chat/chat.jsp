<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat - RentEz</title>
        
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }
            .chat-container {
                max-width: 800px;
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
                background: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 8px;
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
                background: #007bff;
                color: #fff;
                border-bottom-right-radius: 4px;
            }
            .message.left {
                align-self: flex-start;
                background: #e9ecef;
                color: #212529;
                border-bottom-left-radius: 4px;
            }
            .chat-input {
                display: flex;
                gap: 10px;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 8px;
                border: 1px solid #dee2e6;
            }
            .chat-input input {
                flex: 1;
                padding: 10px 15px;
                border-radius: 20px;
                border: 1px solid #dee2e6;
                font-size: 15px;
                transition: all 0.3s ease;
            }
            .chat-input input:focus {
                outline: none;
                border-color: #007bff;
            }
            .chat-input button {
                padding: 10px 20px;
                border-radius: 20px;
                border: none;
                background: #007bff;
                color: #fff;
                font-size: 15px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .chat-input button:hover {
                background: #0056b3;
            }
            .chat-header {
                display: flex;
                align-items: center;
                gap: 15px;
                padding-bottom: 20px;
                border-bottom: 1px solid #dee2e6;
                margin-bottom: 20px;
            }
            .chat-header img {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                object-fit: cover;
            }
            .chat-header h2 {
                margin: 0;
                font-size: 1.25rem;
                color: #212529;
            }
        </style>
    </head>
    <body class="body-bg">
        <main>
            <jsp:include page="/view/common/header.jsp" />
            
            <div class="container">
                <div class="chat-container">
                    <div class="chat-header">
                        <img src="${receiver.avatar != null ? receiver.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                             alt="${receiver.name}" 
                             onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'">
                        <h2>${receiver.name}</h2>
                    </div>
                    
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
                        <button onclick="sendMessage()">
                            <i class="fas fa-paper-plane"></i> Gửi
                        </button>
                    </div>
                </div>
            </div>
            
            <jsp:include page="/view/common/footer.jsp" />
        </main>

        <!-- Existing JavaScript -->
        <script>
            // Gửi tin nhắn (chỉ thêm vào giao diện, không gửi lên server)
            window.sendMessage = function() {
                var input = document.getElementById('messageInput');
                var text = input.value.trim();
                var receiverID = ${receiver.userId};
                if(text) {
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
            // Thêm đoạn này trước khi addEventListener
            var chatInput = document.getElementById('messageInput');
            chatInput.addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    sendMessage();
                }
            });

            // Hàm fetch tin nhắn từ servlet
            function fetchMessages() {
                var receiverID = ${receiver.userId};
                fetch('MessageServlet?action=getMessagesInterval&receiverID=' + receiverID)
                    .then(response => response.json())
                    .then(data => {
                        var messageList = document.querySelector('.message-list');
                        messageList.innerHTML = '';
                        data.forEach(function(msg) {
                            var msgDiv = document.createElement('div');
                            if(msg.senderId === receiverID) {
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
            window.onload = function() {
                fetchMessages();
            };
          
        </script>
    </body>
</html>
