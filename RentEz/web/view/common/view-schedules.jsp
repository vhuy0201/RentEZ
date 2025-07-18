<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Lịch xem nhà</title>

        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />

        <!-- Bootstrap -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
        
        <!-- Font awesome -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
        
        <!-- Line awesome -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
        
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
        
        <link rel="stylesheet" crossorigin="" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />

        <!-- Vietnamese Fonts -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-enhancement.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/responsive-vietnamese.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-effects.css" />
        
        <!-- Google Fonts for Vietnamese support -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
          
        <style>
            :root {
                --primary-color: #007bff;
                --primary-dark: #0056b3;
                --primary-light: #e6f0ff;
                --success-color: #28a745;
                --success-dark: #1e7e34;
                --success-light: #e9f5ee;
                --warning-color: #f29900;
                --warning-dark: #d38800;
                --warning-light: #fff8e6;
                --danger-color: #ea4335;
                --danger-dark: #d93025;
                --danger-light: #fde8e6;
                --gray-dark: #343a40;
                --gray-medium: #5f6368;
                --gray-light: #e9ecef;
                --body-bg: #f8f9fa;
                --card-shadow: 0 5px 15px rgba(0,0,0,0.05);
                --hover-shadow: 0 8px 25px rgba(0,0,0,0.1);
                --border-radius-lg: 10px;
                --border-radius: 8px;
                --border-radius-sm: 4px;
                --transition: all 0.3s ease;
            }

            body {
                font-family: 'Roboto', 'Nunito', sans-serif;
                background-color: var(--body-bg);
                color: #333;
            }
            
            /* Header styling */
            .breadcrumb__title {
                font-size: 3rem;
                font-weight: 700;
                background: linear-gradient(to right, #8556f0, #6bedd1);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                letter-spacing: -0.5px;
                margin-bottom: 1.5rem;
            }
            
            /* Tab styling */
            .tab-container {
                margin-bottom: 2rem;
            }
            
            .nav-tabs {
                border-bottom: 1px solid var(--gray-light);
                margin-bottom: 1.5rem;
            }
            
            .nav-tabs .nav-link {
                color: var(--gray-medium);
                font-weight: 500;
                border: none;
                border-bottom: 3px solid transparent;
                padding: 0.75rem 1.5rem;
                transition: var(--transition);
                position: relative;
                margin-right: 0.5rem;
                border-top-left-radius: var(--border-radius-sm);
                border-top-right-radius: var(--border-radius-sm);
            }
            
            .nav-tabs .nav-link:hover {
                color: var(--primary-color);
                background-color: rgba(0, 123, 255, 0.05);
            }
            
            .nav-tabs .nav-link.active {
                color: var(--primary-color);
                border-color: var(--primary-color);
                font-weight: 600;
                background-color: rgba(0, 123, 255, 0.08);
            }
            
            /* Custom appearance for tab badges */
            .nav-tabs .nav-link .badge {
                font-size: 0.75rem;
                font-weight: 500;
                padding: 0.25em 0.6em;
                vertical-align: text-top;
                box-shadow: 0 2px 5px rgba(0,0,0,0.08);
            }
            
            /* Table styling */
            .schedule-table {
                border-collapse: separate;
                border-spacing: 0;
                width: 100%;
                border-radius: var(--border-radius-lg);
                overflow: hidden;
                box-shadow: var(--card-shadow);
                background-color: white;
            }
            
            .schedule-table thead {
                background: linear-gradient(to right, #007bff, #0056b3);
                color: white;
            }
            
            .schedule-table th {
                padding: 1rem 1.25rem;
                font-weight: 600;
                text-align: left;
                letter-spacing: 0.3px;
            }
            
            .schedule-table tbody tr {
                transition: var(--transition);
                border-bottom: 1px solid var(--gray-light);
            }
            
            .schedule-table tbody tr:hover {
                background-color: rgba(0, 123, 255, 0.05);
                transform: translateY(-2px);
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            }
            
            .schedule-table tbody tr:last-child {
                border-bottom: none;
            }
            
            .schedule-table td {
                padding: 1.25rem;
                vertical-align: middle;
            }
            
            /* Image styling */
            .schedule-table .property-img {
                width: 80px;
                height: 60px;
                border-radius: var(--border-radius);
                object-fit: cover;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                border: 2px solid white;
                transition: var(--transition);
            }
            
            .schedule-table .property-img:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            }
            
            /* Property info styling */
            .schedule-table .property-title {
                font-weight: 600;
                font-size: 1.05rem;
                color: var(--primary-color);
                margin-bottom: 0.375rem;
                transition: var(--transition);
            }
            
            .schedule-table .property-title:hover {
                color: var(--primary-dark);
                text-decoration: none;
            }
            
            .schedule-table .property-address {
                font-size: 0.875rem;
                color: var(--gray-medium);
                display: flex;
                align-items: center;
                gap: 0.375rem;
            }
            
            .schedule-table .property-address i {
                color: var(--primary-color);
                font-size: 0.75rem;
            }
            
            /* Status badges styling */
            .badge {
                padding: 0.5rem 1rem;
                border-radius: 50px;
                font-weight: 500;
                font-size: 0.875rem;
                letter-spacing: 0.3px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
                display: inline-flex;
                align-items: center;
                gap: 0.375rem;
            }
            
            .badge i {
                font-size: 0.75rem;
            }
            
            .badge-pending {
                background-color: var(--warning-color);
                color: white;
            }
            
            .badge-confirmed {
                background-color: var(--success-color);
                color: white;
            }
            
            .badge-cancelled {
                background-color: var(--danger-color);
                color: white;
            }
            
            /* Button styling */
            .action-btn {
                padding: 0.5rem 1rem;
                border-radius: var(--border-radius);
                font-weight: 500;
                transition: var(--transition);
                letter-spacing: 0.2px;
                display: inline-flex;
                align-items: center;
                gap: 0.375rem;
                border: none;
            }
            
            .confirm-btn {
                background: linear-gradient(to right, var(--success-color), var(--success-dark));
                color: white;
                box-shadow: 0 2px 6px rgba(40, 167, 69, 0.2);
            }
            
            .confirm-btn:hover {
                background: linear-gradient(to right, var(--success-dark), var(--success-dark));
                color: white;
                box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
                transform: translateY(-2px);
            }
            
            .cancel-btn {
                background: linear-gradient(to right, var(--danger-color), var(--danger-dark));
                color: white;
                box-shadow: 0 2px 6px rgba(234, 67, 53, 0.2);
            }
            
            .cancel-btn:hover {
                background: linear-gradient(to right, var(--danger-dark), var(--danger-dark));
                color: white;
                box-shadow: 0 4px 10px rgba(234, 67, 53, 0.3);
                transform: translateY(-2px);
            }
            
            .btn-outline-primary {
                border: 1px solid var(--primary-color);
                color: var(--primary-color);
                background-color: transparent;
            }
            
            .btn-outline-primary:hover {
                background-color: var(--primary-color);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
            }
            
            /* Page title styling */
            .schedule-title {
                position: relative;
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                font-weight: 700;
                color: var(--gray-dark);
                display: inline-block;
            }
            
            .schedule-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 80px;
                height: 4px;
                background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
                border-radius: 10px;
            }
            
            /* Empty state styling */
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: linear-gradient(135deg, #fff, #f8f9fa);
                border-radius: var(--border-radius-lg);
                margin: 2.5rem 0;
                border: 1px dashed var(--gray-light);
                box-shadow: var(--card-shadow);
            }
            
            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1.5rem;
                display: block;
                background: linear-gradient(to right, #8556f0, #6bedd1);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            
            .empty-state h3 {
                margin-bottom: 1rem;
                color: var(--gray-dark);
                font-weight: 600;
                font-size: 1.5rem;
            }
            
            .empty-state p {
                color: var(--gray-medium);
                max-width: 500px;
                margin: 0 auto 1.5rem;
                font-size: 1.05rem;
            }
            
            .empty-state .btn-primary {
                background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
                color: white;
                border: none;
                padding: 0.75rem 2rem;
                font-weight: 500;
                border-radius: var(--border-radius);
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
                transition: var(--transition);
            }
            
            .empty-state .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(0, 123, 255, 0.3);
            }
            
            /* User info styling */
            .user-info {
                display: flex;
                align-items: center;
            }
            
            .user-avatar {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 1rem;
                border: 2px solid white;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                transition: var(--transition);
            }
            
            .user-avatar:hover {
                transform: scale(1.1);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
                border-color: var(--primary-color);
            }
            
            .user-name {
                font-weight: 600;
                margin-bottom: 0.25rem;
                color: var(--gray-dark);
                font-size: 1rem;
            }
            
            .user-contact {
                font-size: 0.875rem;
                color: var(--gray-medium);
                display: flex;
                gap: 1rem;
            }
            
            .user-contact span {
                display: flex;
                align-items: center;
                gap: 0.25rem;
            }
            
            .user-contact i {
                color: var(--primary-color);
            }
            
            /* Sorting control */
            .schedule-sort {
                margin-bottom: 1.5rem;
            }
            
            .form-select {
                padding: 0.75rem 1rem;
                border-radius: var(--border-radius);
                border: 1px solid var(--gray-light);
                color: var(--gray-dark);
                font-weight: 500;
                background-color: white;
                box-shadow: 0 1px 4px rgba(0,0,0,0.03);
                transition: var(--transition);
                width: auto;
                min-width: 250px;
            }
            
            .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.15);
                outline: none;
            }
            
            /* Loading overlay */
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(255, 255, 255, 0.85);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1050;
                visibility: hidden;
                opacity: 0;
                transition: all 0.3s;
                backdrop-filter: blur(3px);
            }
            
            .loading-overlay.show {
                visibility: visible;
                opacity: 1;
            }
            
            .loading-spinner {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                background: white;
                border-radius: var(--border-radius-lg);
                box-shadow: var(--hover-shadow);
            }
            
            .loading-spinner .spinner-border {
                width: 3.5rem;
                height: 3.5rem;
                margin-bottom: 1.25rem;
                color: var(--primary-color);
                border-width: 0.25rem;
            }
            
            /* Special styling for date */
            .schedule-date {
                font-weight: 500;
                background-color: var(--primary-light);
                padding: 0.5rem 1rem;
                border-radius: var(--border-radius);
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--primary-dark);
            }
            
            .schedule-date i {
                color: var(--primary-color);
            }
            
            /* Mobile responsiveness */
            @media (max-width: 768px) {
                .nav-tabs .nav-link {
                    padding: 0.625rem 0.875rem;
                    font-size: 0.95rem;
                }
                
                .schedule-table th, .schedule-table td {
                    padding: 1rem 0.75rem;
                }
                
                .user-contact {
                    flex-direction: column;
                    gap: 0.25rem;
                }
                
                .property-img {
                    width: 70px;
                    height: 50px;
                }
                
                .action-btn {
                    padding: 0.5rem 0.75rem;
                    font-size: 0.875rem;
                }
                
                .breadcrumb__title {
                    font-size: 2.25rem;
                }
                
                .schedule-title {
                    font-size: 1.5rem;
                }
            }
            
            /* Toast styling */
            .toast-container {
                z-index: 1060;
            }
            
            .toast {
                background-color: white;
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                min-width: 300px;
            }
            
            .toast-header {
                padding: 0.75rem 1rem;
                background: white;
                border-bottom-width: 3px;
            }
            
            .toast-body {
                padding: 1rem;
                background: white;
            }
            
            /* Badge for filter */
            .filter-badge {
                position: relative;
                display: inline-block;
                padding: 0.5rem 1rem 0.5rem 2rem;
                background-color: var(--primary-light);
                color: var(--primary-color);
                border-radius: var(--border-radius);
                margin-right: 0.75rem;
                margin-bottom: 0.75rem;
                font-size: 0.9rem;
                font-weight: 500;
                box-shadow: 0 2px 4px rgba(0,0,0,0.04);
            }
            
            .filter-badge::before {
                content: '';
                position: absolute;
                left: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                width: 0.5rem;
                height: 0.5rem;
                background-color: var(--primary-color);
                border-radius: 50%;
            }
            
            .filter-badge.warning {
                background-color: var(--warning-light);
                color: var(--warning-dark);
            }
            
            .filter-badge.warning::before {
                background-color: var(--warning-color);
            }
            
            .filter-badge.success {
                background-color: var(--success-light);
                color: var(--success-dark);
            }
            
            .filter-badge.success::before {
                background-color: var(--success-color);
            }
            
            .filter-badge.danger {
                background-color: var(--danger-light);
                color: var(--danger-dark);
            }
            
            .filter-badge.danger::before {
                background-color: var(--danger-color);
            }
        </style>
    </head>    <body>
        <!-- Loading overlay -->
        <div id="loadingOverlay" class="loading-overlay">
            <div class="loading-spinner">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Đang tải...</span>
                </div>
                <div id="loadingMessage">Đang xử lý yêu cầu...</div>
            </div>
        </div>
        
        <div id="root">
            <main class="body-bg">
                <jsp:include page="/view/common/header.jsp" />
                <section class="breadcrumb padding-y-120">
                    <img src="${pageContext.request.contextPath}/view/guest/asset/img/breadcrumb-img-DVKBF4db.png" 
                         alt="Breadcrumb Image" 
                         class="breadcrumb__img" />
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="breadcrumb__wrapper">
                                    <h2 class="breadcrumb__title">Lịch xem nhà</h2>
                                    <ul class="breadcrumb__list">
                                        <li class="breadcrumb__item">
                                            <a class="breadcrumb__link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                                        </li>
                                        <li class="breadcrumb__item">
                                            Lịch xem nhà
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <section class="padding-y-80">
                    <div class="container">
                        <c:if test="${sessionScope.user == null}">
                            <!-- Not logged in -->
                            <div class="row justify-content-center">
                                <div class="col-md-8">
                                    <div class="empty-state">
                                        <i class="bi bi-lock"></i>
                                        <h3>Yêu cầu đăng nhập</h3>
                                        <p>Vui lòng đăng nhập để xem lịch hẹn xem nhà của bạn.</p>
                                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Đăng nhập</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${sessionScope.user != null}">
                            <div class="row">
                                <div class="col-lg-12">
                                    <h3 class="schedule-title">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                Yêu cầu xem nhà của khách hàng
                                            </c:when>
                                            <c:otherwise>
                                                Lịch xem nhà của bạn
                                            </c:otherwise>
                                        </c:choose>
                                    </h3>                                    
                                    
                                    <div class="d-flex justify-content-between align-items-center flex-wrap mb-4">
                                        <!-- Sorting options -->
                                        <div class="schedule-sort">
                                            <select id="sortSchedules" class="form-select">
                                                <option value="date-desc">Sắp xếp theo: Ngày xem (mới nhất)</option>
                                                <option value="date-asc">Sắp xếp theo: Ngày xem (cũ nhất)</option>
                                                <option value="name-asc">Sắp xếp theo: Tên bất động sản (A-Z)</option>
                                                <option value="name-desc">Sắp xếp theo: Tên bất động sản (Z-A)</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <!-- Tab navigation -->
                                    <div class="tab-container">
                                        <ul class="nav nav-tabs" id="scheduleTabs" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all-schedules" 
                                                    type="button" role="tab" aria-controls="all-schedules" aria-selected="true">
                                                    <i class="bi bi-calendar-week me-2"></i>Tất cả
                                                    <c:if test="${not empty schedules}">
                                                        <span class="ms-1 badge rounded-pill bg-primary">${schedules.size()}</span>
                                                    </c:if>
                                                </button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-schedules" 
                                                    type="button" role="tab" aria-controls="pending-schedules" aria-selected="false">
                                                    <i class="bi bi-hourglass-split me-2"></i>Chờ xác nhận
                                                    <c:if test="${not empty pendingSchedules}">
                                                        <span class="ms-1 badge rounded-pill bg-warning text-dark">${pendingSchedules.size()}</span>
                                                    </c:if>
                                                </button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="confirmed-tab" data-bs-toggle="tab" data-bs-target="#confirmed-schedules" 
                                                    type="button" role="tab" aria-controls="confirmed-schedules" aria-selected="false">
                                                    <i class="bi bi-check-circle me-2"></i>Đã xác nhận
                                                    <c:if test="${not empty confirmedSchedules}">
                                                        <span class="ms-1 badge rounded-pill bg-success">${confirmedSchedules.size()}</span>
                                                    </c:if>
                                                </button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="cancelled-tab" data-bs-toggle="tab" data-bs-target="#cancelled-schedules" 
                                                    type="button" role="tab" aria-controls="cancelled-schedules" aria-selected="false">
                                                    <i class="bi bi-x-circle me-2"></i>Đã hủy
                                                    <c:if test="${not empty cancelledSchedules}">
                                                        <span class="ms-1 badge rounded-pill bg-danger">${cancelledSchedules.size()}</span>
                                                    </c:if>
                                                </button>
                                            </li>
                                        </ul>
                                    </div>
                                    
                                    <!-- Tab content -->
                                    <div class="tab-content" id="scheduleTabContent">
                                        <!-- All schedules tab -->
                                        <div class="tab-pane fade show active" id="all-schedules" role="tabpanel" aria-labelledby="all-tab">
                                            <c:if test="${empty schedules}">
                                                <div class="empty-state">
                                                    <i class="bi bi-calendar-x"></i>
                                                    <h3>Không có lịch hẹn nào</h3>
                                                    <p>
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                Hiện tại bạn không có yêu cầu xem nhà nào từ khách hàng.
                                                            </c:when>
                                                            <c:otherwise>
                                                                Bạn chưa đặt lịch xem bất động sản nào.
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                        <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">Tìm nhà ngay</a>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty schedules}">
                                                <div class="table-responsive">
                                                    <table class="table schedule-table">
                                                        <thead>
                                                            <tr>
                                                                <th>Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th>Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th>Chủ nhà</th>
                                                                </c:if>
                                                                <th>Ngày giờ xem</th>
                                                                <th>Trạng thái</th>
                                                                <th>Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${schedules}" var="schedule">
                                                                <tr>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="property-img me-3">
                                                                            <div>
                                                                                <div class="property-title">${schedule.property.title}</div>
                                                                                <div class="property-address"><i class="bi bi-geo-alt-fill"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.renter.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.renter.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.renter.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.landlord.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.landlord.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.landlord.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="schedule-date">
                                                                            <i class="bi bi-calendar-event"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${schedule.status eq 'Pending'}">
                                                                                <span class="badge badge-pending"><i class="bi bi-hourglass-split"></i> Chờ xác nhận</span>
                                                                            </c:when>
                                                                            <c:when test="${schedule.status eq 'Confirmed'}">
                                                                                <span class="badge badge-confirmed"><i class="bi bi-check-circle"></i> Đã xác nhận</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge badge-cancelled"><i class="bi bi-x-circle"></i> Đã hủy</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <c:if test="${schedule.status eq 'Pending'}">
                                                                            <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                                <form action="${pageContext.request.contextPath}/updateSchedule" method="POST" class="d-inline">
                                                                                    <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                    <input type="hidden" name="action" value="confirm">
                                                                                    <button type="submit" class="btn action-btn confirm-btn">
                                                                                        <i class="bi bi-check-lg"></i> Xác nhận
                                                                                    </button>
                                                                                </form>
                                                                                <form action="${pageContext.request.contextPath}/updateSchedule" method="POST" class="d-inline ms-2">
                                                                                    <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                    <input type="hidden" name="action" value="cancel">
                                                                                    <button type="submit" class="btn action-btn cancel-btn">
                                                                                        <i class="bi bi-x-lg"></i> Từ chối
                                                                                    </button>
                                                                                </form>
                                                                            </c:if>
                                                                            <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                                <form action="${pageContext.request.contextPath}/updateSchedule" method="POST">
                                                                                    <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                    <input type="hidden" name="action" value="cancel">
                                                                                    <button type="submit" class="btn action-btn cancel-btn">
                                                                                        <i class="bi bi-x-lg"></i> Hủy lịch
                                                                                    </button>
                                                                                </form>
                                                                            </c:if>
                                                                        </c:if>
                                                                        <c:if test="${schedule.status ne 'Pending'}">
                                                                            <a href="${pageContext.request.contextPath}/property-detail?id=${schedule.propertyId}" 
                                                                               class="btn btn-outline-primary action-btn">
                                                                                <i class="bi bi-eye"></i> Xem chi tiết
                                                                            </a>
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Pending schedules tab -->
                                        <div class="tab-pane fade" id="pending-schedules" role="tabpanel" aria-labelledby="pending-tab">
                                            <c:if test="${empty pendingSchedules}">
                                                <div class="empty-state">
                                                    <i class="bi bi-hourglass-split"></i>
                                                    <h3>Không có lịch hẹn đang chờ xác nhận</h3>
                                                    <p>
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                Hiện tại không có yêu cầu xem nhà nào cần xác nhận.
                                                            </c:when>
                                                            <c:otherwise>
                                                                Bạn không có lịch xem nhà nào đang chờ xác nhận.
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </c:if>
                                              <!-- Pending schedules table structure -->
                                            <c:if test="${not empty pendingSchedules}">
                                                <div class="table-responsive">
                                                    <table class="table schedule-table">
                                                        <thead>
                                                            <tr>
                                                                <th>Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th>Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th>Chủ nhà</th>
                                                                </c:if>
                                                                <th>Ngày giờ xem</th>
                                                                <th>Trạng thái</th>
                                                                <th>Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${pendingSchedules}" var="schedule">
                                                                <tr>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="property-img me-3">
                                                                            <div>
                                                                                <div class="property-title">${schedule.property.title}</div>
                                                                                <div class="property-address"><i class="bi bi-geo-alt-fill"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.renter.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.renter.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.renter.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.landlord.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.landlord.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.landlord.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="schedule-date">
                                                                            <i class="bi bi-calendar-event"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge badge-pending"><i class="bi bi-hourglass-split"></i> Chờ xác nhận</span>
                                                                    </td>
                                                                    <td>
                                                                        <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                            <form action="${pageContext.request.contextPath}/updateSchedule" method="POST" class="d-inline">
                                                                                <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                <input type="hidden" name="action" value="confirm">
                                                                                <button type="submit" class="btn action-btn confirm-btn">
                                                                                    <i class="bi bi-check-lg"></i> Xác nhận
                                                                                </button>
                                                                            </form>
                                                                            <form action="${pageContext.request.contextPath}/updateSchedule" method="POST" class="d-inline ms-2">
                                                                                <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                <input type="hidden" name="action" value="cancel">
                                                                                <button type="submit" class="btn action-btn cancel-btn">
                                                                                    <i class="bi bi-x-lg"></i> Từ chối
                                                                                </button>
                                                                            </form>
                                                                        </c:if>
                                                                        <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                            <form action="${pageContext.request.contextPath}/updateSchedule" method="POST">
                                                                                <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                <input type="hidden" name="action" value="cancel">
                                                                                <button type="submit" class="btn action-btn cancel-btn">
                                                                                    <i class="bi bi-x-lg"></i> Hủy lịch
                                                                                </button>
                                                                            </form>
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Confirmed schedules tab -->
                                        <div class="tab-pane fade" id="confirmed-schedules" role="tabpanel" aria-labelledby="confirmed-tab">
                                            <c:if test="${empty confirmedSchedules}">
                                                <div class="empty-state">
                                                    <i class="bi bi-calendar-check"></i>
                                                    <h3>Không có lịch hẹn đã xác nhận</h3>
                                                    <p>
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                Bạn chưa xác nhận lịch xem nhà nào.
                                                            </c:when>
                                                            <c:otherwise>
                                                                Chưa có lịch xem nhà nào được xác nhận.
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </c:if>
                                            
                                            <!-- Confirmed schedules table structure -->
                                            <c:if test="${not empty confirmedSchedules}">
                                                <div class="table-responsive">
                                                    <table class="table schedule-table">
                                                        <thead>
                                                            <tr>
                                                                <th>Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th>Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th>Chủ nhà</th>
                                                                </c:if>
                                                                <th>Ngày giờ xem</th>
                                                                <th>Trạng thái</th>
                                                                <th>Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${confirmedSchedules}" var="schedule">
                                                                <tr>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="property-img me-3">
                                                                            <div>
                                                                                <div class="property-title">${schedule.property.title}</div>
                                                                                <div class="property-address"><i class="bi bi-geo-alt-fill"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.renter.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.renter.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.renter.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.landlord.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.landlord.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.landlord.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="schedule-date">
                                                                            <i class="bi bi-calendar-event"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge badge-confirmed"><i class="bi bi-check-circle"></i> Đã xác nhận</span>
                                                                    </td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/property-detail?id=${schedule.propertyId}" 
                                                                           class="btn btn-outline-primary action-btn">
                                                                            <i class="bi bi-eye"></i> Xem chi tiết
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Cancelled schedules tab -->
                                        <div class="tab-pane fade" id="cancelled-schedules" role="tabpanel" aria-labelledby="cancelled-tab">
                                            <c:if test="${empty cancelledSchedules}">
                                                <div class="empty-state">
                                                    <i class="bi bi-calendar-x"></i>
                                                    <h3>Không có lịch hẹn đã hủy</h3>
                                                    <p>
                                                        Không có lịch xem nhà nào đã bị hủy.
                                                    </p>
                                                </div>
                                            </c:if>
                                            
                                            <!-- Cancelled schedules table structure -->
                                            <c:if test="${not empty cancelledSchedules}">
                                                <div class="table-responsive">
                                                    <table class="table schedule-table">
                                                        <thead>
                                                            <tr>
                                                                <th>Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th>Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th>Chủ nhà</th>
                                                                </c:if>
                                                                <th>Ngày giờ xem</th>
                                                                <th>Trạng thái</th>
                                                                <th>Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${cancelledSchedules}" var="schedule">
                                                                <tr>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="property-img me-3">
                                                                            <div>
                                                                                <div class="property-title">${schedule.property.title}</div>
                                                                                <div class="property-address"><i class="bi bi-geo-alt-fill"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.renter.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.renter.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.renter.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="user-info">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="user-avatar">
                                                                                    <div>
                                                                                        <div class="user-name">${schedule.landlord.name}</div>
                                                                                        <div class="user-contact">
                                                                                            <span><i class="bi bi-telephone-fill"></i> ${schedule.landlord.phone}</span>
                                                                                            <span><i class="bi bi-envelope-fill"></i> ${schedule.landlord.email}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="schedule-date">
                                                                            <i class="bi bi-calendar-event"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge badge-cancelled"><i class="bi bi-x-circle"></i> Đã hủy</span>
                                                                    </td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/property-detail?id=${schedule.propertyId}" 
                                                                           class="btn btn-outline-primary action-btn">
                                                                            <i class="bi bi-eye"></i> Xem chi tiết
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </section>

                <jsp:include page="/view/common/footer.jsp" />
            </main>
        </div>
        
        <!-- Bootstrap JS bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" 
                crossorigin="anonymous"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize sorting
                setupSorting();
                
                // Initialize the tabs
                const triggerTabList = [].slice.call(document.querySelectorAll('#scheduleTabs button'));
                triggerTabList.forEach(function(triggerEl) {
                    const tabTrigger = new bootstrap.Tab(triggerEl);
                    
                    triggerEl.addEventListener('click', function(event) {
                        event.preventDefault();
                        tabTrigger.show();
                    });
                });
                
                // Handle form submissions with confirmation
                const actionForms = document.querySelectorAll('form[action="${pageContext.request.contextPath}/updateSchedule"]');
                actionForms.forEach(form => {
                    form.addEventListener('submit', function(event) {
                        event.preventDefault(); // Prevent form submission initially
                        
                        const action = form.querySelector('input[name="action"]').value;
                        let confirmMessage = '';
                        
                        if (action === 'confirm') {
                            confirmMessage = 'Bạn có chắc chắn muốn xác nhận lịch xem nhà này?';
                        } else if (action === 'cancel') {
                            confirmMessage = 'Bạn có chắc chắn muốn hủy lịch xem nhà này?';
                        }
                        
                        // Use Bootstrap modal for confirmation instead of native alert
                        // Create a modal dynamically
                        const modalId = 'confirmModal-' + Math.random().toString(36).substring(2, 15);
                        const modalHTML = `
                            <div class="modal fade" id="${modalId}" tabindex="-1" aria-labelledby="${modalId}-label" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="${modalId}-label">Xác nhận hành động</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>${confirmMessage}</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="button" class="btn btn-primary" id="confirmActionBtn">Xác nhận</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                        
                        // Append modal HTML to body
                        document.body.insertAdjacentHTML('beforeend', modalHTML);
                        
                        // Get the modal element
                        const modalElement = document.getElementById(modalId);
                        const modal = new bootstrap.Modal(modalElement);
                        
                        // Show the modal
                        modal.show();
                        
                        // Handle confirm button click
                        document.getElementById('confirmActionBtn').addEventListener('click', function() {
                            // Show loading state
                            const button = form.querySelector('button[type="submit"]');
                            const originalText = button.innerHTML;
                            
                            // Disable button and show spinner
                            button.disabled = true;                        if (action === 'confirm') {
                                button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang xác nhận...';
                                document.getElementById('loadingMessage').textContent = 'Đang xác nhận lịch xem nhà...';
                            } else if (action === 'cancel') {
                                button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang hủy...';
                                document.getElementById('loadingMessage').textContent = 'Đang hủy lịch xem nhà...';
                            }
                            
                            // Show loading overlay
                            document.getElementById('loadingOverlay').classList.add('show');
                            
                            // Submit form after visual feedback
                            setTimeout(() => {
                                form.submit();
                            }, 300);
                        });
                        
                        // Clean up modal on hidden
                        modalElement.addEventListener('hidden.bs.modal', function() {
                            modalElement.remove();
                        });
                    });
                });
                
                // Handle URL parameters for showing specific tab
                const urlParams = new URLSearchParams(window.location.search);
                let tabParam = urlParams.get('tab');
                
                // Retrieve from localStorage if not in URL
                if (!tabParam) {
                    tabParam = localStorage.getItem('activeScheduleTab');
                }
                
                // Show appropriate tab
                if (tabParam) {
                    const tabToShow = document.querySelector(`#${tabParam}-tab`);
                    if (tabToShow) {
                        const tab = new bootstrap.Tab(tabToShow);
                        tab.show();
                    }
                }
                
                // Save active tab in localStorage when changed
                triggerTabList.forEach(function(tabElement) {
                    tabElement.addEventListener('shown.bs.tab', function(e) {
                        // Extract tab ID without the '-tab' suffix
                        const tabId = e.target.id.replace('-tab', '');
                        localStorage.setItem('activeScheduleTab', tabId);
                        
                        // Update URL without reloading page
                        const url = new URL(window.location.href);
                        url.searchParams.set('tab', tabId);
                        window.history.replaceState({}, document.title, url.toString());
                    });
                });
                
                // Show toast message if available
                const statusMessage = urlParams.get('message');
                if (statusMessage) {
                    showToast(decodeURIComponent(statusMessage));
                    
                    // Clean URL
                    const url = new URL(window.location.href);
                    url.searchParams.delete('message');
                    window.history.replaceState({}, document.title, url.toString());
                }
            });
              // Sorting functionality
            function setupSorting() {
                const sortSelect = document.getElementById('sortSchedules');
                if (!sortSelect) return;
                
                // Restore sort preference from localStorage
                const savedSort = localStorage.getItem('scheduleSort');
                if (savedSort) {
                    sortSelect.value = savedSort;
                }
                
                sortSelect.addEventListener('change', function() {
                    const sortValue = this.value;
                    localStorage.setItem('scheduleSort', sortValue);
                    
                    // Perform sorting for all tables
                    const tables = document.querySelectorAll('.schedule-table');
                    tables.forEach(table => {
                        sortTable(table, sortValue);
                    });
                });
                
                // Initial sort on page load
                const tables = document.querySelectorAll('.schedule-table');
                tables.forEach(table => {
                    sortTable(table, sortSelect.value);
                });
            }
            
            function sortTable(table, sortType) {
                const tbody = table.querySelector('tbody');
                if (!tbody) return;
                
                const rows = Array.from(tbody.querySelectorAll('tr'));
                
                rows.sort((a, b) => {
                    switch (sortType) {
                        case 'date-asc':
                            // Get date from 3rd td
                            const dateA = getDateFromRow(a);
                            const dateB = getDateFromRow(b);
                            return dateA - dateB;
                        case 'date-desc':
                            // Get date from 3rd td
                            const dateDescA = getDateFromRow(a);
                            const dateDescB = getDateFromRow(b);
                            return dateDescB - dateDescA;
                        case 'name-asc':
                            // Get property name from 1st td
                            const nameA = getPropertyNameFromRow(a).toLowerCase();
                            const nameB = getPropertyNameFromRow(b).toLowerCase();
                            return nameA.localeCompare(nameB);
                        case 'name-desc':
                            // Get property name from 1st td
                            const nameDescA = getPropertyNameFromRow(a).toLowerCase();
                            const nameDescB = getPropertyNameFromRow(b).toLowerCase();
                            return nameDescB.localeCompare(nameDescA);
                        default:
                            return 0;
                    }
                });
                
                // Reorder rows in DOM
                rows.forEach(row => {
                    tbody.appendChild(row);
                });
            }
            
            function getDateFromRow(row) {
                // Date is in the 3rd column
                const dateCell = row.querySelector('td:nth-child(3)');
                if (!dateCell) return 0;
                
                // Extract date in format dd/MM/yyyy lÃºc HH:mm
                const dateString = dateCell.textContent.trim();
                
                // Convert to date object
                if (dateString) {
                    const parts = dateString.split(' lÃºc ');
                    if (parts.length === 2) {
                        const datePart = parts[0].split('/').reverse().join('-');
                        const timePart = parts[1];
                        return new Date(`${datePart}T${timePart}`).getTime();
                    }
                }
                return 0;
            }
            
            function getPropertyNameFromRow(row) {
                // Property name is in the first td > div > div > div.property-title
                const titleElement = row.querySelector('.property-title');
                return titleElement ? titleElement.textContent.trim() : '';
            }
            
            function showToast(message) {
                // Create toast container
                const toastContainer = document.createElement('div');
                toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
                toastContainer.style.zIndex = '5';
                
                // Create toast HTML
                const isSuccess = message.toLowerCase().includes('thÃ nh cÃ´ng') || 
                                 !message.toLowerCase().includes('tháº¥t báº¡i') && 
                                 !message.toLowerCase().includes('lá»i') && 
                                 !message.toLowerCase().includes('khÃ´ng');
                
                const borderColor = isSuccess ? 'success' : 'danger';
                const iconType = isSuccess ? 'check-circle-fill' : 'exclamation-triangle-fill';
                
                const toastContent = `
                    <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header border-${borderColor} border-bottom">
                            <i class="bi bi-${iconType} me-2 text-${borderColor}"></i>
                            <strong class="me-auto">ThÃ´ng bÃ¡o</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body">
                            ${message}
                        </div>
                    </div>
                `;
                
                toastContainer.innerHTML = toastContent;
                document.body.appendChild(toastContainer);
                
                // Initialize Bootstrap toast
                const toastElement = toastContainer.querySelector('.toast');
                if (toastElement) {
                    const bsToast = new bootstrap.Toast(toastElement, {
                        autohide: true,
                        delay: 5000
                    });
                    
                    // Remove from DOM after hiding animation
                    toastElement.addEventListener('hidden.bs.toast', () => {
                        if (document.body.contains(toastContainer)) {
                            document.body.removeChild(toastContainer);
                        }
                    });
                    
                    // Handle close button
                    const closeButton = toastElement.querySelector('.btn-close');
                    if (closeButton) {
                        closeButton.addEventListener('click', () => {
                            bsToast.hide();
                        });
                    }
                }
            }
        </script>
    </body>
</html>
