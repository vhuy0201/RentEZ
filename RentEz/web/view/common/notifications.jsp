<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo - RentEz</title>
    <link
      rel="shortcut icon"
      href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"
    />
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
    <!-- Font awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
    <!-- Line awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
    <!-- Main stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />
    
    <!-- Vietnamese Fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css" />
    
    <style>
        .notifications-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 0 15px;
        }
        
        .page-title {
            margin-bottom: 30px;
            color: #333;
            font-weight: 600;
        }
        
        .notification-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }
        
        .notification-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .notification-card.unread {
            border-left: 4px solid var(--bs-primary);
        }
        
        .notification-card.unread::before {
            content: '';
            position: absolute;
            top: 20px;
            left: -4px;
            width: 8px;
            height: 8px;
            background: var(--bs-primary);
            border-radius: 50%;
        }
        
        .notification-body {
            padding: 20px;
            display: flex;
            align-items: flex-start;
        }
        
        .notification-icon {
            width: 40px;
            height: 40px;
            background: rgba(var(--bs-primary-rgb), 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }
        
        .notification-icon i {
            color: var(--bs-primary);
            font-size: 18px;
        }
        
        .notification-content {
            flex-grow: 1;
        }
        
        .notification-message {
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .notification-time {
            color: #6c757d;
            font-size: 0.85rem;
        }
        
        .notification-actions {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-top: 10px;
        }
        
        .notification-actions button {
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            padding: 5px;
            margin-left: 10px;
            border-radius: 5px;
            transition: background-color 0.2s ease;
        }
        
        .notification-actions button:hover {
            background-color: rgba(0,0,0,0.05);
            color: var(--bs-primary);
        }
        
        .actions-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .no-notifications {
            text-align: center;
            padding: 50px 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        
        .no-notifications i {
            font-size: 50px;
            color: #dee2e6;
            margin-bottom: 20px;
            display: block;
        }
    </style>
</head>
<body>
    <div id="root">
        <main class="body-bg">
            <jsp:include page="/view/common/header.jsp" />
            
            <div class="notifications-container">
                <div class="actions-header">
                    <h2 class="page-title">Thông báo</h2>
                    
                    <c:if test="${not empty notifications}">
                        <form action="${pageContext.request.contextPath}/notifications" method="post">
                            <input type="hidden" name="action" value="markAllAsRead">
                            <button type="submit" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-check-double"></i> Đánh dấu tất cả đã đọc
                            </button>
                        </form>
                    </c:if>
                </div>
                
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="no-notifications">
                            <i class="fas fa-bell-slash"></i>
                            <p>Bạn chưa có thông báo nào</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${notifications}" var="notification">
                            <div class="notification-card ${notification.isRead ? '' : 'unread'}">
                                <div class="notification-body">
                                    <div class="notification-icon">
                                        <c:choose>
                                            <c:when test="${notification.referenceType == 'Booking'}">
                                                <i class="fas fa-calendar-check"></i>
                                            </c:when>
                                            <c:when test="${notification.referenceType == 'Schedule'}">
                                                <i class="fas fa-calendar-alt"></i>
                                            </c:when>
                                            <c:when test="${notification.referenceType == 'Payment'}">
                                                <i class="fas fa-credit-card"></i>
                                            </c:when>
                                            <c:when test="${notification.referenceType == 'Message'}">
                                                <i class="fas fa-comment-alt"></i>
                                            </c:when>
                                            <c:when test="${notification.referenceType == 'Bill'}">
                                                <i class="fas fa-file-invoice-dollar"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-bell"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <div class="notification-content">
                                        <p class="notification-message">${notification.message}</p>
                                        <p class="notification-time">
                                            <fmt:formatDate value="${notification.sentDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </p>
                                        
                                        <div class="notification-actions">
                                            <c:if test="${not notification.isRead}">
                                                <form action="${pageContext.request.contextPath}/notifications" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="markAsRead">
                                                    <input type="hidden" name="notificationId" value="${notification.notificationId}">
                                                    <button type="submit" title="Đánh dấu đã đọc">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <c:if test="${not empty notification.referenceId}">
                                                <a href="${pageContext.request.contextPath}/notifications?action=redirect&notificationId=${notification.notificationId}" 
                                                   class="btn btn-sm btn-link" title="Xem chi tiết">
                                                    <i class="fas fa-external-link-alt"></i>
                                                </a>
                                            </c:if>
                                            
                                            <form action="${pageContext.request.contextPath}/notifications" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="notificationId" value="${notification.notificationId}">
                                                <button type="submit" title="Xóa thông báo">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <jsp:include page="/view/common/footer.jsp" />
        </main>
    </div>
    
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add some animations for better UX
        document.querySelectorAll('.notification-card').forEach(card => {
            const deleteBtn = card.querySelector('button[title="Xóa thông báo"]');
            if(deleteBtn) {
                deleteBtn.addEventListener('click', function(e) {
                    if(!confirm('Bạn có chắc chắn muốn xóa thông báo này không?')) {
                        e.preventDefault();
                    }
                });
            }
        });
    </script>
</body>
</html>
