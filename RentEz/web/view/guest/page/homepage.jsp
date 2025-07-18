<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>RentEz - Trang chủ</title>

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

        <!--    <script
          type="module"
          crossorigin=""
          src="${pageContext.request.contextPath}/view/guest/asset/js/index-Br3lXc3e.js"
        ></script>-->
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
    </head>
    <body class="">
        <div id="root">
            <main class="body-bg">
                <jsp:include page="/view/common/header.jsp" />

                <section class="banner">
                    <div class="container container-two">
                        <div class="position-relative">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="banner-inner position-relative">
                                        <div class="banner-content">                      
                                            <span
                                                class="banner-content__subtitle text-uppercase font-14"
                                                >
                                                Thuê phòng dễ dàng
                                            </span>

                                            <h1 class="banner-content__title">
                                                Tìm kiếm
                                                <span class="text-gradient">phòng cho thuê</span> lý tưởng
                                            </h1>
                                            <p class="banner-content__desc font-18">
                                                Khám phá hàng ngàn phòng cho thuê chất lượng với 
                                                giá cả phải chăng và tiện nghi đầy đủ cho mọi nhu cầu 
                                                sinh sống và học tập của bạn
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 order-lg-0 order-1">
                                    <div class="banner-thumb">
                                        <img
                                            src="${pageContext.request.contextPath}/view/guest/asset/img/banner-img-C9N0pCHn.png"
                                            alt=""
                                            /><img
                                            src="${pageContext.request.contextPath}/view/guest/asset/img/shape-triangle.png"
                                            alt=""
                                            class="shape-element one"
                                            /><img
                                            src="${pageContext.request.contextPath}/view/guest/asset/img/shape-circle.png"
                                            alt=""
                                            class="shape-element two"
                                            /><img
                                            src="${pageContext.request.contextPath}/view/guest/asset/img/shape-moon.png"
                                            alt=""
                                            class="shape-element three"
                                            />
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="react-tabs" data-rttabs="true">
                                        <ul class="common-tab nav nav-pills" role="tablist"></ul>
                                        <div
                                            class="react-tabs__tab-panel react-tabs__tab-panel--selected"
                                            role="tabpanel"
                                            id="panel:r7:0"
                                            aria-labelledby="tab:r7:0"
                                            >
                                            <div class="Toastify"></div>
                                            <!-- Update filter form -->
                                            <div class="filter">
                                                <form
                                                    action="${pageContext.request.contextPath}/search"
                                                    >
                                                    <div class="row gy-sm-4 gy-3">
                                                        <div class="col-lg-3 col-sm-6 col-xs-6">                              <input
                                                                type="text"
                                                                placeholder="Nhập từ khóa tìm kiếm"
                                                                name="searchKeyword"
                                                                id="name"
                                                                class="common-input"
                                                                value=""
                                                                />
                                                        </div>
                                                        <div class="col-lg-3 col-sm-6 col-xs-6">
                                                            <div class="select-has-icon icon-black">                                <select
                                                                    class="select common-input"
                                                                    name="roomType"
                                                                    >
                                                                    <option value="" disabled="">
                                                                        Loại phòng
                                                                    </option>
                                                                    <c:forEach items="${allPropertyTypes}" var="type">
                                                                        <option value="${type.typeName}">${type.typeName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-3 col-sm-6 col-xs-6">
                                                                <div class="select-has-icon icon-black">                                
                                                                    <select
                                                                        class="select common-input"
                                                                        name="location"
                                                                        >
                                                                        <option value="" disabled="">Khu vực</option>
                                                                        <c:forEach items="${allCities}" var="city">
                                                                            <option value="${city}">${city}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                        </div>
                                                        <div class="col-lg-3 col-sm-6 col-xs-6">                              
                                                            <button type="submit" class="btn btn-main w-100">
                                                                Tìm phòng
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                        <div
                                            class="react-tabs__tab-panel"
                                            role="tabpanel"
                                            id="panel:r7:1"
                                            aria-labelledby="tab:r7:1"
                                            ></div>
                                        <div
                                            class="react-tabs__tab-panel"
                                            role="tabpanel"
                                            id="panel:r7:2"
                                            aria-labelledby="tab:r7:2"
                                            ></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="about padding-y-120">
                    <div class="container container-two">
                        <div class="row gy-4 align-items-center">
                            <div class="col-lg-6">
                                <div class="about-thumb">
                                    <img
                                        src="${pageContext.request.contextPath}/view/guest/asset/img/about-img-Bvhtdgfl.png"
                                        alt=""
                                        />
                                    <div class="client-statistics flx-align">
                                        <span class="client-statistics__icon"
                                              ><i class="fas fa-users text-gradient"></i
                                            ></span>
                                        <div class="client-statistics__content">
                                            <h5 class="client-statistics__number statisticsCounter">
                                                <span>4,000</span>
                                            </h5>
                                            <span class="client-statistics__text fs-18"
                                                  >Khách hàng Hài lòng</span
                                            >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="about-content">
                                    <div class="section-heading style-left">
                                        <div class="section-heading__inner">
                                            <span class="section-heading__subtitle"
                                                  ><span class="text-gradient fw-semibold">
                                                    Về Chúng Tôi
                                                </span></span
                                            >
                                            <h2 class="section-heading__title">
                                                Tìm phòng dễ dàng với RentEz - Hỗ trợ sinh viên và
                                                người đi làm

                                            </h2>
                                        </div>
                                    </div>
                                    <div class="about-box d-flex">
                                        <div class="about-box__icon">
                                            <img
                                                src="${pageContext.request.contextPath}/view/guest/asset/img/about-icon-B0EE1wab.svg"
                                                alt=""
                                                />
                                        </div>
                                        <div class="about-box__content">
                                            <h6 class="about-box__title">
                                                Căn phòng Hoàn hảo Đang Chờ Bạn
                                            </h6>
                                            <p class="about-box__desc font-13">
                                                RentEz cung cấp đa dạng các loại phòng từ phòng đơn đến căn hộ mini với đầy đủ tiện nghi, phù hợp với mọi nhu cầu và ngân sách.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="about-button">
                                        <a
                                            class="btn btn-main"
                                            href="${pageContext.request.contextPath}/about"
                                            >Tìm hiểu thêm<span class="icon icon-right">
                                                <i class="fas fa-arrow-right"></i> </span
                                            ></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="property padding-y-120">
                    <div class="container container-two">
                        <div
                            class="section-heading style-left style-dark flx-between align-items-end gap-3"
                            >
                            <div class="section-heading__inner">
                                <span class="section-heading__subtitle"
                                      ><span class="text-gradient fw-semibold">
                                        Bất động sản mới nhất
                                    </span></span
                                >
                                <h2 class="section-heading__title">
                                    Khám phá các phòng cho thuê mới nhất của chúng tôi
                                </h2>
                            </div>
                            <a class="btn btn-main" href="${pageContext.request.contextPath}/search">
                                Xem thêm<span class="icon icon-right">
                                    <i class="fas fa-arrow-right"></i>
                                </span>
                            </a>
                        </div>
                        <div class="row gy-4 property-item-wrapper">
                            <c:forEach var="property" items="${featuredProperties}">
                                <div class="col-lg-4 col-sm-6">
                                    <div class="property-item">                                        <div class="property-item__thumb">
                                            <a class="link" href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}">
                                                <c:choose>
                                                    <c:when test="${not empty property.avatar}">
                                                        <img src="${pageContext.request.contextPath}/${property.avatar}" 
                                                             alt="${property.title}" class="cover-img" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/view/guest/asset/img/property-1-D5t-zcgy.png" 
                                                             alt="Hình ảnh mặc định" class="cover-img" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <c:if test="${property.priorityLevel > 0}">
                                                <span class="property-item__badge">Nổi bật</span>
                                            </c:if>
                                        </div>
                                        <div class="property-item__content">
                                            <h6 class="property-item__price">
                                                <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" groupingUsed="true"/><span class="day">/tháng</span>
                                            </h6>                                            <h6 class="property-item__title">
                                                <a class="link" href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}">
                                                    ${property.title}
                                                </a>
                                            </h6>
                                            <p class="property-item__location d-flex gap-2">
                                                <span class="icon"><i class="fas fa-map-marker-alt"></i></span>
                                                    <c:set var="location" value="${locations[property.locationId]}" />
                                                    <c:if test="${not empty location}">
                                                        ${location.address}, ${location.city}
                                                </c:if>
                                            </p>
                                            <div class="property-item__bottom flx-between gap-2">
                                                <ul class="amenities-list flx-align">
                                                    <li class="amenities-list__item flx-align">
                                                        <span class="icon"><i class="fas fa-expand"></i></span>
                                                        <span class="text">${property.size}m²</span>
                                                    </li>
                                                    <li class="amenities-list__item flx-align">
                                                        <span class="icon"><i class="fas fa-bed"></i></span>
                                                        <span class="text">${property.numberOfBedrooms} Phòng ngủ</span>
                                                    </li>
                                                    <li class="amenities-list__item flx-align">
                                                        <span class="icon"><i class="fas fa-bath"></i></span>
                                                        <span class="text">${property.numberOfBathrooms} Phòng tắm</span>
                                                    </li>
                                                </ul>                                                <a class="simple-btn" href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}">
                                                    Xem chi tiết<span class="icon-right"><i class="fas fa-arrow-right"></i></span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="text-center property__btn">
                            <a class="btn btn-main" href="${pageContext.request.contextPath}/search">
                                Xem tất cả bất động sản
                                <span class="icon icon-right">
                                    <i class="fas fa-arrow-right"></i>
                                </span>
                            </a>
                        </div>
                    </div>
                </section>
                <section class="property-type padding-y-120">
                    <div class="container container-two">
                        <div class="section-heading">
                            <div class="section-heading__inner">
                                <span class="section-heading__subtitle bg-gray-100">
                                    <span class="text-gradient fw-semibold">Loại Phòng</span>
                                </span>
                                <h2 class="section-heading__title">
                                    Hãy để chúng tôi giúp bạn tìm căn phòng phù hợp với nhu cầu
                                </h2>
                            </div>
                        </div>
                        <div class="row gy-4">
                            <div class="col-lg-4 col-sm-6 col-xs-6">
                                <div class="property-type-item">
                                    <span class="property-type-item__icon">
                                        <img
                                            src="data:image/svg+xml,%3csvg%20width=&#39;45&#39;%20height=&#39;45&#39;%20viewBox=&#39;0%200%2045%2045&#39;%20fill=&#39;none&#39;%20xmlns=&#39;http://www.w3.org/2000/svg&#39;%3e%3cpath%20d=&#39;M32.8825%2019.0836C32.7986%2019.0836%2032.7149%2019.0592%2032.6425%2019.0109L29.181%2016.7032C29.0606%2016.6229%2028.9883%2016.4879%2028.9883%2016.3432V12.1124C28.9883%2011.8734%2029.182%2011.6797%2029.421%2011.6797H32.8825C33.1215%2011.6797%2033.3152%2011.8734%2033.3152%2012.1124V18.6509C33.3152%2018.8105%2033.2274%2018.9571%2033.0867%2019.0323C33.0227%2019.0666%2032.9526%2019.0836%2032.8825%2019.0836ZM29.8537%2016.1116L32.4498%2017.8424V12.5451H29.8537V16.1116Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M36.3438%2021.199H8.65146C8.45848%2021.199%208.28878%2021.0711%208.23555%2020.8855C8.18233%2020.7%208.25849%2020.5017%208.42213%2020.3993L22.2683%2011.7454C22.4087%2011.6578%2022.5866%2011.6578%2022.727%2011.7454L36.5732%2020.3993C36.7368%2020.5017%2036.813%2020.7%2036.7598%2020.8855C36.7064%2021.0711%2036.5367%2021.199%2036.3438%2021.199ZM10.1602%2020.3336H34.8351L22.4976%2012.6227L10.1602%2020.3336Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M33.7452%2040.2398H11.2452C11.0063%2040.2398%2010.8125%2040.0461%2010.8125%2039.8071V20.7686C10.8125%2020.5297%2011.0063%2020.3359%2011.2452%2020.3359H33.7452C33.9842%2020.3359%2034.1779%2020.5297%2034.1779%2020.7686V39.8071C34.1779%2040.0461%2033.9842%2040.2398%2033.7452%2040.2398ZM11.6779%2039.3744H33.3125V21.2013H11.6779V39.3744Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M25.9573%2040.2383H19.0343C18.7953%2040.2383%2018.6016%2040.0446%2018.6016%2039.8056V29.421C18.6016%2029.182%2018.7953%2028.9883%2019.0343%2028.9883H25.9573C26.1964%2028.9883%2026.39%2029.182%2026.39%2029.421V39.8056C26.39%2040.0446%2026.1964%2040.2383%2025.9573%2040.2383ZM19.4669%2039.3729H25.5246V29.8537H19.4669V39.3729Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M36.3438%2040.2365H8.65144C8.41251%2040.2365%208.21875%2040.0428%208.21875%2039.8038C8.21875%2039.5648%208.41251%2039.3711%208.65144%2039.3711H36.3438C36.5828%2039.3711%2036.7764%2039.5648%2036.7764%2039.8038C36.7764%2040.0428%2036.5828%2040.2365%2036.3438%2040.2365Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M39.8059%2043.7007H5.1905C4.95157%2043.7007%204.75781%2043.507%204.75781%2043.268V1.72957C4.75781%201.49063%204.95157%201.29688%205.1905%201.29688H32.8828C33.1218%201.29688%2033.3155%201.49063%2033.3155%201.72957V8.21995H39.8059C40.0449%208.21995%2040.2386%208.41371%2040.2386%208.65264V43.268C40.2386%2043.507%2040.0449%2043.7007%2039.8059%2043.7007ZM5.6232%2042.8353H39.3732V9.08534H32.8828C32.6438%209.08534%2032.4501%208.89158%2032.4501%208.65264V2.16226H5.6232V42.8353Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M39.805%209.08534H32.8819C32.6429%209.08534%2032.4492%208.89158%2032.4492%208.65265V1.72957C32.4492%201.55459%2032.5546%201.39675%2032.7164%201.32977C32.8778%201.26296%2033.0642%201.29974%2033.1878%201.42358L40.1109%208.34665C40.2347%208.4704%2040.2717%208.65655%2040.2047%208.8182C40.1378%208.97994%2039.98%209.08534%2039.805%209.08534ZM33.3146%208.21996H38.7604L33.3146%202.77418V8.21996Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M29.4207%205.6232H8.65144C8.41251%205.6232%208.21875%205.42944%208.21875%205.1905C8.21875%204.95157%208.41251%204.75781%208.65144%204.75781H29.4207C29.6597%204.75781%2029.8534%204.95157%2029.8534%205.1905C29.8534%205.42944%2029.6597%205.6232%2029.4207%205.6232Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M29.4207%209.08413H8.65144C8.41251%209.08413%208.21875%208.89037%208.21875%208.65144C8.21875%208.41251%208.41251%208.21875%208.65144%208.21875H29.4207C29.6597%208.21875%2029.8534%208.41251%2029.8534%208.65144C29.8534%208.89037%2029.6597%209.08413%2029.4207%209.08413Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M17.3053%2012.5451H8.65144C8.41251%2012.5451%208.21875%2012.3513%208.21875%2012.1124C8.21875%2011.8734%208.41251%2011.6797%208.65144%2011.6797H17.3053C17.5442%2011.6797%2017.738%2011.8734%2017.738%2012.1124C17.738%2012.3513%2017.5442%2012.5451%2017.3053%2012.5451Z&#39;%20fill=&#39;white&#39;/%3e%3cpath%20d=&#39;M12.113%2016.006H8.65144C8.41251%2016.006%208.21875%2015.8122%208.21875%2015.5733C8.21875%2015.3344%208.41251%2015.1406%208.65144%2015.1406H12.113C12.3519%2015.1406%2012.5457%2015.3344%2012.5457%2015.5733C12.5457%2015.8122%2012.3519%2016.006%2012.113%2016.006Z&#39;%20fill=&#39;white&#39;/%3e%3c/svg%3e"

                                            alt=""
                                            /></span>
                                    <h6 class="property-type-item__title">Phòng cho Sinh viên</h6>
                                    <p class="property-type-item__desc font-18">
                                        Giá phải chăng, gần trường đại học, hoàn hảo cho sinh viên có ngân sách hạn chế
                                    </p>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-6">
                                <div class="property-type-item">
                                    <span class="property-type-item__icon"
                                          ><img
                                            src="${pageContext.request.contextPath}/view/guest/asset/img/property-type-icon2-BwZ63RRz.svg"
                                            alt=""
                                            /></span>
                                    <h6 class="property-type-item__title">
                                        Dịch vụ Bất động sản Chuyên nghiệp
                                    </h6>
                                    <p class="property-type-item__desc font-18">
                                        Sự hài lòng của khách hàng là yếu tố quan trọng cho doanh nghiệp vì nó dẫn đến lòng trung thành và đánh giá tích cực
                                    </p>
                                </div>
                            </div>
                            <div class="col-lg-4 col-sm-6 col-xs-6">
                                <div class="property-type-item">
                                    <span class="property-type-item__icon"
                                          ><img
                                            src="${pageContext.request.contextPath}/view/guest/asset/img/property-type-icon3-BLEs1TEV.svg"
                                            alt=""
                                            /></span>
                                    <h6 class="property-type-item__title">
                                        Tìm nhà Cao cấp
                                    </h6>
                                    <p class="property-type-item__desc font-18">
                                        Sự hài lòng của khách hàng là yếu tố quan trọng cho doanh nghiệp vì nó dẫn đến lòng trung thành và đánh giá tích cực
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="portfolio padding-t-120 padding-b-60 overflow-hidden">
                    <div class="section-heading">
                        <span class="section-heading__subtitle">
                            <span class="text-gradient fw-semibold">Danh mục Mới nhất</span>
                        </span>
                        <h2 class="section-heading__title">
                            Những lựa chọn Nhà ở & Bất động sản Tuyệt vời
                        </h2>
                    </div>
                    <div class="portfolio-wrapper">
                        <div class="slick-slider slick-initialized" dir="ltr">
                            <div class="slick-list" style="padding: 0px 50px">
                                <div
                                    class="slick-track"
                                    style="
                                    width: 7188px;
                                    opacity: 1;
                                    transform: translate3d(-2995px, 0px, 0px);
                                    transition: -webkit-transform 1500ms;
                                    "
                                    >
                                    <div
                                        data-index="-4"
                                        tabindex="-1"
                                        class="slick-slide slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio1-BxOjKKrh.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="-3"
                                        tabindex="-1"
                                        class="slick-slide slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio2-JvFDWxue.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="-2"
                                        tabindex="-1"
                                        class="slick-slide slick-center slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio3-zU6U6SCf.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="-1"
                                        tabindex="-1"
                                        class="slick-slide slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio4-DoIkziu9.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="0"
                                        class="slick-slide"
                                        tabindex="-1"
                                        aria-hidden="true"
                                        style="outline: none; width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio1-BxOjKKrh.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="1"
                                        class="slick-slide slick-active"
                                        tabindex="-1"
                                        aria-hidden="false"
                                        style="outline: none; width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio2-JvFDWxue.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="2"
                                        class="slick-slide slick-active slick-center slick-current"
                                        tabindex="-1"
                                        aria-hidden="false"
                                        style="outline: none; width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio3-zU6U6SCf.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="3"
                                        class="slick-slide slick-active"
                                        tabindex="-1"
                                        aria-hidden="false"
                                        style="outline: none; width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio4-DoIkziu9.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="4"
                                        tabindex="-1"
                                        class="slick-slide slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio1-BxOjKKrh.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="5"
                                        tabindex="-1"
                                        class="slick-slide slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio2-JvFDWxue.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="6"
                                        tabindex="-1"
                                        class="slick-slide slick-center slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio3-zU6U6SCf.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        data-index="7"
                                        tabindex="-1"
                                        class="slick-slide slick-cloned"
                                        aria-hidden="true"
                                        style="width: 599px"
                                        >
                                        <div>
                                            <div class="portfolio-item">
                                                <div class="portfolio-item__thumb">
                                                    <img
                                                        src="${pageContext.request.contextPath}/view/guest/asset/img/portfolio4-DoIkziu9.png"
                                                        alt=""
                                                        class="cover-img"
                                                        />
                                                </div>
                                                <div class="portfolio-item__content">
                                                    <a
                                                        class="btn btn-icon"
                                                        href="${pageContext.request.contextPath}/search"
                                                        ><span class="text-gradient line-height-0"
                                                           ><i class="fas fa-arrow-right"></i></span
                                                        ></a>
                                                    <div class="portfolio-item__inner">
                                                        <h6 class="portfolio-item__title">
                                                            <a
                                                                class="link"
                                                                href="${pageContext.request.contextPath}/search"
                                                                >Dịch vụ thuê ngoài</a
                                                            >
                                                        </h6>
                                                        <p class="portfolio-item__desc">
                                                            Bất động sản là một ngành công nghiệp lớn liên quan đến việc mua, bán và cho thuê các căn hộ
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button class="d-none">Trước</button><button class="d-none">Sau</button>
                    </div>
                </section>
                <jsp:include page="/view/common/footer.jsp" />
            </main>
            <div class="scrollToTop" style="visibility: hidden">
                <i class="fas fa-chevron-up text-gradient"></i>
            </div>
        </div>

        <!-- Bootstrap Bundle Js -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
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
                @supports not selector(has(*)) {
                    :where(.join *) {
                        border-radius: inherit;
                    }
                }
                @supports selector(:has(*)) {
                    :where(.join *:has(.join-item)) {
                        border-radius: inherit;
                    }
                }
                .tooltip {
                    position: relative;
                    display: inline-block;
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
