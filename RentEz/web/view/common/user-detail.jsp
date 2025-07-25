<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Thông tin chi tiết người dùng ${userDetail.name} - RentEz">
        <meta name="keywords" content="thuê nhà, bất động sản, thông tin người dùng">
        <meta name="author" content="RentEz">
        <title>Thông tin người dùng - ${userDetail.name} - RentEz</title>

        <!-- Preload critical fonts -->
        <link rel="preload" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css" as="style">

        <!-- Favicon and Icons -->
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />
        <link rel="apple-touch-icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />

        <!-- Stylesheets -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/user-detail.css" />

        <!-- Page-specific CSS -->
        <style>
            /* Preloader styles */
            .page-loader {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
                transition: opacity 0.5s ease;
            }

            .loader-spinner {
                width: 50px;
                height: 50px;
                border: 3px solid rgba(255, 255, 255, 0.3);
                border-top: 3px solid white;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .fade-out {
                opacity: 0;
                pointer-events: none;
            }
        </style>
    </head>

    <body>
        <!-- Page Loader -->
        <div class="page-loader" id="pageLoader">
            <div class="loader-spinner"></div>
        </div>

        <!-- Include header -->
        <jsp:include page="header.jsp" />

        <div class="user-detail-container">
            <!-- Back Button -->
            <a href="javascript:history.back()" class="back-button">
                <i class="fas fa-arrow-left"></i>
                Quay lại
            </a>

            <!-- User Header -->
            <div class="user-header-card">
                <div class="row align-items-center">
                    <div class="col-md-3 text-center">
                        <c:choose>
                            <c:when test="${not empty userDetail.avatar}">
                                <img src="${userDetail.avatar}" alt="${userDetail.name}" class="user-avatar"
                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                <div class="default-avatar" style="display: none;">
                                    ${userDetail.name.substring(0, 1).toUpperCase()}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="default-avatar">
                                    ${userDetail.name.substring(0, 1).toUpperCase()}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-9">
                        <h1 class="user-name">${userDetail.name}</h1>
                        <span class="user-role">
                            <c:choose>
                                <c:when test="${userDetail.role == 'Landlord'}">Chủ nhà</c:when>
                                <c:when test="${userDetail.role == 'Tenant'}">Người thuê</c:when>
                                <c:when test="${userDetail.role == 'Admin'}">Quản trị viên</c:when>
                                <c:otherwise>${userDetail.role}</c:otherwise>
                            </c:choose>
                        </span>

                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <button class="action-btn btn-chat" onclick="openChatWithUser('${userDetail.userId}', '${userDetail.name}')">
                                <i class="fas fa-comments"></i>
                                Nhắn tin
                            </button>
                            <a href="tel:${userDetail.phone}" class="action-btn btn-contact">
                                <i class="fas fa-phone"></i>
                                Gọi điện
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User Information Grid -->
            <div class="user-info-grid">
                <div class="info-card">
                    <div class="info-card-icon" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white;">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="info-card-title">Email</div>
                    <div class="info-card-value">${userDetail.email}</div>
                </div>

                <div class="info-card">
                    <div class="info-card-icon" style="background: linear-gradient(135deg, #f093fb, #f5576c); color: white;">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="info-card-title">Số điện thoại</div>
                    <div class="info-card-value">${userDetail.phone}</div>
                </div>

                <div class="info-card">
                    <div class="info-card-icon" style="background: linear-gradient(135deg, #4facfe, #00f2fe); color: white;">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="info-card-title">Địa chỉ</div>
                    <div class="info-card-value">${userDetail.address}</div>
                </div>

                <div class="info-card">
                    <div class="info-card-icon" style="background: linear-gradient(135deg, #43e97b, #38f9d7); color: white;">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="info-card-title">Trạng thái</div>
                    <div class="info-card-value">
                        <c:choose>
                            <c:when test="${userDetail.status}">
                                <span style="color: #28a745;">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #dc3545;">Không hoạt động</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Booking History Section (for Tenants) -->
            <c:if test="${userDetail.role == 'Renter' && not empty userBookings}">
                <h2 class="section-title">
                    <i class="fas fa-history"></i>
                    Lịch sử thuê nhà
                </h2>

                <c:forEach var="booking" items="${userBookings}">
                    <div class="booking-card">
                        <div class="booking-header">
                            <div>
                                <div class="booking-property">Bất động sản #${booking.propertyId}</div>
                                <div class="booking-dates">
                                    <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy"/> - 
                                    <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                            <span class="booking-status status-active">Đang thuê</span>
                            <c:choose>
                                <c:when test="${booking.status == 'Pending'}">Đang chờ</c:when>
                                <c:when test="${booking.status == 'Confirmed'}">Đang thuê</c:when>
                                <c:when test="${booking.status == 'Completed'}">Đang thuê</c:when>
                                <c:otherwise>${booking.status}</c:otherwise>
                            </c:choose>
                        </div>

                        <div class="booking-details">
                            <div class="booking-detail-item">
                                <div class="booking-detail-label">Giá thuê hàng tháng</div>
                                <div class="booking-detail-value">
                                    <fmt:formatNumber value="${booking.monthlyRent}" type="number" groupingUsed="true"/>đ
                                </div>
                            </div>
                            <div class="booking-detail-item">
                                <div class="booking-detail-label">Tổng giá trị</div>
                                <div class="booking-detail-value">
                                    <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/>đ
                                </div>
                            </div>
                            <div class="booking-detail-item">
                                <div class="booking-detail-label">Thời hạn</div>
                                <div class="booking-detail-value">
                                    <c:set var="startTime" value="${booking.startDate.time}" />
                                    <c:set var="endTime" value="${booking.endDate.time}" />
                                    <c:set var="diffInMillis" value="${endTime - startTime}" />
                                    <c:set var="diffInDays" value="${diffInMillis / (1000 * 60 * 60 * 24)}" />
                                    <c:set var="diffInMonths" value="${diffInDays / 30}" />
                                    <fmt:formatNumber value="${diffInMonths}" maxFractionDigits="0" /> tháng
                                </div>
                            </div>
                            <div class="booking-detail-item">
                                <div class="booking-detail-label">Trạng thái thanh toán</div>
                                <div class="booking-detail-value" style="color: #28a745;">Đã thanh toán</div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <!-- Properties Section (for Landlords) -->
            <c:if test="${userDetail.role == 'Landlord' && not empty userProperties}">
                <h2 class="section-title">
                    <i class="fas fa-building"></i>
                    Bất động sản đang quản lý
                </h2>

                <div class="row">
                    <c:forEach var="property" items="${userProperties}">
                        <div class="col-md-6 col-lg-4 mb-3">
                            <div class="property-card">
                                <div class="property-title">${property.title}</div>
                                <div class="property-price">
                                    <fmt:formatNumber value="${property.price}" type="number" groupingUsed="true"/>đ/tháng
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="property-status status-available">
                                        ${property.availabilityStatus}
                                    </span>
                                    <small class="text-muted">
                                        ${property.numberOfBedrooms}PN • ${property.numberOfBathrooms}WC
                                    </small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- Empty State for No Data -->
            <c:if test="${(userDetail.role == 'Renter' && empty userBookings) || (userDetail.role == 'Landlord' && empty userProperties)}">
                <div class="empty-state">
                    <i class="fas fa-inbox empty-icon"></i>
                    <h3>Chưa có dữ liệu</h3>
                    <p>
                        <c:choose>
                            <c:when test="${userDetail.role == 'Renter'}">
                                Người dùng này chưa có lịch sử thuê nhà nào.
                            </c:when>
                            <c:when test="${userDetail.role == 'Landlord'}">
                                Người dùng này chưa có bất động sản nào.
                            </c:when>
                            <c:otherwise>
                                Chưa có thông tin bổ sung cho người dùng này.
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </c:if>
        </div>

        <!-- Include footer -->
        <jsp:include page="footer.jsp" />

        <!-- Bootstrap JS -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>

        <script>
                                // Function to open chat with user
                                function openChatWithUser(userId, userName) {
                                    // Placeholder for chat functionality
                                    alert(`Tính năng chat sẽ được tích hợp sau.\nSẽ mở chat với: ${userName}`);

                                    // Future implementation:
                                    // if (typeof window.openMiniChat === 'function') {
                                    //     window.openMiniChat(userId, null, userName, 'Liên hệ trực tiếp');
                                    // } else {
                                    //     window.location.href = `${pageContext.request.contextPath}/chat?userId=${userId}`;
                                    // }
                                }

                                // Copy phone to clipboard function
                                function copyToClipboard(text, element) {
                                    navigator.clipboard.writeText(text).then(function () {
                                        // Show success feedback
                                        const originalText = element.innerHTML;
                                        element.innerHTML = '<i class="fas fa-check"></i> Đã sao chép!';
                                        element.style.background = 'linear-gradient(135deg, #28a745, #20c997)';

                                        setTimeout(function () {
                                            element.innerHTML = originalText;
                                            element.style.background = 'linear-gradient(135deg, #51cf66, #40c057)';
                                        }, 2000);
                                    }).catch(function (err) {
                                        console.error('Could not copy text: ', err);
                                    });
                                }

                                // Enhanced page animations
                                document.addEventListener('DOMContentLoaded', function () {
                                    // Hide page loader
                                    const loader = document.getElementById('pageLoader');
                                    setTimeout(() => {
                                        loader.classList.add('fade-out');
                                        setTimeout(() => {
                                            loader.style.display = 'none';
                                        }, 500);
                                    }, 800);

                                    // Fade in animation for cards
                                    const observerOptions = {
                                        threshold: 0.1,
                                        rootMargin: '0px 0px -50px 0px'
                                    };

                                    const observer = new IntersectionObserver(function (entries) {
                                        entries.forEach(entry => {
                                            if (entry.isIntersecting) {
                                                entry.target.style.opacity = '1';
                                                entry.target.style.transform = 'translateY(0)';
                                            }
                                        });
                                    }, observerOptions);

                                    // Apply initial styles and observe cards
                                    const cards = document.querySelectorAll('.info-card, .booking-card, .property-card');
                                    cards.forEach((card, index) => {
                                        card.style.opacity = '0';
                                        card.style.transform = 'translateY(30px)';
                                        card.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
                                        observer.observe(card);
                                    });

                                    // Header card animation
                                    const headerCard = document.querySelector('.user-header-card');
                                    if (headerCard) {
                                        headerCard.style.opacity = '0';
                                        headerCard.style.transform = 'translateY(-20px)';
                                        headerCard.style.transition = 'opacity 0.8s ease, transform 0.8s ease';

                                        setTimeout(() => {
                                            headerCard.style.opacity = '1';
                                            headerCard.style.transform = 'translateY(0)';
                                        }, 200);
                                    }

                                    // Add click to copy functionality for info cards
                                    const infoCards = document.querySelectorAll('.info-card');
                                    infoCards.forEach(card => {
                                        const value = card.querySelector('.info-card-value');
                                        const icon = card.querySelector('.info-card-icon i');

                                        if (value && (icon.classList.contains('fa-envelope') || icon.classList.contains('fa-phone'))) {
                                            card.style.cursor = 'pointer';
                                            card.title = 'Click để sao chép';

                                            card.addEventListener('click', function () {
                                                const text = value.textContent.trim();
                                                copyToClipboard(text, value);
                                            });
                                        }
                                    });

                                    // Add floating animation to action buttons
                                    const actionBtns = document.querySelectorAll('.action-btn');
                                    actionBtns.forEach(btn => {
                                        btn.addEventListener('mouseenter', function () {
                                            this.style.animation = 'float 2s ease-in-out infinite';
                                        });

                                        btn.addEventListener('mouseleave', function () {
                                            this.style.animation = '';
                                        });
                                    });

                                    // Add parallax effect to background
                                    window.addEventListener('scroll', function () {
                                        const scrolled = window.pageYOffset;
                                        const parallax = document.querySelector('.user-detail-container::before');
                                        if (parallax) {
                                            parallax.style.transform = `translateY(${scrolled * 0.5}px)`;
                                        }
                                    });
                                });

                                // Add custom CSS animations
                                const style = document.createElement('style');
                                style.textContent = `
                @keyframes float {
                    0%, 100% { transform: translateY(0px); }
                    50% { transform: translateY(-10px); }
                }
            
                @keyframes pulse {
                    0% { transform: scale(1); }
                    50% { transform: scale(1.05); }
                    100% { transform: scale(1); }
                }
            
                .pulse-animation {
                    animation: pulse 2s infinite;
                }
            
                .glow-effect {
                    box-shadow: 0 0 20px rgba(102, 126, 234, 0.5) !important;
                }
            `;
                                document.head.appendChild(style);
        </script>
    </body>
</html>
