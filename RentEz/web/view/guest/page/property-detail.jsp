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
                height: 400px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 10px;
            }
            .property-gallery .thumbnail {
                width: 100px;
                height: 75px;
                object-fit: cover;
                border-radius: 4px;
                margin-right: 10px;
                cursor: pointer;
                opacity: 0.7;
                transition: opacity 0.3s ease;
            }
            .property-gallery .thumbnail:hover, .property-gallery .thumbnail.active {
                opacity: 1;
            }
            .property-details h2 {
                margin-bottom: 20px;
                color: #343a40;
            }
            .property-details .price {
                font-size: 24px;
                font-weight: bold;
                color: #28a745;
                margin-bottom: 15px;
            }
            .property-details .features {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }
            .property-details .feature {
                background-color: #f8f9fa;
                padding: 8px 12px;
                margin-right: 10px;
                margin-bottom: 10px;
                border-radius: 4px;
                display: flex;
                align-items: center;
            }
            .property-details .feature i {
                margin-right: 5px;
                color: #6c757d;
            }
            .property-details .description {
                white-space: pre-line;
                margin-bottom: 30px;
            }
            .landlord-info {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
            }
            .landlord-info img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 20px;
            }
            .landlord-info h4 {
                margin-bottom: 10px;
            }
            .contact-form {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .location-map {
                height: 300px;
                width: 100%;
                border-radius: 8px;
                margin-bottom: 30px;
            }
            .section-title {
                margin-top: 40px;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 1px solid #dee2e6;
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
                
                <section class="padding-y-80">
                    <div class="container">
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
                                <div class="property-details">
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
                            
                            <!-- Cột bên phải: Thông tin chủ nhà và form liên hệ -->
                            <div class="col-lg-4">
                                <div class="landlord-info d-flex">
                                    <img src="${landlord.avatar != null && !landlord.avatar.isEmpty() ? landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" alt="Avatar">
                                    <div>
                                        <h4>${landlord.name}</h4>
                                        <p><i class="fa fa-phone"></i> ${landlord.phone}</p>
                                        <p><i class="fa fa-envelope"></i> ${landlord.email}</p>
                                    </div>
                                </div>
                                
                                <!-- Form liên hệ -->
                                <div class="contact-form">
                                    <h4 class="mb-4">Liên hệ với chủ nhà</h4>
                                    
                                    <c:choose>
                                        <c:when test="${empty sessionScope.user}">
                                            <div class="alert alert-info">
                                                Vui lòng <a href="${pageContext.request.contextPath}/login">đăng nhập</a> để gửi tin nhắn cho chủ nhà.
                                            </div>
                                        </c:when>
                                        <c:otherwise>                                            <form action="${pageContext.request.contextPath}/messages" method="post">
                                                <input type="hidden" name="action" value="sendMessage">
                                                <input type="hidden" name="receiverId" value="${property.landlordId}">
                                                <input type="hidden" name="propertyId" value="${property.propertyId}">
                                                
                                                <div class="mb-3">
                                                    <label for="messageContent" class="form-label">Nội dung tin nhắn</label>
                                                    <textarea class="form-control" id="messageContent" name="content" rows="4" required
                                                              placeholder="Xin chào, tôi quan tâm đến bất động sản này và muốn biết thêm thông tin."></textarea>
                                                </div>
                                                
                                                <button type="submit" class="btn btn-primary w-100">Gửi tin nhắn</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <jsp:include page="/view/common/footer.jsp" />
            </main>
        </div>
        
        <!-- Bootstrap JS và các thư viện cần thiết -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
        
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
            }
        </script>
    </body>
</html>
