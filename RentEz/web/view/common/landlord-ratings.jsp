<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá chủ trọ - ${landlord.name}</title>
    
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
        .rating-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .landlord-profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            background: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .landlord-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .landlord-info h2 {
            margin-bottom: 5px;
        }
        
        .landlord-info .role-badge {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 10px;
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
        
        .renter-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .renter-info {
            flex-grow: 1;
        }
        
        .renter-name {
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
        
        /* Rating form */
        .rating-form {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-top: 40px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            border-top: 5px solid #4CAF50;
        }
        
        .rating-form h3 {
            margin-bottom: 20px;
            color: #333;
        }
        
        .star-rating {
            direction: rtl;
            unicode-bidi: bidi-override;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .star-rating input {
            display: none;
        }
        
        .star-rating label {
            font-size: 2rem;
            padding: 0 5px;
            color: #ccc;
            cursor: pointer;
        }
        
        .star-rating label:before {
            content: "★";
        }
        
        .star-rating input:checked ~ label {
            color: #FFB800;
        }
        
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #FFCA28;
        }
        
        .comment-input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: vertical;
            min-height: 100px;
            margin-bottom: 15px;
        }
        
        .submit-rating {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .submit-rating:hover {
            background-color: #43A047;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
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
    </style>
</head>
<body>
    <!-- Include header -->
    <jsp:include page="/view/common/header.jsp" />

    <main class="main">
        <div class="container">
            <div class="rating-container">
                <!-- Landlord Profile -->
                <div class="landlord-profile">
                    <img src="${pageContext.request.contextPath}/${not empty landlord.avatar ? landlord.avatar : '/view/guest/asset/img/default-avatar.png'}" 
                         class="landlord-avatar" alt="${landlord.name}" 
                         onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                    <div class="landlord-info">
                        <h2>${landlord.name}</h2>
                        <span class="role-badge">Chủ trọ</span>
                        <p>${landlord.email}</p>
                    </div>
                </div>
                
                <!-- Rating Summary -->
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
                
                <!-- Submit Rating Section -->
                <c:if test="${canRate}">
                    <div class="rating-form">
                        <h3>Đánh giá chủ trọ này</h3>
                        <form action="${pageContext.request.contextPath}/ratings" method="post">
                            <input type="hidden" name="action" value="submitRating">
                            <input type="hidden" name="landlordId" value="${landlord.userId}">
                            
                            <div class="form-group mb-4">
                                <label for="rating">Đánh giá của bạn</label>
                                <div class="star-rating">
                                    <input type="radio" id="star5" name="rating" value="5" required />
                                    <label for="star5" title="5 sao"></label>
                                    <input type="radio" id="star4" name="rating" value="4" />
                                    <label for="star4" title="4 sao"></label>
                                    <input type="radio" id="star3" name="rating" value="3" />
                                    <label for="star3" title="3 sao"></label>
                                    <input type="radio" id="star2" name="rating" value="2" />
                                    <label for="star2" title="2 sao"></label>
                                    <input type="radio" id="star1" name="rating" value="1" />
                                    <label for="star1" title="1 sao"></label>
                                </div>
                            </div>
                            
                            <div class="form-group mb-4">
                                <label for="comment">Nhận xét chi tiết</label>
                                <textarea id="comment" name="comment" class="comment-input" 
                                    placeholder="Chia sẻ trải nghiệm của bạn về việc thuê trọ từ chủ trọ này..." required></textarea>
                            </div>
                            
                            <button type="submit" class="submit-rating">Gửi đánh giá</button>
                        </form>
                    </div>
                </c:if>
                
                <!-- List of Ratings -->
                <div class="ratings-list">
                    <h3 class="mb-4">Đánh giá từ người thuê</h3>
                    
                    <c:choose>
                        <c:when test="${not empty ratings}">
                            <c:forEach var="rating" items="${ratings}">
                                <div class="rating-card">
                                    <div class="rating-header">
                                        <img src="${pageContext.request.contextPath}/${not empty rating.renterAvatar ? rating.renterAvatar : '/view/guest/asset/img/default-avatar.png'}" 
                                            class="renter-avatar" alt="${rating.renterName}" 
                                            onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" />
                                        <div class="renter-info">
                                            <div class="renter-name">${rating.renterName}</div>
                                            <div class="rating-date">
                                                <fmt:formatDate value="${rating.ratingDate}" pattern="dd/MM/yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                    
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
                                <h4>Chưa có đánh giá nào</h4>
                                <p>Hãy là người đầu tiên đánh giá chủ trọ này!</p>
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
