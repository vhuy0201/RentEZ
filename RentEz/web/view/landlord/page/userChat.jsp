<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tin nhắn - RentEz</title>
        
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
        <style>
            .chat-users-container {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                padding: 20px;
            }
            
            .chat-users-header {
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #dee2e6;
            }
            
            .chat-users-header h4 {
                margin: 0;
                color: #333;
                font-weight: 600;
            }
            
            .chat-search {
                margin-bottom: 20px;
                position: relative;
            }
            
            .chat-search input {
                width: 100%;
                padding: 10px 40px 10px 15px;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                font-size: 14px;
            }
            
            .chat-search i {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
            }
            
            .chat-user-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            
            .chat-user-item {
                padding: 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                border: 1px solid transparent;
            }
            
            .chat-user-item:hover {
                background: #f8f9fa;
                border-color: #dee2e6;
            }
            
            .chat-user-item a {
                text-decoration: none;
                color: inherit;
            }
            
            .chat-user-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            
            .chat-user-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
            }
            
            .chat-user-details h5 {
                margin: 0 0 5px 0;
                color: #333;
                font-weight: 600;
            }
            
            .chat-user-details p {
                margin: 0;
                color: #6c757d;
                font-size: 13px;
            }
            
            .chat-user-meta {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-top: 5px;
                color: #6c757d;
                font-size: 12px;
            }
            
            .chat-user-meta i {
                font-size: 14px;
            }
            
            .chat-empty-state {
                text-align: center;
                padding: 40px 20px;
                color: #6c757d;
            }
            
            .chat-empty-state i {
                font-size: 48px;
                margin-bottom: 15px;
                color: #dee2e6;
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .chat-user-item {
                    padding: 12px;
                }
                
                .chat-user-avatar {
                    width: 40px;
                    height: 40px;
                }
                
                .chat-user-details h5 {
                    font-size: 14px;
                }
                
                .chat-user-details p {
                    font-size: 12px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Include Navigation -->
                <jsp:include page="../common/navigation.jsp" />
                
                <!-- Main Content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-md-4 py-4">
                    <div class="chat-users-container">
                        <!-- Header -->
                        <div class="chat-users-header">
                            <h4><i class="fas fa-comments me-2"></i>Tin nhắn</h4>
                        </div>
                        
                        <!-- Search Box -->
                        <div class="chat-search">
                            <input type="text" id="searchInput" placeholder="Tìm kiếm người dùng...">
                            <i class="fas fa-search"></i>
                        </div>
                        
                        <!-- Users List -->
                        <ul class="chat-user-list">
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:forEach var="u" items="${users}">
                                        <li class="chat-user-item">
                                            <a href="MessageServlet?action=getMessages&receiverID=${u.userId}" onclick="selectUser(${u.userId})">
                                                <div class="chat-user-info">
                                                    <img src="${not empty u.avatar ? u.avatar : 'https://ui-avatars.com/api/?name='.concat(u.name)}" 
                                                         alt="${u.name}" 
                                                         class="chat-user-avatar"
                                                         onerror="this.src='https://ui-avatars.com/api/?name=${u.name}'">
                                                    <div class="chat-user-details">
                                                        <h5>${u.name}</h5>
                                                        <div class="chat-user-meta">
                                                            <span><i class="fas fa-envelope me-1"></i>${u.email}</span>
                                                            <span><i class="fas fa-phone me-1"></i>${u.phone}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="chat-empty-state">
                                        <i class="fas fa-comments"></i>
                                        <h5>Chưa có cuộc trò chuyện nào</h5>
                                        <p>Bắt đầu trò chuyện với khách hàng của bạn</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </main>
            </div>
        </div>
        
        <!-- Bootstrap Bundle JS -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Xử lý tìm kiếm người dùng
            const searchInput = document.getElementById('searchInput');
            const userItems = document.querySelectorAll('.chat-user-item');
            
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                
                userItems.forEach(item => {
                    const userName = item.querySelector('h5').textContent.toLowerCase();
                    const userEmail = item.querySelector('.chat-user-meta').textContent.toLowerCase();
                    
                    if (userName.includes(searchTerm) || userEmail.includes(searchTerm)) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
            
            function selectUser(userId) {
                // Có thể thêm logic xử lý khi chọn user nếu cần
                console.log('Selected user:', userId);
            }
        </script>
    </body>
</html>
