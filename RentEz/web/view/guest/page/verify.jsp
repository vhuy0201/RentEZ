<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentEz - Xác thực email</title>

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

      .verification-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f5f5f5;
      }

      .verification-form {
        max-width: 500px;
        width: 100%;
        padding: 40px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }

      .verification-form h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #333;
      }

      .verification-code {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-bottom: 25px;
      }

      .verification-code input {
        width: 50px;
        height: 50px;
        text-align: center;
        font-size: 24px;
        border: 1px solid #ddd;
        border-radius: 5px;
      }

      .verification-code input:focus {
        border-color: #ffaa00;
        outline: none;
      }

      .btn-verify {
        background: var(--gradient-one);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        font-weight: bold;
        width: 100%;
        transition: all 0.3s;
      }

      .btn-verify:hover {
        opacity: 0.9;
        transform: translateY(-2px);
      }

      .resend-code {
        text-align: center;
        margin-top: 20px;
      }

      .resend-code a {
        color: #ffaa00;
        text-decoration: none;
      }

      .resend-code a:hover {
        text-decoration: underline;
      }
      
      .error-message {
        color: #ff3333;
        text-align: center;
        margin-bottom: 15px;
      }
    </style>
  </head>
  <body>
<jsp:include page="/view/common/header.jsp" />
    <section class="verification-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-8">
            <div class="verification-form">
              <h2>Xác thực email của bạn</h2>
              <p class="text-center mb-4">
                Chúng tôi đã gửi mã xác thực 6 chữ số đến email
                <strong>${email}</strong>. Vui lòng nhập mã để hoàn tất đăng ký.
              </p>
                <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
              </c:if>
              
              <c:if test="${not empty message}">
                <div class="alert alert-success text-center mb-4">${message}</div>
              </c:if>
              
              <form action="${pageContext.request.contextPath}/register" method="post">
                <input type="hidden" name="action" value="verify" />
                <input type="hidden" name="email" value="${email}" />
                
                <div class="verification-code">
                  <input type="text" maxlength="1" name="code1" autofocus required pattern="[0-9]" title="Please enter a digit" />
                  <input type="text" maxlength="1" name="code2" required pattern="[0-9]" title="Please enter a digit" />
                  <input type="text" maxlength="1" name="code3" required pattern="[0-9]" title="Please enter a digit" />
                  <input type="text" maxlength="1" name="code4" required pattern="[0-9]" title="Please enter a digit" />
                  <input type="text" maxlength="1" name="code5" required pattern="[0-9]" title="Please enter a digit" />
                  <input type="text" maxlength="1" name="code6" required pattern="[0-9]" title="Please enter a digit" />
                </div>
                
                <button type="submit" class="btn-verify">Xác nhận</button>
              </form>
              
              <div class="resend-code">
                <p>Không nhận được mã? <a href="${pageContext.request.contextPath}/register?action=resend&email=${email}">Gửi lại</a></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <jsp:include page="../../common/footer.jsp" />

    <!-- Scripts -->
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.verification-code input');
        
        // Auto-focus next input after typing
        inputs.forEach((input, index) => {
          input.addEventListener('input', function() {
            if (this.value.length === 1 && index < inputs.length - 1) {
              inputs[index + 1].focus();
            }
          });
          
          // Handle backspace to go to previous input
          input.addEventListener('keydown', function(e) {
            if (e.key === 'Backspace' && !this.value && index > 0) {
              inputs[index - 1].focus();
            }
          });
        });
      });
    </script>
  </body>
</html>
