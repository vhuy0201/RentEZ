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
                            <div class="col-lg-4">                                
                                <div class="landlord-info d-flex">
                                    <img src="${landlord.avatar != null && !landlord.avatar.isEmpty() ? landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" alt="Avatar">
                                    <div>
                                        <h4>${landlord.name}</h4>
                                        <p><i class="fa fa-phone"></i> ${landlord.phone}</p>
                                        <p><i class="fa fa-envelope"></i> ${landlord.email}</p>
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/ratings?action=viewLandlordRatings&landlordId=${landlord.userId}" 
                                               class="btn btn-outline-primary btn-sm flex-fill">
                                                <i class="fas fa-star me-1"></i>
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-sm flex-fill" 
                                                    data-bs-toggle="modal" data-bs-target="#reportModal">
                                                <i class="fas fa-flag me-1"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/MessageServlet?action=getMessages&receiverID=${landlord.userId}" 
                                               class="btn btn-outline-success btn-sm flex-fill">
                                                <i class="fas fa-comments me-1"></i>
                                            </a>
                                        </div>
                                        <!-- Report Modal -->
                                        <div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="reportModalLabel">Báo cáo chủ nhà</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <form id="reportForm" action="ReportServlet" method="POST">
                                                        <div class="modal-body">
                                                            <input type="hidden" name="landLordId" value="${landlord.userId}" />
                                                            <input type="hidden" name="action" value="create" />
                                                            <input type="hidden" name="propertyID" value="${property.propertyId}" />

                                                            <div class="mb-3">
                                                                <label for="reportContent" class="form-label">Nội dung báo cáo:</label>
                                                                <textarea class="form-control" id="reportContent" name="content" rows="4" required placeholder="Nhập nội dung báo cáo..."></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                            <button type="submit" class="btn btn-danger">Gửi báo cáo</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
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
                    <div class="modal-dialog modal-xl modal-dialog-centered">
                        <div class="modal-content" style="min-height: 80vh;">
                            <div class="modal-header bg-gradient-to-r from-orange-500 to-orange-600 text-white">
                                <h5 class="modal-title fw-bold" id="rentalBookingModalLabel">
                                    <i class="fas fa-file-contract me-2"></i>HỢP ĐỒNG THUÊ NHÀ NGUYÊN CĂN
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/rental-booking" method="POST">
                                <div class="modal-body p-0">
                                    <c:if test="${sessionScope.user == null}">
                                        <div class="alert alert-warning m-4" role="alert">
                                            <i class="fa fa-exclamation-triangle me-2"></i>
                                            Vui lòng <a href="${pageContext.request.contextPath}/login" class="alert-link">đăng nhập</a> để tiến hành thuê nhà.
                                        </div>
                                    </c:if>

                                    <c:if test="${sessionScope.user != null}">
                                        <!-- Contract Document Style -->
                                        <div class="contract-document p-4" style="font-family: 'Times New Roman', serif; line-height: 1.8; max-height: 70vh; overflow-y: auto;">

                                            <input type="hidden" name="propertyId" value="${property.propertyId}">
                                            <input type="hidden" name="landlordId" value="${landlord.userId}">

                                            <!-- Contract Header -->
                                            <div class="text-center mb-4">
                                                <p class="fw-bold mb-2">Căn cứ vào khả năng, nhu cầu của hai bên:</p>
                                                <p>Hôm nay, ngày <span id="currentDate"></span>, chúng tôi gồm có:</p>
                                            </div>

                                            <!-- Party A - Landlord -->
                                            <div class="mb-4">
                                                <h6 class="fw-bold text-orange-600 mb-3">BÊN CHO THUÊ NHÀ (Gọi tắt là Bên A):</h6>
                                                <div class="ms-3 row g-2">
                                                    <div class="col-12">
                                                        <div class="d-flex align-items-center">
                                                            <span class="fw-medium" style="width: 100px;">Ông/Bà:</span>
                                                            <span class="flex-fill border-bottom border-2 px-2 py-1 bg-light">${landlord.name}</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="d-flex align-items-center">
                                                            <span class="fw-medium" style="width: 100px;">Email:</span>
                                                            <span class="flex-fill border-bottom border-2 px-2 py-1 bg-light">${landlord.email}</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="d-flex align-items-center">
                                                            <span class="fw-medium" style="width: 100px;">Điện thoại:</span>
                                                            <span class="flex-fill border-bottom border-2 px-2 py-1 bg-light">
                                                                ${not empty landlord.phone ? landlord.phone : '...........................'}
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Party B - Renter -->
                                            <div class="mb-4">
                                                <h6 class="fw-bold text-orange-600 mb-3">BÊN THUÊ NHÀ (Gọi tắt là Bên B):</h6>
                                                <div class="ms-3 row g-2">
                                                    <div class="col-12">
                                                        <div class="d-flex align-items-center">
                                                            <span class="fw-medium" style="width: 100px;">Ông/Bà:</span>
                                                            <span class="flex-fill border-bottom border-2 px-2 py-1 bg-light">${sessionScope.user.name}</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="d-flex align-items-center">
                                                            <span class="fw-medium" style="width: 100px;">Email:</span>
                                                            <span class="flex-fill border-bottom border-2 px-2 py-1 bg-light">${sessionScope.user.email}</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="d-flex align-items-center">
                                                            <span class="fw-medium" style="width: 100px;">Điện thoại:</span>
                                                            <span class="flex-fill border-bottom border-2 px-2 py-1 bg-light">
                                                                ${not empty sessionScope.user.phone ? sessionScope.user.phone : '...........................'}
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <p class="mb-4 text-justify">
                                                Sau khi thỏa thuận, hai bên đồng ý tham gia và ký kết hợp đồng thuê nhà với các điều khoản sau đây:
                                            </p>

                                            <!-- Article 1 - Property and Duration -->
                                            <div class="mb-4">
                                                <h6 class="fw-bold text-orange-600 mb-3">ĐIỀU 1: DIỆN TÍCH VÀ THỜI GIAN THUÊ</h6>
                                                <div class="ms-3">
                                                    <p class="text-justify mb-3">1.1 Bên A đồng ý cho Bên B thuê toàn bộ ngôi nhà <strong>"${property.title}"</strong> 
                                                        tọa lạc tại địa chỉ: <strong>${location.address}, ${location.city}, ${location.stateProvince}</strong> 
                                                        với các đặc điểm sau:</p>
                                                    <div class="ms-4 mb-3">
                                                        <p class="mb-1">- Diện tích: <strong>${property.size} m²</strong></p>
                                                        <p class="mb-1">- Loại hình: <strong>${propertyType.typeName}</strong></p>
                                                        <p class="mb-1">- Số phòng ngủ: <strong>${property.numberOfBedrooms}</strong></p>
                                                        <p class="mb-1">- Số phòng tắm: <strong>${property.numberOfBathrooms}</strong></p>
                                                        <p class="mb-1">- Kết cấu: Nhà nguyên căn đầy đủ tiện nghi</p>
                                                    </div>

                                                    <!-- Rental Period Selection -->
                                                    <div class="bg-orange-50 p-3 rounded mb-3 border-start border-4 border-orange-500">
                                                        <h6 class="fw-bold text-orange-700 mb-3">
                                                            <i class="fas fa-calendar-alt me-2"></i>Thời gian thuê:
                                                        </h6>
                                                        <div class="row g-3">
                                                            <div class="col-md-6">
                                                                <label class="form-label fw-bold">Ngày bắt đầu thuê:</label>
                                                                <input type="date" class="form-control form-control-lg" id="startDate" name="startDate" required>
                                                                <div class="form-text text-muted">
                                                                    <i class="fas fa-info-circle me-1"></i>Không thể chọn ngày trong quá khứ
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label fw-bold">Số tháng thuê:</label>
                                                                <select class="form-select form-select-lg" id="rentalMonths" name="rentalMonths" required>
                                                                    <option value="">Chọn số tháng</option>
                                                                    <option value="1">1 tháng</option>
                                                                    <option value="2">2 tháng</option>
                                                                    <option value="3">3 tháng</option>
                                                                    <option value="6">6 tháng</option>
                                                                    <option value="12">12 tháng</option>
                                                                    <option value="24">24 tháng</option>
                                                                    <option value="36">36 tháng</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="mt-3">
                                                            <p class="text-justify">1.5 Thời gian cho thuê: Bắt đầu từ ngày: <strong><span id="displayStartDate">__/__/____</span></strong> 
                                                                và sẽ chấm dứt vào ngày: <strong><span id="displayEndDate">__/__/____</span></strong></p>
                                                            <input type="hidden" id="endDate" name="endDate">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Article 2 - Price and Payment -->
                                            <div class="mb-4">
                                                <h6 class="fw-bold text-orange-600 mb-3">ĐIỀU 2: GIÁ THUÊ VÀ PHƯƠNG THỨC THANH TOÁN</h6>
                                                <div class="ms-3">
                                                    <div class="bg-green-50 p-3 rounded border-start border-4 border-green-500">
                                                        <div class="row g-3">
                                                            <div class="col-md-6">
                                                                <label class="form-label fw-bold">Tiền thuê hàng tháng:</label>
                                                                <div class="input-group input-group-lg">
                                                                    <span class="input-group-text bg-green-100">₫</span>
                                                                    <input type="text" class="form-control bg-white" id="monthlyRentDisplay" 
                                                                           value="<fmt:formatNumber value='${property.price}' type='number' groupingUsed='true'/>" readonly>
                                                                    <input type="hidden" id="monthlyRent" name="monthlyRent" value="${property.price}">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label fw-bold">Tiền đặt cọc:</label>
                                                                <div class="input-group input-group-lg">
                                                                    <span class="input-group-text bg-blue-100">₫</span>
                                                                    <input type="text" class="form-control bg-white" id="depositAmountDisplay" 
                                                                           value="<fmt:formatNumber value='${propertyBookingTemplate != null ? propertyBookingTemplate.depositAmount : property.price}' type='number' groupingUsed='true'/>" readonly>
                                                                    <input type="hidden" id="depositAmount" name="depositAmount" 
                                                                           value="${propertyBookingTemplate != null ? propertyBookingTemplate.depositAmount : property.price}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mt-3">
                                                            <label class="form-label fw-bold text-success">Tổng giá trị hợp đồng:</label>
                                                            <div class="input-group input-group-lg">
                                                                <span class="input-group-text bg-success text-white">₫</span>
                                                                <input type="text" class="form-control fw-bold text-success fs-5" id="totalPriceDisplay" readonly>
                                                                <input type="hidden" id="totalPrice" name="totalPrice">
                                                            </div>
                                                            <div class="form-text text-muted mt-2">
                                                                <small><i class="fas fa-info-circle me-1"></i>Tổng tiền = Tiền thuê hàng tháng + Tiền đặt cọc</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Article 3 - Terms and Conditions -->
                                            <div class="mb-4">
                                                <h6 class="fw-bold text-orange-600 mb-3">ĐIỀU 3: ĐIỀU KHOẢN VÀ ĐIỀU KIỆN</h6>
                                                <div class="ms-3">
                                                    <div class="bg-blue-50 p-3 rounded border-start border-4 border-blue-500 mb-3">
                                                        <label class="form-label fw-bold">3.1 Điều khoản và điều kiện:</label>
                                                        <textarea class="form-control" id="termsAndConditions" name="termsAndConditions" 
                                                                  rows="3" readonly>${propertyBookingTemplate != null ? propertyBookingTemplate.termsAndConditions : 'Hai bên cam kết thực hiện đúng và đầy đủ các điều khoản đã thỏa thuận.'}</textarea>
                                                    </div>

                                                    <div class="bg-yellow-50 p-3 rounded border-start border-4 border-yellow-500">
                                                        <label class="form-label fw-bold">3.2 Điều khoản phạt:</label>
                                                        <textarea class="form-control" id="penaltyClause" name="penaltyClause" 
                                                                  rows="3" readonly>${propertyBookingTemplate != null ? propertyBookingTemplate.penaltyClause : 'Trong quá trình thực hiện nếu có vướng mắc, hai bên sẽ cùng nhau thỏa thuận giải quyết trên tinh thần hợp tác.'}</textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Article 4 - Agreement -->
                                            <div class="mb-4">
                                                <h6 class="fw-bold text-orange-600 mb-3">ĐIỀU 4: XÁC NHẬN KÝ KẾT</h6>
                                                <div class="ms-3">
                                                    <!-- Landlord signature status (read-only) -->
                                                    <div class="alert alert-success mb-3" role="alert">
                                                        <i class="fas fa-check-circle me-2"></i>
                                                        <strong>Chủ nhà đã ký kết hợp đồng này</strong>
                                                        <br><small>Các điều khoản và điều kiện đã được chủ nhà xác nhận.</small>
                                                    </div>

                                                    <!-- Renter signature -->
                                                    <div class="bg-orange-50 p-4 rounded border mb-3">
                                                        <h6 class="fw-bold text-orange-600 mb-3">
                                                            <i class="fas fa-signature me-2"></i>Chữ ký người thuê nhà:
                                                        </h6>

                                                        <!-- Digital signature canvas -->
                                                        <div class="signature-container mb-3">
                                                            <label class="form-label fw-bold mb-2">Vui lòng ký tên của bạn vào khung bên dưới:</label>
                                                            <div class="signature-canvas-wrapper border rounded p-2 bg-white" style="text-align: center;">
                                                                <canvas id="signatureCanvas" width="500" height="150" 
                                                                        style="border: 2px dashed #ddd; cursor: crosshair; max-width: 100%; height: auto;"></canvas>
                                                                <div class="mt-2">
                                                                    <button type="button" id="clearSignatureBtn" class="btn btn-outline-secondary btn-sm me-2" onclick="clearSignature()">
                                                                        <i class="fas fa-eraser me-1"></i>Xóa chữ ký
                                                                    </button>
                                                                    <small class="text-muted">Sử dụng chuột hoặc ngón tay để ký tên</small>
                                                                </div>
                                                            </div>
                                                            <input type="hidden" id="signatureData" name="signatureData">
                                                        </div>

                                                        <!-- Agreement checkbox -->
                                                        <div class="form-check mb-3">
                                                            <input class="form-check-input me-3" type="checkbox" id="signedByRenter" name="signedByRenter" value="true" required style="transform: scale(1.5);">
                                                            <label class="form-check-label fw-bold" for="signedByRenter">
                                                                <i class="fas fa-user me-2 text-orange-600"></i>Tôi đã ký tên và đồng ý với tất cả điều khoản của hợp đồng thuê nhà này
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <!-- Hidden input for landlord signature (always true) -->
                                                    <input type="hidden" name="signedByLandlord" value="true">
                                                </div>
                                            </div>

                                            <div class="alert alert-warning" role="alert">
                                                <i class="fas fa-exclamation-triangle me-2"></i>
                                                <small><strong>Lưu ý quan trọng:</strong> Bằng việc tick vào ô xác nhận, bạn đồng ý với tất cả các điều khoản và điều kiện của hợp đồng thuê nhà này. Vui lòng đọc kỹ trước khi xác nhận.</small>
                                            </div>
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

        <!-- Signature Canvas Styles -->
        <style>
            .signature-canvas-wrapper {
                background: linear-gradient(to bottom, #f8f9fa 0%, #ffffff 100%);
                box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
            }

            #signatureCanvas {
                border: 2px dashed #dee2e6 !important;
                background: white;
                border-radius: 8px;
                transition: border-color 0.3s ease;
            }

            #signatureCanvas:hover {
                border-color: #ffa500 !important;
            }

            #signatureCanvas.active {
                border-color: #fd7e14 !important;
                box-shadow: 0 0 10px rgba(255, 165, 0, 0.3);
            }

            .signature-container {
                position: relative;
            }

            .signature-container::after {
                content: "Chữ ký của bạn";
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: #6c757d;
                font-style: italic;
                pointer-events: none;
                z-index: 1;
                opacity: 0.5;
                font-size: 14px;
            }

            .signature-container.has-signature::after {
                display: none;
            }

            /* Date input validation styles */
            .form-control[type="date"]:invalid {
                border-color: #dc3545;
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
            }

            .form-control[type="date"]:focus {
                border-color: #fd7e14;
                box-shadow: 0 0 0 0.2rem rgba(253, 126, 20, 0.25);
            }

            /* Responsive canvas */
            @media (max-width: 768px) {
                #signatureCanvas {
                    width: 100% !important;
                    height: auto !important;
                }
            }
        </style>

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
                                                                            const totalPriceDisplayInput = document.getElementById('totalPriceDisplay');

                                                                            // Set current date on modal open
                                                                            function setCurrentDate() {
                                                                                const currentDateEl = document.getElementById("currentDate");
                                                                                const today = new Date();
                                                                                if (currentDateEl) {
                                                                                    currentDateEl.textContent = today.toLocaleDateString('vi-VN');
                                                                                }
                                                                            }

                                                                            // Calculate end date based on start date and months
                                                                            function calculateEndDate() {
                                                                                const startDateInput = document.getElementById("startDate");
                                                                                const rentalMonthsSelect = document.getElementById("rentalMonths");
                                                                                const displayStartDate = document.getElementById("displayStartDate");
                                                                                const displayEndDate = document.getElementById("displayEndDate");
                                                                                const hiddenEndDate = document.getElementById("endDate");

                                                                                const startDateValue = startDateInput.value;
                                                                                const rentalMonths = parseInt(rentalMonthsSelect.value);

                                                                                if (startDateValue && rentalMonths) {
                                                                                    const startDate = new Date(startDateValue);
                                                                                    const endDate = new Date(startDate);
                                                                                    endDate.setMonth(endDate.getMonth() + rentalMonths);

                                                                                    // Hiển thị ngày bắt đầu và kết thúc
                                                                                    displayStartDate.textContent = startDate.toLocaleDateString('vi-VN');
                                                                                    displayEndDate.textContent = endDate.toLocaleDateString('vi-VN');
                                                                                    hiddenEndDate.value = endDate.toISOString().split("T")[0]; // yyyy-mm-dd
                                                                                }
                                                                            }
                                                                            document.addEventListener("DOMContentLoaded", function () {
                                                                                showCurrentDate();

                                                                                document.getElementById("startDate").addEventListener("change", updateRentalPeriod);
                                                                                document.getElementById("rentalMonths").addEventListener("change", updateRentalPeriod);
                                                                            });

                                                                            function calculateTotalPrice() {
                                                                                const monthsSelect = document.getElementById('rentalMonths');
                                                                                const monthlyRent = parseFloat(monthlyRentInput.value) || 0;
                                                                                const depositAmount = parseFloat(depositAmountInput.value) || 0;
                                                                                const totalPriceDisplayInput = document.getElementById('totalPriceDisplay');

                                                                                // Tổng giá trị hợp đồng = Tiền thuê hàng tháng + Tiền cọc (không nhân với số tháng)
                                                                                const totalPrice = monthlyRent + depositAmount;

                                                                                // Update hidden field value
                                                                                totalPriceInput.value = totalPrice;

                                                                                // Update display field with formatted number
                                                                                if (totalPriceDisplayInput) {
                                                                                    totalPriceDisplayInput.value = totalPrice.toLocaleString('vi-VN');
                                                                                }
                                                                            }

                                                                            // Set minimum dates and add event listeners
                                                                            if (startDateInput && endDateInput) {
                                                                                const today = new Date();
                                                                                const yyyy = today.getFullYear();
                                                                                const mm = String(today.getMonth() + 1).padStart(2, '0');
                                                                                const dd = String(today.getDate()).padStart(2, '0');
                                                                                const todayStr = `${yyyy}-${mm}-${dd}`;

                                                                                            startDateInput.min = todayStr;

                                                                            // Add event listeners for date and month changes
                                                                            startDateInput.addEventListener('change', function() {
                                                                                const selectedDate = new Date(this.value);
                                                                                const today = new Date();
                                                                                today.setHours(0, 0, 0, 0); // Reset time to start of day for accurate comparison
                                                                                
                                                                                if (selectedDate < today) {
                                                                                    alert('Không thể chọn ngày trong quá khứ. Vui lòng chọn ngày từ hôm nay trở đi.');
                                                                                    this.value = '';
                                                                                    return;
                                                                                }
                                                                                
                                                                                calculateEndDate();
                                                                            });                                                                                            const monthsSelect = document.getElementById('rentalMonths');
                                                                                            if (monthsSelect) {
                                                                                                monthsSelect.addEventListener('change', calculateEndDate);
                                                                                            }
                                                                                        }

                                                                                        // Initial calculation when modal opens
                                                                                        if (rentalBookingModal) {
                                                                                            rentalBookingModal.addEventListener('shown.bs.modal', function () {
                                                                                                setCurrentDate();
                                                                                                calculateTotalPrice();

                                                                                                // Set minimum date for start date input
                                                                                                const startDateInput = document.getElementById('startDate');
                                                                                                if (startDateInput) {
                                                                                                    const today = new Date();
                                                                                                    const yyyy = today.getFullYear();
                                                                                                    const mm = String(today.getMonth() + 1).padStart(2, '0');
                                                                                                    const dd = String(today.getDate()).padStart(2, '0');
                                                                                                    const todayStr = `${yyyy}-${mm}-${dd}`;
                                                                                                    startDateInput.min = todayStr;
                                                                                                }

                                                                                                // Format display amounts
                                                                                                const monthlyRent = parseFloat(monthlyRentInput.value) || 0;
                                                                                                const depositAmount = parseFloat(depositAmountInput.value) || 0;

                                                                                                const monthlyRentDisplay = document.getElementById('monthlyRentDisplay');
                                                                                                const depositAmountDisplay = document.getElementById('depositAmountDisplay');

                                                                                                if (monthlyRentDisplay) {
                                                                                                    monthlyRentDisplay.value = monthlyRent.toLocaleString('vi-VN');
                                                                                                }
                                                                                                if (depositAmountDisplay) {
                                                                                                    depositAmountDisplay.value = depositAmount.toLocaleString('vi-VN');
                                                                                                }

                                                                                                // Initialize digital signature
                                                                                                initializeSignature();

                                                                                                // Trigger calculateEndDate if both date and month are selected
                                                                                                setTimeout(() => {
                                                                                                    calculateEndDate();
                                                                                                }, 100);
                                                                                            });
                                                                                        }

                                                                                        // Digital Signature Functions
                                                                                        let signatureCanvas, signatureCtx, isDrawing = false;

                                                                                        function initializeSignature() {
                                                                                            signatureCanvas = document.getElementById('signatureCanvas');
                                                                                            if (!signatureCanvas)
                                                                                                return;

                                                                                            signatureCtx = signatureCanvas.getContext('2d');

                                                                                            // Set canvas size for better quality
                                                                                            const rect = signatureCanvas.getBoundingClientRect();
                                                                                            signatureCanvas.width = 500;
                                                                                            signatureCanvas.height = 150;

                                                                                            // Configure drawing style
                                                                                            signatureCtx.strokeStyle = '#000';
                                                                                            signatureCtx.lineWidth = 2;
                                                                                            signatureCtx.lineCap = 'round';
                                                                                            signatureCtx.lineJoin = 'round';

                                                                                            // Mouse events
                                                                                            signatureCanvas.addEventListener('mousedown', startDrawing);
                                                                                            signatureCanvas.addEventListener('mousemove', draw);
                                                                                            signatureCanvas.addEventListener('mouseup', stopDrawing);
                                                                                            signatureCanvas.addEventListener('mouseout', stopDrawing);

                                                                                            // Touch events for mobile
                                                                                            signatureCanvas.addEventListener('touchstart', handleTouch);
                                                                                            signatureCanvas.addEventListener('touchmove', handleTouch);
                                                                                            signatureCanvas.addEventListener('touchend', stopDrawing);
                                                                                            
                                                                                            // Also attach clear signature event listener as backup
                                                                                            const clearBtn = document.getElementById('clearSignatureBtn');
                                                                                            if (clearBtn) {
                                                                                                clearBtn.addEventListener('click', function(e) {
                                                                                                    e.preventDefault();
                                                                                                    e.stopPropagation();
                                                                                                    window.clearSignature();
                                                                                                });
                                                                                            }
                                                                                            
                                                                                            console.log('Signature canvas initialized');
                                                                                        }

                                                                                        function startDrawing(e) {
                                                                                            isDrawing = true;
                                                                                            signatureCanvas.classList.add('active');

                                                                                            const rect = signatureCanvas.getBoundingClientRect();
                                                                                            const scaleX = signatureCanvas.width / rect.width;
                                                                                            const scaleY = signatureCanvas.height / rect.height;

                                                                                            signatureCtx.beginPath();
                                                                                            signatureCtx.moveTo(
                                                                                                    (e.clientX - rect.left) * scaleX,
                                                                                                    (e.clientY - rect.top) * scaleY
                                                                                                    );
                                                                                        }

                                                                                        function draw(e) {
                                                                                            if (!isDrawing)
                                                                                                return;

                                                                                            const rect = signatureCanvas.getBoundingClientRect();
                                                                                            const scaleX = signatureCanvas.width / rect.width;
                                                                                            const scaleY = signatureCanvas.height / rect.height;

                                                                                            signatureCtx.lineTo(
                                                                                                    (e.clientX - rect.left) * scaleX,
                                                                                                    (e.clientY - rect.top) * scaleY
                                                                                                    );
                                                                                            signatureCtx.stroke();
                                                                                        }

                                                                                        function stopDrawing() {
                                                                                            if (isDrawing) {
                                                                                                isDrawing = false;
                                                                                                signatureCanvas.classList.remove('active');

                                                                                                // Save signature data
                                                                                                const signatureData = signatureCanvas.toDataURL();
                                                                                                const signatureDataInput = document.getElementById('signatureData');
                                                                                                if (signatureDataInput) {
                                                                                                    signatureDataInput.value = signatureData;
                                                                                                }

                                                                                                // Add visual feedback
                                                                                                const container = document.querySelector('.signature-container');
                                                                                                if (container) {
                                                                                                    container.classList.add('has-signature');
                                                                                                }
                                                                                                
                                                                                                console.log('Signature saved');
                                                                                            }
                                                                                        }

                                                                                        function handleTouch(e) {
                                                                                            e.preventDefault();
                                                                                            const touch = e.touches[0];
                                                                                            const mouseEvent = new MouseEvent(e.type === 'touchstart' ? 'mousedown' :
                                                                                                    e.type === 'touchmove' ? 'mousemove' : 'mouseup', {
                                                                                                        clientX: touch.clientX,
                                                                                                        clientY: touch.clientY
                                                                                                    });
                                                                                            signatureCanvas.dispatchEvent(mouseEvent);
                                                                                        }

                                                                                        // Make clearSignature available globally
                                                                                        window.clearSignature = function() {
                                                                                            console.log('clearSignature called');
                                                                                            
                                                                                            // Get canvas and context fresh each time
                                                                                            const canvas = document.getElementById('signatureCanvas');
                                                                                            const signatureDataInput = document.getElementById('signatureData');
                                                                                            
                                                                                            if (canvas) {
                                                                                                const ctx = canvas.getContext('2d');
                                                                                                if (ctx) {
                                                                                                    // Clear the canvas
                                                                                                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                                                                                                }
                                                                                                
                                                                                                // Clear the signature data
                                                                                                if (signatureDataInput) {
                                                                                                    signatureDataInput.value = '';
                                                                                                }

                                                                                                // Remove visual feedback
                                                                                                const container = document.querySelector('.signature-container');
                                                                                                if (container) {
                                                                                                    container.classList.remove('has-signature');
                                                                                                }
                                                                                                canvas.classList.remove('active');
                                                                                                
                                                                                                console.log('Signature cleared successfully');
                                                                                            } else {
                                                                                                console.error('Signature canvas not found');
                                                                                            }
                                                                                        };

                                                                                        // Also calculate on page load
                                                                                        calculateTotalPrice();

                                                                                        // Rental form validation and submission
                                                                                        const rentalForm = document.querySelector('#rentalBookingModal form');
                                                                                        const rentalSubmitBtn = document.getElementById('rentalSubmitBtn');
                                                                                        const rentalSpinner = document.getElementById('rentalSpinner');
                                                                                        const rentalSubmitBtnText = document.getElementById('rentalSubmitBtnText');

                                                                                        if (rentalForm) {
                                                                                            rentalForm.addEventListener('submit', function (event) {
                                                                                                let isValid = true;

                                                                                                // Validate start date is not in the past
                                                                                                const startDate = startDateInput.value;
                                                                                                if (startDate) {
                                                                                                    const selectedDate = new Date(startDate);
                                                                                                    const today = new Date();
                                                                                                    today.setHours(0, 0, 0, 0);
                                                                                                    
                                                                                                    if (selectedDate < today) {
                                                                                                        event.preventDefault();
                                                                                                        alert('Ngày bắt đầu thuê không thể là ngày trong quá khứ. Vui lòng chọn ngày từ hôm nay trở đi.');
                                                                                                        isValid = false;
                                                                                                        return;
                                                                                                    }
                                                                                                }

                                                                                                // Validate required fields
                                                                                                const monthsSelect = document.getElementById('rentalMonths');
                                                                                                const months = monthsSelect ? monthsSelect.value : '';
                                                                                                const depositAmount = depositAmountInput.value;
                                                                                                const signedByRenter = document.getElementById('signedByRenter').checked;
                                                                                                const signatureData = document.getElementById('signatureData').value;

                                                                                                if (!startDate || !months || !depositAmount || depositAmount <= 0) {
                                                                                                    event.preventDefault();
                                                                                                    showToast('Vui lòng điền đầy đủ thông tin bắt buộc (ngày bắt đầu thuê, số tháng thuê, tiền đặt cọc)');
                                                                                                    isValid = false;
                                                                                                }

                                                                                                if (!signatureData || signatureData.trim() === '') {
                                                                                                    event.preventDefault();
                                                                                                    showToast('Vui lòng ký tên vào khung chữ ký');
                                                                                                    isValid = false;
                                                                                                }

                                                                                                if (!signedByRenter) {
                                                                                                    event.preventDefault();
                                                                                                    showToast('Bạn cần xác nhận đồng ý với hợp đồng thuê nhà');
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

                                                                                                // Clear signature
                                                                                                clearSignature();

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
                                                                                            existingToasts.forEach(t => {
                                                                                                if (document.body.contains(t)) {
                                                                                                    document.body.removeChild(t);
                                                                                                }
                                                                                            });

                                                                                            // Create toast container
                                                                                            const toastContainer = document.createElement('div');
                                                                                            toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
                                                                                            toastContainer.style.zIndex = '9999';

                                                                                            // Create toast HTML
                                                                                            const isSuccess = message.toLowerCase().includes('thành công') ||
                                                                                                    message.toLowerCase().includes('hoàn tất') ||
                                                                                                    message.toLowerCase().includes('gửi thành công');

                                                                                            const toastClass = isSuccess ? 'text-bg-success' : 'text-bg-danger';
                                                                                            const iconClass = isSuccess ? 'fas fa-check-circle' : 'fas fa-exclamation-triangle';

                                                                                            const toastContent = `
                        <div class="toast show ` + toastClass +`" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="toast-header">
                                <i class="` + iconClass +` me-2"></i>
                                <strong class="me-auto">Thông báo</strong>
                                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                            </div>
                            <div class="toast-body">
            ` + message +`
                            </div>
                        </div>
                    `;

                                                                                            toastContainer.innerHTML = toastContent;
                                                                                            document.body.appendChild(toastContainer);

                                                                                            // Initialize Bootstrap toast if available
                                                                                            const toastElement = toastContainer.querySelector('.toast');
                                                                                            if (toastElement) {
                                                                                                if (typeof bootstrap !== 'undefined' && bootstrap.Toast) {
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

                                                                                                    bsToast.show();
                                                                                                } else {
                                                                                                    // Fallback: auto-hide after 5 seconds
                                                                                                    setTimeout(() => {
                                                                                                        if (document.body.contains(toastContainer)) {
                                                                                                            toastContainer.style.transition = 'opacity 0.3s ease-out';
                                                                                                            toastContainer.style.opacity = '0';
                                                                                                            setTimeout(() => {
                                                                                                                if (document.body.contains(toastContainer)) {
                                                                                                                    document.body.removeChild(toastContainer);
                                                                                                                }
                                                                                                            }, 300);
                                                                                                        }
                                                                                                    }, 5000);

                                                                                                    // Handle close button for fallback
                                                                                                    const closeButton = toastElement.querySelector('.btn-close');
                                                                                                    if (closeButton) {
                                                                                                        closeButton.addEventListener('click', () => {
                                                                                                            toastContainer.style.transition = 'opacity 0.3s ease-out';
                                                                                                            toastContainer.style.opacity = '0';
                                                                                                            setTimeout(() => {
                                                                                                                if (document.body.contains(toastContainer)) {
                                                                                                                    document.body.removeChild(toastContainer);
                                                                                                                }
                                                                                                            }, 300);
                                                                                                        });
                                                                                                    }
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
