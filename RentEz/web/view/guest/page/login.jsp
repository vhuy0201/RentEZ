<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentEz - Login</title>

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
    
    <style>
      .login-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('${pageContext.request.contextPath}/view/guest/asset/img/banner-img-C9N0pCHn.png');
        background-size: cover;
        background-position: center;
      }
      
      .login-box {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
        padding: 40px;
        max-width: 500px;
        width: 100%;
        margin: 0 auto;
      }
      
      .login-box__title {
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
        .btn-login {
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
      
      .btn-login:hover {
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
        content: '';
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
        /* Header login button style fix */
      .header-right .btn-main {
        background: var(--gradient-one);
        color: #000000;
        font-weight: 600;
        border: 2px solid #fff;
      }
        .header-right .btn-main.active {
        background: #fff;
        color: #000000;
        font-weight: 600;
      }    
      
      /* General button styles fix */
      .btn {
        color: #000000 !important; /* Override any white text color */
      }
      
      .btn-outline-light {
        color: #333 !important;
      }
      
      .btn-main {
        color: #000000 !important;
      }</style>
  </head>  <body class="">
    <div id="root">
      <main class="body-bg">
        <jsp:include page="/view/common/header.jsp" />
        
        <section class="login-section">
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-md-6">
                <div class="login-box">
                  <h2 class="login-box__title">Login to <span class="text-gradient">RentEz</span></h2>
                  
                  <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                      ${error}
                    </div>
                  </c:if>
                  
                  <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                      <input type="email" class="form-control" name="email" placeholder="Email" required>
                    </div>
                    
                    <div class="form-group">
                      <input type="password" class="form-control" name="password" placeholder="Password" required>
                    </div>
                      <div class="form-group d-flex justify-content-between align-items-center">
                      <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="remember" name="remember">
                        <label class="form-check-label" for="remember">Remember me</label>
                      </div>
                      <a href="${pageContext.request.contextPath}/forgot-password" class="text-link">Forgot password?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-login">Login</button>
                    
                    <div class="separator">
                      <span>OR</span>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/login-google" class="btn btn-google">
                      <svg class="google-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
                        <path fill="#4285F4" d="M17.64 9.2c0-.637-.057-1.251-.164-1.84H9v3.481h4.844c-.209 1.125-.843 2.078-1.796 2.716v2.259h2.908c1.702-1.567 2.684-3.874 2.684-6.615z"></path>
                        <path fill="#34A853" d="M9 18c2.43 0 4.467-.806 5.956-2.18l-2.908-2.259c-.806.54-1.837.86-3.048.86-2.344 0-4.328-1.584-5.036-3.711H.957v2.332A8.997 8.997 0 0 0 9 18z"></path>
                        <path fill="#FBBC05" d="M3.964 10.71A5.41 5.41 0 0 1 3.682 9c0-.593.102-1.17.282-1.71V4.958H.957A8.996 8.996 0 0 0 0 9c0 1.452.348 2.827.957 4.042l3.007-2.332z"></path>
                        <path fill="#EA4335" d="M9 3.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C13.463.891 11.426 0 9 0A8.997 8.997 0 0 0 .957 4.958L3.964 7.29C4.672 5.163 6.656 3.58 9 3.58z"></path>
                      </svg>
                      Login with Google
                    </a>
                    
                    <div class="footer-text">
                      <p>Don't have an account? <a href="${pageContext.request.contextPath}/view/guest/page/register.jsp" class="text-link">Register</a></p>
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
                <p>&copy; 2025 RentEz. All rights reserved.</p>
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
