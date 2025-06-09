<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý tin đăng - RentEz</title>
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
        <style>
            body {
                background: #f5f7fa;
                font-family: 'Inter', Arial, sans-serif;
            }
            .sidebar {
                background: linear-gradient(135deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                min-height: 100vh;
                border-radius: 0 2rem 2rem 0;
                box-shadow: 0 0 2rem #0001;
            }
            .sidebar a {
                color: #fff;
                font-weight: 500;
                border-radius: 0.5rem;
                margin-bottom: 0.25rem;
                transition: background 0.2s;
            }
            .sidebar .active, .sidebar a:hover {
                background: rgba(255,255,255,0.12);
                color: #fff;
            }
            .account-avatar {
                width: 64px;
                height: 64px;
                background: linear-gradient(135deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                font-weight: bold;
                box-shadow: 0 2px 8px #0002;
            }
            .dashboard-header {
                border-radius: 1rem;
                border: none;
                box-shadow: 0 2px 12px #0001;
                background: #fff;
                padding: 1.5rem 2rem;
                margin-bottom: 2rem;
            }
            .dashboard-card {
                border-radius: 1rem;
                border: none;
                box-shadow: 0 2px 12px #0001;
                background: #fff;
            }
            .dashboard-section-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #1a1f2a;
            }
            .dashboard-section-subtitle {
                font-size: 1rem;
                color: #8556f0;
                font-weight: 600;
                margin-bottom: 1.5rem;
            }
            .text-gradient {
                background: linear-gradient(90deg, #8556f0 0%, #439beb 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .btn-main {
                background: linear-gradient(90deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                transition: background 0.2s;
            }
            .btn-main:hover {
                background: linear-gradient(90deg, #439beb 0%, #8556f0 100%);
                color: #fff;
            }
            .btn-detail, .btn-edit, .btn-delete {
                border-radius: 0.5rem;
                padding: 0.5rem 1rem;
                font-weight: 600;
                margin-right: 0.25rem;
                border: none;
            }
            .btn-detail {
                background: #17a2b8;
                color: #fff;
            }
            .btn-detail:hover {
                background: #138496;
                color: #fff;
            }
            .btn-edit {
                background: #ffc107;
                color: #fff;
            }
            .btn-edit:hover {
                background: #e0a800;
                color: #fff;
            }
            .btn-delete {
                background: #dc3545;
                color: #fff;
            }
            .btn-delete:hover {
                background: #c82333;
                color: #fff;
            }
            .nav-link {
                padding: 0.75rem 1rem;
            }
            .table-responsive {
                border-radius: 1rem;
                overflow-x: auto;
                overflow-y: visible;
                background: #fff;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
                margin: 2rem 1.5rem;
                position: relative;
            }
            .table {
                background: #fff;
                border-radius: 1rem;
                margin-bottom: 0;
            }
            .table th, .table td {
                padding: 1.1rem 1.25rem;
                text-align: center;
                vertical-align: middle;
                border: none;
                background: #fff;
                font-size: 1rem;
            }
            .table th {
                background: linear-gradient(90deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                font-weight: 700;
                letter-spacing: 0.5px;
                font-size: 1.05rem;
                padding: 1.5rem 2rem;
                text-align: center;
            }
            .table-striped > tbody > tr:nth-of-type(odd) > * {
                background: #f7f8fa;
            }
            .property-title {
                font-weight: 600;
                color: #1a1f2a;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding-left: 1.5rem;
            }
            .table td:first-child {
                padding-left: 2rem !important;
            }
            .table th:first-child {
                padding-left: 2rem !important;
            }
            .table th:last-child, .table td:last-child {
                padding-right: 2rem !important;
            }
            .property-type {
                font-size: 1rem;
                font-weight: 500;
                color: #1a1f2a;
            }
            .property-price {
                font-weight: 700;
                color: #1a1f2a;
            }
            .property-size {
                color: #1a1f2a !important;
                font-weight: 600;
            }
            .property-status {
                font-size: 0.95rem;
                font-weight: 600;
                padding: 0.35rem 1.1rem;
                border-radius: 1rem;
                display: inline-block;
            }
            .status-available {
                background: #e6f9ed;
                color: #28a745;
            }
            .status-rented {
                background: #fff3cd;
                color: #ffc107;
            }
            .status-not-available {
                background: #f8d7da;
                color: #dc3545;
            }
            .table td .btn-detail,
            .table td .btn-edit,
            .table td .btn-delete {
                margin: 0 0.15rem;
                padding: 0.45rem 0.85rem;
                font-size: 1rem;
            }
            .table td {
                min-width: 120px;
            }
            .success-message {
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(90deg, #28a745 0%, #34c759 100%);
                color: #fff;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                z-index: 1000;
                opacity: 0;
                transition: opacity 0.5s;
            }
            .success-message.show {
                opacity: 1;
            }
            @media (max-width: 991.98px) {
                .table th, .table td {
                    padding: 0.7rem 0.5rem;
                    font-size: 0.95rem;
                }
                .table-responsive {
                    margin: 1rem 0.5rem;
                }
                .property-title {
                    gap: 0.5rem;
                    padding-left: 0.75rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <aside class="col-md-2 d-none d-md-block sidebar py-4">
                    <div class="text-center mb-4">
                        <div class="account-avatar mx-auto mb-2">T</div>
                        <div><strong>Dũng Trần</strong></div>
                        <div class="small">0 điểm</div>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/HomeServlet"><i class="fas fa-home me-2"></i>Trang chủ</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/landLordHomeServlet"><i class="fas fa-tachometer-alt me-2"></i>Tổng quan</a></li>
                        <li class="nav-item w-100"><a class="nav-link active" href="${pageContext.request.contextPath}/viewProperties"><i class="fas fa-list me-2"></i>Quản lý tin đăng</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/addProperty"><i class="fas fa-plus me-2"></i>Đăng tin</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-user-friends me-2"></i>Khách hàng</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-gem me-2"></i>Gói hội viên</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-wallet me-2"></i>Quản lý tài chính</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-cog me-2"></i>Cài đặt tài khoản</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                    </ul>
                </aside>
                <!-- Main content -->
                <main class="col-md-10 ms-sm-auto px-md-4">
                    <!-- Header -->
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center">
                        <div>
                            <div class="dashboard-section-subtitle">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Quản lý tin đăng</div>
                        </div>
                        <div>
                            <span class="me-3">Xin chào, <strong>Dũng Trần</strong></span>
                            <a href="#" class="btn btn-main btn-sm">Nạp tiền</a>
                        </div>
                    </div>

                    <!-- Success message -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="success-message" id="successMessage">
                            ${sessionScope.successMessage}
                        </div>
                    </c:if>

                    <!-- Properties Table -->
                    <div class="dashboard-card shadow-sm mb-4">
                        <div class="p-3 fw-bold dashboard-section-subtitle d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-list me-2"></i>Danh sách tin đăng</span>
                            <a href="${pageContext.request.contextPath}/addProperty" class="btn btn-main btn-sm"><i class="fas fa-plus me-1"></i>Đăng tin mới</a>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="error">${error}</div>
                            </c:if>
                            <c:choose>
                                <c:when test="${empty properties}">
                                    <div class="text-center text-muted py-5">
                                        <i class="fas fa-folder-open fa-3x mb-3 text-gradient"></i>
                                        <div class="mb-2">Bạn chưa có tin đăng nào.</div>
                                        <a href="${pageContext.request.contextPath}/addProperty" class="btn btn-main"><i class="fas fa-plus me-1"></i>Đăng tin mới</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table align-middle mb-0">
                                            <thead>
                                                <tr>
                                                    <th>Tiêu đề</th>
                                                    <th>Loại hình</th>
                                                    <th>Giá (VNĐ)</th>
                                                    <th>Diện tích (m²)</th>
                                                    <th>Trạng thái</th>
                                                    <th class="text-center">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="property" items="${properties}">
                                                    <tr>
                                                        <td class="property-title">
                                                            <i class="fas fa-home text-gradient"></i>
                                                            ${property.title}
                                                        </td>
                                                        <td class="property-type">${typeNames[property.typeId]}</td>
                                                        <td class="property-price">
                                                            <fmt:formatNumber value="${property.price}" type="number" groupingUsed="true"/> VNĐ
                                                        </td>
                                                        <td class="property-size">
                                                            <fmt:formatNumber value="${property.size}" type="number" maxFractionDigits="0"/>m²
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${property.availabilityStatus eq 'Available'}">
                                                                    <span class="property-status status-available"><i class="fas fa-check-circle me-1"></i>Còn trống</span>
                                                                </c:when>
                                                                <c:when test="${property.availabilityStatus eq 'Rented'}">
                                                                    <span class="property-status status-rented"><i class="fas fa-user-check me-1"></i>Đã thuê</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="property-status status-not-available"><i class="fas fa-times-circle me-1"></i>Không khả dụng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-center">
                                                            <a href="${pageContext.request.contextPath}/viewPropertyDetail?propertyId=${property.propertyId}" class="btn btn-detail btn-sm" title="Xem chi tiết"><i class="fas fa-eye"></i></a>
                                                            <a href="${pageContext.request.contextPath}/editProperty?propertyId=${property.propertyId}" class="btn btn-edit btn-sm" title="Chỉnh sửa"><i class="fas fa-edit"></i></a>
                                                            <a href="${pageContext.request.contextPath}/deleteProperty?propertyId=${property.propertyId}" class="btn btn-delete btn-sm" title="Xóa"><i class="fas fa-trash-alt"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <jsp:include page="/view/common/footer.jsp" />
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/view/landlord/asset/js/fontAwesome.js"></script>
        <script src="${pageContext.request.contextPath}/view/landlord/asset/js/successMessage.js"></script>
        
    </body>
</html>