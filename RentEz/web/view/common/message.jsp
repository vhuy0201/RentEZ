<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentEz - Tin nhắn</title>

    <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />

    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
    <!-- Font awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
    <!-- line awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-enhancement.css" />
      <style>
        :root {
            --primary-color: #0084ff;
            --light-primary-color: #e6f2ff;
            --success-color: #28a745;
            --light-gray: #f5f7fa;
            --dark-gray: #6c757d;
            --message-sent-bg: #0084ff;
            --message-received-bg: #ffffff;
        }
        
        .chat-container {
            display: flex;
            height: calc(100vh - 180px);
            margin: 30px auto;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        
        .conversation-list {
            width: 30%;
            border-right: 1px solid #e0e0e0;
            overflow-y: auto;
            background-color: var(--light-gray);
        }
        
        .conversation-item {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
        }
        
        .conversation-item:hover {
            background-color: rgba(0, 132, 255, 0.05);
        }
        
        .conversation-item.active {
            background-color: var(--light-primary-color);
            border-left: 4px solid var(--primary-color);
        }
        
        .avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
            object-fit: cover;
            border: 2px solid white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .user-info {
            flex: 1;
        }
        
        .user-name {
            font-weight: bold;
            margin: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .property-title {
            font-size: 12px;
            color: var(--dark-gray);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-weight: 500;
        }
        
        .last-message {
            font-size: 13px;
            color: var(--dark-gray);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin: 3px 0;
        }
        
        .message-time {
            font-size: 11px;
            color: var(--dark-gray);
        }
        
        .unread-badge {
            background-color: var(--primary-color);
            color: white;
            font-size: 11px;
            padding: 2px 8px;
            border-radius: 12px;
            margin-left: 5px;
            font-weight: 600;
        }
        
        .chat-area {
            width: 70%;
            display: flex;
            flex-direction: column;
            background-color: #f5f7fa;
        }
        
        .chat-header {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            background-color: #ffffff;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .chat-header .user-info {
            margin-left: 15px;
        }
        
        .status-indicator {
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            margin-right: 5px;
        }
        
        .status-online {
            background-color: var(--success-color);
        }
        
        .status-offline {
            background-color: var(--dark-gray);
        }
        
        .messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background-color: #f0f2f5;
            display: flex;
            flex-direction: column;
            background-image: url('${pageContext.request.contextPath}/view/guest/asset/img/chat-bg-pattern.png');
            background-size: 200px;
            background-blend-mode: lighten;
            background-color: rgba(245, 247, 250, 0.8);
        }
        
        .message {
            margin-bottom: 12px;
            max-width: 75%;
            display: flex;
            flex-direction: column;
            position: relative;
            clear: both;
        }
        
        .message-content {
            padding: 10px 15px;
            border-radius: 18px;
            position: relative;
            word-wrap: break-word;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
            line-height: 1.4;
        }
        
        .message-sent {
            align-self: flex-end;
            float: right;
        }
        
        .message-sent .message-content {
            background-color: var(--message-sent-bg);
            color: white;
            border-bottom-right-radius: 4px;
        }
        
        .message-received {
            align-self: flex-start;
            float: left;
        }
        
        .message-received .message-content {
            background-color: var(--message-received-bg);
            color: #212529;
            border-bottom-left-radius: 4px;
        }
        
        .message-time {
            font-size: 10px;
            color: rgba(108, 117, 125, 0.8);
            margin-top: 4px;
            display: block;
            text-align: right;
        }
        
        .message-sent .message-time {
            padding-right: 8px;
        }
        
        .message-received .message-time {
            text-align: left;
            padding-left: 8px;
        }
        
        .message-status {
            font-size: 10px;
            margin-top: 2px;
            color: rgba(255, 255, 255, 0.7);
        }
        
        .input-area {
            padding: 15px;
            border-top: 1px solid #e0e0e0;
            background-color: #ffffff;
            display: flex;
            align-items: center;
            position: relative;
        }
        
        .message-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            border-radius: 24px;
            margin-right: 10px;
            resize: none;
            font-size: 14px;
            transition: border 0.3s ease;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        
        .message-input:focus {
            border-color: var(--primary-color);
            outline: none;
        }
          .send-button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 44px;
            height: 44px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(0, 132, 255, 0.3);
        }
        
        .send-button:hover:not(:disabled) {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 132, 255, 0.4);
        }
        
        .send-button:disabled {
            background-color: #abbad3;
            cursor: not-allowed;
            box-shadow: none;
        }
        
        .no-conversation-message {
            text-align: center;
            padding: 30px;
            color: var(--dark-gray);
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            margin: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .empty-state {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            background-color: var(--light-gray);
            color: var(--dark-gray);
            text-align: center;
            padding: 40px 20px;
        }
        
        .empty-state i {
            font-size: 60px;
            margin-bottom: 20px;
            color: var(--primary-color);
            opacity: 0.8;
        }
        
        .property-box {
            background-color: var(--light-gray);
            border-radius: 8px;
            padding: 10px 12px;
            margin-top: 8px;
            border-left: 3px solid var(--primary-color);
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        
        .property-box a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            display: block;
            margin-bottom: 3px;
        }
        
        .property-box a:hover {
            text-decoration: underline;
        }
        
        .chat-date-separator {
            text-align: center;
            color: var(--dark-gray);
            font-size: 12px;
            margin: 15px 0;
            position: relative;
        }
        
        .chat-date-separator:before,
        .chat-date-separator:after {
            content: "";
            position: absolute;
            height: 1px;
            background-color: #e0e0e0;
            top: 50%;
            width: 30%;
        }
        
        .chat-date-separator:before {
            left: 0;
        }
        
        .chat-date-separator:after {
            right: 0;
        }
        
        .chat-date-separator span {
            background-color: #f0f2f5;
            padding: 0 15px;
            position: relative;
            z-index: 1;
        }
        
        .typing-indicator {
            display: none;
            padding: 8px;
            margin-bottom: 10px;
            align-self: flex-start;
        }
        
        .typing-indicator span {
            height: 8px;
            width: 8px;
            float: left;
            margin: 0 1px;
            background-color: #9E9EA1;
            display: block;
            border-radius: 50%;
            opacity: 0.4;
        }
        
        .typing-indicator span:nth-of-type(1) {
            animation: typing 1s infinite 0s;
        }
        
        .typing-indicator span:nth-of-type(2) {
            animation: typing 1s infinite 0.2s;
        }
        
        .typing-indicator span:nth-of-type(3) {
            animation: typing 1s infinite 0.4s;
        }
        
        @keyframes typing {
            0% { transform: translateY(0px); }
            33% { transform: translateY(-5px); }
            66% { transform: translateY(0px); }
        }
        
        @media (max-width: 768px) {
            .chat-container {
                flex-direction: column;
                height: calc(100vh - 140px);
                margin: 15px auto;
            }
            
            .conversation-list, .chat-area {
                width: 100%;
            }
            
            .conversation-list {
                height: 35%;
                border-right: none;
                border-bottom: 1px solid #e0e0e0;
            }
            
            .chat-area {
                height: 65%;
            }
            
            .message {
                max-width: 85%;
            }
        }
    </style>
</head>
<body>
    <!-- Include header -->
    <jsp:include page="/view/common/header.jsp" />

    <main class="main">
        <div class="container">
            <div class="row mb-4">
                <div class="col">
                    <h2 class="page-title">Tin nhắn</h2>
                </div>
            </div>
            
            <div class="chat-container">
                <!-- Danh sách cuộc trò chuyện -->
                <div class="conversation-list">
                    <c:choose>
                        <c:when test="${not empty conversations}">
                            <c:forEach var="conversation" items="${conversations}">
                                <div class="conversation-item ${conversation.userId == chatUser.userId ? 'active' : ''}" 
                                     onclick="location.href='${pageContext.request.contextPath}/messages?userId=${conversation.userId}&propertyId=${conversation.propertyId}'">
                                    
                                    <img src="${pageContext.request.contextPath}/${not empty conversation.userAvatar ? conversation.userAvatar : '/view/guest/asset/img/default-avatar.png'}" 
                                         class="avatar" alt="${conversation.userName}" 
                                         onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                                    
                                    <div class="user-info">
                                        <h5 class="user-name">
                                            ${conversation.userName}
                                            <c:if test="${conversation.unreadCount > 0}">
                                                <span class="unread-badge">${conversation.unreadCount}</span>
                                            </c:if>
                                        </h5>
                                        <p class="property-title">${conversation.propertyTitle}</p>
                                        <p class="last-message">${conversation.lastMessage}</p>
                                        <span class="message-time">
                                            <fmt:formatDate value="${conversation.lastMessageDate}" pattern="dd/MM/yyyy HH:mm" />
                                            <span class="status-indicator ${conversation.isOnline ? 'status-online' : 'status-offline'}"></span>
                                            ${conversation.isOnline ? 'Online' : 'Offline'}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-conversation-message">
                                <p>Bạn chưa có cuộc trò chuyện nào.</p>
                                <p>Hãy bắt đầu bằng cách nhắn tin cho chủ nhà hoặc người thuê tiềm năng!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Khu vực chat -->
                <div class="chat-area">
                    <c:choose>
                        <c:when test="${not empty chatUser}">
                            <!-- Tiêu đề chat -->
                            <div class="chat-header">
                                <img src="${pageContext.request.contextPath}/${not empty chatUser.avatar ? chatUser.avatar : '/view/guest/asset/img/default-avatar.png'}" 
                                     class="avatar" alt="${chatUser.name}" 
                                     onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                                  <div class="user-info">
                                    <h5 class="user-name">
                                        ${chatUser.name}
                                        <span id="userStatus" class="status-indicator status-offline"></span>
                                        <span>Offline</span>
                                    </h5>
                                    <div class="property-box">
                                        <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}">${property.title}</a>
                                        <p class="mb-0">${propertyLocation.address}, ${propertyLocation.city}</p>
                                    </div>
                                </div>
                            </div>
                              <!-- Tin nhắn -->
                            <div class="messages" id="messageContainer">                                <c:forEach var="message" items="${messages}">
                                    <div class="message ${message.senderId == sessionScope.user.userId ? 'message-sent' : 'message-received'}">
                                        <div class="message-content">
                                            ${message.content}
                                            <span class="message-time">
                                                <fmt:formatDate value="${message.sendDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <!-- Typing indicator -->
                                <div id="typingIndicator" class="typing-indicator" style="display:none;">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>
                            
                            <!-- Khu vực nhập tin nhắn -->
                            <div class="input-area">
                                <textarea id="messageInput" class="message-input" placeholder="Nhập tin nhắn..." rows="1"></textarea>
                                <button id="sendButton" class="send-button" disabled>
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </div>
                            
                            <input type="hidden" id="receiverId" value="${chatUser.userId}" />
                            <input type="hidden" id="propertyId" value="${property.propertyId}" />
                        </c:when>
                        <c:otherwise>
                            <!-- Hiển thị trạng thái trống -->
                            <div class="empty-state">
                                <i class="far fa-comments"></i>
                                <h3>Chào mừng đến với tin nhắn</h3>
                                <p>Chọn một cuộc trò chuyện từ danh sách bên trái hoặc bắt đầu một cuộc trò chuyện mới.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>

    <!-- Include footer -->
    <jsp:include page="/view/common/footer.jsp" />

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
      <c:if test="${not empty chatUser}">
        <script>            // Khởi tạo kết nối WebSocket
            let socket = null;
            const messageContainer = document.getElementById("messageContainer");
            const messageInput = document.getElementById("messageInput");
            const sendButton = document.getElementById("sendButton");
            const receiverId = document.getElementById("receiverId").value;
            const propertyId = document.getElementById("propertyId").value;
            const currentUserId = <c:out value="${sessionScope.user.userId}"/>;
            
            // Grouping similar dates
            const processedDates = new Set();
            
            // Insert date separator if needed
            function insertDateSeparatorIfNeeded(date) {
                const dateString = date.toLocaleDateString('vi-VN');
                if (!processedDates.has(dateString)) {
                    processedDates.add(dateString);
                    
                    const separator = document.createElement("div");
                    separator.className = "chat-date-separator";
                    separator.innerHTML = `<span>${dateString}</span>`;
                    messageContainer.appendChild(separator);
                }
            }
            
            // Connect đến WebSocket server
            function connectWebSocket() {
                // Tạo WebSocket connection
                const wsUrl = "ws://" + window.location.host + "${pageContext.request.contextPath}/chat/" + currentUserId;
                socket = new WebSocket(wsUrl);
                
                // Xử lý khi mở kết nối
                socket.onopen = function(event) {
                    console.log("WebSocket connection established");
                    // Kích hoạt nút gửi
                    updateSendButtonState();
                };
                
                // Xử lý khi nhận tin nhắn
                socket.onmessage = function(event) {
                    const message = JSON.parse(event.data);
                    
                    // Kiểm tra xem tin nhắn có thuộc cuộc trò chuyện hiện tại không
                    if ((message.senderId == currentUserId && message.receiverId == receiverId) || 
                        (message.senderId == receiverId && message.receiverId == currentUserId)) {
                        
                        addMessageToChat(message, true);
                    }
                };
                
                // Xử lý khi đóng kết nối
                socket.onclose = function(event) {
                    console.log("WebSocket connection closed");
                    setTimeout(connectWebSocket, 3000); // Thử kết nối lại sau 3s
                };
                
                // Xử lý khi lỗi
                socket.onerror = function(error) {
                    console.error("WebSocket error:", error);
                };
            }
            
            // Thêm tin nhắn vào chat
            function addMessageToChat(message, fromServer = false) {
                // Kiểm tra tin nhắn có phải của người hiện tại không
                const isSentByMe = message.senderId == currentUserId;
                
                // Format thời gian
                const messageDate = fromServer ? new Date(message.sendDate) : new Date();
                
                // Add date separator if it's a new date
                insertDateSeparatorIfNeeded(messageDate);
                
                const formattedTime = messageDate.getHours().toString().padStart(2, '0') + ':' + 
                                    messageDate.getMinutes().toString().padStart(2, '0');
                
                // Tạo phần tử tin nhắn mới
                const messageDiv = document.createElement("div");
                messageDiv.className = `message ${isSentByMe ? 'message-sent' : 'message-received'}`;
                
                // Thêm nội dung tin nhắn
                let messageContent = `
                    <div class="message-content">
                        ${message.content}
                        <span class="message-time">${formattedTime}`;
                
                // Add delivery status for sent messages
                if (isSentByMe && !fromServer) {
                    messageContent += `<span class="message-status"> • Đang gửi...</span>`;
                }
                
                messageContent += `</span></div>`;
                messageDiv.innerHTML = messageContent;
                
                // Thêm tin nhắn vào container
                messageContainer.appendChild(messageDiv);
                
                // Cuộn xuống dưới cùng
                scrollToBottom();
                
                // Đánh dấu tin nhắn đã đọc nếu tin nhắn từ người khác
                if (!isSentByMe && fromServer) {
                    markMessageAsRead(message.messageId);
                }
                
                // Update sent message status when it's confirmed by server
                if (fromServer && isSentByMe) {
                    const pendingMessages = messageContainer.querySelectorAll('.message-sent .message-status');
                    if (pendingMessages.length > 0) {
                        // Update the most recent pending message
                        const lastPendingMessage = pendingMessages[pendingMessages.length - 1];
                        lastPendingMessage.innerHTML = ' • Đã gửi';
                        lastPendingMessage.style.opacity = '0.6';
                    }
                }
            }
            
            // Hàm gửi tin nhắn
            function sendMessage() {
                const content = messageInput.value.trim();
                
                if (content) {
                    // Create message object
                    const message = {
                        senderId: currentUserId,
                        receiverId: parseInt(receiverId),
                        propertyId: parseInt(propertyId),
                        content: content
                    };
                    
                    // Add message to chat immediately for better UX
                    addMessageToChat(message);
                    
                    // Reset input
                    messageInput.value = '';
                    messageInput.style.height = 'auto';
                    updateSendButtonState();
                    
                    // Send to server if connection is open
                    if (socket && socket.readyState === WebSocket.OPEN) {
                        socket.send(JSON.stringify(message));
                    } else {
                        // Handle offline case - could store messages and resend later
                        console.log("WebSocket not connected, message will be sent when reconnected");
                        connectWebSocket(); // Try to reconnect
                    }
                }
            }            
            // Hàm đánh dấu tin nhắn đã đọc
            function markMessageAsRead(messageId) {
                fetch('${pageContext.request.contextPath}/messages', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=markAsRead&messageId=${messageId}`
                })
                .then(response => response.json())
                .catch(error => console.error('Error marking message as read:', error));
            }
            
            // Cập nhật trạng thái nút gửi
            function updateSendButtonState() {
                const content = messageInput.value.trim();
                sendButton.disabled = !content;
                
                // Visual feedback on button state
                if (!content) {
                    sendButton.style.opacity = '0.6';
                } else {
                    sendButton.style.opacity = '1';
                }
            }
            
            // Cuộn xuống dưới cùng của khung chat
            function scrollToBottom() {
                messageContainer.scrollTop = messageContainer.scrollHeight;
            }
            
            // Process existing messages to group by date
            function processExistingMessages() {
                const existingMessages = messageContainer.querySelectorAll('.message');
                if (existingMessages.length === 0) return;
                
                // Clear existing processed dates
                processedDates.clear();
                
                // Create temporary fragment to rebuild message container
                const fragment = document.createDocumentFragment();
                let currentDate = null;
                let lastProcessedDate = null;
                
                existingMessages.forEach((message) => {
                    // Extract date from the message
                    const timeElement = message.querySelector('.message-time');
                    if (!timeElement) return;
                    
                    // Get date from the format "dd/MM/yyyy HH:mm"
                    const dateTimeStr = timeElement.textContent.trim();
                    const datePart = dateTimeStr.split(' ')[0];
                    const timePart = dateTimeStr.split(' ')[1];
                    
                    // Update time format to show only HH:mm
                    timeElement.textContent = timePart;
                    
                    if (datePart !== lastProcessedDate) {
                        // Insert date separator
                        const separator = document.createElement("div");
                        separator.className = "chat-date-separator";
                        separator.innerHTML = `<span>${datePart}</span>`;
                        
                        fragment.appendChild(separator);
                        lastProcessedDate = datePart;
                        processedDates.add(datePart);
                    }
                    
                    fragment.appendChild(message.cloneNode(true));
                });
                
                // Replace container content
                messageContainer.innerHTML = '';
                messageContainer.appendChild(fragment);
            }
            
            // Thiết lập event listeners
            document.addEventListener('DOMContentLoaded', function() {
                // Process existing messages
                processExistingMessages();
                
                // Kết nối WebSocket khi trang tải
                connectWebSocket();
                
                // Cuộn xuống dưới cùng khi tải trang
                setTimeout(scrollToBottom, 100);
                
                // Event listener cho nút gửi
                sendButton.addEventListener('click', sendMessage);
                
                // Event listener cho input khi nhấn Enter
                messageInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter' && !e.shiftKey) {
                        e.preventDefault();
                        sendMessage();
                    }
                });
                
                // Cập nhật trạng thái nút gửi khi nhập tin nhắn
                messageInput.addEventListener('input', updateSendButtonState);
                
                // Auto-resize textarea
                messageInput.addEventListener('input', function() {
                    this.style.height = 'auto';
                    this.style.height = Math.min(100, this.scrollHeight) + 'px';
                });
                
                // Initial button state
                updateSendButtonState();
                
                // Check online status of the chat user
                function updateOnlineStatus() {
                    fetch('${pageContext.request.contextPath}/messages', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `action=checkOnlineStatus&userId=${receiverId}`
                    })
                    .then(response => response.json())
                    .then(data => {
                        const userStatus = document.getElementById('userStatus');
                        if (userStatus) {
                            if (data.isOnline) {
                                userStatus.className = 'status-indicator status-online';
                                userStatus.nextSibling.textContent = 'Online';
                            } else {
                                userStatus.className = 'status-indicator status-offline';
                                userStatus.nextSibling.textContent = 'Offline';
                            }
                        }
                    })
                    .catch(error => console.error('Error checking online status:', error));
                }
                
                // Check online status initially and then every 30 seconds
                updateOnlineStatus();
                setInterval(updateOnlineStatus, 30000);
            });
        </script>
    </c:if>
</body>
</html>
