<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Kết quả tìm kiếm</title>

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
            .empty-results {
                text-align: center;
                padding: 40px 0;
                background-color: #f8f9fa;
                border-radius: 8px;
                margin: 20px 0;
            }
            .empty-results i {
                font-size: 48px;
                color: #6c757d;
                margin-bottom: 20px;
            }
            .empty-results h4 {
                margin-bottom: 15px;
                color: #343a40;
            }
            .empty-results p {
                color: #6c757d;
                max-width: 500px;
                margin: 0 auto;
            }
            
            /* Price input styling */
            .price-input-group {
                position: relative;
            }
            
            .price-input-group input[type="number"] {
                padding-right: 35px;
            }
            
            .price-input-group::after {
                content: "₫";
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                font-weight: 500;
                pointer-events: none;
                z-index: 2;
            }
            
            .price-input-group input:focus::after {
                color: #007bff;
            }
            
            /* Validation styling */
            input[name="minPrice"]:invalid,
            input[name="maxPrice"]:invalid {
                border-color: #dc3545 !important;
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
            }
            
            /* Price formatting tooltip */
            input[name="minPrice"][title],
            input[name="maxPrice"][title] {
                position: relative;
            }
            
            /* Responsive adjustments for price inputs */
            @media (max-width: 768px) {
                .property-filter .row > div {
                    margin-bottom: 15px;
                }
                
                .property-filter input[type="number"] {
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body class="">
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
                                    <h2 class="breadcrumb__title">Danh sách phòng trọ</h2>
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
                                            <i class="fas fa-angle-right"></i>
                                        </li>
                                        <li class="breadcrumb__item">
                                            <span class="breadcrumb__item-text">
                                                Danh sách phòng trọ
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="property bg-gray-100 padding-y-120">
                    <div class="container container-two">
                        <div class="property-filter__bottom flx-between gap-2 mb-4">
                            <span class="property-filter__text font-18 text-gray-800"
                                  >Tìm thấy ${resultCount} kết quả</span
                            >
                            <div class="d-flex align-items-center gap-2">
                                <div class="list-grid d-flex align-items-center gap-2 me-4">
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="property-filter__text font-18 text-gray-800">
                                        Sắp xếp:
                                    </span>
                                    <div class="select-has-icon data-sort">
                                        <select
                                            class="form-select common-input pill text-gray-800 px-3 py-2"
                                            >
                                            <option value="All">Tất cả</option>
                                            <option value="Newest">Mới nhất</option>
                                            <option value="High Price">Giá cao đến thấp</option>
                                            <option value="Low Price">Giá thấp đến cao</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row gy-4">
                            <div class="col-lg-8">                <div
                                    class="list-grid-item-wrapper property-item-wrapper row gy-4"
                                    >
                                    <c:if test="${empty searchResults}">
                                        <div class="col-12">
                                            <div class="empty-results">
                                                <i class="fas fa-search"></i>
                                                <h4>Không tìm thấy kết quả nào</h4>
                                                <p>Không tìm thấy phòng trọ nào phù hợp với tiêu chí tìm kiếm của bạn. Vui lòng thử lại với từ khóa khác hoặc mở rộng phạm vi tìm kiếm.</p>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:forEach items="${searchResults}" var="property">
                                        <div class="col-sm-6">
                                            <div
                                                class="property-item property-item style-two style-shaped"
                                                >                                                <div class="property-item__thumb">
                                                    <a
                                                        class="link"
                                                        href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}"
                                                        ><img
                                                            src="${not empty property.avatar ? property.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/property-placeholder.png')}"
                                                            alt="${property.title}"
                                                            class="cover-img" /></a
                                                    ><span class="property-item__badge">Cho thuê</span>
                                                </div>
                                                <div class="property-item__content">
                                                    <h6 class="property-item__price">
                                                       <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="đ" maxFractionDigits="10000" />
                                                        <span class="day">/tháng</span>
                                                    </h6>                                                    <h6 class="property-item__title">
                                                        <a
                                                            class="link"
                                                            href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}"
                                                            >${property.title}
                                                        </a>
                                                    </h6>
                                                    <p class="property-item__location d-flex gap-2">
                                                        <span class="icon text-gradient">
                                                            <i class="fas fa-map-marker-alt"></i></span
                                                        >${locations[property.locationId].address}, ${locations[property.locationId].city}
                                                    </p>
                                                    <div class="property-item__bottom flx-between gap-2">
                                                        <ul class="amenities-list flx-align">
                                                            <li class="amenities-list__item flx-align">
                                                                <span class="icon text-gradient"
                                                                      ><i class="fas fa-bed"></i></span
                                                                ><span class="text">${property.numberOfBedrooms} Phòng ngủ</span>
                                                            </li>
                                                            <li class="amenities-list__item flx-align">
                                                                <span class="icon text-gradient"
                                                                      ><i class="fas fa-bath"></i></span
                                                                ><span class="text">${property.numberOfBathrooms} Phòng tắm</span>
                                                            </li>
                                                        </ul>
                                                    </div>                                                    <div class="property-item__bottom flx-between gap-2 mb-2">
                                                        <ul class="amenities-list flx-align">
                                                            <li class="amenities-list__item flx-align">
                                                                <span class="icon text-gradient"
                                                                      ><i class="fas fa-home"></i></span
                                                                ><span class="text">${propertyTypes[property.typeId].typeName}</span>
                                                            </li>
                                                            <li class="amenities-list__item flx-align">
                                                                <span class="icon text-gradient"
                                                                      ><i class="fas fa-ruler-combined"></i></span
                                                                ><span class="text">${property.size} m²</span>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                    
                                                    <!-- Action buttons row -->
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <a
                                                            class="simple-btn text-gradient fw-semibold"
                                                            href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}"
                                                            >Xem chi tiết<span class="icon-right">
                                                                <i class="fas fa-arrow-right"></i> </span
                                                            ></a>
                                                        
                                                        <!-- Favorite button -->
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user != null}">
                                                                <c:choose>
                                                                    <c:when test="${userFavorites.contains(property.propertyId)}">                                                                        <button type="button" onclick="toggleFavorite('${property.propertyId}', false)" 
                                                                                class="btn btn-outline-danger btn-sm favorite-btn" 
                                                                                style="border-radius: 20px;">
                                                                            <i class="fas fa-heart"></i>
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>                                                                        <button type="button" onclick="toggleFavorite('${property.propertyId}', true)" 
                                                                                class="btn btn-outline-secondary btn-sm favorite-btn" 
                                                                                style="border-radius: 20px;">
                                                                            <i class="far fa-heart"></i>
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" onclick="redirectToLogin()" 
                                                                        class="btn btn-outline-secondary btn-sm" 
                                                                        style="border-radius: 20px;">
                                                                    <i class="far fa-heart"></i>
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="col-lg-4 ps-lg-5">                <div class="search-sidebar">
                                    <form
                                        action="${pageContext.request.contextPath}/search"
                                        method="get"
                                        >
                                        <!-- Từ khóa tìm kiếm -->
                                        <div class="search-sidebar__item">
                                            <h6 class="search-sidebar__title mb-4">
                                                <i class="fas fa-search me-2 text-gradient"></i>Từ khóa tìm kiếm
                                            </h6>
                                            <div class="position-relative">
                                                <input
                                                    type="text"
                                                    class="common-input text-gray-800"
                                                    placeholder="Nhập từ khóa..."
                                                    name="searchKeyword"
                                                    value="${searchKeyword}"
                                                    />
                                            </div>
                                        </div>
                                        <div class="search-sidebar__item">
                                            <h6 class="search-sidebar__title mb-4">
                                                <i class="fas fa-home me-2 text-gradient"></i>Loại phòng
                                            </h6>
                                            <div class="common-check">
                                                <input
                                                    class="form-check-input"
                                                    type="radio"
                                                    name="roomType"
                                                    id="roomType_all"
                                                    value="all"
                                                    ${selectedRoomType == 'all' || empty selectedRoomType ? 'checked' : ''}
                                                    />
                                                <label class="form-check-label" for="roomType_all">
                                                    Tất cả loại phòng
                                                </label>
                                            </div>
                                            <c:forEach items="${allPropertyTypes}" var="type">
                                                <div class="common-check">
                                                    <input
                                                        class="form-check-input"
                                                        type="radio"
                                                        name="roomType"
                                                        id="roomType_${type.typeId}"
                                                        value="${type.typeName}"
                                                        ${selectedRoomType == type.typeName ? 'checked' : ''}
                                                        />
                                                    <label class="form-check-label" for="roomType_${type.typeId}">
                                                        ${type.typeName}
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="search-sidebar__item">
                                            <h6 class="search-sidebar__title mb-4">
                                                <i class="fas fa-map-marker-alt me-2 text-gradient"></i>Khu vực
                                            </h6>
                                            <div class="common-radio">
                                                <input
                                                    class="form-check-input"
                                                    type="radio"
                                                    name="location"
                                                    id="location_all"
                                                    value="all"
                                                    ${selectedLocation == 'all' || empty selectedLocation ? 'checked' : ''}
                                                    />
                                                <label class="form-check-label" for="location_all">
                                                    Tất cả khu vực
                                                </label>
                                            </div>
                                            <c:forEach items="${allCities}" var="city" varStatus="status">
                                                <div class="common-radio">
                                                    <input
                                                        class="form-check-input"
                                                        type="radio"
                                                        name="location"
                                                        id="location_${status.index}"
                                                        value="${city}"
                                                        ${selectedLocation == city ? 'checked' : ''}
                                                        />
                                                    <label class="form-check-label" for="location_${status.index}">
                                                        ${city}
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="search-sidebar__item">
                                            <h6 class="search-sidebar__title mb-4">
                                                <i class="fas fa-money-bill-wave me-2 text-gradient"></i>Mức giá tùy chỉnh
                                            </h6>
                                            <div class="row g-3">
                                                <div class="col-6">
                                                    <label class="form-label small text-muted">Giá từ (VNĐ)</label>
                                                    <input
                                                        type="number"
                                                        class="form-control common-input"
                                                        placeholder="1,000,000"
                                                        name="minPrice"
                                                        value="${selectedMinPrice != null ? selectedMinPrice : ''}"
                                                        min="0"
                                                        step="100000"
                                                        />
                                                </div>
                                                <div class="col-6">
                                                    <label class="form-label small text-muted">Giá đến (VNĐ)</label>
                                                    <input
                                                        type="number"
                                                        class="form-control common-input"
                                                        placeholder="5,000,000"
                                                        name="maxPrice"
                                                        value="${selectedMaxPrice != null ? selectedMaxPrice : ''}"
                                                        min="0"
                                                        step="100000"
                                                        />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="search-sidebar__item">
                                            <h6 class="search-sidebar__title mb-4">
                                                <i class="fas fa-filter me-2 text-gradient"></i>Lọc nhanh theo giá
                                            </h6>
                                            <div class="common-check">
                                                <input
                                                    class="form-check-input price-filter"
                                                    type="checkbox"
                                                    id="lowPrice"
                                                    data-min="0"
                                                    data-max="2000000"
                                                    /><label class="form-check-label" for="lowPrice"
                                                    >Dưới 2 triệu/tháng</label
                                                >
                                            </div>
                                            <div class="common-check">
                                                <input
                                                    class="form-check-input price-filter"
                                                    type="checkbox"
                                                    id="midPrice"
                                                    data-min="2000000"
                                                    data-max="5000000"
                                                    /><label class="form-check-label" for="midPrice"
                                                    >2 - 5 triệu/tháng</label
                                                >
                                            </div>
                                            <div class="common-check">
                                                <input
                                                    class="form-check-input price-filter"
                                                    type="checkbox"
                                                    id="highPrice"
                                                    data-min="5000000"
                                                    data-max=""
                                                    /><label class="form-check-label" for="highPrice"
                                                    >Trên 5 triệu/tháng</label
                                                >
                                            </div>
                                        </div>

                                        <div class="search-sidebar__item">
                                            <button type="submit" class="btn btn-main w-100 mb-3">
                                                <i class="fas fa-search me-2"></i>Tìm kiếm
                                            </button>
                                            <button type="button" class="btn btn-outline-secondary w-100" onclick="clearFilters()">
                                                <i class="fas fa-times me-2"></i>Xóa bộ lọc
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>            <nav aria-label="Page navigation example">
                            <ul class="pagination common-pagination">
                                <c:if test="${not empty searchResults}">
                                    <li class="page-item active">
                                        <a
                                            class="page-link"
                                            href="${pageContext.request.contextPath}/search?page=1&searchKeyword=${searchKeyword}&roomType=${selectedRoomType}&location=${selectedLocation}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}"
                                            >1</a
                                        >
                                    </li>
                                    <c:if test="${resultCount > 10}">
                                        <li class="page-item">
                                            <a
                                                class="page-link"
                                                href="${pageContext.request.contextPath}/search?page=2&searchKeyword=${searchKeyword}&roomType=${selectedRoomType}&location=${selectedLocation}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}"
                                                >2</a
                                            >
                                        </li>
                                    </c:if>
                                    <c:if test="${resultCount > 20}">
                                        <li class="page-item">
                                            <a
                                                class="page-link"
                                                href="${pageContext.request.contextPath}/search?page=3&searchKeyword=${searchKeyword}&roomType=${selectedRoomType}&location=${selectedLocation}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}"
                                                >3</a
                                            >
                                        </li>
                                    </c:if>
                                    <c:if test="${resultCount > 30}">
                                        <li class="page-item">
                                            <a
                                                class="page-link"
                                                href="${pageContext.request.contextPath}/search?page=4&searchKeyword=${searchKeyword}&roomType=${selectedRoomType}&location=${selectedLocation}&minPrice=${selectedMinPrice}&maxPrice=${selectedMaxPrice}"
                                                >4</a
                                            >
                                        </li>
                                    </c:if>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </section>
                <jsp:include page="/view/common/footer.jsp" />
            </main>
            <div class="scrollToTop" style="visibility: hidden">
                <i class="fas fa-chevron-up text-gradient"></i>
            </div>
        </div>        <!-- Bootstrap Bundle Js -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        
        <script>
            // Favorite functionality
            function toggleFavorite(propertyId, isAdd) {
                const favoriteBtn = event.target.closest('.favorite-btn');
                const originalHtml = favoriteBtn.innerHTML;
                
                // Show loading state
                favoriteBtn.disabled = true;
                favoriteBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                
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

            // Price validation and formatting
            document.addEventListener('DOMContentLoaded', function() {
                const minPriceInput = document.querySelector('input[name="minPrice"]');
                const maxPriceInput = document.querySelector('input[name="maxPrice"]');
                
                // Validate price inputs
                function validatePrices() {
                    const minPrice = parseFloat(minPriceInput.value) || 0;
                    const maxPrice = parseFloat(maxPriceInput.value) || 0;
                    
                    if (minPrice > 0 && maxPrice > 0 && minPrice > maxPrice) {
                        maxPriceInput.setCustomValidity('Giá tối đa phải lớn hơn giá tối thiểu');
                        minPriceInput.setCustomValidity('Giá tối thiểu phải nhỏ hơn giá tối đa');
                    } else {
                        maxPriceInput.setCustomValidity('');
                        minPriceInput.setCustomValidity('');
                    }
                }
                
                if (minPriceInput && maxPriceInput) {
                    minPriceInput.addEventListener('change', validatePrices);
                    maxPriceInput.addEventListener('change', validatePrices);
                    
                    // Format price display with thousands separator
                    function formatPrice(input) {
                        let value = input.value.replace(/\D/g, '');
                        if (value) {
                            // Add thousands separator for display in placeholder
                            const formattedValue = new Intl.NumberFormat('vi-VN').format(parseInt(value));
                            input.setAttribute('title', formattedValue + ' ₫');
                        }
                    }
                    
                    minPriceInput.addEventListener('input', function() { formatPrice(this); });
                    maxPriceInput.addEventListener('input', function() { formatPrice(this); });
                }

                // Price filter checkboxes functionality
                const priceFilters = document.querySelectorAll('.price-filter');
                priceFilters.forEach(filter => {
                    filter.addEventListener('change', function() {
                        if (this.checked) {
                            // Uncheck other price filters
                            priceFilters.forEach(other => {
                                if (other !== this) other.checked = false;
                            });
                            
                            // Set min and max price inputs
                            const minPrice = this.getAttribute('data-min');
                            const maxPrice = this.getAttribute('data-max');
                            
                            if (minPriceInput) minPriceInput.value = minPrice;
                            if (maxPriceInput && maxPrice) maxPriceInput.value = maxPrice;
                        }
                    });
                });
            });

            // Clear filters function
            function clearFilters() {
                const form = document.querySelector('.search-sidebar form');
                if (form) {
                    // Reset all form inputs
                    form.reset();
                    // Redirect to search page without parameters
                    window.location.href = '${pageContext.request.contextPath}/search';
                }
            }
        </script>
    </body>
    <ddict-div style="visibility: visible !important"
               ><template shadowrootmode="open"
        ><style>
                *,
                :before,
                :after {
                    box-sizing: border-box;
                    border-width: 0;
                    border-style: solid;
                    border-color: #e5e7eb;
                }
                :before,
                :after {
                    --tw-content: "";
                }
                html,
                :host {
                    line-height: 1.5;
                    -webkit-text-size-adjust: 100%;
                    -moz-tab-size: 4;
                    -o-tab-size: 4;
                    tab-size: 4;
                    font-family: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji",
                        "Segoe UI Emoji", Segoe UI Symbol, "Noto Color Emoji";
                    font-feature-settings: normal;
                    font-variation-settings: normal;
                    -webkit-tap-highlight-color: transparent;
                }
                body {
                    margin: 0;
                    line-height: inherit;
                }
                hr {
                    height: 0;
                    color: inherit;
                    border-top-width: 1px;
                }
                abbr:where([title]) {
                    -webkit-text-decoration: underline dotted;
                    text-decoration: underline dotted;
                }
                h1,
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: inherit;
                    font-weight: inherit;
                }
                a {
                    color: inherit;
                    text-decoration: inherit;
                }
                b,
                strong {
                    font-weight: bolder;
                }
                code,
                kbd,
                samp,
                pre {
                    font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,
                        Liberation Mono, Courier New, monospace;
                    font-feature-settings: normal;
                    font-variation-settings: normal;
                    font-size: 1em;
                }
                small {
                    font-size: 80%;
                }
                sub,
                sup {
                    font-size: 75%;
                    line-height: 0;
                    position: relative;
                    vertical-align: baseline;
                }
                sub {
                    bottom: -0.25em;
                }
                sup {
                    top: -0.5em;
                }
                table {
                    text-indent: 0;
                    border-color: inherit;
                    border-collapse: collapse;
                }
                button,
                input,
                optgroup,
                select,
                textarea {
                    font-family: inherit;
                    font-feature-settings: inherit;
                    font-variation-settings: inherit;
                    font-size: 100%;
                    font-weight: inherit;
                    line-height: inherit;
                    letter-spacing: inherit;
                    color: inherit;
                    margin: 0;
                    padding: 0;
                }
                button,
                select {
                    text-transform: none;
                }
                button,
                input:where([type="button"]),
                input:where([type="reset"]),
                input:where([type="submit"]) {
                    -webkit-appearance: button;
                    background-color: transparent;
                    background-image: none;
                }
                :-moz-focusring {
                    outline: auto;
                }
                :-moz-ui-invalid {
                    box-shadow: none;
                }
                progress {
                    vertical-align: baseline;
                }
                ::-webkit-inner-spin-button,
                ::-webkit-outer-spin-button {
                    height: auto;
                }
                [type="search"] {
                    -webkit-appearance: textfield;
                    outline-offset: -2px;
                }
                ::-webkit-search-decoration {
                    -webkit-appearance: none;
                }
                ::-webkit-file-upload-button {
                    -webkit-appearance: button;
                    font: inherit;
                }
                summary {
                    display: list-item;
                }
                blockquote,
                dl,
                dd,
                h1,
                h2,
                h3,
                h4,
                h5,
                h6,
                hr,
                figure,
                p,
                pre {
                    margin: 0;
                }
                fieldset {
                    margin: 0;
                    padding: 0;
                }
                legend {
                    padding: 0;
                }
                ol,
                ul,
                menu {
                    list-style: none;
                    margin: 0;
                    padding: 0;
                }
                dialog {
                    padding: 0;
                }
                textarea {
                    resize: vertical;
                }
                input::-moz-placeholder,
                textarea::-moz-placeholder {
                    opacity: 1;
                    color: #9ca3af;
                }
                input::placeholder,
                textarea::placeholder {
                    opacity: 1;
                    color: #9ca3af;
                }
                button,
                [role="button"] {
                    cursor: pointer;
                }
                :disabled {
                    cursor: default;
                }
                img,
                svg,
                video,
                canvas,
                audio,
                iframe,
                embed,
                object {
                    display: block;
                    vertical-align: middle;
                }
                img,
                video {
                    max-width: 100%;
                    height: auto;
                }
                [hidden] {
                    display: none;
                }
                :root,
                [data-theme] {
                    background-color: var(--fallback-b1, oklch(var(--b1) / 1));
                    color: var(--fallback-bc, oklch(var(--bc) / 1));
                }
                @supports not (color: oklch(0% 0 0)) {
                    :root {
                        color-scheme: light;
                        --fallback-p: #491eff;
                        --fallback-pc: #d4dbff;
                        --fallback-s: #ff41c7;
                        --fallback-sc: #fff9fc;
                        --fallback-a: #00cfbd;
                        --fallback-ac: #00100d;
                        --fallback-n: #2b3440;
                        --fallback-nc: #d7dde4;
                        --fallback-b1: #ffffff;
                        --fallback-b2: #e5e6e6;
                        --fallback-b3: #e5e6e6;
                        --fallback-bc: #1f2937;
                        --fallback-in: #00b3f0;
                        --fallback-inc: #000000;
                        --fallback-su: #00ca92;
                        --fallback-suc: #000000;
                        --fallback-wa: #ffc22d;
                        --fallback-wac: #000000;
                        --fallback-er: #ff6f70;
                        --fallback-erc: #000000;
                    }
                    @media (prefers-color-scheme: dark) {
                        :root {
                            color-scheme: dark;
                            --fallback-p: #7582ff;
                            --fallback-pc: #050617;
                            --fallback-s: #ff71cf;
                            --fallback-sc: #190211;
                            --fallback-a: #00c7b5;
                            --fallback-ac: #000e0c;
                            --fallback-n: #2a323c;
                            --fallback-nc: #a6adbb;
                            --fallback-b1: #1d232a;
                            --fallback-b2: #191e24;
                            --fallback-b3: #15191e;
                            --fallback-bc: #a6adbb;
                            --fallback-in: #00b3f0;
                            --fallback-inc: #000000;
                            --fallback-su: #00ca92;
                            --fallback-suc: #000000;
                            --fallback-wa: #ffc22d;
                            --fallback-wac: #000000;
                            --fallback-er: #ff6f70;
                            --fallback-erc: #000000;
                        }
                    }
                }
                html {
                    -webkit-tap-highlight-color: transparent;
                }
                * {
                    scrollbar-color: color-mix(in oklch, currentColor 35%, transparent)
                        transparent;
                }
                *:hover {
                    scrollbar-color: color-mix(in oklch, currentColor 60%, transparent)
                        transparent;
                }
                :root {
                    color-scheme: light;
                    --in: 72.06% 0.191 231.6;
                    --su: 64.8% 0.15 160;
                    --wa: 84.71% 0.199 83.87;
                    --er: 71.76% 0.221 22.18;
                    --pc: 89.824% 0.06192 275.75;
                    --ac: 15.352% 0.0368 183.61;
                    --inc: 0% 0 0;
                    --suc: 0% 0 0;
                    --wac: 0% 0 0;
                    --erc: 0% 0 0;
                    --rounded-box: 1rem;
                    --rounded-btn: 0.5rem;
                    --rounded-badge: 1.9rem;
                    --animation-btn: 0.25s;
                    --animation-input: 0.2s;
                    --btn-focus-scale: 0.95;
                    --border-btn: 1px;
                    --tab-border: 1px;
                    --tab-radius: 0.5rem;
                    --p: 49.12% 0.3096 275.75;
                    --s: 69.71% 0.329 342.55;
                    --sc: 98.71% 0.0106 342.55;
                    --a: 76.76% 0.184 183.61;
                    --n: 32.1785% 0.02476 255.701624;
                    --nc: 89.4994% 0.011585 252.096176;
                    --b1: 100% 0 0;
                    --b2: 96.1151% 0 0;
                    --b3: 92.4169% 0.00108 197.137559;
                    --bc: 27.8078% 0.029596 256.847952;
                }
                @media (prefers-color-scheme: dark) {
                    :root {
                        color-scheme: dark;
                        --in: 72.06% 0.191 231.6;
                        --su: 64.8% 0.15 160;
                        --wa: 84.71% 0.199 83.87;
                        --er: 71.76% 0.221 22.18;
                        --pc: 13.138% 0.0392 275.75;
                        --sc: 14.96% 0.052 342.55;
                        --ac: 14.902% 0.0334 183.61;
                        --inc: 0% 0 0;
                        --suc: 0% 0 0;
                        --wac: 0% 0 0;
                        --erc: 0% 0 0;
                        --rounded-box: 1rem;
                        --rounded-btn: 0.5rem;
                        --rounded-badge: 1.9rem;
                        --animation-btn: 0.25s;
                        --animation-input: 0.2s;
                        --btn-focus-scale: 0.95;
                        --border-btn: 1px;
                        --tab-border: 1px;
                        --tab-radius: 0.5rem;
                        --p: 65.69% 0.196 275.75;
                        --s: 74.8% 0.26 342.55;
                        --a: 74.51% 0.167 183.61;
                        --n: 31.3815% 0.021108 254.139175;
                        --nc: 74.6477% 0.0216 264.435964;
                        --b1: 25.3267% 0.015896 252.417568;
                        --b2: 23.2607% 0.013807 253.100675;
                        --b3: 21.1484% 0.01165 254.087939;
                        --bc: 74.6477% 0.0216 264.435964;
                    }
                }
                [data-theme="light"] {
                    color-scheme: light;
                    --in: 72.06% 0.191 231.6;
                    --su: 64.8% 0.15 160;
                    --wa: 84.71% 0.199 83.87;
                    --er: 71.76% 0.221 22.18;
                    --pc: 89.824% 0.06192 275.75;
                    --ac: 15.352% 0.0368 183.61;
                    --inc: 0% 0 0;
                    --suc: 0% 0 0;
                    --wac: 0% 0 0;
                    --erc: 0% 0 0;
                    --rounded-box: 1rem;
                    --rounded-btn: 0.5rem;
                    --rounded-badge: 1.9rem;
                    --animation-btn: 0.25s;
                    --animation-input: 0.2s;
                    --btn-focus-scale: 0.95;
                    --border-btn: 1px;
                    --tab-border: 1px;
                    --tab-radius: 0.5rem;
                    --p: 49.12% 0.3096 275.75;
                    --s: 69.71% 0.329 342.55;
                    --sc: 98.71% 0.0106 342.55;
                    --a: 76.76% 0.184 183.61;
                    --n: 32.1785% 0.02476 255.701624;
                    --nc: 89.4994% 0.011585 252.096176;
                    --b1: 100% 0 0;
                    --b2: 96.1151% 0 0;
                    --b3: 92.4169% 0.00108 197.137559;
                    --bc: 27.8078% 0.029596 256.847952;
                }
                [data-theme="dark"] {
                    color-scheme: dark;
                    --in: 72.06% 0.191 231.6;
                    --su: 64.8% 0.15 160;
                    --wa: 84.71% 0.199 83.87;
                    --er: 71.76% 0.221 22.18;
                    --pc: 13.138% 0.0392 275.75;
                    --sc: 14.96% 0.052 342.55;
                    --ac: 14.902% 0.0334 183.61;
                    --inc: 0% 0 0;
                    --suc: 0% 0 0;
                    --wac: 0% 0 0;
                    --erc: 0% 0 0;
                    --rounded-box: 1rem;
                    --rounded-btn: 0.5rem;
                    --rounded-badge: 1.9rem;
                    --animation-btn: 0.25s;
                    --animation-input: 0.2s;
                    --btn-focus-scale: 0.95;
                    --border-btn: 1px;
                    --tab-border: 1px;
                    --tab-radius: 0.5rem;
                    --p: 65.69% 0.196 275.75;
                    --s: 74.8% 0.26 342.55;
                    --a: 74.51% 0.167 183.61;
                    --n: 31.3815% 0.021108 254.139175;
                    --nc: 74.6477% 0.0216 264.435964;
                    --b1: 25.3267% 0.015896 252.417568;
                    --b2: 23.2607% 0.013807 253.100675;
                    --b3: 21.1484% 0.01165 254.087939;
                    --bc: 74.6477% 0.0216 264.435964;
                }
                *,
                :before,
                :after {
                    --tw-border-spacing-x: 0;
                    --tw-border-spacing-y: 0;
                    --tw-translate-x: 0;
                    --tw-translate-y: 0;
                    --tw-rotate: 0;
                    --tw-skew-x: 0;
                    --tw-skew-y: 0;
                    --tw-scale-x: 1;
                    --tw-scale-y: 1;
                    --tw-pan-x: ;
                    --tw-pan-y: ;
                    --tw-pinch-zoom: ;
                    --tw-scroll-snap-strictness: proximity;
                    --tw-gradient-from-position: ;
                    --tw-gradient-via-position: ;
                    --tw-gradient-to-position: ;
                    --tw-ordinal: ;
                    --tw-slashed-zero: ;
                    --tw-numeric-figure: ;
                    --tw-numeric-spacing: ;
                    --tw-numeric-fraction: ;
                    --tw-ring-inset: ;
                    --tw-ring-offset-width: 0px;
                    --tw-ring-offset-color: #fff;
                    --tw-ring-color: rgb(59 130 246 / 0.5);
                    --tw-ring-offset-shadow: 0 0 #0000;
                    --tw-ring-shadow: 0 0 #0000;
                    --tw-shadow: 0 0 #0000;
                    --tw-shadow-colored: 0 0 #0000;
                    --tw-blur: ;
                    --tw-brightness: ;
                    --tw-contrast: ;
                    --tw-grayscale: ;
                    --tw-hue-rotate: ;
                    --tw-invert: ;
                    --tw-saturate: ;
                    --tw-sepia: ;
                    --tw-drop-shadow: ;
                    --tw-backdrop-blur: ;
                    --tw-backdrop-brightness: ;
                    --tw-backdrop-contrast: ;
                    --tw-backdrop-grayscale: ;
                    --tw-backdrop-hue-rotate: ;
                    --tw-backdrop-invert: ;
                    --tw-backdrop-opacity: ;
                    --tw-backdrop-saturate: ;
                    --tw-backdrop-sepia: ;
                    --tw-contain-size: ;
                    --tw-contain-layout: ;
                    --tw-contain-paint: ;
                    --tw-contain-style: ;
                }
                ::backdrop {
                    --tw-border-spacing-x: 0;
                    --tw-border-spacing-y: 0;
                    --tw-translate-x: 0;
                    --tw-translate-y: 0;
                    --tw-rotate: 0;
                    --tw-skew-x: 0;
                    --tw-skew-y: 0;
                    --tw-scale-x: 1;
                    --tw-scale-y: 1;
                    --tw-pan-x: ;
                    --tw-pan-y: ;
                    --tw-pinch-zoom: ;
                    --tw-scroll-snap-strictness: proximity;
                    --tw-gradient-from-position: ;
                    --tw-gradient-via-position: ;
                    --tw-gradient-to-position: ;
                    --tw-ordinal: ;
                    --tw-slashed-zero: ;
                    --tw-numeric-figure: ;
                    --tw-numeric-spacing: ;
                    --tw-numeric-fraction: ;
                    --tw-ring-inset: ;
                    --tw-ring-offset-width: 0px;
                    --tw-ring-offset-color: #fff;
                    --tw-ring-color: rgb(59 130 246 / 0.5);
                    --tw-ring-offset-shadow: 0 0 #0000;
                    --tw-ring-shadow: 0 0 #0000;
                    --tw-shadow: 0 0 #0000;
                    --tw-shadow-colored: 0 0 #0000;
                    --tw-blur: ;
                    --tw-brightness: ;
                    --tw-contrast: ;
                    --tw-grayscale: ;
                    --tw-hue-rotate: ;
                    --tw-invert: ;
                    --tw-saturate: ;
                    --tw-sepia: ;
                    --tw-drop-shadow: ;
                    --tw-backdrop-blur: ;
                    --tw-backdrop-brightness: ;
                    --tw-backdrop-contrast: ;
                    --tw-backdrop-grayscale: ;
                    --tw-backdrop-hue-rotate: ;
                    --tw-backdrop-invert: ;
                    --tw-backdrop-opacity: ;
                    --tw-backdrop-saturate: ;
                    --tw-backdrop-sepia: ;
                    --tw-contain-size: ;
                    --tw-contain-layout: ;
                    --tw-contain-paint: ;
                    --tw-contain-style: ;
                }
                .avatar.placeholder > div {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                @media (hover: hover) {
                    .link-hover:hover {
                        text-decoration-line: underline;
                    }
                    .label a:hover {
                        --tw-text-opacity: 1;
                        color: var(
                            --fallback-bc,
                            oklch(var(--bc) / var(--tw-text-opacity))
                            );
                    }
                }
                .btn {
                    display: inline-flex;
                    height: 3rem;
                    min-height: 3rem;
                    flex-shrink: 0;
                    cursor: pointer;
                    -webkit-user-select: none;
                    -moz-user-select: none;
                    user-select: none;
                    flex-wrap: wrap;
                    align-items: center;
                    justify-content: center;
                    border-radius: var(--rounded-btn, 0.5rem);
                    border-color: transparent;
                    border-color: oklch(
                        var(--btn-color, var(--b2)) / var(--tw-border-opacity)
                        );
                    padding-left: 1rem;
                    padding-right: 1rem;
                    text-align: center;
                    font-size: 0.875rem;
                    line-height: 1em;
                    gap: 0.5rem;
                    font-weight: 600;
                    text-decoration-line: none;
                    transition-duration: 0.2s;
                    transition-timing-function: cubic-bezier(0, 0, 0.2, 1);
                    border-width: var(--border-btn, 1px);
                    transition-property: color, background-color, border-color, opacity,
                        box-shadow, transform;
                    --tw-text-opacity: 1;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                    --tw-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
                    --tw-shadow-colored: 0 1px 2px 0 var(--tw-shadow-color);
                    box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
                        var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
                    outline-color: var(--fallback-bc, oklch(var(--bc) / 1));
                    background-color: oklch(
                        var(--btn-color, var(--b2)) / var(--tw-bg-opacity)
                        );
                    --tw-bg-opacity: 1;
                    --tw-border-opacity: 1;
                }
                .btn-disabled,
                .btn[disabled],
                .btn:disabled {
                    pointer-events: none;
                }
                .btn-circle {
                    height: 3rem;
                    width: 3rem;
                    border-radius: 9999px;
                    padding: 0;
                }
                :where(.btn:is(input[type="checkbox"])),
                :where(.btn:is(input[type="radio"])) {
                    width: auto;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                }
                .btn:is(input[type="checkbox"]):after,
                .btn:is(input[type="radio"]):after {
                    --tw-content: attr(aria-label);
                    content: var(--tw-content);
                }
                .card {
                    position: relative;
                    display: flex;
                    flex-direction: column;
                    border-radius: var(--rounded-box, 1rem);
                }
                .card:focus {
                    outline: 2px solid transparent;
                    outline-offset: 2px;
                }
                .card-body {
                    display: flex;
                    flex: 1 1 auto;
                    flex-direction: column;
                    padding: var(--padding-card, 2rem);
                    gap: 0.5rem;
                }
                .card-body :where(p) {
                    flex-grow: 1;
                }
                .card figure {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .card.image-full {
                    display: grid;
                }
                .card.image-full:before {
                    position: relative;
                    content: "";
                    z-index: 10;
                    border-radius: var(--rounded-box, 1rem);
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-n,
                        oklch(var(--n) / var(--tw-bg-opacity))
                        );
                    opacity: 0.75;
                }
                .card.image-full:before,
                .card.image-full > * {
                    grid-column-start: 1;
                    grid-row-start: 1;
                }
                .card.image-full > figure img {
                    height: 100%;
                    -o-object-fit: cover;
                    object-fit: cover;
                }
                .card.image-full > .card-body {
                    position: relative;
                    z-index: 20;
                    --tw-text-opacity: 1;
                    color: var(--fallback-nc, oklch(var(--nc) / var(--tw-text-opacity)));
                }
                @media (hover: hover) {
                    .btm-nav > *.\!disabled:hover {
                        pointer-events: none !important;
                        --tw-border-opacity: 0 !important;
                        background-color: var(
                            --fallback-n,
                            oklch(var(--n) / var(--tw-bg-opacity))
                            ) !important;
                        --tw-bg-opacity: 0.1 !important;
                        color: var(
                            --fallback-bc,
                            oklch(var(--bc) / var(--tw-text-opacity))
                            ) !important;
                        --tw-text-opacity: 0.2 !important;
                    }
                    .btm-nav > *.disabled:hover,
                    .btm-nav > *[disabled]:hover {
                        pointer-events: none;
                        --tw-border-opacity: 0;
                        background-color: var(
                            --fallback-n,
                            oklch(var(--n) / var(--tw-bg-opacity))
                            );
                        --tw-bg-opacity: 0.1;
                        color: var(
                            --fallback-bc,
                            oklch(var(--bc) / var(--tw-text-opacity))
                            );
                        --tw-text-opacity: 0.2;
                    }
                    .btn:hover {
                        --tw-border-opacity: 1;
                        border-color: var(
                            --fallback-b3,
                            oklch(var(--b3) / var(--tw-border-opacity))
                            );
                        --tw-bg-opacity: 1;
                        background-color: var(
                            --fallback-b3,
                            oklch(var(--b3) / var(--tw-bg-opacity))
                            );
                    }
                    @supports (color: color-mix(in oklab, black, black)) {
                        .btn:hover {
                            background-color: color-mix(
                                in oklab,
                                oklch(var(--btn-color, var(--b2)) / var(--tw-bg-opacity, 1)) 90%,
                                black
                                );
                            border-color: color-mix(
                                in oklab,
                                oklch(var(--btn-color, var(--b2)) / var(--tw-border-opacity, 1))
                                90%,
                                black
                                );
                        }
                    }
                    @supports not (color: oklch(0% 0 0)) {
                        .btn:hover {
                            background-color: var(--btn-color, var(--fallback-b2));
                            border-color: var(--btn-color, var(--fallback-b2));
                        }
                    }
                    .btn.glass:hover {
                        --glass-opacity: 25%;
                        --glass-border-opacity: 15%;
                    }
                    .btn-ghost:hover {
                        border-color: transparent;
                    }
                    @supports (color: oklch(0% 0 0)) {
                        .btn-ghost:hover {
                            background-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                        }
                    }
                    .btn-outline.btn-primary:hover {
                        --tw-text-opacity: 1;
                        color: var(
                            --fallback-pc,
                            oklch(var(--pc) / var(--tw-text-opacity))
                            );
                    }
                    @supports (color: color-mix(in oklab, black, black)) {
                        .btn-outline.btn-primary:hover {
                            background-color: color-mix(
                                in oklab,
                                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                                black
                                );
                            border-color: color-mix(
                                in oklab,
                                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                                black
                                );
                        }
                    }
                    .btn-disabled:hover,
                    .btn[disabled]:hover,
                    .btn:disabled:hover {
                        --tw-border-opacity: 0;
                        background-color: var(
                            --fallback-n,
                            oklch(var(--n) / var(--tw-bg-opacity))
                            );
                        --tw-bg-opacity: 0.2;
                        color: var(
                            --fallback-bc,
                            oklch(var(--bc) / var(--tw-text-opacity))
                            );
                        --tw-text-opacity: 0.2;
                    }
                    @supports (color: color-mix(in oklab, black, black)) {
                        .btn:is(input[type="checkbox"]:checked):hover,
                            .btn:is(input[type="radio"]:checked):hover {
                            background-color: color-mix(
                                in oklab,
                                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                                black
                                );
                            border-color: color-mix(
                                in oklab,
                                var(--fallback-p, oklch(var(--p) / 1)) 90%,
                                black
                                );
                        }
                    }
                }
                .form-control {
                    display: flex;
                    flex-direction: column;
                }
                .label {
                    display: flex;
                    -webkit-user-select: none;
                    -moz-user-select: none;
                    user-select: none;
                    align-items: center;
                    justify-content: space-between;
                    padding: 0.5rem 0.25rem;
                }
                .hero {
                    display: grid;
                    width: 100%;
                    place-items: center;
                    background-size: cover;
                    background-position: center;
                }
                .hero > * {
                    grid-column-start: 1;
                    grid-row-start: 1;
                }
                .hero-content {
                    z-index: 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    max-width: 80rem;
                    gap: 1rem;
                    padding: 1rem;
                }
                .input {
                    flex-shrink: 1;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                    height: 3rem;
                    padding-left: 1rem;
                    padding-right: 1rem;
                    font-size: 1rem;
                    line-height: 2;
                    line-height: 1.5rem;
                    border-radius: var(--rounded-btn, 0.5rem);
                    border-width: 1px;
                    border-color: transparent;
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-b1,
                        oklch(var(--b1) / var(--tw-bg-opacity))
                        );
                }
                .input[type="number"]::-webkit-inner-spin-button,
                .input-md[type="number"]::-webkit-inner-spin-button {
                    margin-top: -1rem;
                    margin-bottom: -1rem;
                    margin-inline-end: -1rem;
                }
                .join {
                    display: inline-flex;
                    align-items: stretch;
                    border-radius: var(--rounded-btn, 0.5rem);
                }
                .join :where(.join-item) {
                    border-start-end-radius: 0;
                    border-end-end-radius: 0;
                    border-end-start-radius: 0;
                    border-start-start-radius: 0;
                }
                .join .join-item:not(:first-child):not(:last-child),
                .join *:not(:first-child):not(:last-child) .join-item {
                    border-start-end-radius: 0;
                    border-end-end-radius: 0;
                    border-end-start-radius: 0;
                    border-start-start-radius: 0;
                }
                .join .join-item:first-child:not(:last-child),
                .join *:first-child:not(:last-child) .join-item {
                    border-start-end-radius: 0;
                    border-end-end-radius: 0;
                }
                .join .dropdown .join-item:first-child:not(:last-child),
                .join *:first-child:not(:last-child) .dropdown .join-item {
                    border-start-end-radius: inherit;
                    border-end-end-radius: inherit;
                }
                .join :where(.join-item:first-child:not(:last-child)),
                .join :where(*:first-child:not(:last-child) .join-item) {
                    border-end-start-radius: inherit;
                    border-start-start-radius: inherit;
                }
                .join .join-item:last-child:not(:first-child),
                .join *:last-child:not(:first-child) .join-item {
                    border-end-start-radius: 0;
                    border-start-start-radius: 0;
                }
                .join :where(.join-item:last-child:not(:first-child)),
                .join :where(*:last-child:not(:first-child) .join-item) {
                    border-start-end-radius: inherit;
                    border-end-end-radius: inherit;
                }
                @supports not selector(:has(*)) {
                    :where(.join *) {
                        border-radius: inherit;
                    }
                }
                @supports selector(:has(*)) {
                    :where(.join *:has(.join-item)) {
                        border-radius: inherit;
                    }
                }
                .link {
                    cursor: pointer;
                    text-decoration-line: underline;
                }
                .link-hover {
                    text-decoration-line: none;
                }
                .mask {
                    -webkit-mask-size: contain;
                    mask-size: contain;
                    -webkit-mask-repeat: no-repeat;
                    mask-repeat: no-repeat;
                    -webkit-mask-position: center;
                    mask-position: center;
                }
                .menu li.\!disabled {
                    cursor: not-allowed !important;
                    -webkit-user-select: none !important;
                    -moz-user-select: none !important;
                    user-select: none !important;
                    color: var(--fallback-bc, oklch(var(--bc) / 0.3)) !important;
                }
                .menu li.disabled {
                    cursor: not-allowed;
                    -webkit-user-select: none;
                    -moz-user-select: none;
                    user-select: none;
                    color: var(--fallback-bc, oklch(var(--bc) / 0.3));
                }
                .textarea {
                    min-height: 3rem;
                    flex-shrink: 1;
                    padding: 0.5rem 1rem;
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                    line-height: 2;
                    border-radius: var(--rounded-btn, 0.5rem);
                    border-width: 1px;
                    border-color: transparent;
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-b1,
                        oklch(var(--b1) / var(--tw-bg-opacity))
                        );
                }
                .toggle {
                    flex-shrink: 0;
                    --tglbg: var(--fallback-b1, oklch(var(--b1) / 1));
                    --handleoffset: 1.5rem;
                    --handleoffsetcalculator: calc(var(--handleoffset) * -1);
                    --togglehandleborder: 0 0;
                    height: 1.5rem;
                    width: 3rem;
                    cursor: pointer;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                    border-radius: var(--rounded-badge, 1.9rem);
                    border-width: 1px;
                    border-color: currentColor;
                    background-color: currentColor;
                    color: var(--fallback-bc, oklch(var(--bc) / 0.5));
                    transition: background,
                        box-shadow var(--animation-input, 0.2s) ease-out;
                    box-shadow: var(--handleoffsetcalculator) 0 0 2px var(--tglbg) inset,
                        0 0 0 2px var(--tglbg) inset, var(--togglehandleborder);
                }
                .btm-nav > *.\!disabled {
                    pointer-events: none !important;
                    --tw-border-opacity: 0 !important;
                    background-color: var(
                        --fallback-n,
                        oklch(var(--n) / var(--tw-bg-opacity))
                        ) !important;
                    --tw-bg-opacity: 0.1 !important;
                    color: var(
                        --fallback-bc,
                        oklch(var(--bc) / var(--tw-text-opacity))
                        ) !important;
                    --tw-text-opacity: 0.2 !important;
                }
                .btm-nav > *.disabled,
                .btm-nav > *[disabled] {
                    pointer-events: none;
                    --tw-border-opacity: 0;
                    background-color: var(
                        --fallback-n,
                        oklch(var(--n) / var(--tw-bg-opacity))
                        );
                    --tw-bg-opacity: 0.1;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                    --tw-text-opacity: 0.2;
                }
                .btm-nav > * .label {
                    font-size: 1rem;
                    line-height: 1.5rem;
                }
                @media (prefers-reduced-motion: no-preference) {
                    .btn {
                        animation: button-pop var(--animation-btn, 0.25s) ease-out;
                    }
                }
                .btn:active:hover,
                .btn:active:focus {
                    animation: button-pop 0s ease-out;
                    transform: scale(var(--btn-focus-scale, 0.97));
                }
                @supports not (color: oklch(0% 0 0)) {
                    .btn {
                        background-color: var(--btn-color, var(--fallback-b2));
                        border-color: var(--btn-color, var(--fallback-b2));
                    }
                    .btn-primary {
                        --btn-color: var(--fallback-p);
                    }
                }
                @supports (color: color-mix(in oklab, black, black)) {
                    .btn-outline.btn-primary.btn-active {
                        background-color: color-mix(
                            in oklab,
                            var(--fallback-p, oklch(var(--p) / 1)) 90%,
                            black
                            );
                        border-color: color-mix(
                            in oklab,
                            var(--fallback-p, oklch(var(--p) / 1)) 90%,
                            black
                            );
                    }
                }
                .btn:focus-visible {
                    outline-style: solid;
                    outline-width: 2px;
                    outline-offset: 2px;
                }
                .btn-primary {
                    --tw-text-opacity: 1;
                    color: var(--fallback-pc, oklch(var(--pc) / var(--tw-text-opacity)));
                    outline-color: var(--fallback-p, oklch(var(--p) / 1));
                }
                @supports (color: oklch(0% 0 0)) {
                    .btn-primary {
                        --btn-color: var(--p);
                    }
                }
                .btn.glass {
                    --tw-shadow: 0 0 #0000;
                    --tw-shadow-colored: 0 0 #0000;
                    box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
                        var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
                    outline-color: currentColor;
                }
                .btn.glass.btn-active {
                    --glass-opacity: 25%;
                    --glass-border-opacity: 15%;
                }
                .btn-ghost {
                    border-width: 1px;
                    border-color: transparent;
                    background-color: transparent;
                    color: currentColor;
                    --tw-shadow: 0 0 #0000;
                    --tw-shadow-colored: 0 0 #0000;
                    box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
                        var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
                    outline-color: currentColor;
                }
                .btn-ghost.btn-active {
                    border-color: transparent;
                    background-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                }
                .btn-outline.btn-primary {
                    --tw-text-opacity: 1;
                    color: var(--fallback-p, oklch(var(--p) / var(--tw-text-opacity)));
                }
                .btn-outline.btn-primary.btn-active {
                    --tw-text-opacity: 1;
                    color: var(--fallback-pc, oklch(var(--pc) / var(--tw-text-opacity)));
                }
                .btn.btn-disabled,
                .btn[disabled],
                .btn:disabled {
                    --tw-border-opacity: 0;
                    background-color: var(
                        --fallback-n,
                        oklch(var(--n) / var(--tw-bg-opacity))
                        );
                    --tw-bg-opacity: 0.2;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                    --tw-text-opacity: 0.2;
                }
                .btn:is(input[type="checkbox"]:checked),
                .btn:is(input[type="radio"]:checked) {
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-p,
                        oklch(var(--p) / var(--tw-border-opacity))
                        );
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-p,
                        oklch(var(--p) / var(--tw-bg-opacity))
                        );
                    --tw-text-opacity: 1;
                    color: var(--fallback-pc, oklch(var(--pc) / var(--tw-text-opacity)));
                }
                .btn:is(input[type="checkbox"]:checked):focus-visible,
                .btn:is(input[type="radio"]:checked):focus-visible {
                    outline-color: var(--fallback-p, oklch(var(--p) / 1));
                }
                @keyframes button-pop {
                    0% {
                        transform: scale(var(--btn-focus-scale, 0.98));
                    }
                    40% {
                        transform: scale(1.02);
                    }
                    to {
                        transform: scale(1);
                    }
                }
                .card :where(figure:first-child) {
                    overflow: hidden;
                    border-start-start-radius: inherit;
                    border-start-end-radius: inherit;
                    border-end-start-radius: unset;
                    border-end-end-radius: unset;
                }
                .card :where(figure:last-child) {
                    overflow: hidden;
                    border-start-start-radius: unset;
                    border-start-end-radius: unset;
                    border-end-start-radius: inherit;
                    border-end-end-radius: inherit;
                }
                .card:focus-visible {
                    outline: 2px solid currentColor;
                    outline-offset: 2px;
                }
                .card.bordered {
                    border-width: 1px;
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-b2,
                        oklch(var(--b2) / var(--tw-border-opacity))
                        );
                }
                .card.compact .card-body {
                    padding: 1rem;
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                }
                .card.image-full :where(figure) {
                    overflow: hidden;
                    border-radius: inherit;
                }
                @keyframes checkmark {
                    0% {
                        background-position-y: 5px;
                    }
                    50% {
                        background-position-y: -2px;
                    }
                    to {
                        background-position-y: 0;
                    }
                }
                .label-text {
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                    --tw-text-opacity: 1;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                }
                .label-text-alt {
                    font-size: 0.75rem;
                    line-height: 1rem;
                    --tw-text-opacity: 1;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                }
                .input input {
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-p,
                        oklch(var(--p) / var(--tw-bg-opacity))
                        );
                    background-color: transparent;
                }
                .input input:focus {
                    outline: 2px solid transparent;
                    outline-offset: 2px;
                }
                .input[list]::-webkit-calendar-picker-indicator {
                    line-height: 1em;
                }
                .input-bordered {
                    border-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                }
                .input:focus,
                .input:focus-within {
                    box-shadow: none;
                    border-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                    outline-style: solid;
                    outline-width: 2px;
                    outline-offset: 2px;
                    outline-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                }
                .input:has(> input[disabled]),
                .input-disabled,
                .input:disabled,
                .input[disabled] {
                    cursor: not-allowed;
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-b2,
                        oklch(var(--b2) / var(--tw-border-opacity))
                        );
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-b2,
                        oklch(var(--b2) / var(--tw-bg-opacity))
                        );
                    color: var(--fallback-bc, oklch(var(--bc) / 0.4));
                }
                .input:has(> input[disabled])::-moz-placeholder,
                .input-disabled::-moz-placeholder,
                .input:disabled::-moz-placeholder,
                .input[disabled]::-moz-placeholder {
                    color: var(
                        --fallback-bc,
                        oklch(var(--bc) / var(--tw-placeholder-opacity))
                        );
                    --tw-placeholder-opacity: 0.2;
                }
                .input:has(> input[disabled])::placeholder,
                .input-disabled::placeholder,
                .input:disabled::placeholder,
                .input[disabled]::placeholder {
                    color: var(
                        --fallback-bc,
                        oklch(var(--bc) / var(--tw-placeholder-opacity))
                        );
                    --tw-placeholder-opacity: 0.2;
                }
                .input:has(> input[disabled]) > input[disabled] {
                    cursor: not-allowed;
                }
                .input::-webkit-date-and-time-value {
                    text-align: inherit;
                }
                .join > :where(*:not(:first-child)) {
                    margin-top: 0;
                    margin-bottom: 0;
                    margin-inline-start: -1px;
                }
                .join > :where(*:not(:first-child)):is(.btn) {
                    margin-inline-start: calc(var(--border-btn) * -1);
                }
                .link:focus {
                    outline: 2px solid transparent;
                    outline-offset: 2px;
                }
                .link:focus-visible {
                    outline: 2px solid currentColor;
                    outline-offset: 2px;
                }
                .mockup-phone .display {
                    overflow: hidden;
                    border-radius: 40px;
                    margin-top: -25px;
                }
                .mockup-browser .mockup-browser-toolbar .input {
                    position: relative;
                    margin-left: auto;
                    margin-right: auto;
                    display: block;
                    height: 1.75rem;
                    width: 24rem;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-b2,
                        oklch(var(--b2) / var(--tw-bg-opacity))
                        );
                    padding-left: 2rem;
                    direction: ltr;
                }
                .mockup-browser .mockup-browser-toolbar .input:before {
                    content: "";
                    position: absolute;
                    left: 0.5rem;
                    top: 50%;
                    aspect-ratio: 1 / 1;
                    height: 0.75rem;
                    --tw-translate-y: -50%;
                    transform: translate(var(--tw-translate-x), var(--tw-translate-y))
                        rotate(var(--tw-rotate)) skew(var(--tw-skew-x))
                        skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x))
                        scaleY(var(--tw-scale-y));
                    border-radius: 9999px;
                    border-width: 2px;
                    border-color: currentColor;
                    opacity: 0.6;
                }
                .mockup-browser .mockup-browser-toolbar .input:after {
                    content: "";
                    position: absolute;
                    left: 1.25rem;
                    top: 50%;
                    height: 0.5rem;
                    --tw-translate-y: 25%;
                    --tw-rotate: -45deg;
                    transform: translate(var(--tw-translate-x), var(--tw-translate-y))
                        rotate(var(--tw-rotate)) skew(var(--tw-skew-x))
                        skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x))
                        scaleY(var(--tw-scale-y));
                    border-radius: 9999px;
                    border-width: 1px;
                    border-color: currentColor;
                    opacity: 0.6;
                }
                @keyframes modal-pop {
                    0% {
                        opacity: 0;
                    }
                }
                @keyframes progress-loading {
                    50% {
                        background-position-x: -115%;
                    }
                }
                @keyframes radiomark {
                    0% {
                        box-shadow: 0 0 0 12px var(--fallback-b1, oklch(var(--b1) / 1))
                            inset,
                            0 0 0 12px var(--fallback-b1, oklch(var(--b1) / 1)) inset;
                    }
                    50% {
                        box-shadow: 0 0 0 3px var(--fallback-b1, oklch(var(--b1) / 1)) inset,
                            0 0 0 3px var(--fallback-b1, oklch(var(--b1) / 1)) inset;
                    }
                    to {
                        box-shadow: 0 0 0 4px var(--fallback-b1, oklch(var(--b1) / 1)) inset,
                            0 0 0 4px var(--fallback-b1, oklch(var(--b1) / 1)) inset;
                    }
                }
                @keyframes rating-pop {
                    0% {
                        transform: translateY(-0.125em);
                    }
                    40% {
                        transform: translateY(-0.125em);
                    }
                    to {
                        transform: translateY(0);
                    }
                }
                @keyframes skeleton {
                    0% {
                        background-position: 150%;
                    }
                    to {
                        background-position: -50%;
                    }
                }
                .textarea:focus {
                    box-shadow: none;
                    border-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                    outline-style: solid;
                    outline-width: 2px;
                    outline-offset: 2px;
                    outline-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                }
                .textarea-primary {
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-p,
                        oklch(var(--p) / var(--tw-border-opacity))
                        );
                }
                .textarea-primary:focus {
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-p,
                        oklch(var(--p) / var(--tw-border-opacity))
                        );
                    outline-color: var(--fallback-p, oklch(var(--p) / 1));
                }
                .textarea-disabled,
                .textarea:disabled,
                .textarea[disabled] {
                    cursor: not-allowed;
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-b2,
                        oklch(var(--b2) / var(--tw-border-opacity))
                        );
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-b2,
                        oklch(var(--b2) / var(--tw-bg-opacity))
                        );
                    color: var(--fallback-bc, oklch(var(--bc) / 0.4));
                }
                .textarea-disabled::-moz-placeholder,
                .textarea:disabled::-moz-placeholder,
                .textarea[disabled]::-moz-placeholder {
                    color: var(
                        --fallback-bc,
                        oklch(var(--bc) / var(--tw-placeholder-opacity))
                        );
                    --tw-placeholder-opacity: 0.2;
                }
                .textarea-disabled::placeholder,
                .textarea:disabled::placeholder,
                .textarea[disabled]::placeholder {
                    color: var(
                        --fallback-bc,
                        oklch(var(--bc) / var(--tw-placeholder-opacity))
                        );
                    --tw-placeholder-opacity: 0.2;
                }
                @keyframes toast-pop {
                    0% {
                        transform: scale(0.9);
                        opacity: 0;
                    }
                    to {
                        transform: scale(1);
                        opacity: 1;
                    }
                }
                [dir="rtl"] .toggle {
                    --handleoffsetcalculator: calc(var(--handleoffset) * 1);
                }
                .toggle:focus-visible {
                    outline-style: solid;
                    outline-width: 2px;
                    outline-offset: 2px;
                    outline-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
                }
                .toggle:hover {
                    background-color: currentColor;
                }
                .toggle:checked,
                .toggle[aria-checked="true"] {
                    background-image: none;
                    --handleoffsetcalculator: var(--handleoffset);
                    --tw-text-opacity: 1;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                }
                [dir="rtl"] .toggle:checked,
                [dir="rtl"] .toggle[aria-checked="true"] {
                    --handleoffsetcalculator: calc(var(--handleoffset) * -1);
                }
                .toggle:indeterminate {
                    --tw-text-opacity: 1;
                    color: var(--fallback-bc, oklch(var(--bc) / var(--tw-text-opacity)));
                    box-shadow: calc(var(--handleoffset) / 2) 0 0 2px var(--tglbg) inset,
                        calc(var(--handleoffset) / -2) 0 0 2px var(--tglbg) inset,
                        0 0 0 2px var(--tglbg) inset;
                }
                [dir="rtl"] .toggle:indeterminate {
                    box-shadow: calc(var(--handleoffset) / 2) 0 0 2px var(--tglbg) inset,
                        calc(var(--handleoffset) / -2) 0 0 2px var(--tglbg) inset,
                        0 0 0 2px var(--tglbg) inset;
                }
                .toggle:disabled {
                    cursor: not-allowed;
                    --tw-border-opacity: 1;
                    border-color: var(
                        --fallback-bc,
                        oklch(var(--bc) / var(--tw-border-opacity))
                        );
                    background-color: transparent;
                    opacity: 0.3;
                    --togglehandleborder: 0 0 0 3px
                        var(--fallback-bc, oklch(var(--bc) / 1)) inset,
                        var(--handleoffsetcalculator) 0 0 3px
                        var(--fallback-bc, oklch(var(--bc) / 1)) inset;
                }
                .btn-xs {
                    height: 1.5rem;
                    min-height: 1.5rem;
                    padding-left: 0.5rem;
                    padding-right: 0.5rem;
                    font-size: 0.75rem;
                }
                .btn-square:where(.btn-xs) {
                    height: 1.5rem;
                    width: 1.5rem;
                    padding: 0;
                }
                .btn-circle:where(.btn-xs) {
                    height: 1.5rem;
                    width: 1.5rem;
                    border-radius: 9999px;
                    padding: 0;
                }
                .btn-circle:where(.btn-sm) {
                    height: 2rem;
                    width: 2rem;
                    border-radius: 9999px;
                    padding: 0;
                }
                .btn-circle:where(.btn-md) {
                    height: 3rem;
                    width: 3rem;
                    border-radius: 9999px;
                    padding: 0;
                }
                .btn-circle:where(.btn-lg) {
                    height: 4rem;
                    width: 4rem;
                    border-radius: 9999px;
                    padding: 0;
                }
                .join.join-vertical {
                    flex-direction: column;
                }
                .join.join-vertical .join-item:first-child:not(:last-child),
                .join.join-vertical *:first-child:not(:last-child) .join-item {
                    border-end-start-radius: 0;
                    border-end-end-radius: 0;
                    border-start-start-radius: inherit;
                    border-start-end-radius: inherit;
                }
                .join.join-vertical .join-item:last-child:not(:first-child),
                .join.join-vertical *:last-child:not(:first-child) .join-item {
                    border-start-start-radius: 0;
                    border-start-end-radius: 0;
                    border-end-start-radius: inherit;
                    border-end-end-radius: inherit;
                }
                .join.join-horizontal {
                    flex-direction: row;
                }
                .join.join-horizontal .join-item:first-child:not(:last-child),
                .join.join-horizontal *:first-child:not(:last-child) .join-item {
                    border-end-end-radius: 0;
                    border-start-end-radius: 0;
                    border-end-start-radius: inherit;
                    border-start-start-radius: inherit;
                }
                .join.join-horizontal .join-item:last-child:not(:first-child),
                .join.join-horizontal *:last-child:not(:first-child) .join-item {
                    border-end-start-radius: 0;
                    border-start-start-radius: 0;
                    border-end-end-radius: inherit;
                    border-start-end-radius: inherit;
                }
                .tooltip {
                    position: relative;
                    display: inline-block;
                    --tooltip-offset: calc(100% + 1px + var(--tooltip-tail, 0px));
                }
                .tooltip:before {
                    position: absolute;
                    pointer-events: none;
                    z-index: 1;
                    content: var(--tw-content);
                    --tw-content: attr(data-tip);
                }
                .tooltip:before,
                .tooltip-top:before {
                    transform: translate(-50%);
                    top: auto;
                    left: 50%;
                    right: auto;
                    bottom: var(--tooltip-offset);
                }
                .card-compact .card-body {
                    padding: 1rem;
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                }
                .card-normal .card-body {
                    padding: var(--padding-card, 2rem);
                    font-size: 1rem;
                    line-height: 1.5rem;
                }
                .join.join-vertical > :where(*:not(:first-child)) {
                    margin-left: 0;
                    margin-right: 0;
                    margin-top: -1px;
                }
                .join.join-vertical > :where(*:not(:first-child)):is(.btn) {
                    margin-top: calc(var(--border-btn) * -1);
                }
                .join.join-horizontal > :where(*:not(:first-child)) {
                    margin-top: 0;
                    margin-bottom: 0;
                    margin-inline-start: -1px;
                }
                .join.join-horizontal > :where(*:not(:first-child)):is(.btn) {
                    margin-inline-start: calc(var(--border-btn) * -1);
                }
                .tooltip {
                    position: relative;
                    display: inline-block;
                    text-align: center;
                    --tooltip-tail: 0.1875rem;
                    --tooltip-color: var(--fallback-n, oklch(var(--n) / 1));
                    --tooltip-text-color: var(--fallback-nc, oklch(var(--nc) / 1));
                    --tooltip-tail-offset: calc(100% + 0.0625rem - var(--tooltip-tail));
                }
                .tooltip:before,
                .tooltip:after {
                    opacity: 0;
                    transition-property: color, background-color, border-color,
                        text-decoration-color, fill, stroke, opacity, box-shadow, transform,
                        filter, -webkit-backdrop-filter;
                    transition-property: color, background-color, border-color,
                        text-decoration-color, fill, stroke, opacity, box-shadow, transform,
                        filter, backdrop-filter;
                    transition-property: color, background-color, border-color,
                        text-decoration-color, fill, stroke, opacity, box-shadow, transform,
                        filter, backdrop-filter, -webkit-backdrop-filter;
                    transition-delay: 0.1s;
                    transition-duration: 0.2s;
                    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
                }
                .tooltip:after {
                    position: absolute;
                    content: "";
                    border-style: solid;
                    border-width: var(--tooltip-tail, 0);
                    width: 0;
                    height: 0;
                    display: block;
                }
                .tooltip:before {
                    max-width: 20rem;
                    white-space: normal;
                    border-radius: 0.25rem;
                    padding: 0.25rem 0.5rem;
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                    background-color: var(--tooltip-color);
                    color: var(--tooltip-text-color);
                    width: -moz-max-content;
                    width: max-content;
                }
                .tooltip.tooltip-open:before {
                    opacity: 1;
                    transition-delay: 75ms;
                }
                .tooltip.tooltip-open:after {
                    opacity: 1;
                    transition-delay: 75ms;
                }
                .tooltip:hover:before {
                    opacity: 1;
                    transition-delay: 75ms;
                }
                .tooltip:hover:after {
                    opacity: 1;
                    transition-delay: 75ms;
                }
                .tooltip:has(:focus-visible):after,
                .tooltip:has(:focus-visible):before {
                    opacity: 1;
                    transition-delay: 75ms;
                }
                .tooltip:not([data-tip]):hover:before,
                .tooltip:not([data-tip]):hover:after {
                    visibility: hidden;
                    opacity: 0;
                }
                .tooltip:after,
                .tooltip-top:after {
                    transform: translate(-50%);
                    border-color: var(--tooltip-color) transparent transparent transparent;
                    top: auto;
                    left: 50%;
                    right: auto;
                    bottom: var(--tooltip-tail-offset);
                }
                .absolute {
                    position: absolute;
                }
                .relative {
                    position: relative;
                }
                .inset-0 {
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 0;
                }
                .z-10 {
                    z-index: 10;
                }
                .m-0 {
                    margin: 0;
                }
                .mb-1 {
                    margin-bottom: 0.25rem;
                }
                .mr-2 {
                    margin-right: 0.5rem;
                }
                .mt-2 {
                    margin-top: 0.5rem;
                }
                .mt-6 {
                    margin-top: 1.5rem;
                }
                .block {
                    display: block;
                }
                .flex {
                    display: flex;
                }
                .h-6 {
                    height: 1.5rem;
                }
                .min-h-screen {
                    min-height: 100vh;
                }
                .w-12 {
                    width: 3rem;
                }
                .w-5 {
                    width: 1.25rem;
                }
                .w-6 {
                    width: 1.5rem;
                }
                .w-full {
                    width: 100%;
                }
                .max-w-sm {
                    max-width: 24rem;
                }
                .flex-shrink-0 {
                    flex-shrink: 0;
                }
                .transform {
                    transform: translate(var(--tw-translate-x), var(--tw-translate-y))
                        rotate(var(--tw-rotate)) skew(var(--tw-skew-x))
                        skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x))
                        scaleY(var(--tw-scale-y));
                }
                @keyframes moveGradient {
                    0%,
                    to {
                        background-position: 0% 50%;
                    }
                    50% {
                        background-position: 100% 50%;
                    }
                }
                .animate-moveGradient {
                    animation: moveGradient 4s alternate infinite;
                }
                .cursor-pointer {
                    cursor: pointer;
                }
                .list-inside {
                    list-style-position: inside;
                }
                .list-outside {
                    list-style-position: outside;
                }
                .list-decimal {
                    list-style-type: decimal;
                }
                .list-disc {
                    list-style-type: disc;
                }
                .list-none {
                    list-style-type: none;
                }
                .flex-row {
                    flex-direction: row;
                }
                .flex-col {
                    flex-direction: column;
                }
                .items-center {
                    align-items: center;
                }
                .justify-start {
                    justify-content: flex-start;
                }
                .justify-end {
                    justify-content: flex-end;
                }
                .justify-center {
                    justify-content: center;
                }
                .justify-between {
                    justify-content: space-between;
                }
                .gap-1 {
                    gap: 0.25rem;
                }
                .gap-2 {
                    gap: 0.5rem;
                }
                .rounded-lg {
                    border-radius: 0.5rem;
                }
                .rounded-md {
                    border-radius: 0.375rem;
                }
                .border {
                    border-width: 1px;
                }
                .border-t {
                    border-top-width: 1px;
                }
                .border-solid {
                    border-style: solid;
                }
                .\!border-none {
                    border-style: none !important;
                }
                .border-\[\#D3D4D9\] {
                    --tw-border-opacity: 1;
                    border-color: rgb(211 212 217 / var(--tw-border-opacity));
                }
                .border-neutral-300 {
                    --tw-border-opacity: 1;
                    border-color: rgb(212 212 212 / var(--tw-border-opacity));
                }
                .\!bg-transparent {
                    background-color: transparent !important;
                }
                .\!bg-white {
                    --tw-bg-opacity: 1 !important;
                    background-color: rgb(255 255 255 / var(--tw-bg-opacity)) !important;
                }
                .bg-base-100 {
                    --tw-bg-opacity: 1;
                    background-color: var(
                        --fallback-b1,
                        oklch(var(--b1) / var(--tw-bg-opacity))
                        );
                }
                .bg-gray-100 {
                    --tw-bg-opacity: 1;
                    background-color: rgb(243 244 246 / var(--tw-bg-opacity));
                }
                .bg-white {
                    --tw-bg-opacity: 1;
                    background-color: rgb(255 255 255 / var(--tw-bg-opacity));
                }
                .bg-gradient-to-br {
                    background-image: linear-gradient(
                        to bottom right,
                        var(--tw-gradient-stops)
                        );
                }
                .from-\[\#8556f0\] {
                    --tw-gradient-from: #8556f0 var(--tw-gradient-from-position);
                    --tw-gradient-to: rgb(133 86 240 / 0) var(--tw-gradient-to-position);
                    --tw-gradient-stops: var(--tw-gradient-from), var(--tw-gradient-to);
                }
                .via-\[\#6bedd1\] {
                    --tw-gradient-to: rgb(107 237 209 / 0) var(--tw-gradient-to-position);
                    --tw-gradient-stops: var(--tw-gradient-from),
                        #6bedd1 var(--tw-gradient-via-position), var(--tw-gradient-to);
                }
                .via-\[\#d6b379\] {
                    --tw-gradient-to: rgb(214 179 121 / 0) var(--tw-gradient-to-position);
                    --tw-gradient-stops: var(--tw-gradient-from),
                        #d6b379 var(--tw-gradient-via-position), var(--tw-gradient-to);
                }
                .to-\[\#439beb\] {
                    --tw-gradient-to: #439beb var(--tw-gradient-to-position);
                }
                .bg-\[length\:300\%_300\%\] {
                    background-size: 300% 300%;
                }
                .bg-\[position\:0\%_50\%\] {
                    background-position: 0% 50%;
                }
                .p-0 {
                    padding: 0;
                }
                .p-0\.5 {
                    padding: 0.125rem;
                }
                .p-1 {
                    padding: 0.25rem;
                }
                .p-2 {
                    padding: 0.5rem;
                }
                .p-3 {
                    padding: 0.75rem;
                }
                .py-6 {
                    padding-top: 1.5rem;
                    padding-bottom: 1.5rem;
                }
                .pb-1 {
                    padding-bottom: 0.25rem;
                }
                .pt-0 {
                    padding-top: 0;
                }
                .pt-2 {
                    padding-top: 0.5rem;
                }
                .text-center {
                    text-align: center;
                }
                .text-5xl {
                    font-size: 3rem;
                    line-height: 1;
                }
                .text-base {
                    font-size: 1rem;
                    line-height: 1.5rem;
                }
                .text-sm {
                    font-size: 0.875rem;
                    line-height: 1.25rem;
                }
                .text-xs {
                    font-size: 0.75rem;
                    line-height: 1rem;
                }
                .font-bold {
                    font-weight: 700;
                }
                .font-normal {
                    font-weight: 400;
                }
                .capitalize {
                    text-transform: capitalize;
                }
                .italic {
                    font-style: italic;
                }
                .leading-6 {
                    line-height: 1.5rem;
                }
                .leading-tight {
                    line-height: 1.25;
                }
                .text-primary {
                    --tw-text-opacity: 1;
                    color: var(--fallback-p, oklch(var(--p) / var(--tw-text-opacity)));
                }
                .text-slate-400 {
                    --tw-text-opacity: 1;
                    color: rgb(148 163 184 / var(--tw-text-opacity));
                }
                .text-slate-900 {
                    --tw-text-opacity: 1;
                    color: rgb(15 23 42 / var(--tw-text-opacity));
                }
                .text-textCustom {
                    --tw-text-opacity: 1;
                    color: rgb(26 31 42 / var(--tw-text-opacity));
                }
                .opacity-100 {
                    opacity: 1;
                }
                .opacity-50 {
                    opacity: 0.5;
                }
                .\!shadow-none {
                    --tw-shadow: 0 0 #0000 !important;
                    --tw-shadow-colored: 0 0 #0000 !important;
                    box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
                        var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow) !important;
                }
                .shadow-2xl {
                    --tw-shadow: 0 25px 50px -12px rgb(0 0 0 / 0.25);
                    --tw-shadow-colored: 0 25px 50px -12px var(--tw-shadow-color);
                    box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
                        var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
                }
                .shadow-lg {
                    --tw-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1),
                        0 4px 6px -4px rgb(0 0 0 / 0.1);
                    --tw-shadow-colored: 0 10px 15px -3px var(--tw-shadow-color),
                        0 4px 6px -4px var(--tw-shadow-color);
                    box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
                        var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
                }
                .\!ring-0 {
                    --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0
                        var(--tw-ring-offset-width) var(--tw-ring-offset-color) !important;
                    --tw-ring-shadow: var(--tw-ring-inset) 0 0 0
                        calc(0px + var(--tw-ring-offset-width)) var(--tw-ring-color) !important;
                    box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow),
                        var(--tw-shadow, 0 0 #0000) !important;
                }
                body {
                    width: 200%;
                }
                .before\:\!bottom-\[100\%\]:before {
                    content: var(--tw-content);
                    bottom: 100% !important;
                }
                .before\:\!rounded-md:before {
                    content: var(--tw-content);
                    border-radius: 0.375rem !important;
                }
                .before\:\!border:before {
                    content: var(--tw-content);
                    border-width: 1px !important;
                }
                .before\:\!border-solid:before {
                    content: var(--tw-content);
                    border-style: solid !important;
                }
                .before\:\!border-gray-200:before {
                    content: var(--tw-content);
                    --tw-border-opacity: 1 !important;
                    border-color: rgb(229 231 235 / var(--tw-border-opacity)) !important;
                }
                .before\:\!bg-white:before {
                    content: var(--tw-content);
                    --tw-bg-opacity: 1 !important;
                    background-color: rgb(255 255 255 / var(--tw-bg-opacity)) !important;
                }
                .before\:\!text-textSecondary:before {
                    content: var(--tw-content);
                    --tw-text-opacity: 1 !important;
                    color: rgb(61 68 81 / var(--tw-text-opacity)) !important;
                }
                .before\:\!\[box-shadow\:0px_1px_8px_0px_\#3D44514D\]:before {
                    content: var(--tw-content);
                    box-shadow: 0 1px 8px #3d44514d !important;
                }
                .after\:\!border-transparent:after {
                    content: var(--tw-content);
                    border-color: transparent !important;
                }
                @media (min-width: 1024px) {
                    .lg\:flex-row-reverse {
                        flex-direction: row-reverse;
                    }
                    .lg\:text-left {
                        text-align: left;
                    }
                }
                .shadow-custom[data-v-a0957544] {
                    box-shadow: 0 0 2rem #0003;
                }
                </style
                ><ddict-div data-v-app=""
                ><!---->
                <div></div></ddict-div></template
                ></ddict-div>
                </html>
