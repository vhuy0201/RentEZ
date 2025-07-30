<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa tin đăng - RentEz</title>
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

            .btn-outline {
                background: transparent;
                color: #e65100;
                border: 2px solid #ff6d00;
                border-radius: 0.75rem;
                font-weight: 600;
                padding: 0.75rem 1.5rem;
                transition: all 0.3s ease;
            }

            .btn-outline:hover {
                background: rgba(255, 109, 0, 0.1);
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(230, 81, 0, 0.2);
                color: #e65100;
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

            .error-message {
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #f44336 0%, #e57373 100%);
                color: #fff;
                padding: 1rem 1.5rem;
                border-radius: 0.75rem;
                box-shadow: 0 4px 20px rgba(244, 67, 54, 0.3);
                z-index: 1000;
                opacity: 0;
                transition: opacity 0.5s;
            }

            .error-message.show {
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

            .form-card {
                border-radius: 1.5rem;
                border: none;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
                background: #fff;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .form-card:hover {
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            }

            .form-header {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                padding: 1.5rem 2rem;
                border-bottom: 2px solid #ffe0b2;
            }

            .form-body {
                padding: 2rem;
            }

            .form-control, .form-select {
                border-radius: 0.75rem;
                padding: 0.75rem 1rem;
                border: 2px solid #f0f0f0;
                transition: all 0.3s ease;
                font-size: 0.95rem;
            }

            .form-control:focus, .form-select:focus {
                border-color: #ff6d00;
                box-shadow: 0 0 0 0.25rem rgba(255, 109, 0, 0.25);
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 0.5rem;
                font-size: 0.95rem;
            }

            .form-section {
                background: #fff;
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                border: 1px solid #f0f0f0;
                transition: all 0.3s ease;
            }

            .form-section:hover {
                border-color: #ffe0b2;
                box-shadow: 0 4px 15px rgba(255, 224, 178, 0.3);
            }

            .form-section-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #e65100;
                margin-bottom: 1.25rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .form-section-icon {
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

            .location-form {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                border-radius: 1rem;
                padding: 1.5rem;
                border: 1px solid #ffe0b2;
            }

            .form-footer {
                background: #f9f9f9;
                padding: 1.5rem 2rem;
                border-top: 1px solid #f0f0f0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            /* Image Upload Styles */
            .image-upload-container {
                margin-bottom: 1rem;
            }

            .image-upload-area {
                border: 2px dashed #e65100;
                border-radius: 12px;
                padding: 3rem 2rem;
                text-align: center;
                background: #fff9f5;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
            }

            .image-upload-area:hover,
            .image-upload-area.drag-over {
                border-color: #ff6d00;
                background: #fff3e0;
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(230, 81, 0, 0.15);
            }

            .image-upload-content {
                pointer-events: none;
            }

            .upload-icon {
                font-size: 3rem;
                color: #e65100;
                margin-bottom: 1rem;
                display: block;
            }

            .image-upload-area h5 {
                color: #e65100;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .image-preview-container {
                position: relative;
                display: inline-block;
            }

            .image-preview {
                max-width: 100%;
                max-height: 300px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .image-preview-overlay {
                position: absolute;
                top: 10px;
                right: 10px;
                display: flex;
                gap: 0.5rem;
            }

            .current-image {
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 8px;
                border: 1px solid #dee2e6;
            }

            .current-image-preview {
                margin-top: 0.5rem;
            }

            .current-property-image {
                max-width: 200px;
                max-height: 150px;
                border-radius: 8px;
                object-fit: cover;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .image-validation-error {
                font-size: 0.875rem;
                margin-top: 0.5rem;
            }

            .progress-container {
                margin: 2rem;
            }

            .progress-steps {
                display: flex;
                justify-content: space-between;
                position: relative;
                margin-bottom: 2rem;
            }

            .progress-steps::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 0;
                right: 0;
                height: 2px;
                background: #f0f0f0;
                transform: translateY(-50%);
                z-index: 1;
            }

            .progress-step {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #fff;
                border: 2px solid #f0f0f0;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                color: #999;
                position: relative;
                z-index: 2;
            }

            .progress-step.active {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 100%);
                color: #fff;
                border-color: #e65100;
                box-shadow: 0 4px 15px rgba(230, 81, 0, 0.3);
            }

            .progress-step.completed {
                background: linear-gradient(135deg, #4caf50 0%, #66bb6a 100%);
                color: #fff;
                border-color: #4caf50;
            }

            .progress-label {
                position: absolute;
                top: 100%;
                left: 50%;
                transform: translateX(-50%);
                margin-top: 0.5rem;
                font-size: 0.75rem;
                font-weight: 600;
                color: #666;
                white-space: nowrap;
            }

            .progress-step.active .progress-label {
                color: #e65100;
            }

            .progress-step.completed .progress-label {
                color: #4caf50;
            }

            @media (max-width: 768px) {
                .sidebar {
                    border-radius: 0;
                }

                .dashboard-header {
                    padding: 1.5rem;
                }

                .form-body {
                    padding: 1.5rem;
                }
            }

            .image-upload {
                border: 2px dashed #ffe0b2;
                border-radius: 1rem;
                padding: 2rem;
                text-align: center;
                background: #fff8f0;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .image-upload:hover {
                border-color: #ff9800;
                background: #fff5e6;
            }

            .image-upload-icon {
                font-size: 3rem;
                color: #ff6d00;
                margin-bottom: 1rem;
            }

            .amenities-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1rem;
            }

            .amenity-item {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .amenity-checkbox {
                width: 20px;
                height: 20px;
                accent-color: #ff6d00;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar với theme cam gradient -->
                <aside class="col-md-3 col-lg-2 d-none d-md-block sidebar py-4">
                    <div class="d-flex flex-column h-100">
                        <div class="text-center user-info">
                            <div class="account-avatar mx-auto mb-3">T</div>
                            <div class="fw-bold fs-5 mb-2">Dũng Trần</div>
                            <div class="user-points">
                                <i class="fas fa-star me-2"></i>0 điểm
                            </div>
                        </div>

                        <nav class="flex-grow-1">
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/HomeServlet">
                                        <i class="fas fa-home"></i>Trang chủ
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/landLordHomeServlet">
                                        <i class="fas fa-tachometer-alt"></i>Tổng quan
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/viewProperties">
                                        <i class="fas fa-list"></i>Quản lý tin đăng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/addProperty">
                                        <i class="fas fa-plus"></i>Đăng tin mới
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/customerManagement">
                                        <i class="fas fa-user-friends"></i>Khách hàng
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/financialManagement">
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
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center mb-4">
                        <div>
                            <div class="dashboard-section-subtitle mb-2">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Chỉnh sửa tin đăng</div>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted">Xin chào, <strong class="text-dark">Dũng Trần</strong></span>
                            <a href="#" class="btn btn-main">
                                <i class="fas fa-plus me-2"></i>Nạp tiền
                            </a>
                        </div>
                    </div>

                    <!-- Progress bar -->
                    <div class="progress-container">
                        <div class="progress-steps">
                            <div class="progress-step active">
                                1
                                <span class="progress-label">Thông tin cơ bản</span>
                            </div>
                            <div class="progress-step">
                                2
                                <span class="progress-label">Vị trí</span>
                            </div>
                            <div class="progress-step">
                                3
                                <span class="progress-label">Chi tiết</span>
                            </div>
                            <div class="progress-step">
                                4
                                <span class="progress-label">Hình ảnh</span>
                            </div>
                            <div class="progress-step">
                                5
                                <span class="progress-label">Xác nhận</span>
                            </div>
                        </div>
                    </div>

                    <!-- Success/Error messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mb-4" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success mb-4" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            ${message}
                        </div>
                    </c:if>

                    <!-- Property Form -->
                    <div class="form-card mb-4">
                        <div class="form-header">
                            <h4 class="mb-0 d-flex align-items-center">
                                <i class="fas fa-home me-3" style="color: #e65100;"></i>
                                Chỉnh sửa thông tin bất động sản
                            </h4>
                        </div>
                        <div class="form-body">
                            <form action="editProperty" method="post" enctype="multipart/form-data" id="propertyForm">
                                <input type="hidden" name="propertyId" value="${property.propertyId}">
                                <!-- Basic Information Section -->
                                <div class="form-section">
                                    <div class="form-section-title">
                                        <div class="form-section-icon">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        Thông tin cơ bản
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <label for="title" class="form-label">Tiêu đề tin đăng <span class="text-danger">*</span></label>
                                            <input type="text" id="title" name="title" class="form-control" value="${property.title}" required>
                                            <small class="text-muted">Tiêu đề ngắn gọn, đầy đủ thông tin (VD: Căn hộ 2 phòng ngủ tại Vinhomes Ocean Park)</small>
                                        </div>

                                        <div class="col-md-12 mb-3">
                                            <label for="description" class="form-label">Mô tả chi tiết <span class="text-danger">*</span></label>
                                            <textarea id="description" name="description" rows="5" class="form-control" required>${property.description}</textarea>
                                            <small class="text-muted">Mô tả đầy đủ về bất động sản, tiện ích xung quanh và các điểm nổi bật</small>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="typeId" class="form-label">Loại bất động sản <span class="text-danger">*</span></label>
                                            <select id="typeId" name="typeId" class="form-select" required>
                                                <option value="">-- Chọn loại bất động sản --</option>
                                                <option value="1" ${property.typeId == 1 ? 'selected' : ''}>Căn hộ/Chung cư</option>
                                                <option value="2" ${property.typeId == 2 ? 'selected' : ''}>Nhà riêng</option>
                                                <option value="3" ${property.typeId == 3 ? 'selected' : ''}>Biệt thự</option>
                                                <option value="4" ${property.typeId == 4 ? 'selected' : ''}>Nhà mặt phố</option>
                                                <option value="5" ${property.typeId == 5 ? 'selected' : ''}>Đất nền</option>
                                                <option value="6" ${property.typeId == 6 ? 'selected' : ''}>Văn phòng</option>
                                                <option value="7" ${property.typeId == 7 ? 'selected' : ''}>Phòng trọ</option>
                                            </select>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="availabilityStatus" class="form-label">Trạng thái <span class="text-danger">*</span></label>
                                            <select id="availabilityStatus" name="availabilityStatus" class="form-select" required>
                                                <option value="Available" ${property.availabilityStatus == 'Available' ? 'selected' : ''}>Còn trống</option>
                                                <option value="Rented" ${property.availabilityStatus == 'Rented' ? 'selected' : ''}>Đã cho thuê</option>
                                                <option value="Not Available" ${property.availabilityStatus == 'Not Available' ? 'selected' : ''}>Không khả dụng</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Location Section -->
                                <div class="form-section">
                                    <div class="form-section-title">
                                        <div class="form-section-icon">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </div>
                                        Vị trí bất động sản
                                    </div>

                                    <div class="location-form">
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label for="address" class="form-label">Địa chỉ chi tiết <span class="text-danger">*</span></label>
                                                <input type="text" id="address" name="address" class="form-control" value="${location.address}" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="city" class="form-label">Thành phố/Tỉnh <span class="text-danger">*</span></label>
                                                <input type="text" id="city" name="city" class="form-control" value="${location.city}" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="stateProvince" class="form-label">Quận/Huyện <span class="text-danger">*</span></label>
                                                <input type="text" id="stateProvince" name="stateProvince" class="form-control" value="${location.stateProvince}" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="country" class="form-label">Quốc gia <span class="text-danger">*</span></label>
                                                <input type="text" id="country" name="country" class="form-control" value="${location.country}" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="ZipCode" class="form-label">Mã bưu chính</label>
                                                <input type="text" id="ZipCode" name="ZipCode" class="form-control" value="${location.zipCode != 0 ? location.zipCode : ''}">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Details Section -->
                                <div class="form-section">
                                    <div class="form-section-title">
                                        <div class="form-section-icon">
                                            <i class="fas fa-list-ul"></i>
                                        </div>
                                        Chi tiết bất động sản
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="price" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="number" id="price" name="price" step="1000" class="form-control" value="${property.price}" required>
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                            <small class="text-muted">Nhập giá cho thuê/bán (VD: 5000000)</small>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="size" class="form-label">Diện tích (m²) <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="number" id="size" name="size" step="0.01" class="form-control" value="${property.size}" required>
                                                <span class="input-group-text">m²</span>
                                            </div>
                                        </div>

                                        <div class="col-md-3 mb-3">
                                            <label for="numberOfBedrooms" class="form-label">Số phòng ngủ <span class="text-danger">*</span></label>
                                            <input type="number" id="numberOfBedrooms" name="numberOfBedrooms" min="0" class="form-control" value="${property.numberOfBedrooms}" required>
                                        </div>

                                        <div class="col-md-3 mb-3">
                                            <label for="numberOfBathrooms" class="form-label">Số phòng tắm <span class="text-danger">*</span></label>
                                            <input type="number" id="numberOfBathrooms" name="numberOfBathrooms" min="0" class="form-control" value="${property.numberOfBathrooms}" required>
                                        </div>

                                    </div>


                                    <div class="mb-3">
                                        <label for="priorityLevel" class="form-label">Mức độ ưu tiên</label>
                                        <select id="priorityLevel" name="priorityLevel" class="form-select">
                                            <option value="1" ${property.priorityLevel == 1 ? 'selected' : ''}>Thường</option>
                                            <option value="2" ${property.priorityLevel == 2 ? 'selected' : ''}>Ưu tiên</option>
                                            <option value="3" ${property.priorityLevel == 3 ? 'selected' : ''}>Cao cấp</option>
                                        </select>
                                        <small class="text-muted">Tin đăng có mức độ ưu tiên cao sẽ được hiển thị nổi bật hơn</small>
                                    </div>
                                </div>

                                <!-- Images Section -->
                                <div class="form-section">
                                    <div class="form-section-title">
                                        <div class="form-section-icon">
                                            <i class="fas fa-images"></i>
                                        </div>
                                        Hình ảnh bất động sản
                                    </div>

                                    <div class="mb-4">
                                        <label for="propertyImage" class="form-label">Hình ảnh chính</label>
                                        <div class="image-upload-container">
                                            <div class="image-upload-area" id="imageUploadArea">
                                                <div class="image-upload-content">
                                                    <i class="fas fa-cloud-upload-alt upload-icon"></i>
                                                    <h5>Tải lên hình ảnh chính</h5>
                                                    <p class="text-muted">Kéo thả hoặc nhấp để chọn ảnh (JPG, PNG, tối đa 5MB)</p>
                                                    <input type="file" id="propertyImage" name="propertyImage" accept="image/*" class="form-control d-none">
                                                </div>
                                            </div>
                                            <div class="image-preview-container d-none" id="imagePreviewContainer">
                                                <img id="imagePreview" src="" alt="Preview" class="image-preview">
                                                <div class="image-preview-overlay">
                                                    <button type="button" class="btn btn-sm btn-danger" id="removeImage">
                                                        <i class="fas fa-trash"></i> Xóa
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-secondary" id="changeImage">
                                                        <i class="fas fa-edit"></i> Thay đổi
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${not empty property.avatar}">
                                            <div class="current-image mt-3">
                                                <label class="form-label">Hình ảnh hiện tại:</label>
                                                <div class="current-image-preview">
                                                    <img src="${property.avatar}" alt="Current Property Image" class="current-property-image">
                                                </div>
                                                <small class="text-muted">Chọn ảnh mới để thay thế ảnh hiện tại</small>
                                            </div>
                                        </c:if>
                                        <div class="image-validation-error text-danger d-none" id="imageError"></div>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-main">
                                    <i class="fas fa-check me-2"></i>Cập nhật tin
                                </button>
                                <a href="${pageContext.request.contextPath}/viewProperties" class="btn btn-outline">Hủy</a>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>



        <jsp:include page="/view/common/footer.jsp" />
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        <script>
            function confirmLogout() {
                if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                    window.location.href = '${pageContext.request.contextPath}/logout';
                }
            }

            // Image upload functionality
            document.addEventListener('DOMContentLoaded', function() {
                const imageInput = document.getElementById('propertyImage');
                const imageUploadArea = document.getElementById('imageUploadArea');
                const imagePreviewContainer = document.getElementById('imagePreviewContainer');
                const imagePreview = document.getElementById('imagePreview');
                const removeImageBtn = document.getElementById('removeImage');
                const changeImageBtn = document.getElementById('changeImage');
                const imageError = document.getElementById('imageError');
                const priceInput = document.getElementById('price');
                const monthlyRentInput = document.getElementById('monthlyRent');
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                const totalPriceInput = document.getElementById('totalPrice');

                // Initialize monthly rent from property price
                if (priceInput && monthlyRentInput) {
                    monthlyRentInput.value = priceInput.value;
                    
                    priceInput.addEventListener('input', function() {
                        monthlyRentInput.value = this.value;
                        calculateTotalPrice();
                    });
                }

                // Image upload area click handler
                imageUploadArea.addEventListener('click', function() {
                    imageInput.click();
                });

                // Drag and drop handlers
                imageUploadArea.addEventListener('dragover', function(e) {
                    e.preventDefault();
                    this.classList.add('drag-over');
                });

                imageUploadArea.addEventListener('dragleave', function(e) {
                    e.preventDefault();
                    this.classList.remove('drag-over');
                });

                imageUploadArea.addEventListener('drop', function(e) {
                    e.preventDefault();
                    this.classList.remove('drag-over');
                    
                    const files = e.dataTransfer.files;
                    if (files.length > 0) {
                        handleImageUpload(files[0]);
                    }
                });

                // File input change handler
                imageInput.addEventListener('change', function(e) {
                    if (e.target.files.length > 0) {
                        handleImageUpload(e.target.files[0]);
                    }
                });

                // Remove image handler
                removeImageBtn.addEventListener('click', function() {
                    resetImageUpload();
                });

                // Change image handler
                changeImageBtn.addEventListener('click', function() {
                    imageInput.click();
                });

                function handleImageUpload(file) {
                    // Validate file type
                    if (!file.type.startsWith('image/')) {
                        showImageError('Vui lòng chọn file hình ảnh (JPG, PNG, GIF)');
                        return;
                    }

                    // Validate file size (5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        showImageError('Kích thước file không được vượt quá 5MB');
                        return;
                    }

                    // Show preview
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        imagePreview.src = e.target.result;
                        imageUploadArea.classList.add('d-none');
                        imagePreviewContainer.classList.remove('d-none');
                        hideImageError();
                    };
                    reader.readAsDataURL(file);
                }

                function resetImageUpload() {
                    imageInput.value = '';
                    imagePreview.src = '';
                    imagePreviewContainer.classList.add('d-none');
                    imageUploadArea.classList.remove('d-none');
                    hideImageError();
                }

                function showImageError(message) {
                    imageError.textContent = message;
                    imageError.classList.remove('d-none');
                }

                function hideImageError() {
                    imageError.classList.add('d-none');
                }

                // Date range and price calculation
                function calculateTotalPrice() {
                    const startDate = startDateInput.value;
                    const endDate = endDateInput.value;
                    const monthlyRent = parseFloat(monthlyRentInput.value) || 0;

                    if (startDate && endDate && monthlyRent > 0) {
                        const start = new Date(startDate);
                        const end = new Date(endDate);
                        
                        if (end > start) {
                            // Calculate number of months
                            const months = (end.getFullYear() - start.getFullYear()) * 12 + (end.getMonth() - start.getMonth());
                            const totalPrice = months * monthlyRent;
                            totalPriceInput.value = totalPrice;
                        } else {
                            totalPriceInput.value = 0;
                        }
                    } else {
                        totalPriceInput.value = 0;
                    }
                }

                // Event listeners for date inputs
                if (startDateInput && endDateInput) {
                    startDateInput.addEventListener('change', calculateTotalPrice);
                    endDateInput.addEventListener('change', calculateTotalPrice);
                }

                // Form submission
                document.getElementById('submitBooking')?.addEventListener('click', function() {
                    const form = document.getElementById('bookingForm');
                    if (form.checkValidity()) {
                        // Here you would normally submit the booking data to server
                        alert('Yêu cầu xem bất động sản đã được gửi thành công!');
                        $('#bookingModal').modal('hide');
                        form.reset();
                        totalPriceInput.value = 0;
                    } else {
                        form.reportValidity();
                    }
                });
            });
        </script>
    </body>
</html>