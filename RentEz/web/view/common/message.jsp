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
            --message-sent-text: #ffffff;
            --message-received-text: #212529;
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
            max-width: 1200px;
        }
        
        .conversation-list {
            width: 30%;
            border-right: 1px solid #e0e0e0;
            overflow-y: auto;
            background-color: var(--light-gray);
        }
        
        .conversation-item {
            display: flex;
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            cursor: pointer;
            transition: background-color 0.2s;
            position: relative;
        }
        
        .conversation-item:hover {
            background-color: rgba(0, 132, 255, 0.05);
        }
        
        .conversation-item.active {
            background-color: var(--light-primary-color);
        }
        
        .conversation-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 12px;
            flex-shrink: 0;
        }
        
        .conversation-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .conversation-info {
            flex-grow: 1;
            min-width: 0;
        }
        
        .conversation-name {
            font-weight: 600;
            margin-bottom: 0px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .property-title {
            font-size: 0.8rem;
            color: var(--dark-gray);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 3px;
        }
        
        .conversation-last-message {
            font-size: 0.85rem;
            color: var(--dark-gray);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .sent-by-me {
            font-weight: 500;
        }
        
        .conversation-meta {
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            justify-content: space-between;
            padding-left: 8px;
            margin-left: 5px;
        }
        
        .conversation-time {
            font-size: 0.75rem;
            color: var(--dark-gray);
        }
        
        .unread-indicator {
            width: 10px;
            height: 10px;
            background-color: var(--primary-color);
            border-radius: 50%;
        }
        
        .conversation-item.unread {
            background-color: rgba(0, 132, 255, 0.05);
        }
        
        .chat-area {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            background-color: white;
        }
        
        .empty-chat-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: var(--dark-gray);
            text-align: center;
            padding: 20px;
        }
        
        .empty-chat-placeholder i {
            font-size: 3rem;
            margin-bottom: 15px;
            opacity: 0.3;
        }
        
        .chat-header {
            padding: 15px 20px;
            border-bottom: 1px solid #e0e0e0;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .chat-header-user {
            display: flex;
            align-items: center;
        }
        
        .chat-header-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            margin-right: 12px;
            object-fit: cover;
        }
        
        .chat-header-name {
            font-weight: 600;
            margin-bottom: 0;
        }
        
        .chat-header-property {
            display: flex;
            align-items: center;
            font-size: 0.85rem;
            color: var(--dark-gray);
        }
        
        .property-thumbnail {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            margin-right: 6px;
            object-fit: cover;
        }
        
        .chat-messages {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            background-color: var(--light-gray);
            display: flex;
            flex-direction: column;
        }
        
        .date-separator {
            text-align: center;
            margin: 10px 0;
            color: var(--dark-gray);
            font-size: 0.8rem;
            position: relative;
        }
        
        .date-separator:before, .date-separator:after {
            content: "";
            height: 1px;
            background-color: #e0e0e0;
            position: absolute;
            top: 50%;
            width: 42%;
        }
        
        .date-separator:before {
            left: 0;
        }
        
        .date-separator:after {
            right: 0;
        }
        
        .message {
            max-width: 70%;
            margin-bottom: 8px;
            display: flex;
        }
        
        .message.sent {
            align-self: flex-end;
        }
        
        .message.received {
            align-self: flex-start;
        }
        
        .message-content {
            padding: 10px 15px;
            border-radius: 18px;
            position: relative;
            word-wrap: break-word;
            white-space: pre-wrap;
        }
        
        .message.sent .message-content {
            background-color: var(--message-sent-bg);
            color: var(--message-sent-text);
            border-bottom-right-radius: 4px;
        }
        
        .message.received .message-content {
            background-color: var(--message-received-bg);
            color: var(--message-received-text);
            border-bottom-left-radius: 4px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }
        
        .message-time {
            font-size: 0.7rem;
            opacity: 0.7;
            margin-left: 8px;
            white-space: nowrap;
        }
        
        .message.sent .message-time {
            color: rgba(255, 255, 255, 0.9);
        }
        
        .status-icon {
            font-size: 0.7rem;
            margin-left: 5px;
        }
        
        .message.sent .status-icon {
            color: rgba(255, 255, 255, 0.9);
        }
        
        .message-form {
            padding: 15px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            background-color: white;
        }
        
        .message-input {
            flex-grow: 1;
            border: 1px solid #e0e0e0;
            border-radius: 20px;
            padding: 10px 15px;
            resize: none;
            max-height: 100px;
            outline: none;
            transition: border-color 0.2s;
        }
        
        .message-input:focus {
            border-color: var(--primary-color);
        }
        
        .send-button {
            background-color: var(--primary-color);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            margin-left: 10px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .send-button:hover {
            background-color: #006fd6;
        }
        
        .send-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        
        .empty-chat {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: var(--dark-gray);
            text-align: center;
        }
        
        .empty-chat i {
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        .empty-chat p {
            margin-bottom: 5px;
        }
        
        .empty-chat .hint {
            font-size: 0.85rem;
            opacity: 0.7;
        }
        
        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            color: var(--dark-gray);
            height: 100%;
        }
        
        .message.sending .status-icon {
            animation: rotating 2s linear infinite;
        }
        
        .message.error .message-content {
            background-color: rgba(220, 53, 69, 0.8);
        }
        
        .btn-retry {
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            padding: 0;
            font-size: 0.7rem;
            color: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            margin-left: 5px;
            transition: background-color 0.2s;
        }
        
        .btn-retry:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }
        
        @keyframes rotating {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }
        
        /* Mobile responsive styles */
        @media (max-width: 768px) {
            .conversation-list {
                width: 40%;
            }
            
            .conversation-avatar {
                width: 40px;
                height: 40px;
            }
            
            .message {
                max-width: 85%;
            }
        }
        
        @media (max-width: 576px) {
            .chat-container {
                flex-direction: column;
                height: calc(100vh - 150px);
                margin: 15px;
            }
            
            .conversation-list {
                width: 100%;
                height: 30%;
                border-right: none;
                border-bottom: 1px solid #e0e0e0;
            }
            
            .chat-area {
                height: 70%;
            }
        }
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
            
            <div class="chat-container">                <!-- Danh sách cuộc trò chuyện -->
                <div class="conversation-list" id="conversation-list">
                    <c:choose>
                        <c:when test="${not empty conversations}">
                            <c:forEach var="conversation" items="${conversations}">
                                <div class="conversation-item ${conversation.userId == chatUser.userId ? 'active' : ''} ${!conversation.isRead && !conversation.isSentByMe ? 'unread' : ''}" 
                                     data-user-id="${conversation.userId}" 
                                     data-property-id="${conversation.propertyId}">
                                    
                                    <div class="conversation-avatar">
                                        <img src="${pageContext.request.contextPath}/${not empty conversation.userAvatar ? conversation.userAvatar : '/view/guest/asset/img/default-avatar.png'}" 
                                             alt="${conversation.userName}" 
                                             onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                                    </div>
                                    
                                    <div class="conversation-info">
                                        <div class="conversation-name">${conversation.userName}</div>
                                        <div class="property-title">${conversation.propertyTitle}</div>
                                        <div class="conversation-last-message">
                                            ${conversation.isSentByMe ? '<span class="sent-by-me">Bạn: </span>' : ''}
                                            ${conversation.lastMessage}
                                        </div>
                                    </div>
                                    
                                    <div class="conversation-meta">
                                        <div class="conversation-time">
                                            <fmt:formatDate value="${conversation.lastMessageDate}" type="date" 
                                                           pattern="${conversation.isToday ? 'HH:mm' : (conversation.isYesterday ? 'Hôm qua' : 'dd/MM')}" />
                                        </div>
                                        ${!conversation.isRead && !conversation.isSentByMe ? '<div class="unread-indicator"></div>' : ''}
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="text-center p-4">
                                    <i class="fas fa-comments fa-3x text-muted"></i>
                                    <p class="mt-2">Bạn chưa có cuộc trò chuyện nào</p>
                                    <p class="small text-muted">Hãy liên hệ với chủ nhà hoặc người thuê để bắt đầu trò chuyện</p>
                                </div>
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
                            </div>                              <!-- Tin nhắn -->
                            <div class="messages" id="chat-messages">
                                <c:forEach var="message" items="${messages}">
                                    <div class="message ${message.senderId == sessionScope.user.userId ? 'message-sent' : 'message-received'}" data-message-id="${message.messageId}">
                                        <div class="message-content">
                                            ${message.content}
                                            <span class="message-time">
                                                <fmt:formatDate value="${message.sendDate}" pattern="HH:mm" />
                                            </span>
                                            <c:if test="${message.senderId == sessionScope.user.userId}">
                                                <i class="status-icon fas ${message.readStatus ? 'fa-check-double' : 'fa-check'}"></i>
                                            </c:if>
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
                            <div class="input-area" id="message-form">
                                <textarea id="message-input" class="message-input" placeholder="Nhập tin nhắn..." rows="1"></textarea>
                                <button id="send-button" class="send-button" disabled>
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </div>
                            
                            <input type="hidden" id="receiver-id" value="${chatUser.userId}" />
                            <input type="hidden" id="property-id" value="${property.propertyId}" />
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
    <jsp:include page="/view/common/footer.jsp" />    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set context path for chat.js
        window.contextPath = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/chat.js"></script>
</body>
</html>
