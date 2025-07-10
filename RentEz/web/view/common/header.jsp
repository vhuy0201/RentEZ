<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Model.User" %>
<%@ page import="Model.UserTier" %>
<%@ page import="DAO.UserTierDAO" %>

<%
    // Get the current user from session
    User currentUser = (User) session.getAttribute("user");
    UserTier userTier = null;
    
    // If user is logged in, get their membership tier info
    if (currentUser != null) {
        try {
            UserTierDAO userTierDAO = new UserTierDAO();
            userTier = userTierDAO.getByUserId(currentUser.getUserId());
        } catch (Exception e) {
            System.out.println("Error getting user tier: " + e.getMessage());
        }
    }
%>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ người dùng - RentEz</title>
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

<header class="header">
    <div class="container container-two">
        <nav class="header-inner flx-between">
            <div class="logo">
                <a class="link" href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/view/guest/asset/img/logo-DHG6Mbuc.png" alt="Logo" />
                </a>
            </div>
            <div class="header-menu d-lg-block d-none">
                <ul class="nav-menu flx-align">
                    <li class="nav-menu__item">
                        <a class="nav-menu__link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                    </li>                    <li class="nav-menu__item">
                        <a class="nav-menu__link" href="${pageContext.request.contextPath}/search">Bất động sản</a>
                    </li>
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-menu__item">
                            <a class="nav-menu__link" href="${pageContext.request.contextPath}/favorites">
                                <i class="fas fa-heart"></i> Yêu thích
                            </a>
                        </li>
                    </c:if>
                    <li class="nav-menu__item">
                        <a class="nav-menu__link" href="${pageContext.request.contextPath}/about">Giới thiệu</a>
                    </li>
                    <li class="nav-menu__item">
                        <a class="nav-menu__link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                    </li>
                </ul>
            </div>
            <div class="header-right flx-align">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <!-- Show login button if user is not logged in -->
                        <a class="btn btn-main d-lg-block d-none" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    </c:when>
                    <c:otherwise>
                        <!-- Show user avatar and dropdown if user is logged in -->
                        <div class="user-dropdown">
                            <div class="user-dropdown__toggle">                                <span class="user-avatar">
                                    <c:choose>
                                        <c:when test="${empty sessionScope.user.avatar}">
                                            <img src="${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png" 
                                                alt="${sessionScope.user.name}" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" 
                                                onerror="this.src='${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png'" 
                                                alt="${sessionScope.user.name}" />
                                        </c:otherwise>
                                    </c:choose>

                                </span>
                                <span class="user-name">${sessionScope.user.name}</span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="user-dropdown__menu">                                <!-- Membership package info box -->                                <div class="membership-box">
                                    <h4>Gói thành viên</h4>
                                    <p>Tiết kiệm đến 39% so với đăng tin riêng lẻ</p>
                                    <a href="${pageContext.request.contextPath}/membership" class="text-link">Tìm hiểu thêm</a>
                                </div>
                                  <!-- User menu items -->                                <ul class="user-menu">
                                  <li>
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                <a href="${pageContext.request.contextPath}/landLordHomeServlet">
                                                    <i class="fas fa-columns"></i> Bảng điều khiển
                                                </a>
                                            </c:when>
                                            <c:when test="${sessionScope.user.role == 'Renter'}">
                                                <a href="${pageContext.request.contextPath}/renter/account-dashboard.jsp">
                                                    <i class="fas fa-columns"></i> Bảng điều khiển
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/account-dashboard.jsp">
                                                    <i class="fas fa-columns"></i> Bảng điều khiển
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>                                    <li><a href="${pageContext.request.contextPath}/messages"><i class="fas fa-comments"></i> Tin nhắn</a></li>
                                    <li><a href="${pageContext.request.contextPath}/schedules"><i class="fas fa-calendar-alt"></i> Lịch xem nhà</a></li>
                                    <li><a href="${pageContext.request.contextPath}/view-contracts"><i class="fas fa-file-contract"></i> Hợp đồng thuê</a></li>
                                    <li><a href="${pageContext.request.contextPath}/payments"><i class="fas fa-credit-card"></i> Thanh toán</a></li>
                                    <li><a href="${pageContext.request.contextPath}/membership"><i class="fas fa-crown"></i> Gói thành viên</a></li>
                                    <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-edit"></i> Chỉnh sửa hồ sơ</a></li>
                                    <li><a href="${pageContext.request.contextPath}/change-password"><i class="fas fa-key"></i> Đổi mật khẩu</a></li>
                                    <li class="divider"></li>
                                    <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <button type="button" class="toggle-mobileMenu d-lg-none ms-3">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
        </nav>
    </div>
