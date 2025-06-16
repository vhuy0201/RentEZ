<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            
            .nav-link {
                padding: 1rem 1.25rem;
            }
            
            .nav-link i {
                width: 22px;
                margin-right: 0.875rem;
                font-size: 1.1rem;
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
            
            /* Responsive */
            @media (max-width: 768px) {
                .sidebar {
                    border-radius: 0;
                }
                
                .dashboard-header {
                    padding: 1.5rem;
                }
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
        </style>
        
    </head>
    <body class="bg-gray-50">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar với theme cam gradient -->
                <aside class="col-md-3 col-lg-2 d-none d-md-block sidebar py-4">
                    <div class="d-flex flex-column h-100">
                        <!-- User Profile Section -->
                        <div class="text-center user-info">
                            <div class="account-avatar mx-auto mb-3">T</div>
                            <div class="fw-bold fs-5 mb-2">Dũng Trần</div>
                            <div class="user-points">
                                <i class="fas fa-star me-2"></i>0 điểm
                            </div>
                        </div>
                        
                        <!-- Navigation Menu -->
                        <nav class="flex-grow-1">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/HomeServlet">
                                        <i class="fas fa-home"></i>Trang chủ
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="#">
                                        <i class="fas fa-tachometer-alt"></i>Tổng quan
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/viewProperties">
                                        <i class="fas fa-list"></i>Quản lý tin đăng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/addProperty">
                                        <i class="fas fa-plus"></i>Đăng tin mới
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">
                                        <i class="fas fa-user-friends"></i>Khách hàng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">
                                        <i class="fas fa-gem"></i>Gói hội viên
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">
                                        <i class="fas fa-wallet"></i>Quản lý tài chính
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">
                                        <i class="fas fa-cog"></i>Cài đặt tài khoản
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        
                        <!-- Logout Button -->
                        <div class="logout-section">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="#" onclick="confirmLogout()">
                                        <i class="fas fa-sign-out-alt"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </aside>
                
                <!-- Main content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <!-- Header -->
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center">
                        <div>
                            <div class="dashboard-section-subtitle mb-2">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Quản lý tài khoản</div>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted">Xin chào, <strong class="text-dark">Dũng Trần</strong></span>
                            <a href="#" class="btn btn-main">
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
                        <div class="col-md-4">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-primary">
                                        <i class="fas fa-file-alt"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-5 mb-1 text-dark">Tin đăng</div>
                                        <div class="text-muted mb-2">0 tin đang hiển thị</div>
                                        <a href="#" class="btn btn-link p-0 text-gradient fw-semibold text-decoration-none">
                                            <i class="fas fa-plus me-1"></i>Đăng tin mới
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-secondary">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-5 mb-1 text-dark">Liên hệ 30 ngày</div>
                                        <div class="text-muted mb-1">0 người</div>
                                        <div class="text-success small fw-semibold">
                                            <i class="fas fa-arrow-up me-1"></i>+0 mới hôm nay
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center">
                                    <div class="card-icon card-icon-tertiary">
                                        <i class="fas fa-wallet"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold fs-5 mb-1 text-dark">Số dư tài khoản</div>
                                        <div class="text-muted mb-2">0 đ</div>
                                        <a href="#" class="btn btn-link p-0 text-gradient fw-semibold text-decoration-none">
                                            <i class="fas fa-credit-card me-1"></i>Nạp tiền
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Thông tin dành riêng cho bạn -->
                    <div class="dashboard-card info-section mb-4">
                        <div class="p-4">
                            <div class="d-flex align-items-center mb-4">
                                <div class="card-icon card-icon-primary me-3" style="width: 55px; height: 55px; font-size: 1.25rem;">
                                    <i class="fas fa-info-circle"></i>
                                </div>
                                <div class="dashboard-section-subtitle mb-0">Thông tin dành riêng cho bạn</div>
                            </div>
                            <div class="ps-4">
                                <div class="info-item d-flex align-items-start">
                                    <div class="info-bullet"></div>
                                    <span>Bạn chưa có tin đăng nào. 
                                        <a href="#" class="text-gradient fw-semibold text-decoration-none">
                                            Tạo tin đăng đầu tiên
                                        </a>
                                    </span>
                                </div>
                                <div class="info-item d-flex align-items-start">
                                    <div class="info-bullet"></div>
                                    <span>Chưa có liên hệ mới trong 30 ngày qua.</span>
                                </div>
                                <div class="info-item d-flex align-items-start">
                                    <div class="info-bullet"></div>
                                    <span>Hãy cập nhật thông tin cá nhân để tăng uy tín.</span>
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
        </script>
    </body>
</html>