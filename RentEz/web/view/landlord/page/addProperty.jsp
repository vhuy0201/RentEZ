<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng tin mới - RentEz</title>
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

            .form-note {
                background: rgba(255, 152, 0, 0.1);
                border-left: 4px solid #ff9800;
                padding: 1rem;
                border-radius: 0.5rem;
                margin-bottom: 1.5rem;
            }

            .form-note-title {
                font-weight: 700;
                color: #e65100;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .error {
                color: #f44336;
                font-size: 0.875rem;
                margin-top: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .success {
                color: #4caf50;
                font-size: 0.875rem;
                margin-top: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
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

            /* Modal styles for booking form */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 2000;
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background: #fff;
                border-radius: 1rem;
                padding: 2rem;
                width: 90%;
                max-width: 1000px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
                position: relative;
            }

            .modal-header {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                padding: 1rem 1.5rem;
                border-bottom: 2px solid #ffe0b2;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #e65100;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .modal-close:hover {
                color: #bf360c;
            }

            .modal-body {
                padding: 1.5rem;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Navigation -->
                <jsp:include page="../common/navigation.jsp" />

                <!-- Main content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <!-- Header -->
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center mb-4">
                        <div>
                            <div class="dashboard-section-subtitle mb-2">Kênh thông tin bất động sản</div>
                            <div class="dashboard-section-title">Đăng tin mới</div>
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

                    <!-- Form note -->
                    <div class="form-note mb-4">
                        <div class="form-note-title">
                            <i class="fas fa-lightbulb"></i>
                            Mẹo đăng tin hiệu quả
                        </div>
                        <p class="mb-0">Hãy cung cấp thông tin chi tiết và chính xác về bất động sản của bạn. Tin đăng có hình ảnh chất lượng cao và mô tả đầy đủ sẽ nhận được nhiều lượt xem hơn.</p>
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
                                Thông tin bất động sản
                            </h4>
                        </div>
                        <div class="form-body">
                            <form action="addProperty" method="post" enctype="multipart/form-data" id="propertyForm">
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
                                            <input type="text" id="title" name="title" class="form-control" placeholder="Nhập tiêu đề tin đăng" required>
                                            <small class="text-muted">Tiêu đề ngắn gọn, đầy đủ thông tin (VD: Căn hộ 2 phòng ngủ tại Vinhomes Ocean Park)</small>
                                        </div>

                                        <div class="col-md-12 mb-3">
                                            <label for="description" class="form-label">Mô tả chi tiết <span class="text-danger">*</span></label>
                                            <textarea id="description" name="description" rows="5" class="form-control" placeholder="Mô tả chi tiết về bất động sản của bạn" required></textarea>
                                            <small class="text-muted">Mô tả đầy đủ về bất động sản, tiện ích xung quanh và các điểm nổi bật</small>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="typeId" class="form-label">Loại bất động sản <span class="text-danger">*</span></label>
                                            <select id="typeId" name="typeId" class="form-select" required>
                                                <option value="">-- Chọn loại bất động sản --</option>
                                                <c:forEach var="propertyType" items="${propertyTypes}">
                                                    <option value="${propertyType.typeId}">${propertyType.typeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="availabilityStatus" class="form-label">Trạng thái <span class="text-danger">*</span></label>
                                            <select id="availabilityStatus" name="availabilityStatus" class="form-select" required>
                                                <option value="Available">Còn trống</option>
                                                <option value="Rented">Đã cho thuê</option>
                                                <option value="Pending">Đang xử lý</option>
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
                                                <input type="text" id="address" name="address" class="form-control" placeholder="Số nhà, tên đường" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="city" class="form-label">Thành phố/Tỉnh <span class="text-danger">*</span></label>
                                                <input type="text" id="city" name="city" class="form-control" placeholder="Thành phố/Tỉnh" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="stateProvince" class="form-label">Quận/Huyện <span class="text-danger">*</span></label>
                                                <input type="text" id="stateProvince" name="stateProvince" class="form-control" placeholder="Quận/Huyện" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="country" class="form-label">Quốc gia <span class="text-danger">*</span></label>
                                                <input type="text" id="country" name="country" class="form-control" value="Việt Nam" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label for="ZipCode" class="form-label">Mã bưu chính</label>
                                                <input type="text" id="ZipCode" name="ZipCode" class="form-control" placeholder="Mã bưu chính (nếu có)">
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
                                                <input type="number" id="price" name="price" step="1000" class="form-control" placeholder="Nhập giá" required>
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                            <small class="text-muted">Nhập giá cho thuê (VD: 5000000)</small>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="size" class="form-label">Diện tích (m²) <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="number" id="size" name="size" step="0.01" class="form-control" placeholder="Nhập diện tích" required>
                                                <span class="input-group-text">m²</span>
                                            </div>
                                        </div>

                                        <div class="col-md-3 mb-3">
                                            <label for="numberOfBedrooms" class="form-label">Số phòng ngủ <span class="text-danger">*</span></label>
                                            <input type="number" id="numberOfBedrooms" name="numberOfBedrooms" min="0" class="form-control" required>
                                        </div>

                                        <div class="col-md-3 mb-3">
                                            <label for="numberOfBathrooms" class="form-label">Số phòng tắm <span class="text-danger">*</span></label>
                                            <input type="number" id="numberOfBathrooms" name="numberOfBathrooms" min="0" class="form-control" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="priorityLevel" class="form-label">Mức độ ưu tiên</label>
                                        <select id="priorityLevel" name="priorityLevel" class="form-select">
                                            <option value="1">Thường</option>
                                            <option value="2">Ưu tiên</option>
                                            <option value="3">Cao cấp</option>
                                        </select>
                                        <small class="text-muted">Tin đăng có mức độ ưu tiên cao sẽ được hiển thị nổi bật hơn</small>
                                    </div>
                                </div>

                                <!-- Image Upload Section -->
                                <div class="form-section">
                                    <div class="form-section-title">
                                        <div class="form-section-icon">
                                            <i class="fas fa-images"></i>
                                        </div>
                                        Hình ảnh bất động sản
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <label for="avatarImage" class="form-label">Ảnh đại diện <span class="text-danger">*</span></label>
                                            <small class="text-muted d-block mb-2">Ảnh này sẽ hiển thị làm thumbnail cho bất động sản</small>
                                            <div class="image-upload" onclick="document.getElementById('avatarImage').click()">
                                                <div class="image-upload-icon">
                                                    <i class="fas fa-cloud-upload-alt"></i>
                                                </div>
                                                <h5>Kéo thả hoặc nhấp để chọn ảnh</h5>
                                                <p class="text-muted mb-0">Hỗ trợ: JPG, PNG (tối đa 5MB)</p>
                                                <input type="file" id="avatarImage" name="avatarImage" accept="image/*" style="display: none;" required onchange="previewImage(this)">
                                            </div>
                                            <div id="imagePreview" class="mt-3" style="display: none;">
                                                <img id="previewImg" src="" alt="Preview" style="max-width: 200px; max-height: 200px; border-radius: 8px; border: 2px solid #e65100;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- System Fee Warning -->
                                <div class="alert alert-warning mt-4" style="border-left: 4px solid #ff9800; background: linear-gradient(135deg, #fff8e1 0%, #fff3c4 100%);">
                                    <div class="d-flex align-items-center">
                                        <div class="me-3">
                                            <i class="fas fa-exclamation-triangle" style="color: #ff9800; font-size: 1.5em;"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-2" style="color: #e65100; font-weight: 600;">
                                                <i class="fas fa-info-circle me-2"></i>Thông báo về phí hệ thống
                                            </h6>
                                            <p class="mb-2 text-dark">
                                                <strong>Hệ thống sẽ tự động thu phí dịch vụ 10% trên tổng giá trị giao dịch</strong> 
                                                khi có người thuê đặt cọc bất động sản của bạn.
                                            </p>
                                            <div class="small text-muted">
                                                <i class="fas fa-calculator me-1"></i>
                                                Ví dụ: Nếu tổng giá là 10,000,000 ₫, phí hệ thống sẽ là 1,000,000 ₫
                                            </div>
                                            <div class="small text-muted mt-1">
                                                <i class="fas fa-shield-alt me-1"></i>
                                                Phí này được sử dụng để duy trì và phát triển nền tảng, bảo đảm giao dịch an toàn
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Form Footer -->
                                <div class="form-footer">
                                    <button type="button" class="btn btn-outline" onclick="openBookingModal()">
                                        <i class="fas fa-calendar-plus me-2"></i>Tạo chính sách thuê nhà
                                    </button>
                                    <button type="submit" class="btn btn-main">
                                        <i class="fas fa-check me-2"></i>Đăng tin
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Booking Modal -->
                    <div class="modal" id="bookingModal">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="mb-0 d-flex align-items-center">
                                    <i class="fas fa-calendar-plus me-3" style="color: #e65100;"></i>
                                    Chính sách thuê nhà
                                </h4>
                                <button class="modal-close" onclick="closeBookingModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-section">
                                    <div class="form-section-title">
                                        <div class="form-section-icon">
                                            <i class="fas fa-calendar-alt"></i>
                                        </div>
                                        Thông tin chính sách
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="monthlyRent" class="form-label">Tiền thuê hàng tháng (VNĐ) <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="number" id="monthlyRent" name="monthlyRent" step="1000" class="form-control" placeholder="Nhập tiền thuê" required readonly>
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="depositAmount" class="form-label">Số tiền đặt cọc (VNĐ) <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="number" id="depositAmount" name="depositAmount" step="1000" class="form-control" placeholder="Nhập số tiền cọc" required onchange="calculateTotalPrice()">
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label for="totalPrice" class="form-label">Tổng giá (VNĐ) <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="number" id="totalPrice" name="totalPrice" step="1000" class="form-control" placeholder="Tự động tính toán" readonly>
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                            <small class="text-muted">Tự động tính toán: Tiền đặt cọc + Tiền thuê hàng tháng</small>
                                            <div id="systemFeeDisplay"></div>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label for="penaltyClause" class="form-label">Điều khoản phạt</label>
                                            <textarea id="penaltyClause" name="penaltyClause" rows="3" class="form-control" placeholder="Mô tả điều khoản phạt (nếu có)"></textarea>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label for="termsAndConditions" class="form-label">Điều khoản và điều kiện</label>
                                            <textarea id="termsAndConditions" name="termsAndConditions" rows="3" class="form-control" placeholder="Mô tả điều khoản và điều kiện (nếu có)"></textarea>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end mt-3">
                                        <button type="button" class="btn btn-outline me-2" onclick="closeBookingModal()">
                                            <i class="fas fa-times me-2"></i>Hủy
                                        </button>
                                        <button type="button" class="btn btn-main" onclick="submitWithBooking()">
                                            <i class="fas fa-check me-2"></i>Xác nhận
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <jsp:include page="/view/common/footer.jsp" />
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        <script>
            // Modal control functions
            function openBookingModal() {
                // Auto-fill monthly rent from property price
                const propertyPrice = document.getElementById('price').value;
                if (propertyPrice) {
                    document.getElementById('monthlyRent').value = propertyPrice;
                }
                document.getElementById('bookingModal').style.display = 'flex';
            }

            function closeBookingModal() {
                document.getElementById('bookingModal').style.display = 'none';
            }

            // Image preview function
            function previewImage(input) {
                const file = input.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('previewImg').src = e.target.result;
                        document.getElementById('imagePreview').style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                }
            }

            // Calculate total price based on deposit amount and monthly rent
            function calculateTotalPrice() {
                const depositAmount = document.getElementById('depositAmount').value;
                const monthlyRent = document.getElementById('monthlyRent').value;

                if (depositAmount && monthlyRent) {
                    const totalPrice = parseInt(depositAmount) + parseInt(monthlyRent);
                    document.getElementById('totalPrice').value = totalPrice;
                    
                    // Hiển thị phí hệ thống
                    updateSystemFeeDisplay(totalPrice);
                }
            }
            
            // Update system fee display
            function updateSystemFeeDisplay(totalPrice) {
                const systemFee = totalPrice * 0.10;
                const systemFeeElement = document.getElementById('systemFeeDisplay');
                if (systemFeeElement) {
                    const formattedFee = new Intl.NumberFormat('vi-VN').format(systemFee);
                    systemFeeElement.innerHTML = 
                        '<div class="alert alert-info mt-2" style="background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%); border-left: 4px solid #2196f3;">' +
                            '<small>' +
                                '<i class="fas fa-calculator me-1"></i>' +
                                '<strong>Phí hệ thống (10%):</strong> ' +
                                '<span class="text-primary fw-bold">' + formattedFee + ' ₫</span>' +
                            '</small>' +
                        '</div>';
                }
            }

            // Auto-update monthly rent when property price changes
            document.getElementById('price').addEventListener('input', function() {
                const monthlyRentField = document.getElementById('monthlyRent');
                if (monthlyRentField) {
                    monthlyRentField.value = this.value;
                }
            });

            // Submit property form with booking data
            function submitWithBooking() {
                // Validate required fields
                const totalPrice = document.getElementById('totalPrice').value;
                const depositAmount = document.getElementById('depositAmount').value;
                
                if (!totalPrice || !depositAmount) {
                    alert('Vui lòng điền đầy đủ thông tin chính sách thuê nhà!');
                    return;
                }

                const propertyForm = document.getElementById('propertyForm');
                const bookingFields = ['totalPrice', 'depositAmount', 'monthlyRent', 'penaltyClause', 'termsAndConditions'];
                
                bookingFields.forEach(field => {
                    const input = document.getElementById(field);
                    const hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = field;
                    hiddenInput.value = input.value;
                    propertyForm.appendChild(hiddenInput);
                });
                
                propertyForm.submit();
            }

            // Confirm logout function
            function confirmLogout() {
                if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                    window.location.href = '${pageContext.request.contextPath}/logout';
                }
            }

            // Validate form before submission
            document.getElementById('propertyForm').addEventListener('submit', function(e) {
                const avatarInput = document.getElementById('avatarImage');
                if (!avatarInput.files.length) {
                    e.preventDefault();
                    alert('Vui lòng chọn ảnh đại diện cho bất động sản!');
                    return false;
                }

                // Validate file size (5MB max)
                const file = avatarInput.files[0];
                if (file.size > 5 * 1024 * 1024) {
                    e.preventDefault();
                    alert('Kích thước ảnh đại diện không được vượt quá 5MB!');
                    return false;
                }

                // Validate file type
                const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
                if (!allowedTypes.includes(file.type)) {
                    e.preventDefault();
                    alert('Ảnh đại diện chỉ chấp nhận file JPG, PNG!');
                    return false;
                }
            });
        </script>
    </body>
</html>