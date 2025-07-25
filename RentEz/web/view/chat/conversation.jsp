<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuộc trò chuyện với ${otherUser.name} - RentEz</title>
    
    <!-- Include common header assets -->
    <jsp:include page="../common/header.jsp" />
    
    <!-- Chat-specific styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/chat.css">
    
    <style>
        .chat-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            height: calc(100vh - 150px);
            display: flex;
            flex-direction: column;
        }
        
        .chat-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .chat-header-left {
            display: flex;
            align-items: center;
        }
        
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            border: 3px solid white;
        }
        
        .user-info h3 {
            margin: 0;
            font-size: 1.3rem;
        }
        
        .property-info {
            font-size: 0.9rem;
            opacity: 0.9;
            margin: 0;
        }
        
        .back-button {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .back-button:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
        }
        
        .messages-container {
            flex: 1;
            background: white;
            padding: 20px;
            overflow-y: auto;
            border-left: 1px solid #e0e0e0;
            border-right: 1px solid #e0e0e0;
            background-image: url('${pageContext.request.contextPath}/view/guest/asset/img/chat-bg-pattern.png');
            background-size: 400px;
            background-repeat: repeat;
            background-attachment: fixed;
        }
        
        .message {
            margin-bottom: 20px;
            display: flex;
            align-items: flex-end;
        }
        
        .message.sent {
            justify-content: flex-end;
        }
        
        .message.received {
            justify-content: flex-start;
        }
        
        .message-content {
            max-width: 70%;
            padding: 12px 16px;
            border-radius: 18px;
            position: relative;
            word-wrap: break-word;
        }
        
        .message.sent .message-content {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-bottom-right-radius: 4px;
        }
        
        .message.received .message-content {
            background: #f1f3f5;
            color: #333;
            border-bottom-left-radius: 4px;
        }
        
        .message-time {
            font-size: 0.75rem;
            color: #999;
            margin-top: 5px;
            text-align: center;
        }
        
        .message.sent .message-time {
            color: rgba(255, 255, 255, 0.8);
        }
        
        .negotiation-message {
            border: 2px solid #ffa726;
            background: #fff8e1 !important;
            color: #ff8f00 !important;
        }
        
        .negotiation-badge {
            background: #ffa726;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.7rem;
            margin-bottom: 5px;
            display: inline-block;
        }
        
        .message-input-container {
            background: white;
            padding: 20px;
            border-radius: 0 0 15px 15px;
            border: 1px solid #e0e0e0;
            border-top: none;
        }
        
        .input-group {
            display: flex;
            gap: 10px;
            align-items: flex-end;
        }
        
        .message-input {
            flex: 1;
            border: 2px solid #e0e0e0;
            border-radius: 20px;
            padding: 12px 20px;
            resize: none;
            max-height: 120px;
            min-height: 45px;
            font-family: inherit;
            outline: none;
            transition: border-color 0.3s;
        }
        
        .message-input:focus {
            border-color: #667eea;
        }
        
        .send-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            border-radius: 50%;
            width: 45px;
            height: 45px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .send-button:hover {
            transform: scale(1.1);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .send-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }
        
        .negotiation-toggle {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 10px;
            font-size: 0.9rem;
        }
        
        .negotiation-checkbox {
            margin-right: 5px;
        }
        
        .typing-indicator {
            display: none;
            padding: 10px;
            font-style: italic;
            color: #999;
            text-align: center;
        }
        
        .message-status {
            font-size: 0.7rem;
            color: #999;
            margin-top: 2px;
        }
        
        .message.sent .message-status {
            color: rgba(255, 255, 255, 0.7);
            text-align: right;
        }
        
        @media (max-width: 768px) {
            .chat-container {
                padding: 10px;
                height: calc(100vh - 100px);
            }
            
            .chat-header {
                padding: 15px;
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .chat-header-left {
                width: 100%;
            }
            
            .user-avatar {
                width: 40px;
                height: 40px;
                margin-right: 10px;
            }
            
            .message-content {
                max-width: 85%;
            }
            
            .message-input-container {
                padding: 15px;
            }
        }
        
        .loading-message {
            text-align: center;
            color: #999;
            padding: 20px;
            font-style: italic;
        }
        
        .error-message {
            text-align: center;
            color: #ff4757;
            padding: 20px;
            background: #ffe0e0;
            border-radius: 10px;
            margin: 10px;
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <!-- Chat Header -->
        <div class="chat-header">
            <div class="chat-header-left">
                <img src="${otherUser.avatar != null ? otherUser.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                     alt="${otherUser.name}" 
                     class="user-avatar"
                     onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'">
                
                <div class="user-info">
                    <h3>${otherUser.name}</h3>
                    <p class="property-info">
                        <i class="fas fa-home"></i> ${property.title}
                    </p>
                </div>
            </div>
            
            <a href="${pageContext.request.contextPath}/chat" class="back-button">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
        </div>
        
        <!-- Messages Container -->
        <div class="messages-container" id="messagesContainer">
            <c:choose>
                <c:when test="${empty messages}">
                    <div class="loading-message">
                        <i class="fas fa-comment"></i><br>
                        Chưa có tin nhắn nào. Hãy bắt đầu cuộc trò chuyện!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="message" items="${messages}">
                        <div class="message ${message.senderId == currentUser.userId ? 'sent' : 'received'}">
                            <div class="message-content ${message.isNegotiation() ? 'negotiation-message' : ''}">
                                <c:if test="${message.isNegotiation()}">
                                    <div class="negotiation-badge">
                                        <i class="fas fa-handshake"></i> Thương lượng
                                    </div>
                                </c:if>
                                
                                <div class="message-text">
                                    ${message.content}
                                </div>
                                
                                <div class="message-time">
                                    <fmt:formatDate value="${message.sendDate}" pattern="HH:mm dd/MM/yyyy" />
                                </div>
                                
                                <c:if test="${message.senderId == currentUser.userId}">
                                    <div class="message-status">
                                        <c:choose>
                                            <c:when test="${message.readStatus}">
                                                <i class="fas fa-check-double"></i> Đã đọc
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-check"></i> Đã gửi
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Typing Indicator -->
        <div class="typing-indicator" id="typingIndicator">
            <i class="fas fa-circle"></i>
            <i class="fas fa-circle"></i>
            <i class="fas fa-circle"></i>
            ${otherUser.name} đang nhập...
        </div>
        
        <!-- Message Input -->
        <div class="message-input-container">
            <form id="messageForm">
                <div class="negotiation-toggle">
                    <input type="checkbox" id="isNegotiation" class="negotiation-checkbox">
                    <label for="isNegotiation">
                        <i class="fas fa-handshake"></i> Tin nhắn thương lượng
                    </label>
                </div>
                
                <div class="input-group">
                    <textarea id="messageInput" 
                             class="message-input" 
                             placeholder="Nhập tin nhắn của bạn..."
                             rows="1"
                             required></textarea>
                    <button type="submit" id="sendButton" class="send-button">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
    <script>
        const currentUserId = ${currentUser.userId};
        const otherUserId = ${otherUser.userId};
        const propertyId = ${property.propertyId};
        const contextPath = '${pageContext.request.contextPath}';
        
        // Auto-resize textarea
        const messageInput = document.getElementById('messageInput');
        messageInput.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });
        
        // Handle form submission
        document.getElementById('messageForm').addEventListener('submit', function(e) {
            e.preventDefault();
            sendMessage();
        });
        
        // Send message with Enter key (Shift+Enter for new line)
        messageInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
        
        function sendMessage() {
            const content = messageInput.value.trim();
            const isNegotiation = document.getElementById('isNegotiation').checked;
            const sendButton = document.getElementById('sendButton');
            
            if (content === '') return;
            
            // Disable send button
            sendButton.disabled = true;
            sendButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            
            // Send message via AJAX
            fetch(contextPath + '/chat/api/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    'receiverId': otherUserId,
                    'propertyId': propertyId,
                    'content': content,
                    'isNegotiation': isNegotiation
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Clear input
                    messageInput.value = '';
                    messageInput.style.height = 'auto';
                    document.getElementById('isNegotiation').checked = false;
                    
                    // Add message to UI immediately
                    addMessageToUI(content, true, isNegotiation, new Date());
                    
                    // Scroll to bottom
                    scrollToBottom();
                } else {
                    alert('Lỗi: ' + (data.error || 'Không thể gửi tin nhắn'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Lỗi kết nối. Vui lòng thử lại.');
            })
            .finally(() => {
                // Re-enable send button
                sendButton.disabled = false;
                sendButton.innerHTML = '<i class="fas fa-paper-plane"></i>';
            });
        }
        
        function addMessageToUI(content, isSent, isNegotiation, sendDate) {
            const messagesContainer = document.getElementById('messagesContainer');
            
            // Remove empty message if exists
            const emptyMessage = messagesContainer.querySelector('.loading-message');
            if (emptyMessage) {
                emptyMessage.remove();
            }
            
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + (isSent ? 'sent' : 'received');
            
            const now = new Date(sendDate);
            const timeString = now.toLocaleTimeString('vi-VN', {hour: '2-digit', minute: '2-digit'}) + 
                             ' ' + now.toLocaleDateString('vi-VN');
            
            messageDiv.innerHTML = `
                <div class="message-content ${isNegotiation ? 'negotiation-message' : ''}">
                    ${isNegotiation ? '<div class="negotiation-badge"><i class="fas fa-handshake"></i> Thương lượng</div>' : ''}
                    <div class="message-text">${content}</div>
                    <div class="message-time">${timeString}</div>
                    ${isSent ? '<div class="message-status"><i class="fas fa-check"></i> Đã gửi</div>' : ''}
                </div>
            `;
            
            messagesContainer.appendChild(messageDiv);
        }
        
        function scrollToBottom() {
            const messagesContainer = document.getElementById('messagesContainer');
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
        
        // Auto-refresh messages every 5 seconds
        setInterval(function() {
            if (document.visibilityState === 'visible') {
                refreshMessages();
            }
        }, 5000);
        
        function refreshMessages() {
            fetch(contextPath + '/chat/api/messages?userId=' + otherUserId + '&propertyId=' + propertyId)
            .then(response => response.json())
            .then(messages => {
                const messagesContainer = document.getElementById('messagesContainer');
                const currentMessages = messagesContainer.querySelectorAll('.message').length;
                
                if (messages.length > currentMessages) {
                    // New messages received, reload page to show them
                    location.reload();
                }
            })
            .catch(error => {
                console.error('Error refreshing messages:', error);
            });
        }
        
        // Mark messages as read when page loads
        fetch(contextPath + '/chat/api/mark-read', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                'userId': otherUserId,
                'propertyId': propertyId
            })
        });
        
        // Scroll to bottom on page load
        window.addEventListener('load', function() {
            scrollToBottom();
        });
        
        // Focus on input when page loads
        messageInput.focus();
    </script>
</body>
</html>
