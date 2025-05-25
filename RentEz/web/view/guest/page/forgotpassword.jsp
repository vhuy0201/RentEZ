<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - RentEz</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Vietnamese Fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .forgot-password-container {
            max-width: 500px;
            margin: 100px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            color: #0d6efd;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-primary {
            width: 100%;
            padding: 12px;
            font-weight: bold;
        }
        .alert {
            margin-bottom: 20px;
        }
        .back-to-login {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>    <div class="container">
        <div class="forgot-password-container">
            <h2 class="form-title">Quên mật khẩu</h2>
            
            <c:if test="${not empty message}">
                <div class="alert alert-${messageType}" role="alert">
                    ${message}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">                <div class="form-group">
                    <label for="email" class="form-label">Nhập địa chỉ email của bạn</label>
                    <input type="email" class="form-control" id="email" name="email" required
                           placeholder="Nhập email đã liên kết với tài khoản của bạn">
                    <small class="form-text text-muted">Chúng tôi sẽ gửi một liên kết đặt lại mật khẩu đến email này.</small>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane me-2"></i>Gửi liên kết đặt lại
                </button>
            </form>
              <div class="back-to-login">
                <a href="${pageContext.request.contextPath}/view/guest/page/login.jsp">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại đăng nhập
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
