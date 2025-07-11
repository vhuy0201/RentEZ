<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá của tôi - RentEz</title>
    
    <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
    <!-- Font awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
    <!-- line awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
    <!-- Main stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />
    
    <style>
        .ratings-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            background: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .user-info h2 {
            margin-bottom: 5px;
        }
        
        .role-badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 10px;
        }
        
        .landlord-badge {
            background-color: #4CAF50;
            color: white;
        }
        
        .renter-badge {
            background-color: #2196F3;
            color: white;
        }
        
        .rating-summary {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .average-score {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .score-number {
            font-size: 3rem;
            font-weight: bold;
            color: #FF9800;
            line-height: 1;
        }
        
        .score-stars {
            margin: 5px 0;
        }
        
        .score-stats {
            color: #757575;
            font-size: 0.9rem;
        }
        
        .rating-bars {
            flex-grow: 1;
        }
        
        .rating-bar {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        
        .rating-label {
            min-width: 30px;
        }
        
        .progress {
            height: 10px;
            flex-grow: 1;
            margin: 0 10px;
            border-radius: 5px;
        }
        
        .progress-bar {
            background-color: #FF9800;
        }
        
        .rating-count {
            min-width: 30px;
            text-align: right;
            font-size: 0.9rem;
            color: #757575;
        }
        
        .ratings-list {
            margin-top: 30px;
        }
        
        .rating-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        
        .rating-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .rating-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .user-avatar-small {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .user-details {
            flex-grow: 1;
        }
        
        .user-name {
            font-weight: 600;
            margin-bottom: 2px;
        }
        
        .rating-date {
            font-size: 0.8rem;
            color: #757575;
        }
        
        .rating-value {
            margin-bottom: 10px;
        }
        
        .rating-star {
            color: #FFB800;
        }
        
        .rating-comment {
            font-size: 0.95rem;
            line-height: 1.5;
        }
        
        .empty-ratings {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .empty-ratings i {
            font-size: 3rem;
            color: #E0E0E0;
            margin-bottom: 15px;
        }
        
        .empty-ratings p {
            color: #757575;
        }
        
        .tab-container {
            margin-bottom: 20px;
        }
        
        .nav-tabs {
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }
        
        .nav-tabs .nav-link {
            border: none;
            color: #666;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 5px 5px 0 0;
        }
        
        .nav-tabs .nav-link.active {
            color: #FF9800;
            background: none;
            border-bottom: 3px solid #FF9800;
        }
        
        .nav-tabs .nav-link:hover:not(.active) {
            color: #FF9800;
            border-bottom: 3px solid #FFECB3;
        }
    </style>
</head>
<body>
    <!-- Include header -->
    <jsp:include page="/view/common/header.jsp" />

    <main class="main">
        <div class="container">
            <div class="ratings-container">
                <!-- User Profile -->
                <div class="user-profile">
                    <img src="${pageContext.request.contextPath}/${not empty sessionScope.user.avatar ? sessionScope.user.avatar : '/view/guest/asset/img/default-avatar.png'}" 
                         class="user-avatar" alt="${sessionScope.user.name}" 
                         onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                    <div class="user-info">
                        <h2>${sessionScope.user.name}</h2>
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                <span class="role-badge landlord-badge">Chủ trọ</span>
                            </c:when>
                            <c:otherwise>
                                <span class="role-badge renter-badge">Người thuê</span>
                            </c:otherwise>
                        </c:choose>
                        <p>${sessionScope.user.email}</p>
                    </div>
                </div>
                
                <c:if test="${sessionScope.user.role == 'Landlord'}">
                    <!-- Rating Summary for Landlords -->
                    <div class="rating-summary">
                        <div class="average-score">
                            <div class="score-number">
                                <fmt:formatNumber value="${ratingStats.averageRating}" pattern="#.#" />
                            </div>
                            <div class="score-stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= ratingStats.averageRating}">
                                            <i class="rating-star fas fa-star"></i>
                                        </c:when>
                                        <c:when test="${i - 0.5 <= ratingStats.averageRating}">
                                            <i class="rating-star fas fa-star-half-alt"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="rating-star far fa-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <div class="score-stats">${ratingStats.totalRatings} đánh giá</div>
                        </div>
                    </div>
                </c:if>
                
                <!-- List of Ratings -->
                <div class="ratings-list">
                    <c:if test="${sessionScope.user.role == 'Renter'}">
                        <h3 class="mb-4">Đánh giá của bạn về chủ trọ</h3>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'Landlord'}">
                        <h3 class="mb-4">Đánh giá từ người thuê</h3>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${not empty ratings}">
                            <c:forEach var="rating" items="${ratings}">
                                <div class="rating-card">
                                    <c:choose>
                                        <c:when test="${sessionScope.user.role == 'Landlord'}">
                                            <!-- Show renter info for landlords -->
                                            <div class="rating-header">
                                                <img src="${pageContext.request.contextPath}/${not empty rating.renterAvatar ? rating.renterAvatar : '/view/guest/asset/img/default-avatar.png'}" 
                                                    class="user-avatar-small" alt="${rating.renterName}" 
                                                    onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                                                <div class="user-details">
                                                    <div class="user-name">${rating.renterName}</div>
                                                    <div class="rating-date">
                                                        <fmt:formatDate value="${rating.ratingDate}" pattern="dd/MM/yyyy" />
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Show landlord info for renters -->
                                            <div class="rating-header">
                                                <img src="${pageContext.request.contextPath}/${not empty landlordAvatars[rating.landlordId] ? landlordAvatars[rating.landlordId] : '/view/guest/asset/img/default-avatar.png'}" 
                                                    class="user-avatar-small" alt="${landlordNames[rating.landlordId]}" 
                                                    onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                                                <div class="user-details">
                                                    <div class="user-name">${landlordNames[rating.landlordId]}</div>
                                                    <div class="rating-date">
                                                        <fmt:formatDate value="${rating.ratingDate}" pattern="dd/MM/yyyy" />
                                                    </div>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <div class="rating-value">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="${i <= rating.rating ? 'rating-star fas fa-star' : 'rating-star far fa-star'}"></i>
                                        </c:forEach>
                                    </div>
                                    
                                    <div class="rating-comment">
                                        ${rating.comment}
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-ratings">
                                <i class="far fa-star"></i>
                                <c:if test="${sessionScope.user.role == 'Renter'}">
                                    <h4>Bạn chưa đánh giá chủ trọ nào</h4>
                                    <p>Đánh giá chủ trọ giúp cộng đồng thuê trọ có thêm thông tin!</p>
                                </c:if>
                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                    <h4>Bạn chưa nhận được đánh giá nào</h4>
                                    <p>Các đánh giá từ người thuê sẽ xuất hiện ở đây!</p>
                                </c:if>
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
</body>
</html>
