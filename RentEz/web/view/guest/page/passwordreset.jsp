<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - RentEz</title>
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
        .reset-password-container {
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
        .password-requirements {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 5px;
        }
        .requirements-list {
            margin-top: 5px;
            padding-left: 20px;
        }
        .requirements-list li {
            margin-bottom: 3px;
        }
    </style>
</head>
<body>    <div class="container">
        <div class="reset-password-container">
            <h2 class="form-title">Đặt lại mật khẩu</h2>
            
            <c:if test="${not empty message}">
                <div class="alert alert-${messageType}" role="alert">
                    ${message}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/reset-password" method="post" id="resetPasswordForm">
                <input type="hidden" name="email" value="${param.email}">
                  <div class="form-group">
                    <label for="newPassword" class="form-label">Mật khẩu mới</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required
                               placeholder="Nhập mật khẩu mới của bạn">
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-requirements">
                        Mật khẩu phải có:
                        <ul class="requirements-list">
                            <li>Ít nhất 8 ký tự</li>
                            <li>Ít nhất một chữ hoa</li>
                            <li>Ít nhất một chữ thường</li>
                            <li>Ít nhất một chữ số</li>
                        </ul>
                    </div>
                </div>
                  <div class="form-group">
                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required
                               placeholder="Xác nhận mật khẩu mới của bạn">
                        <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-key me-2"></i>Đặt lại mật khẩu
                </button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('newPassword');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const icon = this.querySelector('i');
            
            if (confirmPasswordInput.type === 'password') {
                confirmPasswordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                confirmPasswordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Form validation
        document.getElementById('resetPasswordForm').addEventListener('submit', function(event) {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
              // Password validation
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
            if (!passwordRegex.test(password)) {
                alert('Mật khẩu phải có ít nhất 8 ký tự và bao gồm ít nhất một chữ hoa, một chữ thường và một chữ số.');
                event.preventDefault();
                return;
            }
            
            // Password match validation
            if (password !== confirmPassword) {
                alert('Mật khẩu không khớp!');
                event.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
