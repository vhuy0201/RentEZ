<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản lý tài khoản - RentEz</title>
        <!-- Sử dụng lại các file css của homepage.jsp -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/landlord/common/navigation.css"/>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Chart.js for revenue charts -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            
            .dashboard-card, .dashboard-header {
                border-radius: 1.5rem;
                border: none;
                box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
                background: #fff;
                transition: all 0.3s ease;
                border-left: 4px solid transparent;
            }
            
            .dashboard-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
                border-left: 4px solid #ff6d00;
            }
            
            .dashboard-header {
                padding: 2rem 2.5rem;
                margin-bottom: 2rem;
                border-left: 6px solid #e65100;
                background: linear-gradient(135deg, #fff 0%, #fff8f0 100%);
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
            
            /* Card icons với theme cam */
            .card-icon {
                width: 65px;
                height: 65px;
                border-radius: 1.25rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                color: #fff;
                margin-right: 1.25rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }
            
            .card-icon-primary {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 100%);
            }
            
            .card-icon-secondary {
                background: linear-gradient(135deg, #ff6d00 0%, #ff9800 100%);
            }
            
            .card-icon-tertiary {
                background: linear-gradient(135deg, #ff9800 0%, #ffb74d 100%);
            }
            
            /* Info section styling */
            .info-section {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                border: 1px solid #ffe0b2;
            }
            
            .info-item {
                padding: 0.75rem 0;
                border-bottom: 1px solid #ffe0b2;
            }
            
            .info-item:last-child {
                border-bottom: none;
            }
            
            .info-bullet {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background: linear-gradient(135deg, #e65100 0%, #ff9800 100%);
                margin-right: 1rem;
                margin-top: 0.5rem;
                flex-shrink: 0;
            }
            
            /* Wallet balance styling */
            .wallet-balance {
                font-size: 1.25rem;
                font-weight: 700;
                background: linear-gradient(135deg, #2e7d32 0%, #4caf50 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            
            .wallet-updated {
                font-size: 0.75rem;
                color: #666;
                font-style: italic;
            }
            
            .wallet-card-hover {
                transition: all 0.3s ease;
            }
            
            .wallet-card-hover:hover .wallet-balance {
                transform: scale(1.05);
                transition: transform 0.3s ease;
            }
            
            /* Transaction Table Styling */
            .transaction-table {
                background: #fff;
                border-radius: 0.75rem;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }
            
            .transaction-table .table {
                margin-bottom: 0;
                font-size: 0.875rem;
            }
            
            .transaction-table thead th {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                color: #495057;
                font-weight: 600;
                font-size: 0.8rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 1rem 0.75rem;
                border: none;
                vertical-align: middle;
            }
            
            .transaction-table tbody td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                border-top: 1px solid #f1f3f4;
                font-size: 0.875rem;
                line-height: 1.4;
            }
            
            .transaction-table tbody tr:hover {
                background-color: rgba(255, 109, 0, 0.02);
                transition: background-color 0.2s ease;
            }
            
            .trans-code {
                font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
                font-size: 0.8rem;
                font-weight: 600;
                color: #6c757d;
                background: #f8f9fa;
                padding: 0.25rem 0.5rem;
                border-radius: 0.375rem;
                border: 1px solid #e9ecef;
            }
            
            .trans-date {
                font-weight: 500;
                color: #495057;
            }
            
            .trans-amount {
                font-weight: 700;
                font-size: 0.9rem;
                background: linear-gradient(90deg, #e65100 0%, #ff6d00 50%, #ff9800 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
            
            .trans-method {
                font-weight: 500;
                color: #6c757d;
                background: #f8f9fa;
                padding: 0.25rem 0.5rem;
                border-radius: 0.375rem;
                display: inline-block;
                font-size: 0.8rem;
            }
            
            .status-badge {
                font-size: 0.75rem;
                font-weight: 600;
                padding: 0.375rem 0.75rem;
                border-radius: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: none;
            }
            
            .status-completed {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            
            .status-pending {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                color: #856404;
                border: 1px solid #ffeaa7;
            }
            
            .status-failed {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            
            .trans-type {
                font-weight: 600;
                font-size: 0.8rem;
                padding: 0.25rem 0.5rem;
                border-radius: 0.375rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .type-booking {
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                color: #1565c0;
            }
            
            .type-rent {
                background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
                color: #2e7d32;
            }
            
            .type-deposit {
                background: linear-gradient(135deg, #e1f5fe 0%, #b3e5fc 100%);
                color: #0277bd;
            }
            
            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
                color: #6c757d;
            }
            
            .empty-state i {
                font-size: 3rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }
            
            .empty-state h6 {
                font-weight: 600;
                margin-bottom: 0.5rem;
            }
            
            .empty-state p {
                font-size: 0.875rem;
                opacity: 0.8;
            }
            
            /* Responsive table adjustments */
            @media (max-width: 768px) {
                .transaction-table {
                    font-size: 0.8rem;
                }
                
                .transaction-table thead th {
                    padding: 0.75rem 0.5rem;
                    font-size: 0.75rem;
                }
                
                .transaction-table tbody td {
                    padding: 0.75rem 0.5rem;
                }
                
                .trans-code, .trans-method, .trans-type {
                    font-size: 0.7rem;
                    padding: 0.2rem 0.4rem;
                }
                
                .status-badge {
                    font-size: 0.7rem;
                    padding: 0.3rem 0.6rem;
                }
            }
            
            /* Table row animation */
            .transaction-table tbody tr {
                transition: all 0.3s ease;
            }
            
            .transaction-table tbody tr:hover {
                transform: translateX(2px);
                box-shadow: 0 2px 8px rgba(230, 81, 0, 0.15);
            }
            
            /* Loading animation for when data is being fetched */
            .table-loading {
                position: relative;
            }
            
            .table-loading::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(255, 255, 255, 0.8);
                z-index: 10;
                display: none;
            }
        </style>
        
    </head>
    <body class="bg-gray-50">
        <div class="container-fluid">
            <div class="row">
                <!-- Navigation -->
                <jsp:include page="../common/navigation.jsp" />
                
                <!-- Main content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <!-- Header -->
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center">
                        <div>
                            <div class="dashboard-section-subtitle mb-2">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Quản lý tài khoản</div>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted">Xin chào, <strong class="text-dark">${sessionScope.user.name}</strong></span>
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
                    
                    <!-- Dashboard Cards -->
                    <div class="row g-4 mb-5">
                        <!-- Revenue Statistics -->
                        <div class="col-md-3">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-primary">
                                        <i class="fas fa-chart-line"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-6 mb-1 text-dark">Doanh thu tháng</div>
                                        <div class="text-gradient fw-bold fs-5 mb-1">
                                            <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-3">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-secondary">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-6 mb-1 text-dark">Doanh thu năm</div>
                                        <div class="text-gradient fw-bold fs-5 mb-1">
                                            <fmt:formatNumber value="${yearlyRevenue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                        </div>
                                        <div class="text-muted small">
                                            <fmt:formatNumber value="${totalTransactions}" type="number"/> giao dịch
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-3">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-tertiary">
                                        <i class="fas fa-chart-pie"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-6 mb-1 text-dark">Tỷ lệ thành công</div>
                                        <div class="text-gradient fw-bold fs-5 mb-1">${successRate}%</div>
                                        <div class="text-muted small">
                                            ${completedTransactions}/${totalTransactions} giao dịch
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-3">
                            <div class="dashboard-card wallet-card-hover p-4" 
                                 <c:if test="${not empty userWallet}">
                                     title="Wallet ID: ${userWallet.walletId} | Cập nhật lần cuối: <fmt:formatDate value="${userWallet.lastUpdated}" pattern="dd/MM/yyyy HH:mm"/>"
                                 </c:if>>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-primary">
                                        <i class="fas fa-wallet"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-6 mb-1 text-dark">Số dư tài khoản</div>
                                        <div class="mb-2">
                                            <c:choose>
                                                <c:when test="${not empty userWallet}">
                                                    <span class="wallet-balance">
                                                        <fmt:formatNumber value="${userWallet.balance}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="fw-bold text-muted">0 ₫</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/payments" class="btn btn-link p-0 text-gradient fw-semibold text-decoration-none small">
                                            <i class="fas fa-credit-card me-1"></i>Nạp tiền
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Revenue Chart Section -->
                    <div class="row g-4 mb-5">
                        <div class="col-lg-8">
                            <div class="dashboard-card p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h5 class="mb-1 text-dark fw-bold">Biểu đồ doanh thu 12 tháng</h5>
                                        <p class="text-muted mb-0 small">Theo dõi xu hướng doanh thu theo thời gian</p>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <span class="badge bg-success">Hoàn thành: ${completedTransactions}</span>
                                        <span class="badge bg-warning">Chờ xử lý: ${pendingTransactions}</span>
                                    </div>
                                </div>
                                <div class="position-relative" style="height: 300px;">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-4">
                            <div class="dashboard-card p-4 h-100">
                                <h5 class="mb-3 text-dark fw-bold">Tổng quan tài chính</h5>
                                <div class="mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="text-muted small">Tổng doanh thu</span>
                                        <span class="fw-bold text-gradient">
                                            <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="text-muted small">Doanh thu quý</span>
                                        <span class="fw-bold">
                                            <fmt:formatNumber value="${quarterlyRevenue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted small">Giao dịch trung bình</span>
                                        <span class="fw-bold">
                                            <fmt:formatNumber value="${averageTransaction}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                        </span>
                                    </div>
                                </div>
                                
                                <div class="border-top pt-3">
                                    <h6 class="mb-3 text-dark">Tài sản quản lý</h6>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="text-muted small">Tổng số phòng</span>
                                        <span class="fw-bold">${totalProperties}</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-muted small">Đang hoạt động</span>
                                        <span class="fw-bold text-success">${activeProperties}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Transactions -->
                    <div class="dashboard-card mb-4">
                        <div class="p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <h5 class="mb-1 text-dark fw-bold d-flex align-items-center">
                                        <i class="fas fa-history text-gradient me-2"></i>
                                        Giao dịch gần đây
                                    </h5>
                                    <p class="text-muted mb-0 small">Danh sách 10 giao dịch mới nhất của bạn</p>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-outline-secondary btn-sm" title="Tải lại">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                    <a href="#" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-external-link-alt me-1"></i>Xem tất cả
                                    </a>
                                </div>
                            </div>
                            
                            <c:choose>
                                <c:when test="${not empty recentPayments}">
                                    <div class="table-responsive">
                                        <div class="transaction-table">
                                            <table class="table table-hover mb-0">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 15%;">Mã giao dịch</th>
                                                        <th style="width: 12%;">Ngày</th>
                                                        <th style="width: 18%;">Số tiền</th>
                                                        <th style="width: 15%;">Phương thức</th>
                                                        <th style="width: 15%;">Trạng thái</th>
                                                        <th style="width: 15%;">Loại giao dịch</th>
                                                        <th style="width: 10%;">Chi tiết</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="payment" items="${recentPayments}" varStatus="status">
                                                        <tr>
                                                            <td>
                                                                <span class="trans-code">${payment.transCode}</span>
                                                            </td>
                                                            <td>
                                                                <span class="trans-date">
                                                                    <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy"/>
                                                                </span>
                                                                <div class="text-muted" style="font-size: 0.75rem;">
                                                                    <fmt:formatDate value="${payment.paymentDate}" pattern="HH:mm"/>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <span class="trans-amount">
                                                                    <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <span class="trans-method">${payment.paymentMethod}</span>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${payment.status == 'Completed'}">
                                                                        <span class="status-badge status-completed">
                                                                            <i class="fas fa-check-circle me-1"></i>Hoàn thành
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${payment.status == 'Pending'}">
                                                                        <span class="status-badge status-pending">
                                                                            <i class="fas fa-clock me-1"></i>Chờ xử lý
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${payment.status == 'Failed'}">
                                                                        <span class="status-badge status-failed">
                                                                            <i class="fas fa-times-circle me-1"></i>Thất bại
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="status-badge" style="background: #f8f9fa; color: #6c757d;">
                                                                            ${payment.status}
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${payment.referenceType == 'BOOKING'}">
                                                                        <span class="trans-type type-booking">
                                                                            <i class="fas fa-calendar-check me-1"></i>Đặt phòng
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${payment.referenceType == 'RENT'}">
                                                                        <span class="trans-type type-rent">
                                                                            <i class="fas fa-home me-1"></i>Thuê phòng
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${payment.referenceType == 'DEPOSIT'}">
                                                                        <span class="trans-type type-deposit">
                                                                            <i class="fas fa-piggy-bank me-1"></i>Tiền cọc
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="trans-type" style="background: #f8f9fa; color: #6c757d;">
                                                                            ${payment.referenceType}
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <button class="btn btn-outline-primary btn-sm" title="Xem chi tiết">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-receipt text-muted"></i>
                                        <h6 class="text-muted">Chưa có giao dịch nào</h6>
                                        <p class="text-muted mb-0">Các giao dịch sẽ xuất hiện ở đây khi có khách thuê phòng</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Thông tin hữu ích -->
                    <div class="dashboard-card info-section mb-4">
                        <div class="p-4">
                            <div class="d-flex align-items-center mb-4">
                                <div class="card-icon card-icon-primary me-3" style="width: 55px; height: 55px; font-size: 1.25rem;">
                                    <i class="fas fa-info-circle"></i>
                                </div>
                                <div class="dashboard-section-subtitle mb-0">Thông tin hữu ích</div>
                            </div>
                            <div class="ps-4">
                                <div class="info-item d-flex align-items-start">
                                    <div class="info-bullet"></div>
                                    <span>Doanh thu được tính từ các giao dịch đã hoàn thành (Completed).</span>
                                </div>
                                <div class="info-item d-flex align-items-start">
                                    <div class="info-bullet"></div>
                                    <span>Biểu đồ hiển thị xu hướng doanh thu trong 12 tháng gần đây.</span>
                                </div>
                                <div class="info-item d-flex align-items-start">
                                    <div class="info-bullet"></div>
                                    <span>Tỷ lệ thành công được tính dựa trên giao dịch hoàn thành / tổng giao dịch.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <!-- Bootstrap JS -->
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
            
            // Confirm logout function
            function confirmLogout() {
                if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                    // Add your logout logic here
                    window.location.href = '${pageContext.request.contextPath}/logout';
                }
            }
            
            // Animate wallet balance counter
            function animateCounter(element, target) {
                const start = 0;
                const increment = target / 100;
                let current = start;
                
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    
                    // Format number as Vietnamese currency
                    const formatted = new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND',
                        minimumFractionDigits: 0,
                        maximumFractionDigits: 0
                    }).format(current).replace('₫', '₫');
                    
                    element.textContent = formatted;
                }, 20);
            }
            
            // Initialize counter animation
            document.addEventListener('DOMContentLoaded', function() {
                const balanceElement = document.querySelector('.wallet-balance');
                if (balanceElement) {
                    const balanceText = balanceElement.textContent;
                    const balanceValue = parseFloat(balanceText.replace(/[^\d]/g, ''));
                    if (balanceValue > 0) {
                        balanceElement.textContent = '0 ₫';
                        setTimeout(() => {
                            animateCounter(balanceElement, balanceValue);
                        }, 500);
                    }
                }
                
                // Initialize Revenue Chart
                initializeRevenueChart();
            });
            
            // Revenue Chart Function
            function initializeRevenueChart() {
                const ctx = document.getElementById('revenueChart');
                if (!ctx) return;
                
                // Get data from JSP
                const monthlyData = [
                    <c:forEach var="revenue" items="${monthlyRevenueChart}" varStatus="status">
                        ${revenue}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                const monthLabels = [
                    <c:forEach var="label" items="${monthLabels}" varStatus="status">
                        '${label}'<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                // Create gradient
                const gradient = ctx.getContext('2d').createLinearGradient(0, 0, 0, 300);
                gradient.addColorStop(0, 'rgba(230, 81, 0, 0.3)');
                gradient.addColorStop(0.5, 'rgba(255, 109, 0, 0.2)');
                gradient.addColorStop(1, 'rgba(255, 152, 0, 0.1)');
                
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: monthLabels,
                        datasets: [{
                            label: 'Doanh thu (₫)',
                            data: monthlyData,
                            borderColor: '#e65100',
                            backgroundColor: gradient,
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4,
                            pointBackgroundColor: '#ff6d00',
                            pointBorderColor: '#e65100',
                            pointBorderWidth: 2,
                            pointRadius: 6,
                            pointHoverRadius: 8,
                            pointHoverBackgroundColor: '#ff9800',
                            pointHoverBorderColor: '#e65100'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                titleColor: '#fff',
                                bodyColor: '#fff',
                                borderColor: '#e65100',
                                borderWidth: 1,
                                cornerRadius: 8,
                                displayColors: false,
                                callbacks: {
                                    label: function(context) {
                                        return 'Doanh thu: ' + new Intl.NumberFormat('vi-VN', {
                                            style: 'currency',
                                            currency: 'VND',
                                            minimumFractionDigits: 0,
                                            maximumFractionDigits: 0
                                        }).format(context.parsed.y);
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    color: '#666',
                                    font: {
                                        size: 12
                                    }
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.1)',
                                    borderDash: [5, 5]
                                },
                                ticks: {
                                    color: '#666',
                                    font: {
                                        size: 12
                                    },
                                    callback: function(value) {
                                        return new Intl.NumberFormat('vi-VN', {
                                            style: 'currency',
                                            currency: 'VND',
                                            minimumFractionDigits: 0,
                                            maximumFractionDigits: 0,
                                            notation: 'compact',
                                            compactDisplay: 'short'
                                        }).format(value);
                                    }
                                }
                            }
                        },
                        interaction: {
                            intersect: false,
                            mode: 'index'
                        },
                        animations: {
                            tension: {
                                duration: 1000,
                                easing: 'easeInOutCubic',
                                from: 1,
                                to: 0.4,
                                loop: false
                            }
                        }
                    }
                });
            }
        </script>
    </body>
</html>