</header>

<style>
    /* Set gradient color variable for consistency */
    :root {
        --gradient-one: linear-gradient(135deg, #ffaa00 0%, #ffcb66 100%);
    }

    /* User dropdown styles */
    .user-dropdown {
        position: relative;
    }

    .user-dropdown__toggle {
        display: flex;
        align-items: center;
        cursor: pointer;
        padding: 5px 10px;
        border-radius: 5px;
        background-color: rgba(255, 255, 255, 0.1);
        transition: background-color 0.3s;
    }

    .user-dropdown__toggle:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .user-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        overflow: hidden;
        margin-right: 8px;
    }

    .user-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .user-name {
        margin-right: 5px;
        font-weight: 500;
    }
    .user-dropdown__menu {
        position: absolute;
        top: 100%;
        right: 0;
        width: 300px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        padding: 15px;
        margin-top: 10px;
        z-index: 1000;
        display: none;
        opacity: 0;
        visibility: hidden;
        transition: opacity 0.2s ease, visibility 0.2s ease;
    }

    /* Create an invisible bridge between toggle and menu */
    .user-dropdown__menu::before {
        content: '';
        position: absolute;
        top: -10px;
        right: 20px;
        width: 120px;
        height: 10px;
        background-color: transparent;
    }

    .user-dropdown:hover .user-dropdown__menu {
        display: block;
        opacity: 1;
        visibility: visible;
    }

    /* Membership box styles */
    .membership-box {
        background: var(--gradient-one, linear-gradient(135deg, #ffaa00 0%, #ffcb66 100%));
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 15px;
        border: 2px solid #fff;
    }

    .membership-box h4 {
        font-size: 16px;
        margin-bottom: 8px;
        color: #000000;
        font-weight: 600;
    }

    .membership-box p {
        font-size: 14px;
        margin-bottom: 8px;
        color: #000000;
    }

    .membership-box .text-link {
        color: #000000;
        font-weight: 600;
        text-decoration: underline;
    }

    /* User menu styles */
    .user-menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .user-menu li {
        margin-bottom: 5px;
    }

    .user-menu li a {
        display: flex;
        align-items: center;
        padding: 8px 10px;
        color: #495057;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    .user-menu li a:hover {
        background-color: #f8f9fa;
    }

    .user-menu li a i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }

    .user-menu li.divider {
        height: 1px;
        background-color: #e9ecef;
        margin: 10px 0;
    }
</style>

<script>
    // Add Font Awesome if not already included
    if (!document.getElementById('fontawesome-css')) {
        var fontAwesome = document.createElement('link');
        fontAwesome.id = 'fontawesome-css';
        fontAwesome.rel = 'stylesheet';
        fontAwesome.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css';
        document.head.appendChild(fontAwesome);
    }    // Enhanced dropdown behavior 
    document.addEventListener('DOMContentLoaded', function () {
        var userDropdown = document.querySelector('.user-dropdown');
        var dropdownMenu = document.querySelector('.user-dropdown__menu');
        var dropdownToggle = document.querySelector('.user-dropdown__toggle');

        if (userDropdown && dropdownMenu) {
            // For touchscreen devices - support tap
            if (dropdownToggle) {
                dropdownToggle.addEventListener('click', function (e) {
                    if ('ontouchstart' in window || window.innerWidth < 992) {
                        if (dropdownMenu.style.visibility === 'visible') {
                            dropdownMenu.style.visibility = 'hidden';
                            dropdownMenu.style.opacity = '0';
                        } else {
                            dropdownMenu.style.visibility = 'visible';
                            dropdownMenu.style.opacity = '1';
                            dropdownMenu.style.display = 'block';
                        }
                        e.stopPropagation();
                    }
                });
            }

            // Close the dropdown when clicking outside
            document.addEventListener('click', function (e) {
                if (!e.target.closest('.user-dropdown')) {
                    dropdownMenu.style.visibility = 'hidden';
                    dropdownMenu.style.opacity = '0';
                }
            });
        }
    });
</script>
