<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý tin đăng - RentEz</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
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
                            'orange-lighter': '#ffb74d',
                            'orange-lightest': '#ffe0b2'
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                background: #fafafa;
                font-family: 'Inter', Arial, sans-serif;
            }

            /* Sidebar với theme cam gradient */
            .sidebar {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 50%, #ff9800 100%);
                color: #fff;
                min-height: 100vh;
                border-radius: 0 2rem 2rem 0;
                box-shadow: 0 8px 32px rgba(230, 81, 0, 0.2);
                position: relative;
                overflow: hidden;
            }

            .sidebar::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(135deg, rgba(230, 81, 0, 0.95) 0%, rgba(255, 109, 0, 0.95) 50%, rgba(255, 152, 0, 0.95) 100%);
                z-index: 1;
            }

            .sidebar > * {
                position: relative;
                z-index: 2;
            }

            .sidebar a {
                color: #fff;
                font-weight: 500;
                border-radius: 0.75rem;
                margin-bottom: 0.5rem;
                transition: all 0.3s ease;
                padding: 1rem 1.25rem;
                display: flex;
                align-items: center;
                text-decoration: none;
                border: 1px solid transparent;
            }

            .sidebar .active {
                background: rgba(255, 255, 255, 0.25);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .sidebar a:hover {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(10px);
                transform: translateX(8px);
                color: #fff;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .account-avatar {
                width: 85px;
                height: 85px;
                background: linear-gradient(135deg, #fff 0%, rgba(255, 255, 255, 0.95) 100%);
                color: #e65100;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
                font-weight: bold;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
                border: 4px solid rgba(255, 255, 255, 0.3);
            }

            .dashboard-header {
                border-radius: 1.5rem;
                border: none;
                box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
                background: linear-gradient(135deg, #fff 0%, #fff8f0 100%);
                padding: 2rem 2.5rem;
                margin-bottom: 2rem;
                border-left: 6px solid #e65100;
            }

            .dashboard-section-title {
                font-size: 1.875rem;
                font-weight: 700;
                color: #1a1a1a;
                margin-bottom: 0.5rem;
            }

            .dashboard-section-subtitle {
                font-size: 0.95rem;
                color: #e65100;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .text-gradient {
                background: linear-gradient(90deg, #e65100 0%, #ff6d00 50%, #ff9800 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 600;
            }

            .btn-main {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 50%, #ff9800 100%);
                color: #fff;
                border: none;
                border-radius: 0.75rem;
                font-weight: 600;
                padding: 0.875rem 1.75rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 20px rgba(230, 81, 0, 0.3);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.875rem;
            }

            .btn-main:hover {
                background: linear-gradient(135deg, #bf360c 0%, #e65100 50%, #ff6d00 100%);
                transform: translateY(-3px);
                box-shadow: 0 8px 30px rgba(230, 81, 0, 0.4);
                color: #fff;
            }

            .btn-main.btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
            }

            .success-message {
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #4caf50 0%, #66bb6a 100%);
                color: #fff;
                padding: 1rem 1.5rem;
                border-radius: 0.75rem;
                box-shadow: 0 4px 20px rgba(76, 175, 80, 0.3);
                z-index: 1000;
                opacity: 0;
                transition: opacity 0.5s;
            }

            .success-message.show {
                opacity: 1;
            }

            .nav-link {
                padding: 1rem 1.25rem;
            }

            .nav-link i {
                width: 22px;
                margin-right: 0.875rem;
                font-size: 1.1rem;
            }

            /* User info styling */
            .user-info {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 2rem;
                border: 1px solid rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
            }

            .user-points {
                background: rgba(255, 255, 255, 0.2);
                padding: 0.5rem 1rem;
                border-radius: 2rem;
                font-size: 0.875rem;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                margin-top: 0.5rem;
            }

            /* Logout button styling */
            .logout-section {
                margin-top: auto;
                padding-top: 2rem;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .logout-section a {
                background: rgba(244, 67, 54, 0.15);
                border: 1px solid rgba(244, 67, 54, 0.2);
                color: #ffcdd2;
            }

            .logout-section a:hover {
                background: rgba(244, 67, 54, 0.25);
                color: #fff;
                transform: translateX(5px);
            }

            /* Table styling */
            .property-card {
                border-radius: 1.5rem;
                border: none;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
                background: #fff;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .property-card-header {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                padding: 1.5rem 2rem;
                border-bottom: 2px solid #ffe0b2;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .property-card-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #e65100;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .property-card-icon {
                width: 40px;
                height: 40px;
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 100%);
                color: #fff;
                border-radius: 0.75rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.25rem;
            }

            .table-container {
                overflow-x: auto;
                padding: 1rem;
            }

            .property-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-bottom: 0;
            }

            .property-table th {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 30%, #ff8f00 70%, #ff9800 100%);
                color: #fff;
                font-weight: 700;
                text-transform: uppercase;
                font-size: 0.9rem;
                letter-spacing: 1px;
                padding: 1.5rem 1.5rem;
                text-align: center;
                border: none;
                position: sticky;
                top: 0;
                z-index: 10;
                box-shadow: 0 2px 8px rgba(230, 81, 0, 0.3);
                text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
            }

            .property-table th:first-child {
                border-top-left-radius: 1rem;
                text-align: left;
            }

            .property-table th:last-child {
                border-top-right-radius: 1rem;
                text-align: center;
            }

            /* Thêm hiệu ứng hover cho header */
            .property-table th:hover {
                background: linear-gradient(135deg, #bf360c 0%, #e65100 30%, #ff6d00 70%, #ff8f00 100%);
                transform: translateY(-1px);
                transition: all 0.3s ease;
            }

            /* Cải thiện spacing và alignment */
            .property-table th {
                vertical-align: middle;
                white-space: nowrap;
            }

            .property-table td {
                padding: 1.5rem 1.5rem;
                border-bottom: 1px solid #f5f5f5;
                vertical-align: middle;
                transition: all 0.3s ease;
                text-align: center;
                background: #fff;
            }

            .property-table td:first-child {
                text-align: left;
            }

            .property-table tr:hover td {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                box-shadow: 0 2px 8px rgba(230, 81, 0, 0.1);
            }

            .property-table tr:last-child td {
                border-bottom: none;
            }

            .property-table tr:last-child td:first-child {
                border-bottom-left-radius: 1rem;
            }

            .property-table tr:last-child td:last-child {
                border-bottom-right-radius: 1rem;
            }

            .property-title {
                font-weight: 700;
                color: #333;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                max-width: 300px;
                text-align: left;
            }

            .property-title-icon {
                width: 36px;
                height: 36px;
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 100%);
                color: #fff;
                border-radius: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
                flex-shrink: 0;
            }

            .property-type {
                font-weight: 500;
                color: #555;
                background: #f5f5f5;
                padding: 0.5rem 1rem;
                border-radius: 2rem;
                display: inline-block;
                font-size: 0.9rem;
            }

            .property-price {
                font-weight: 700;
                color: #e65100;
                font-size: 1.1rem;
            }

            .property-size {
                font-weight: 600;
                color: #333;
            }

            .property-status {
                padding: 0.5rem 1rem;
                border-radius: 2rem;
                font-weight: 600;
                font-size: 0.85rem;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .status-available {
                background: #e8f5e9;
                color: #2e7d32;
                border: 1px solid #c8e6c9;
            }

            .status-rented {
                background: #fff8e1;
                color: #f57c00;
                border: 1px solid #ffecb3;
            }

            .status-not-available {
                background: #ffebee;
                color: #c62828;
                border: 1px solid #ffcdd2;
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 0.5rem;
            }

            .btn-action {
                width: 40px;
                height: 40px;
                border-radius: 0.75rem;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 1rem;
                transition: all 0.3s ease;
                border: none;
            }

            .btn-view {
                background: linear-gradient(135deg, #039be5 0%, #29b6f6 100%);
            }

            .btn-view:hover {
                background: linear-gradient(135deg, #0277bd 0%, #039be5 100%);
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(3, 155, 229, 0.3);
            }

            .btn-edit {
                background: linear-gradient(135deg, #ff9800 0%, #ffb74d 100%);
            }

            .btn-edit:hover {
                background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(255, 152, 0, 0.3);
            }

            .btn-delete {
                background: linear-gradient(135deg, #f44336 0%, #e57373 100%);
            }

            .btn-delete:hover {
                background: linear-gradient(135deg, #d32f2f 0%, #f44336 100%);
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
            }

            /* Empty state */
            .empty-state {
                padding: 4rem 2rem;
                text-align: center;
                background: linear-gradient(135deg, #fff 0%, #fff8f0 100%);
                border-radius: 1.5rem;
            }

            .empty-state-icon {
                width: 100px;
                height: 100px;
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 2rem;
                font-size: 3rem;
                color: #ff6d00;
                box-shadow: 0 8px 30px rgba(255, 109, 0, 0.2);
                border: 2px dashed #ffcc80;
            }

            .empty-state-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 1rem;
            }

            .empty-state-description {
                font-size: 1.1rem;
                color: #666;
                margin-bottom: 2rem;
                max-width: 500px;
                margin-left: auto;
                margin-right: auto;
            }

            /* Filter bar */
            .filter-bar {
                background: #fff;
                border-radius: 1rem;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                align-items: center;
            }

            .filter-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .filter-label {
                font-weight: 600;
                color: #555;
                font-size: 0.9rem;
            }

            .filter-select {
                border: 1px solid #e0e0e0;
                border-radius: 0.5rem;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
                color: #333;
                background: #f9f9f9;
                transition: all 0.3s ease;
            }

            .filter-select:focus {
                border-color: #ff6d00;
                box-shadow: 0 0 0 2px rgba(255, 109, 0, 0.1);
                outline: none;
            }

            .search-box {
                flex-grow: 1;
                position: relative;
            }

            .search-input {
                width: 100%;
                border: 1px solid #e0e0e0;
                border-radius: 0.5rem;
                padding: 0.5rem 1rem 0.5rem 2.5rem;
                font-size: 0.9rem;
                color: #333;
                background: #f9f9f9;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                border-color: #ff6d00;
                box-shadow: 0 0 0 2px rgba(255, 109, 0, 0.1);
                outline: none;
                background: #fff;
            }

            .search-icon {
                position: absolute;
                left: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                color: #999;
                font-size: 1rem;
            }

            /* Pagination */
            .pagination-container {
                display: flex;
                justify-content: center;
                margin-top: 2rem;
            }

            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
                gap: 0.5rem;
            }

            .page-item {
                margin: 0;
            }

            .page-link {
                width: 40px;
                height: 40px;
                border-radius: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #fff;
                color: #333;
                font-weight: 600;
                border: 1px solid #e0e0e0;
                transition: all 0.3s ease;
            }

            .page-link:hover {
                background: #fff8f0;
                color: #e65100;
                border-color: #ffcc80;
            }

            .page-item.active .page-link {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 100%);
                color: #fff;
                border-color: #e65100;
                box-shadow: 0 4px 15px rgba(230, 81, 0, 0.3);
            }

            .page-item.disabled .page-link {
                background: #f5f5f5;
                color: #bbb;
                cursor: not-allowed;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .dashboard-header {
                    padding: 1.5rem;
                }

                .property-table th,
                .property-table td {
                    padding: 1rem;
                }

                .property-title {
                    max-width: 200px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    border-radius: 0;
                }

                .filter-bar {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-item {
                    width: 100%;
                }

                .property-table {
                    min-width: 800px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <jsp:include page="../common/navigation.jsp" />

                <!-- Main content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <!-- Header -->
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center mb-4">
                        <div>
                            <div class="dashboard-section-subtitle mb-2">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Quản lý tin đăng</div>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted">Xin chào, <strong class="text-dark">Dũng Trần</strong></span>
                            <a href="${pageContext.request.contextPath}/payments" class="btn btn-main">
                                <i class="fas fa-plus me-2"></i>Nạp tiền
                            </a>
                        </div>
                    </div>

                    <!-- Success message -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="success-message" id="successMessage">
                            <i class="fas fa-check-circle me-2"></i>
                            ${sessionScope.successMessage}
                        </div>
                    </c:if>

                    <!-- Filter bar -->
                    <div class="filter-bar mb-4">
                        <div class="search-box">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" class="search-input" placeholder="Tìm kiếm tin đăng...">
                        </div>
                        <div class="filter-item">
                            <span class="filter-label">Loại:</span>
                            <select class="filter-select">
                                <option value="">Tất cả</option>
                                <option value="1">Căn hộ</option>
                                <option value="2">Nhà riêng</option>
                                <option value="3">Biệt thự</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <span class="filter-label">Trạng thái:</span>
                            <select class="filter-select">
                                <option value="">Tất cả</option>
                                <option value="Available">Còn trống</option>
                                <option value="Rented">Đã thuê</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <span class="filter-label">Sắp xếp:</span>
                            <select class="filter-select">
                                <option value="newest">Mới nhất</option>
                                <option value="price_asc">Giá tăng dần</option>
                                <option value="price_desc">Giá giảm dần</option>
                            </select>
                        </div>
                    </div>

                    <!-- Properties Table -->
                    <div class="property-card mb-4">
                        <div class="property-card-header">
                            <div class="property-card-title">
                                <div class="property-card-icon">
                                    <i class="fas fa-list"></i>
                                </div>
                                Danh sách tin đăng
                            </div>
                            <a href="${pageContext.request.contextPath}/addProperty" class="btn btn-main btn-sm">
                                <i class="fas fa-plus me-2"></i>Đăng tin mới
                            </a>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger m-3" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                ${error}
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${empty properties}">
                                <div class="empty-state">
                                    <div class="empty-state-icon">
                                        <i class="fas fa-home"></i>
                                    </div>
                                    <h3 class="empty-state-title">Chưa có tin đăng nào</h3>
                                    <p class="empty-state-description">
                                        Bạn chưa có tin đăng bất động sản nào. Hãy bắt đầu bằng cách tạo tin đăng đầu tiên của bạn.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/addProperty" class="btn btn-main">
                                        <i class="fas fa-plus me-2"></i>Đăng tin mới
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-container">
                                    <table class="property-table">
                                        <thead>
                                            <tr>
                                                <th>Tiêu đề</th>
                                                <th>Loại hình</th>
                                                <th>Giá (VNĐ)</th>
                                                <th>Diện tích</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="property" items="${properties}">
                                                <tr>
                                                    <td>
                                                        <div class="property-title">
                                                            <div class="property-title-icon">
                                                                <i class="fas fa-home"></i>
                                                            </div>
                                                            <span>${property.title}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="property-type">${typeNames[property.typeId]}</span>
                                                    </td>
                                                    <td>
                                                        <span class="property-price">
                                                            <fmt:formatNumber value="${property.price}" type="number" groupingUsed="true"/> đ
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="property-size">
                                                            <fmt:formatNumber value="${property.size}" type="number" maxFractionDigits="0"/> m²
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${property.availabilityStatus eq 'Available'}">
                                                                <span class="property-status status-available">
                                                                    <i class="fas fa-check-circle"></i>
                                                                    Còn trống
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${property.availabilityStatus eq 'Rented'}">
                                                                <span class="property-status status-rented">
                                                                    <i class="fas fa-user-check"></i>
                                                                    Đã thuê
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="property-status status-not-available">
                                                                    <i class="fas fa-times-circle"></i>
                                                                    Không khả dụng
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="${pageContext.request.contextPath}/viewPropertyDetail?propertyId=${property.propertyId}" class="btn-action btn-view" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/editProperty?propertyId=${property.propertyId}" class="btn-action btn-edit" title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="#" onclick="confirmDelete(${property.propertyId})" class="btn-action btn-delete" title="Xóa">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <div class="pagination-container">
                                    <ul class="pagination">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-label="Previous">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Next">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
            </div>
        </div>

        <jsp:include page="/view/common/footer.jsp" />
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        <script>
                                                                // Function to show and hide success message
                                                                document.addEventListener('DOMContentLoaded', function () {
                                                                    const successMessage = document.getElementById('successMessage');
                                                                    if (successMessage) {
                                                                        successMessage.classList.add('show');
                                                                        setTimeout(function () {
                                                                            successMessage.classList.remove('show');
                                                                            setTimeout(function () {
                                                                                successMessage.remove();
                                                                            }, 500);
                                                                        }, 3000);
                                                                        fetch('${pageContext.request.contextPath}/cleanupSession', {
                                                                            method: 'POST',
                                                                            headers: {
                                                                                'Content-Type': 'application/x-www-form-urlencoded'
                                                                            },
                                                                            body: 'attribute=successMessage'
                                                                        }).catch(error => console.error('Error cleaning session:', error));
                                                                    }
                                                                });

                                                                // Confirm delete function
                                                                function confirmDelete(propertyId) {
                                                                    if (confirm('Bạn có chắc chắn muốn xóa tin đăng này?')) {
                                                                        window.location.href = '${pageContext.request.contextPath}/deleteProperty?propertyId=' + propertyId;
                                                                    }
                                                                }

                                                                // Confirm logout function
                                                                function confirmLogout() {
                                                                    if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                                                                        // Add your logout logic here
                                                                        window.location.href = '${pageContext.request.contextPath}/logout';
                                                                    }
                                                                }
        </script>
        <script src="${pageContext.request.contextPath}/view/landlord/asset/js/fontAwesome.js"></script>
    </body>
</html>