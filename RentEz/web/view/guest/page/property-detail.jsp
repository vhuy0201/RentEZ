<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Chi tiết bất động sản</title>

        <link
            rel="shortcut icon"
            href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"
            />

        <!-- Bootstrap -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"
            />
        <!-- Font awesome -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"
            />
        <!-- line awesome -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"
            />
        <!-- Bootstrap Icons -->
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
            />
        <link
            rel="stylesheet"
            crossorigin=""
            href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"
            />

        <!-- Vietnamese Fonts -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-enhancement.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/responsive-vietnamese.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-effects.css"
            />

        <style>
            .property-gallery {
                margin-bottom: 30px;
            }
            .property-gallery .main-image {
                width: 100%;
                height: 450px; /* Slightly taller */
                object-fit: cover;
                border-radius: 12px; /* More rounded */
                margin-bottom: 15px; /* Increased space */
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1); /* Enhanced shadow */
                transition: transform 0.3s ease-out;
            }
            .property-gallery .main-image:hover {
                transform: scale(1.03); /* Slightly more pronounced zoom */
            }

            .property-gallery .thumbnail {
                width: 100px;
                height: 75px;
                object-fit: cover;
                border-radius: 6px; /* More rounded */
                margin-right: 10px;
                cursor: pointer;
                opacity: 0.6; /* Slightly more dimmed when not active */
                border: 2px solid transparent;
                transition: opacity 0.3s ease, border-color 0.3s ease, transform 0.2s ease;
            }
            .property-gallery .thumbnail:hover {
                opacity: 1;
                border-color: #007bff; /* Primary color for hover */
                transform: scale(1.05); /* Slight scale on hover */
            }
            .property-gallery .thumbnail.active {
                opacity: 1;
                border-color: #0056b3; /* Darker primary for active */
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
            }

            .property-details h2 { /* Property Title */
                margin-bottom: 20px;
                color: #2c3e50; /* Dark blue-gray */
                font-size: 2.5rem; /* Larger title */
                font-weight: 700; /* Bolder */
                line-height: 1.3;
            }
            .property-details .price {
                font-size: 2rem; /* Larger price */
                font-weight: bold;
                color: #28a745; /* Green price */
                margin-bottom: 25px; /* More space below price */
                padding: 12px 20px;
                background-color: #e9f5ee; /* Light green background */
                border-radius: 8px;
                display: inline-block;
                box-shadow: 0 2px 5px rgba(40, 167, 69, 0.2);
            }
            .property-details .price i { /* If an icon is used with price */
                margin-right: 8px;
            }

            .property-details > p { /* General paragraph styling in details section, like location. Use > to be more specific */
                font-size: 1.1rem;
                color: #555;
                margin-bottom: 15px;
                line-height: 1.6;
            }
            .property-details > p i { /* Icons in paragraphs */
                margin-right: 8px;
                color: #007bff;
            }

            .property-details .features {
                display: flex;
                flex-wrap: wrap;
                gap: 15px; /* Consistent gap */
                margin-bottom: 30px;
            }
            .property-details .feature {
                background-color: #ffffff;
                padding: 12px 18px; /* More padding */
                border-radius: 8px;
                display: flex;
                align-items: center;
                border: 1px solid #e9ecef; /* Light border */
                box-shadow: 0 2px 4px rgba(0,0,0,0.03);
                transition: all 0.3s ease;
            }
            .property-details .feature:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 10px rgba(0,0,0,0.07);
            }
            .property-details .feature i {
                margin-right: 10px; /* More space for icon */
                color: #007bff; /* Primary color for feature icons */
                font-size: 1.2rem; /* Slightly larger icons */
            }
            .property-details .feature span {
                font-size: 0.95rem;
                color: #333;
            }

            .property-details .description {
                white-space: pre-line;
                margin-bottom: 30px;
                font-size: 1.1rem; /* Larger description text */
                line-height: 1.8; /* Better readability */
                color: #495057; /* Softer black */
            }

            .landlord-info {
                background-color: #ffffff; /* White background */
                padding: 25px;
                border-radius: 10px; /* Smoother radius */
                margin-bottom: 30px;
                border: 1px solid #e9ecef; /* Light border */
                box-shadow: 0 5px 15px rgba(0,0,0,0.05); /* Subtle shadow */
                display: flex; /* Ensure items align well */
                align-items: center; /* Vertically align avatar and text block */
            }
            .landlord-info img { /* Avatar */
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 20px;
                border: 3px solid #007bff; /* Primary color border for avatar */
                flex-shrink: 0; /* Prevent avatar from shrinking */
            }
            .landlord-info div { /* Text content wrapper */
                flex-grow: 1; /* Allow text block to take remaining space */
            }
            .landlord-info h4 { /* Landlord Name */
                margin-top: 0;
                margin-bottom: 8px;
                font-size: 1.5rem;
                font-weight: 600;
                color: #2c3e50;
            }
            .landlord-info p { /* Landlord contact details */
                font-size: 1rem;
                color: #555;
                margin-bottom: 6px;
            }
            .landlord-info p:last-child {
                margin-bottom: 0;
            }
            .landlord-info p i {
                margin-right: 8px;
                color: #007bff;
                width: 16px;
                text-align: center;
            }

            .location-map {
                height: 350px; /* Slightly taller map */
                width: 100%;
                border-radius: 10px; /* Match other rounded corners */
                margin-bottom: 30px;
                border: 1px solid #ddd; /* Add a border to the map iframe container */
                overflow: hidden; /* To ensure border-radius applies to iframe */
            }
            .section-title {
                margin-top: 40px;
                margin-bottom: 25px; /* Adjusted margin */
                padding-bottom: 12px; /* Adjusted padding */
                border-bottom: 2px solid #007bff; /* Primary color underline */
                font-size: 1.8rem; /* Larger section titles */
                font-weight: 600;
                color: #343a40; /* Dark gray */
            }
        </style>
    </head>
    <body>
        <div id="root">
            <main class="body-bg">
                <jsp:include page="/view/common/header.jsp" />
                <section class="breadcrumb padding-y-120">
                    <img
                        src="${pageContext.request.contextPath}/view/guest/asset/img/breadcrumb-img-DVKBF4db.png"
                        alt="Breadcrumb Image"
                        class="breadcrumb__img"
                        />
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="breadcrumb__wrapper">
                                    <h2 class="breadcrumb__title">${property.title}</h2>
                                    <ul class="breadcrumb__list">
                                        <li class="breadcrumb__item">
                                            <a
                                                class="breadcrumb__link"
                                                href="${pageContext.request.contextPath}/"
                                                >
                                                Trang chủ</a
                                            >
                                        </li>
                                        <li class="breadcrumb__item">
                                            <a
                                                class="breadcrumb__link"
                                                href="${pageContext.request.contextPath}/search"
                                                >
                                                Tìm kiếm</a
                                            >
                                        </li>
                                        <li class="breadcrumb__item">
                                            Chi tiết bất động sản
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="padding-y-80"
                         style="margin-top: 80px;">                    <div class="container padding-y-80">

                        <div class="row">
                            <!-- Cột bên trái: Thông tin bất động sản -->
                            <div class="col-lg-8">
                                <!-- Phần gallery hình ảnh -->
                                <div class="property-gallery">
                                    <img src="${property.avatar}" alt="${property.title}" class="main-image" id="mainImage">
                                    <div class="d-flex overflow-auto pb-2">
                                        <img src="${property.avatar}" alt="Thumbnail" class="thumbnail active" onclick="changeMainImage(this.src)">
                                        <c:forEach items="${propertyImages}" var="image">
                                            <img src="${image.imageURL}" alt="Thumbnail" class="thumbnail" onclick="changeMainImage(this.src)">
                                        </c:forEach>
                                    </div>
                                </div>
                                <!-- Phần thông tin chi tiết -->
                                <div class="property-details" data-property-id="${property.propertyId}">
                                    <h2>${property.title}</h2>
                                    <p class="price">
                                        <fmt:formatNumber value="${property.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/> / tháng
                                    </p>
                                    <p>
                                        <i class="fa fa-map-marker-alt"></i> 
                                        ${location.address}, ${location.city}, ${location.stateProvince}, ${location.country}
                                    </p>

                                    <div class="features">
                                        <div class="feature">
                                            <i class="fa fa-home"></i>
                                            <span>${propertyType.typeName}</span>
                                        </div>
                                        <div class="feature">
                                            <i class="fa fa-ruler-combined"></i>
                                            <span>${property.size} m<sup>2</sup></span>
                                        </div>
                                        <div class="feature">
                                            <i class="fa fa-bed"></i>
                                            <span>${property.numberOfBedrooms} phòng ngủ</span>
                                        </div>
                                        <div class="feature">
                                            <i class="fa fa-bath"></i>
                                            <span>${property.numberOfBathrooms} phòng tắm</span>
                                        </div>
                                        <div class="feature">
                                            <i class="fa fa-check-circle"></i>
                                            <span>Trạng thái: ${property.availabilityStatus}</span>
                                        </div>
                                    </div>

                                    <h4 class="section-title">Mô tả</h4>
                                    <div class="description">
                                        ${property.description}
                                    </div>

                                    <h4 class="section-title">Vị trí</h4>
                                    <div class="location-map">
                                        <!-- Phần này sẽ được thay thế bằng Google Maps trong phần JavaScript -->
                                        <iframe width="100%" height="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
                                                src="https://maps.google.com/maps?q=${location.address},${location.city},${location.country}&z=15&output=embed">
                                        </iframe>
                                    </div>
                                </div>
                            </div>
                            <!-- Cột bên phải: Thông tin chủ nhà -->
                            <div class="col-lg-4">                                <div class="landlord-info d-flex">
                                    <img src="${landlord.avatar != null && !landlord.avatar.isEmpty() ? landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" alt="Avatar">
                                    <div>
                                        <h4>${landlord.name}</h4>
                                        <p><i class="fa fa-phone"></i> ${landlord.phone}</p>
                                        <p><i class="fa fa-envelope"></i> ${landlord.email}</p>
                                        <p>
                                            <a href="${pageContext.request.contextPath}/ratings?action=viewLandlordRatings&landlordId=${landlord.userId}" class="btn btn-sm btn-primary">
                                                <i class="fa fa-star"></i> Xem đánh giá
                                            </a>
                                        </p>
                                    </div>
                                </div>                
                                <!-- Favorite Button -->
                                <div class="mt-3">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <c:choose>
                                                <c:when test="${isFavorited}">                                                    <button type="button" onclick="toggleFavorite('${property.propertyId}', false)" 
                                                        class="btn btn-danger w-100 py-3 shadow favorite-btn" 
                                                        style="font-size: 1.1rem; font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" 
                                                        id="favoriteBtn">
                                                        <i class="fas fa-heart me-2"></i> Đã yêu thích
                                                    </button>
                                                </c:when>
                                                <c:otherwise>                                                    <button type="button" onclick="toggleFavorite('${property.propertyId}', true)" 
                                                        class="btn btn-danger w-100 py-3 shadow favorite-btn" 
                                                        style="font-size: 1.1rem; font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" 
                                                        id="favoriteBtn">
                                                        <i class="far fa-heart me-2"></i> Thêm vào yêu thích
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" onclick="redirectToLogin()" 
                                                    class="btn btn-danger w-100 py-3 shadow" 
                                                    style="font-size: 1.1rem; font-weight: 600; border-radius: 8px; transition: all 0.3s ease;">
                                                <i class="far fa-heart me-2"></i> Thêm vào yêu thích
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Button to trigger Schedule Viewing Modal -->                                <div class="mt-3">
                                    <button type="button" id="openScheduleModalBtn" class="btn btn-success w-100 py-3 shadow" 
                                            style="font-size: 1.1rem; font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" 
                                            data-bs-toggle="modal" data-bs-target="#scheduleViewingModal">
                                        <i class="fa fa-calendar-alt me-2"></i> Đặt lịch xem nhà
                                    </button>
                                </div>

                                <!-- Button to trigger Rental Booking Modal -->
                                <div class="mt-3">
                                    <button type="button" id="openRentalModalBtn" class="btn btn-primary w-100 py-3 shadow" 
                                            style="font-size: 1.1rem; font-weight: 600; border-radius: 8px; transition: all 0.3s ease;" 
                                            data-bs-toggle="modal" data-bs-target="#rentalBookingModal">
                                        <i class="fa fa-home me-2"></i> Thuê nhà
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Schedule Viewing Modal -->
                <div class="modal fade" id="scheduleViewingModal" tabindex="-1" aria-labelledby="scheduleViewingModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="scheduleViewingModalLabel">Đặt lịch xem nhà</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/scheduleViewing" method="POST">
                                <div class="modal-body">
                                    <p>Chọn ngày bạn muốn xem bất động sản này:</p>
                                    <input type="hidden" name="propertyId" value="${property.propertyId}">
                                    <input type="hidden" name="landlordId" value="${landlord.userId}">
                                    <c:if test="${sessionScope.user == null}">
                                        <p class="text-danger">Vui lòng <a href="${pageContext.request.contextPath}/login">đăng nhập</a> để đặt lịch.</p>
                                    </c:if>                                    <c:if test="${sessionScope.user != null}">
                                        <div class="mb-3">
                                            <label for="scheduleDate" class="form-label">Ngày xem:</label>
                                            <input type="date" class="form-control" id="scheduleDate" name="scheduleDate" required>
                                            <div class="form-text text-muted">Vui lòng chọn ngày trong tương lai.</div>
                                            <div class="invalid-feedback">Vui lòng chọn một ngày hợp lệ.</div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="scheduleTime" class="form-label">Giờ xem:</label>
                                            <input type="time" class="form-control" id="scheduleTime" name="scheduleTime" required min="08:00" max="20:00">
                                            <div class="form-text text-muted">Vui lòng chọn thời gian từ 8:00 sáng đến 8:00 tối.</div>
                                            <div class="invalid-feedback">Vui lòng chọn một thời gian hợp lệ.</div>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>                                    <c:if test="${sessionScope.user != null}">
                                        <button type="submit" class="btn btn-primary" id="scheduleSubmitBtn">
                                            <span class="spinner-border spinner-border-sm d-none" id="scheduleSpinner" role="status" aria-hidden="true"></span>
                                            <span id="submitBtnText">Xác nhận</span>
                                        </button>
                                    </c:if>
                                </div>
                            </form>
                        </div>                    </div>                </div>

                <!-- Rental Booking Modal -->
                <div class="modal fade" id="rentalBookingModal" tabindex="-1" aria-labelledby="rentalBookingModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="rentalBookingModalLabel">Thuê nhà - Thông tin hợp đồng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/rental-booking" method="POST">
                                <div class="modal-body">
                                    <c:if test="${sessionScope.user == null}">
                                        <div class="alert alert-warning" role="alert">
                                            <i class="fa fa-exclamation-triangle me-2"></i>
                                            Vui lòng <a href="${pageContext.request.contextPath}/login" class="alert-link">đăng nhập</a> để tiến hành thuê nhà.
                                        </div>
                                    </c:if>

                                    <c:if test="${sessionScope.user != null}">
                                        <input type="hidden" name="propertyId" value="${property.propertyId}">
                                        <input type="hidden" name="landlordId" value="${landlord.userId}">

                                        <!-- Booking Information Section -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h6 class="fw-bold text-primary mb-3">
                                                    <i class="fa fa-info-circle me-2"></i>Thông tin cơ bản
                                                </h6>
                                                <div class="mb-3">
                                                    <label class="form-label">Ngày bắt đầu thuê:</label>
                                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Ngày kết thúc thuê:</label>
                                                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <h6 class="fw-bold text-success mb-3">
                                                    <i class="fa fa-money-bill-wave me-2"></i>Thông tin thanh toán
                                                </h6>
                                                <div class="mb-3">
                                                    <label class="form-label">Tiền thuê hàng tháng:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">₫</span>
                                                        <input type="number" class="form-control" id="monthlyRent" name="monthlyRent" 
                                                               value="${property.price}" readonly>
                                                    </div>
                                                </div>                                                <div class="mb-3">
                                                    <label class="form-label">Tiền cọc:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">₫</span>
                                                        <input type="number" class="form-control" id="depositAmount" name="depositAmount" 
                                                               value="${propertyBookingTemplate != null ? propertyBookingTemplate.depositAmount : ''}" 
                                                               readonly>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Tổng tiền cần thanh toán:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">₫</span>
                                                        <input type="number" class="form-control fw-bold text-success" id="totalPrice" name="totalPrice" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <hr>
                                        <!-- Terms and Conditions Section -->
                                        <div class="mb-4">
                                            <h6 class="fw-bold text-info mb-3">
                                                <i class="fa fa-file-contract me-2"></i>Điều khoản và điều kiện
                                            </h6>
                                            <textarea class="form-control" id="termsAndConditions" name="termsAndConditions" 
                                                      rows="4" readonly>${propertyBookingTemplate != null ? propertyBookingTemplate.termsAndConditions : 'Chưa có điều khoản và điều kiện được thiết lập.'}</textarea>
                                        </div>

                                        <!-- Penalty Clause Section -->
                                        <div class="mb-4">
                                            <h6 class="fw-bold text-warning mb-3">
                                                <i class="fa fa-exclamation-triangle me-2"></i>Điều khoản phạt
                                            </h6>
                                            <textarea class="form-control" id="penaltyClause" name="penaltyClause" 
                                                      rows="3" readonly>${propertyBookingTemplate != null ? propertyBookingTemplate.penaltyClause : 'Chưa có điều khoản phạt được thiết lập.'}</textarea>
                                        </div>
                                        <!-- Agreement Checkboxes -->
                                        <div class="mb-3">
                                            <h6 class="fw-bold text-secondary mb-3">
                                                <i class="fa fa-signature me-2"></i>Xác nhận ký kết
                                            </h6>

                                            <!-- Landlord signature status (read-only) -->
                                            <div class="alert alert-success mb-3" role="alert">
                                                <i class="fa fa-check-circle me-2"></i>
                                                <strong>Chủ nhà đã ký kết hợp đồng này</strong>
                                                <br><small>Các điều khoản và điều kiện đã được chủ nhà xác nhận.</small>
                                            </div>

                                            <!-- Renter signature -->
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" id="signedByRenter" name="signedByRenter" value="true" required>
                                                <label class="form-check-label fw-bold" for="signedByRenter">
                                                    <i class="fa fa-user me-2 text-primary"></i>Tôi (người thuê) đồng ý với tất cả điều khoản và ký kết hợp đồng này
                                                </label>
                                            </div>

                                            <!-- Hidden input for landlord signature (always true) -->
                                            <input type="hidden" name="signedByLandlord" value="true">
                                        </div>

                                        <div class="alert alert-warning" role="alert">
                                            <i class="fa fa-exclamation-triangle me-2"></i>
                                            <small><strong>Lưu ý quan trọng:</strong> Bằng việc tick vào ô xác nhận, bạn đồng ý với tất cả các điều khoản và điều kiện của hợp đồng thuê nhà này. Vui lòng đọc kỹ trước khi xác nhận.</small>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        <i class="fa fa-times me-2"></i>Hủy
                                    </button>
                                    <c:if test="${sessionScope.user != null}">
                                        <button type="submit" class="btn btn-primary" id="rentalSubmitBtn">
                                            <span class="spinner-border spinner-border-sm d-none" id="rentalSpinner" role="status" aria-hidden="true"></span>
                                            <i class="fa fa-file-signature me-2"></i>
                                            <span id="rentalSubmitBtnText">Gửi yêu cầu thuê nhà</span>
                                        </button>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <jsp:include page="/view/common/footer.jsp" />
            </main>
        </div>        <!-- Bootstrap JS và các thư viện cần thiết -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" 
        crossorigin="anonymous"></script>

        <!-- Schedule Viewing Modal Script -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/schedule-modal.js"></script>

        <!-- JavaScript cho Gallery -->
        <script>
                                                function changeMainImage(src) {
                                                    document.getElementById('mainImage').src = src;

                                                    // Đổi trạng thái active cho thumbnails
                                                    const thumbnails = document.querySelectorAll('.thumbnail');
                                                    thumbnails.forEach(thumb => {
                                                        if (thumb.src === src) {
                                                            thumb.classList.add('active');
                                                        } else {
                                                            thumb.classList.remove('active');
                                                        }
                                                    });
                                                }            // Check if Bootstrap is loaded properly
                                                function isBootstrapLoaded() {
                                                    return (typeof bootstrap !== 'undefined');
                                                }
                                                console.log("Bootstrap loaded status:", isBootstrapLoaded());            // JavaScript for Schedule Viewing Modal
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    // Initialize Bootstrap modal
                                                    const scheduleViewingModal = document.getElementById('scheduleViewingModal');
                                                    let bsModal = null;

                                                    if (scheduleViewingModal) {
                                                        // Initialize the modal only once
                                                        bsModal = new bootstrap.Modal(scheduleViewingModal, {
                                                            backdrop: true, // Allow closing when clicking outside
                                                            keyboard: true      // Will close when pressing ESC key
                                                        });
                                                    }

                                                    // Initialize Rental Booking Modal
                                                    const rentalBookingModal = document.getElementById('rentalBookingModal');
                                                    let rentalModal = null;

                                                    if (rentalBookingModal) {
                                                        rentalModal = new bootstrap.Modal(rentalBookingModal, {
                                                            backdrop: true,
                                                            keyboard: true
                                                        });
                                                    }

                                                    // Rental Modal Date and Price Calculations
                                                    const startDateInput = document.getElementById('startDate');
                                                    const endDateInput = document.getElementById('endDate');
                                                    const monthlyRentInput = document.getElementById('monthlyRent');
                                                    const depositAmountInput = document.getElementById('depositAmount');
                                                    const totalPriceInput = document.getElementById('totalPrice');

                                                    function calculateTotalPrice() {
                                                        const monthlyRent = parseFloat(monthlyRentInput.value) || 0;
                                                        const depositAmount = parseFloat(depositAmountInput.value) || 0;
                                                        const totalPrice = monthlyRent + depositAmount;
                                                        totalPriceInput.value = totalPrice;
                                                    }

                                                    // Set minimum dates for rental period
                                                    if (startDateInput && endDateInput) {
                                                        const today = new Date();
                                                        const yyyy = today.getFullYear();
                                                        const mm = String(today.getMonth() + 1).padStart(2, '0');
                                                        const dd = String(today.getDate()).padStart(2, '0');
                                                        const todayStr = `${yyyy}-${mm}-${dd}`;

                                                                    startDateInput.min = todayStr;
                                                                    endDateInput.min = todayStr;

                                                                    // Update end date minimum when start date changes
                                                                    startDateInput.addEventListener('change', function () {
                                                                        endDateInput.min = this.value;
                                                                        if (endDateInput.value && endDateInput.value < this.value) {
                                                                            endDateInput.value = '';
                                                                        }
                                                                    });
                                                                }

                                                                // Calculate total price when deposit amount changes
                                                                if (depositAmountInput) {
                                                                    depositAmountInput.addEventListener('input', calculateTotalPrice);
                                                                }

                                                                // Initial calculation
                                                                calculateTotalPrice();

                                                                // Rental form validation and submission
                                                                const rentalForm = document.querySelector('#rentalBookingModal form');
                                                                const rentalSubmitBtn = document.getElementById('rentalSubmitBtn');
                                                                const rentalSpinner = document.getElementById('rentalSpinner');
                                                                const rentalSubmitBtnText = document.getElementById('rentalSubmitBtnText');

                                                                if (rentalForm) {
                                                                    rentalForm.addEventListener('submit', function (event) {
                                                                        let isValid = true;

                                                                        // Validate required fields
                                                                        const startDate = startDateInput.value;
                                                                        const endDate = endDateInput.value;
                                                                        const depositAmount = depositAmountInput.value;
                                                                        const termsAndConditions = document.getElementById('termsAndConditions').value;
                                                                        const signedByRenter = document.getElementById('signedByRenter').checked;

                                                                        if (!startDate || !endDate || !depositAmount || depositAmount <= 0) {
                                                                            event.preventDefault();
                                                                            showToast('Vui lòng điền đầy đủ thông tin bắt buộc');
                                                                            isValid = false;
                                                                        }

                                                                        if (!signedByRenter) {
                                                                            event.preventDefault();
                                                                            showToast('Bạn cần xác nhận đồng ý với hợp đồng thuê nhà');
                                                                            isValid = false;
                                                                        }

                                                                        if (startDate && endDate && new Date(startDate) >= new Date(endDate)) {
                                                                            event.preventDefault();
                                                                            showToast('Ngày kết thúc phải sau ngày bắt đầu');
                                                                            isValid = false;
                                                                        }

                                                                        if (!isValid) {
                                                                            return false;
                                                                        }

                                                                        // Show loading spinner
                                                                        if (rentalSubmitBtn && rentalSpinner && rentalSubmitBtnText) {
                                                                            rentalSubmitBtn.disabled = true;
                                                                            rentalSpinner.classList.remove('d-none');
                                                                            rentalSubmitBtnText.textContent = 'Đang xử lý...';
                                                                        }

                                                                        return true;
                                                                    });
                                                                }

                                                                // Reset rental form when modal is hidden
                                                                if (rentalBookingModal) {
                                                                    rentalBookingModal.addEventListener('hidden.bs.modal', function () {
                                                                        if (rentalForm)
                                                                            rentalForm.reset();
                                                                        calculateTotalPrice();
                                                                        if (rentalSubmitBtn)
                                                                            rentalSubmitBtn.disabled = false;
                                                                        if (rentalSpinner)
                                                                            rentalSpinner.classList.add('d-none');
                                                                        if (rentalSubmitBtnText)
                                                                            rentalSubmitBtnText.textContent = 'Gửi yêu cầu thuê nhà';
                                                                    });
                                                                }

                                                                // Function to show toast notifications
                                                                function showToast(message) {
                                                                    // Remove any existing toasts
                                                                    const existingToasts = document.querySelectorAll('.toast-container');
                                                                    existingToasts.forEach(t => document.body.removeChild(t));

                                                                    // Create toast container
                                                                    const toastContainer = document.createElement('div');
                                                                    toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
                                                                    toastContainer.style.zIndex = '5';

                                                                    // Create toast HTML
                                                                    const isSuccess = message.toLowerCase().includes('thành công') ||
                                                                            !message.toLowerCase().includes('thất bại') &&
                                                                            !message.toLowerCase().includes('lỗi') &&
                                                                            !message.toLowerCase().includes('không');

                                                                    const borderColor = isSuccess ? 'success' : 'danger';
                                                                    const iconType = isSuccess ? 'check-circle-fill' : 'exclamation-triangle-fill';

                                                                    const toastContent = `
                        <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="toast-header border-${borderColor} border-bottom">
                                <i class="bi bi-${iconType} me-2 text-${borderColor}"></i>
                                <strong class="me-auto">Thông báo</strong>
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

                                                                // Set minimum date for date picker to today
                                                                const scheduleDateInput = document.getElementById('scheduleDate');
                                                                if (scheduleDateInput) {
                                                                    const today = new Date();
                                                                    const yyyy = today.getFullYear();
                                                                    const mm = String(today.getMonth() + 1).padStart(2, '0'); // Months are 0-based
                                                                    const dd = String(today.getDate()).padStart(2, '0');
                                                                    scheduleDateInput.min = `${yyyy}-${mm}-${dd}`;
                                                                            }
                                                                            // Handle form validation before submission
                                                                            const scheduleForm = document.querySelector('#scheduleViewingModal form');
                                                                            const submitBtn = document.getElementById('scheduleSubmitBtn');
                                                                            const submitSpinner = document.getElementById('scheduleSpinner');
                                                                            const submitBtnText = document.getElementById('submitBtnText');
                                                                            // Get time picker
                                                                            const scheduleTimeInput = document.getElementById('scheduleTime');

                                                                            if (scheduleForm) {
                                                                                scheduleForm.addEventListener('submit', function (event) {
                                                                                    let isValid = true;

                                                                                    // Validate the date input
                                                                                    const dateValue = scheduleDateInput.value;
                                                                                    if (!dateValue || dateValue === '') {
                                                                                        event.preventDefault();
                                                                                        scheduleDateInput.classList.add('is-invalid');
                                                                                        isValid = false;
                                                                                    } else {
                                                                                        scheduleDateInput.classList.remove('is-invalid');

                                                                                        const selectedDate = new Date(dateValue);
                                                                                        const currentDate = new Date();
                                                                                        currentDate.setHours(0, 0, 0, 0); // Reset time part for date comparison

                                                                                        if (selectedDate < currentDate) {
                                                                                            event.preventDefault();
                                                                                            scheduleDateInput.classList.add('is-invalid');
                                                                                            showToast('Không thể chọn ngày trong quá khứ');
                                                                                            isValid = false;
                                                                                        }
                                                                                    }

                                                                                    // Validate time input
                                                                                    if (scheduleTimeInput) {
                                                                                        const timeValue = scheduleTimeInput.value;
                                                                                        if (!timeValue || timeValue === '') {
                                                                                            event.preventDefault();
                                                                                            scheduleTimeInput.classList.add('is-invalid');
                                                                                            isValid = false;
                                                                                        } else {
                                                                                            scheduleTimeInput.classList.remove('is-invalid');

                                                                                            // Check if the selected time is within business hours (8:00 AM to 8:00 PM)
                                                                                            const [hours, minutes] = timeValue.split(':').map(Number);
                                                                                            if (hours < 8 || hours > 20 || (hours === 20 && minutes > 0)) {
                                                                                                event.preventDefault();
                                                                                                scheduleTimeInput.classList.add('is-invalid');
                                                                                                showToast('Vui lòng chọn thời gian từ 8:00 sáng đến 8:00 tối');
                                                                                                isValid = false;
                                                                                            }

                                                                                            // If today is selected, make sure the time is in the future
                                                                                            const selectedDate = new Date(dateValue);
                                                                                            const currentDate = new Date();
                                                                                            if (selectedDate.getDate() === currentDate.getDate() &&
                                                                                                    selectedDate.getMonth() === currentDate.getMonth() &&
                                                                                                    selectedDate.getFullYear() === currentDate.getFullYear()) {

                                                                                                const currentHour = currentDate.getHours();
                                                                                                const currentMinute = currentDate.getMinutes();

                                                                                                if (hours < currentHour || (hours === currentHour && minutes <= currentMinute)) {
                                                                                                    event.preventDefault();
                                                                                                    scheduleTimeInput.classList.add('is-invalid');
                                                                                                    showToast('Vui lòng chọn thời gian trong tương lai');
                                                                                                    isValid = false;
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }

                                                                                    if (!isValid) {
                                                                                        return false;
                                                                                    }

                                                                                    // Show loading spinner and disable button during submission
                                                                                    if (submitBtn && submitSpinner && submitBtnText) {
                                                                                        submitBtn.disabled = true;
                                                                                        submitSpinner.classList.remove('d-none');
                                                                                        submitBtnText.textContent = 'Đang xử lý...';
                                                                                    }

                                                                                    // Form is valid, allow submission
                                                                                    return true;
                                                                                });
                                                                            }
                                                                            // Reset form when modal is hidden
                                                                            const scheduleModal = document.getElementById('scheduleViewingModal');
                                                                            if (scheduleModal) {
                                                                                scheduleModal.addEventListener('hidden.bs.modal', function () {
                                                                                    if (scheduleForm)
                                                                                        scheduleForm.reset();
                                                                                    if (scheduleDateInput)
                                                                                        scheduleDateInput.classList.remove('is-invalid');
                                                                                    if (scheduleTimeInput)
                                                                                        scheduleTimeInput.classList.remove('is-invalid');
                                                                                    if (submitBtn)
                                                                                        submitBtn.disabled = false;
                                                                                    if (submitSpinner)
                                                                                        submitSpinner.classList.add('d-none');
                                                                                    if (submitBtnText)
                                                                                        submitBtnText.textContent = 'Xác nhận';
                                                                                });
                                                                            }                // Handle messages from server after form submission (e.g., success/error)
                                                                            const urlParams = new URLSearchParams(window.location.search);
                                                                            const scheduleMessage = urlParams.get('scheduleMessage');
                                                                            const rentalMessage = urlParams.get('message');

                                                                            if (scheduleMessage) {
                                                                                // Display a toast notification
                                                                                showToast(decodeURIComponent(scheduleMessage));

                                                                                // Clean the URL - remove scheduleMessage parameter
                                                                                const url = new URL(window.location.href);
                                                                                url.searchParams.delete('scheduleMessage');
                                                                                window.history.replaceState({}, document.title, url.toString());
                                                                            }

                                                                            if (rentalMessage) {
                                                                                // Display a toast notification for rental booking
                                                                                showToast(decodeURIComponent(rentalMessage));

                                                                                // Clean the URL - remove message parameter                const url = new URL(window.location.href);
                                                                                url.searchParams.delete('message');
                                                                                window.history.replaceState({}, document.title, url.toString());
                                                                            }
                                                                        });

                                                                        // Favorite functionality
                                                                        function toggleFavorite(propertyId, isAdd) {
                                                                            const favoriteBtn = document.getElementById('favoriteBtn');
                                                                            const originalHtml = favoriteBtn.innerHTML;

                                                                            // Show loading state
                                                                            favoriteBtn.disabled = true;
                                                                            favoriteBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Đang xử lý...';

                                                                            const form = document.createElement('form');
                                                                            form.method = 'POST';
                                                                            form.action = '${pageContext.request.contextPath}/favorite-action';

                                                                            const actionInput = document.createElement('input');
                                                                            actionInput.type = 'hidden';
                                                                            actionInput.name = 'action';
                                                                            actionInput.value = isAdd ? 'add' : 'remove';

                                                                            const propertyInput = document.createElement('input');
                                                                            propertyInput.type = 'hidden';
                                                                            propertyInput.name = 'propertyId';
                                                                            propertyInput.value = propertyId;

                                                                            const redirectInput = document.createElement('input');
                                                                            redirectInput.type = 'hidden';
                                                                            redirectInput.name = 'redirectUrl';
                                                                            redirectInput.value = window.location.href;

                                                                            form.appendChild(actionInput);
                                                                            form.appendChild(propertyInput);
                                                                            form.appendChild(redirectInput);

                                                                            document.body.appendChild(form);
                                                                            form.submit();
                                                                        }

                                                                        function redirectToLogin() {
                                                                            if (confirm('Bạn cần đăng nhập để sử dụng tính năng yêu thích. Chuyển đến trang đăng nhập?')) {
                                                                                window.location.href = '${pageContext.request.contextPath}/login?redirect=' +
                                                                                        encodeURIComponent(window.location.href);
                                                                            }
                                                                        }
        </script>
    </body>
</html>
