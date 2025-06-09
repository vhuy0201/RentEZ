<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentEz - Đăng ký</title>

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

    <style>
      :root {
        --gradient-one: linear-gradient(135deg, #ffaa00 0%, #ffcb66 100%);
      }

      .register-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),
          url("${pageContext.request.contextPath}/view/guest/asset/img/banner-img-C9N0pCHn.png");
        background-size: cover;
        background-position: center;
        padding: 60px 0;
      }

      .register-box {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        padding: 40px;
        max-width: 600px;
        width: 100%;
        margin: 0 auto;
      }

      .register-box__title {
        font-size: 28px;
        margin-bottom: 30px;
        text-align: center;
        color: #333;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-control {
        height: 50px;
        border-radius: 5px;
      }

      .btn-register {
        height: 50px;
        border-radius: 5px;
        background: var(--gradient-one);
        border-color: #000000;
        color: #000000;
        font-weight: 600;
        width: 100%;
        margin-bottom: 15px;
        transition: all 0.3s ease;
      }

      .btn-register:hover {
        opacity: 0.9;
        transform: translateY(-2px);
        border-color: #000000;
      }

      .btn-google {
        height: 50px;
        border-radius: 5px;
        background: #fff;
        color: #000000;
        border: 1px solid #ddd;
        font-weight: 600;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
      }

      .btn-google:hover {
        background: #f1f1f1;
      }

      .google-icon {
        margin-right: 10px;
      }

      .separator {
        display: flex;
        align-items: center;
        text-align: center;
        margin: 20px 0;
      }

      .separator::before,
      .separator::after {
        content: "";
        flex: 1;
        border-bottom: 1px solid #ddd;
      }

      .separator span {
        padding: 0 10px;
        color: #777;
      }

      .text-link {
        color: var(--primary-color);
        text-decoration: none;
      }

      .text-link:hover {
        text-decoration: underline;
      }

      .footer-text {
        text-align: center;
        margin-top: 20px;
      }

      .role-select {
        margin-bottom: 20px;
      }

      .role-options {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
      }

      .role-option {
        flex: 1;
        margin: 0 5px;
        text-align: center;
      }

      .role-option input[type="radio"] {
        display: none;
      }

      .role-option label {
        display: block;
        padding: 15px 10px;
        background: #f8f9fa;
        border: 1px solid #ddd;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.3s;
      }

      .role-option input[type="radio"]:checked + label {
        background: var(--gradient-one);
        border-color: #ffaa00;
        color: #000;
        font-weight: 500;
      }

      .role-option i {
        display: block;
        font-size: 24px;
        margin-bottom: 5px;
      }

      /* General button styles fix */
      .btn {
        color: #000000 !important;
      }

      .btn-outline-light {
        color: #333 !important;
      }

      .btn-main {
        color: #000000 !important;
      }

      @media (max-width: 767px) {
        .register-box {
          padding: 20px;
        }
      }
    </style>
  </head>
  <body>
    <div id="root">
      <main class="body-bg">
        <jsp:include page="/view/common/header.jsp" />

        <section class="register-section">
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-md-8">                <div class="register-box">
                  <h2 class="register-box__title">
                    Tạo tài khoản trên
                    <span class="text-gradient">RentEz</span>
                  </h2>
                  <c:if test="${not empty error}">
                    <div
                      class="alert alert-danger alert-dismissible fade show"
                      role="alert"
                    >
                      <i class="fas fa-exclamation-circle mr-2"></i> ${error}
                      <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                      ></button>
                    </div>
                  </c:if>

                  <form
                    action="${pageContext.request.contextPath}/register"
                    method="post"
                    id="registrationForm"
                  >
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">                          <input
                            type="text"
                            class="form-control"
                            name="name"
                            placeholder="Họ và tên"
                            required
                            value="${param.name != null ? param.name : ''}"
                          />
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">                          <input
                            type="email"
                            class="form-control"
                            name="email"
                            placeholder="Địa chỉ email"
                            required
                            value="${param.email != null ? param.email : ''}"
                          />
                        </div>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">                          <input
                            type="password"
                            class="form-control"
                            id="password"
                            name="password"
                            placeholder="Mật khẩu"
                            required
                          />
                          <div
                            class="password-strength mt-1"
                            id="passwordStrength"
                          >
                            <div class="progress" style="height: 5px">
                              <div
                                class="progress-bar"
                                role="progressbar"
                                style="width: 0%"
                                aria-valuenow="0"
                                aria-valuemin="0"
                                aria-valuemax="100"
                              ></div>
                            </div>
                            <small class="text-muted" id="passwordHint"
                              >Mật khẩu phải có ít nhất 8 ký tự</small
                            >
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <input
                            type="password"
                            class="form-control"
                            name="confirmPassword"
                            id="confirmPassword"
                            placeholder="Confirm Password"
                            required
                          />
                          <small
                            class="text-danger d-none"
                            id="passwordMatchError"
                            >Passwords do not match</small
                          >
                        </div>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">                          <input
                            type="tel"
                            class="form-control"
                            name="phone"
                            placeholder="Số điện thoại"
                            required
                            value="${param.phone != null ? param.phone : ''}"
                          />
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">                          <input
                            type="text"
                            class="form-control"
                            name="address"
                            placeholder="Địa chỉ"
                            value="${param.address != null ? param.address : ''}"
                          />
                        </div>
                      </div>
                    </div>                    <div class="role-select">
                      <h6>Tôi muốn:</h6>
                      <div class="role-options">
                        <div class="role-option">
                          <input
                            type="radio"
                            id="renter"
                            name="role"
                            value="Renter"
                            checked
                          />
                          <label for="renter">
                            <i class="fas fa-home"></i>
                            Thuê bất động sản
                          </label>
                        </div>
                        <div class="role-option">
                          <input
                            type="radio"
                            id="landlord"
                            name="role"
                            value="Landlord"
                          />
                          <label for="landlord">
                            <i class="fas fa-building"></i>
                            Đăng bất động sản
                          </label>
                        </div>
                      </div>
                    </div>

                    <div class="form-group">
                      <div class="form-check">
                        <input
                          type="checkbox"
                          class="form-check-input"
                          id="terms"
                          required
                        />                        <label class="form-check-label" for="terms"
                          >Tôi đồng ý với
                          <a href="#" class="text-link">Điều khoản dịch vụ</a> và
                          <a href="#" class="text-link"
                            >Chính sách bảo mật</a
                          ></label
                        >
                      </div>
                    </div>                    <button type="submit" class="btn btn-register">
                      Tạo tài khoản
                    </button>

                    <div class="separator">
                      <span>HOẶC</span>
                    </div>

                    <a
                      href="${pageContext.request.contextPath}/login-google"
                      class="btn btn-google"
                    >
                      <svg
                        class="google-icon"
                        xmlns="http://www.w3.org/2000/svg"
                        width="18"
                        height="18"
                        viewBox="0 0 18 18"
                      >
                        <path
                          fill="#4285F4"
                          d="M17.64 9.2c0-.637-.057-1.251-.164-1.84H9v3.481h4.844c-.209 1.125-.843 2.078-1.796 2.716v2.259h2.908c1.702-1.567 2.684-3.874 2.684-6.615z"
                        ></path>
                        <path
                          fill="#34A853"
                          d="M9 18c2.43 0 4.467-.806 5.956-2.18l-2.908-2.259c-.806.54-1.837.86-3.048.86-2.344 0-4.328-1.584-5.036-3.711H.957v2.332A8.997 8.997 0 0 0 9 18z"
                        ></path>
                        <path
                          fill="#FBBC05"
                          d="M3.964 10.71A5.41 5.41 0 0 1 3.682 9c0-.593.102-1.17.282-1.71V4.958H.957A8.996 8.996 0 0 0 0 9c0 1.452.348 2.827.957 4.042l3.007-2.332z"
                        ></path>
                        <path
                          fill="#EA4335"
                          d="M9 3.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C13.463.891 11.426 0 9 0A8.997 8.997 0 0 0 .957 4.958L3.964 7.29C4.672 5.163 6.656 3.58 9 3.58z"                        ></path>
                      </svg>                      Đăng ký với Google
                    </a>

                    <div class="footer-text">
                      <p>
                        Đã có tài khoản?
                        <a
                          href="${pageContext.request.contextPath}/login"
                          class="text-link"
                          >Đăng nhập</a
                        >
                      </p>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </section>

        <footer class="footer bg-dark text-white py-4">
          <div class="container">
            <div class="row">
              <div class="col-12 text-center">
                <p>&copy; 2025 RentEz. Đã đăng ký bản quyền.</p>
              </div>
            </div>
          </div>
        </footer>
      </main>
    </div>

    <!-- JavaScript files -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
