<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin nhắn - RentEz</title>
    
    <!-- Include common header assets -->
    <jsp:include page="../common/header.jsp" />
    
    <style>
        .chat-list-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 800px;
            margin: 30px auto;
            min-height: calc(100vh - 200px);
        }

        .chat-list-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px 30px;
            text-align: center;
            position: relative;
        }

        .chat-list-header h2 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
        }

        .chat-list-header p {
            margin: 8px 0 0 0;
            opacity: 0.9;
            font-size: 1rem;
        }

        .back-to-home {
            position: absolute;
            left: 25px;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            padding: 10px 15px;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .back-to-home:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            transform: translateY(-50%) translateY(-2px);
        }

        .chat-list-content {
            padding: 30px;
            background: #f8f9ff;
            background-image: 
                radial-gradient(circle at 20px 80px, #667eea12 0%, transparent 50%),
                radial-gradient(circle at 80px 20px, #764ba212 0%, transparent 50%);
        }

        .search-box {
            margin-bottom: 25px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 15px 50px 15px 20px;
            border: 2px solid #e6e9f0;
            border-radius: 25px;
            font-size: 15px;
            outline: none;
            transition: all 0.3s ease;
            background: white;
        }

        .search-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
        }

        .user-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .user-item {
            background: white;
            border-radius: 15px;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .user-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .user-link {
            display: flex;
            align-items: center;
            padding: 20px 25px;
            text-decoration: none;
            color: inherit;
            position: relative;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 20px;
            border: 3px solid #e6e9f0;
            transition: all 0.3s ease;
        }

        .user-item:hover .user-avatar {
            border-color: #667eea;
        }

        .user-info {
            flex: 1;
        }

        .user-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin: 0 0 5px 0;
            color: #333;
        }

        .user-details {
            font-size: 0.9rem;
            color: #666;
            margin: 0 0 8px 0;
        }

        .last-message {
            font-size: 0.85rem;
            color: #999;
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 300px;
        }

        .chat-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 8px;
        }

        .message-time {
            font-size: 0.8rem;
            color: #999;
        }

        .unread-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 50%;
            min-width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .online-status {
            position: absolute;
            bottom: 2px;
            right: 2px;
            width: 16px;
            height: 16px;
            background: #4CAF50;
            border: 3px solid white;
            border-radius: 50%;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #ddd;
        }

        .empty-state h3 {
            margin-bottom: 10px;
            color: #666;
        }

        .empty-state p {
            margin: 0;
            line-height: 1.5;
        }

        .new-conversation-btn {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            margin-top: 20px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .new-conversation-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .chat-list-container {
                margin: 10px;
                border-radius: 15px;
            }

            .chat-list-header {
                padding: 20px;
            }

            .chat-list-header h2 {
                font-size: 1.5rem;
            }

            .back-to-home {
                left: 20px;
                padding: 8px 12px;
            }

            .chat-list-content {
                padding: 20px 15px;
            }

            .user-link {
                padding: 15px 20px;
            }

            .user-avatar {
                width: 50px;
                height: 50px;
                margin-right: 15px;
            }

            .user-name {
                font-size: 1rem;
            }

            .last-message {
                max-width: 200px;
            }
        }

        /* Loading Animation */
        .loading {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .loading i {
            font-size: 2rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        /* Fade in animation */
        .user-item {
            animation: fadeInUp 0.3s ease forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        .user-item:nth-child(1) { animation-delay: 0.1s; }
        .user-item:nth-child(2) { animation-delay: 0.2s; }
        .user-item:nth-child(3) { animation-delay: 0.3s; }
        .user-item:nth-child(4) { animation-delay: 0.4s; }
        .user-item:nth-child(5) { animation-delay: 0.5s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body class="body-bg">
    <div class="container">
        <div class="chat-list-container">
            <!-- Header -->
            <div class="chat-list-header">
                <a href="${pageContext.request.contextPath}/" class="back-to-home">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <h2>
                    <i class="fas fa-comments"></i>
                    Tin nhắn
                </h2>
                <p>Quản lý cuộc trò chuyện của bạn</p>
            </div>

            <!-- Content -->
            <div class="chat-list-content">
                <!-- Search Box -->
                <div class="search-box">
                    <input type="text" class="search-input" id="searchInput" placeholder="Tìm kiếm cuộc trò chuyện...">
                    <i class="fas fa-search search-icon"></i>
                </div>

                <!-- User List -->
                <ul class="user-list" id="userList">
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach var="u" items="${users}" varStatus="status">
                                <li class="user-item">
                                    <a href="MessageServlet?action=getMessages&receiverID=${u.userId}" class="user-link" onclick="selectUser(${u.userId})">
                                        <div style="position: relative;">
                                            <img src="${not empty u.avatar ? u.avatar : 'https://ui-avatars.com/api/?name='.concat(u.name).concat('&background=667eea&color=fff')}" 
                                                 alt="${u.name}" class="user-avatar" 
                                                 onerror="this.src='https://ui-avatars.com/api/?name='+encodeURIComponent('${u.name}')+'&background=667eea&color=fff'">
                                            <!-- Online status indicator (you can add logic to determine online status) -->
                                            <div class="online-status"></div>
                                        </div>
                                        <div class="user-info">
                                            <div class="user-name">${u.name}</div>
                                            <div class="user-details">
                                                <i class="fas fa-envelope"></i> ${u.email}
                                                <c:if test="${not empty u.phone}">
                                                    <br><i class="fas fa-phone"></i> ${u.phone}
                                                </c:if>
                                            </div>
                                            <div class="last-message">
                                                <i class="fas fa-comment-dots"></i>
                                                Nhấp để bắt đầu trò chuyện
                                            </div>
                                        </div>
                                        <div class="chat-meta">
                                            <div class="message-time">
                                                <i class="fas fa-clock"></i>
                                                Bây giờ
                                            </div>
                                            <!-- Uncomment if you have unread message count logic -->
                                            <!-- <div class="unread-badge">3</div> -->
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-comments"></i>
                                <h3>Chưa có cuộc trò chuyện nào</h3>
                                <p>Bạn chưa có tin nhắn nào.<br>Hãy bắt đầu cuộc trò chuyện đầu tiên!</p>
                                <a href="${pageContext.request.contextPath}/search" class="new-conversation-btn">
                                    <i class="fas fa-plus"></i>
                                    Tìm bất động sản để liên hệ
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
    <script>
        function selectUser(userId) {
            // Add any analytics or tracking here
            console.log('Starting conversation with user:', userId);
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const userItems = document.querySelectorAll('.user-item');
            
            userItems.forEach(function(item) {
                const userName = item.querySelector('.user-name').textContent.toLowerCase();
                const userEmail = item.querySelector('.user-details').textContent.toLowerCase();
                
                if (userName.includes(searchTerm) || userEmail.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
            
            // Show/hide empty state
            const visibleItems = Array.from(userItems).filter(item => item.style.display !== 'none');
            const emptyState = document.querySelector('.empty-state');
            
            if (visibleItems.length === 0 && searchTerm.trim() !== '') {
                if (!document.getElementById('no-results')) {
                    const noResults = document.createElement('div');
                    noResults.id = 'no-results';
                    noResults.className = 'empty-state';
                    noResults.innerHTML = `
                        <i class="fas fa-search"></i>
                        <h3>Không tìm thấy kết quả</h3>
                        <p>Không có cuộc trò chuyện nào phù hợp với từ khóa "<strong>${searchTerm}</strong>"</p>
                    `;
                    document.getElementById('userList').appendChild(noResults);
                }
            } else {
                const noResults = document.getElementById('no-results');
                if (noResults) {
                    noResults.remove();
                }
            }
        });

        // Add loading effect when clicking on user
        document.querySelectorAll('.user-link').forEach(function(link) {
            link.addEventListener('click', function() {
                // Add loading state
                this.style.opacity = '0.7';
                this.style.pointerEvents = 'none';
                
                // Add loading spinner
                const spinner = document.createElement('div');
                spinner.className = 'loading';
                spinner.innerHTML = '<i class="fas fa-spinner"></i>';
                spinner.style.position = 'absolute';
                spinner.style.top = '50%';
                spinner.style.left = '50%';
                spinner.style.transform = 'translate(-50%, -50%)';
                spinner.style.background = 'rgba(255, 255, 255, 0.9)';
                spinner.style.borderRadius = '10px';
                spinner.style.padding = '10px';
                
                this.style.position = 'relative';
                this.appendChild(spinner);
            });
        });

        // Auto-refresh user list every 30 seconds (optional)
        setInterval(function() {
            // You can add AJAX call here to refresh the user list
            // fetch('/MessageServlet?action=refreshUserList')...
        }, 30000);

        // Add entrance animation
        window.addEventListener('load', function() {
            const userItems = document.querySelectorAll('.user-item');
            userItems.forEach(function(item, index) {
                setTimeout(function() {
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
