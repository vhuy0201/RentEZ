<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Lỗi</title>

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
            .error-container {
                text-align: center;
                padding: 100px 0;
            }
            .error-container .error-icon {
                font-size: 80px;
                color: #dc3545;
                margin-bottom: 30px;
            }
            .error-container h2 {
                font-size: 36px;
                margin-bottom: 20px;
                color: #343a40;
            }
            .error-container p {
                font-size: 18px;
                color: #6c757d;
                max-width: 600px;
                margin: 0 auto 30px;
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
                                    <h2 class="breadcrumb__title">Lỗi</h2>
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
                                            Lỗi
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
                            <div class="col-12">
                                <div class="error-container">
                                    <div class="error-icon">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                    <h2>Đã xảy ra lỗi</h2>
                                    <p>${errorMessage != null ? errorMessage : 'Không tìm thấy thông tin bạn yêu cầu'}</p>
                                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Quay lại trang chủ</a>
                                    <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-primary ms-2">Tìm kiếm bất động sản</a>
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
    </body>
</html>
