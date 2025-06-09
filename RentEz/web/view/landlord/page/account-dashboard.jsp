<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản lý tài khoản - RentEz</title>
        <!-- Sử dụng lại các file css của homepage.jsp -->
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
            .dashboard-card, .dashboard-header {
                border-radius: 1rem;
                border: none;
                box-shadow: 0 2px 12px #0001;
                background: #fff;
            }
            .dashboard-header {
                padding: 1.5rem 2rem;
                margin-bottom: 2rem;
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
            .nav-link {
                padding: 0.75rem 1rem;
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
                        <li class="nav-item w-100"><a class="nav-link active" href="#"><i class="fas fa-tachometer-alt me-2"></i>Tổng quan</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/viewProperties"><i class="fas fa-list me-2"></i>Quản lý tin đăng</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/addProperty"><i class="fas fa-plus me-2"></i>Đăng tin</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-user-friends me-2"></i>Khách hàng</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-gem me-2"></i>Gói hội viên</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-wallet me-2"></i>Quản lý tài chính</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-cog me-2"></i>Cài đặt tài khoản</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li> 
                    </ul>
                </aside>
                <!-- Main content -->
                <main class="col-md-10 ms-sm-auto px-4">
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center">
                        <div>
                            <div class="dashboard-section-subtitle">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Quản lý tài khoản</div>
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
                    <!-- Tổng quan -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="dashboard-card p-4 d-flex align-items-center gap-3">
                                <div><i class="fas fa-file-alt text-gradient" style="font-size:2rem;"></i></div>
                                <div>
                                    <div class="fw-bold">Tin đăng</div>
                                    <div>0 tin đang hiển thị</div>
                                    <a href="#" class="btn btn-link p-0 mt-2 text-gradient">Đăng tin mới</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="dashboard-card p-4 d-flex align-items-center gap-3">
                                <div><i class="fas fa-users text-gradient" style="font-size:2rem;"></i></div>
                                <div>
                                    <div class="fw-bold">Liên hệ 30 ngày</div>
                                    <div>0 người</div>
                                    <div class="text-success small">+0 mới hôm nay</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="dashboard-card p-4 d-flex align-items-center gap-3">
                                <div><i class="fas fa-wallet text-gradient" style="font-size:2rem;"></i></div>
                                <div>
                                    <div class="fw-bold">Số dư tài khoản</div>
                                    <div>0 đ</div>
                                    <a href="#" class="btn btn-link p-0 mt-2 text-gradient">Nạp tiền</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Thông tin dành riêng cho bạn -->
                    <div class="dashboard-card mb-4">
                        <div class="p-3 fw-bold dashboard-section-subtitle">Thông tin dành riêng cho bạn</div>
                        <div class="p-3">
                            <ul>
                                <li>Bạn chưa có tin đăng nào. <a href="#" class="text-gradient">Tạo tin đăng đầu tiên</a></li>
                                <li>Chưa có liên hệ mới trong 30 ngày qua.</li>
                                <li>Hãy cập nhật thông tin cá nhân để tăng uy tín.</li>
                            </ul>
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
        </script>
        <script src="${pageContext.request.contextPath}/view/landlord/asset/fontAwesome.js"></script>
    </body>
</html>