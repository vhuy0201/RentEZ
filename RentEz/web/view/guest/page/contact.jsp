<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ - RentEz</title>
    <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
    <!-- Font awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
    <!-- Line awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
    <!-- Main stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />
    <!-- Vietnamese Fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css" />
    
    <style>
        .hero-section {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 120px 0 80px;
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('${pageContext.request.contextPath}/view/guest/asset/img/contact-bg.jpg') center/cover;
            opacity: 0.1;
            z-index: 1;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .contact-card {
            background: white;
            border-radius: 15px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            border: 1px solid #f0f0f0;
            margin-bottom: 30px;
        }
        
        .contact-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }
        
        .contact-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 35px;
            color: white;
        }
        
        .form-section {
            background: #f8f9fa;
            padding: 80px 0;
        }
        
        .contact-form {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px 20px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #4facfe;
            box-shadow: 0 0 0 0.25rem rgba(79, 172, 254, 0.25);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            border-radius: 10px;
            padding: 15px 40px;
            font-size: 18px;
            font-weight: 600;
            color: white;
            transition: transform 0.3s ease;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            color: white;
        }
        
        .map-section {
            height: 500px;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .faq-section {
            padding: 80px 0;
        }
        
        .faq-item {
            background: white;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .faq-header {
            padding: 25px 30px;
            cursor: pointer;
            border-bottom: 1px solid #e9ecef;
            transition: background-color 0.3s ease;
        }
        
        .faq-header:hover {
            background-color: #f8f9fa;
        }
        
        .faq-body {
            padding: 25px 30px;
            display: none;
        }
        
        .faq-icon {
            transition: transform 0.3s ease;
        }
        
        .faq-item.active .faq-icon {
            transform: rotate(180deg);
        }
        
        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }
        
        .section-subtitle {
            text-align: center;
            color: #7f8c8d;
            font-size: 1.2rem;
            margin-bottom: 60px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .office-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        
        .office-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
        }
        
        .support-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
        }
        
        .support-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .support-icon {
            width: 60px;
            height: 60px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 24px;
        }
        
        @media (max-width: 768px) {
            .contact-form {
                padding: 25px;
            }
            
            .hero-section {
                padding: 80px 0 60px;
            }
        }
    </style>
</head>
<body>
    <div id="root">
        <main>
            <!-- Header -->
            <jsp:include page="/view/common/header.jsp" />
            
            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="hero-content">
                        <div class="row align-items-center">
                            <div class="col-lg-8 mx-auto text-center">
                                <h1 class="display-3 fw-bold mb-4">Liên hệ với chúng tôi</h1>
                                <p class="lead mb-5">Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn. Hãy liên hệ với RentEz để được tư vấn tốt nhất về dịch vụ cho thuê bất động sản.</p>
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="tel:+84901234567" class="btn btn-outline-light btn-lg px-4 py-3">
                                        <i class="fas fa-phone me-2"></i>Gọi ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Map Section -->
            <section class="py-5">
                <div class="container">
                    <h2 class="section-title">Vị trí văn phòng</h2>
                    <p class="section-subtitle">Đến thăm văn phòng của chúng tôi tại Hà Nội và TP. Hồ Chí Minh</p>
                    
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="office-card">
                                <div class="office-image">
                                    <i class="fas fa-building"></i>
                                </div>
                                <h4 class="mb-3">Văn phòng Hà Nội</h4>
                                <p class="mb-3">Tầng 10, Tòa nhà FPT, Khu Công nghệ cao Hòa Lạc</p>
                                <p class="text-muted">Km29 Đại lộ Thăng Long, Thạch Thất, Hà Nội</p>
                                <div class="map-section mt-3">
                                    <iframe 
                                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.863855796743!2d105.52284341533314!3d21.012825293016085!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345b465a4e65fb%3A0x1c98c8f6b707b291!2sFPT%20University!5e0!3m2!1sen!2s!4v1641885428857!5m2!1sen!2s"
                                        width="100%" 
                                        height="300" 
                                        style="border:0;" 
                                        allowfullscreen="" 
                                        loading="lazy" 
                                        referrerpolicy="no-referrer-when-downgrade">
                                    </iframe>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-6">
                            <div class="office-card">
                                <div class="office-image">
                                    <i class="fas fa-city"></i>
                                </div>
                                <h4 class="mb-3">Văn phòng TP. HCM</h4>
                                <p class="mb-3">Tầng 15, Tòa nhà Saigon Trade Center</p>
                                <p class="text-muted">37 Tôn Đức Thắng, Quận 1, TP. Hồ Chí Minh</p>
                                <div class="map-section mt-3">
                                    <iframe 
                                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.3249428967393!2d106.70130631533626!3d10.783005792314398!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f1c06f4e1dd%3A0x43900f1d4539489d!2s37%20T%C3%B4n%20%C4%90%E1%BB%A9c%20Th%E1%BA%AFng%2C%20B%E1%BA%BFn%20Ngh%C3%A9%2C%20Qu%E1%BA%ADn%201%2C%20Th%C3%A0nh%20ph%E1%BB%91%20H%E1%BB%93%20Ch%C3%AD%20Minh%2C%20Vietnam!5e0!3m2!1sen!2s!4v1641885467891!5m2!1sen!2s"
                                        width="100%" 
                                        height="300" 
                                        style="border:0;" 
                                        allowfullscreen="" 
                                        loading="lazy" 
                                        referrerpolicy="no-referrer-when-downgrade">
                                    </iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Support Section -->
            <section class="support-section">
                <div class="container">
                    <h2 class="text-center mb-5">Các kênh hỗ trợ khác</h2>
                    
                    <div class="row g-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="support-card">
                                <div class="support-icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                <h5 class="mb-3">Tài liệu hướng dẫn</h5>
                                <p>Xem hướng dẫn chi tiết về cách sử dụng RentEz</p>
                                <a href="#" class="btn btn-outline-light btn-sm">Xem tài liệu</a>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6">
                            <div class="support-card">
                                <div class="support-icon">
                                    <i class="fas fa-video"></i>
                                </div>
                                <h5 class="mb-3">Video hướng dẫn</h5>
                                <p>Học cách sử dụng RentEz qua video trực quan</p>
                                <a href="#" class="btn btn-outline-light btn-sm">Xem video</a>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6">
                            <div class="support-card">
                                <div class="support-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h5 class="mb-3">Cộng đồng</h5>
                                <p>Tham gia cộng đồng người dùng RentEz</p>
                                <a href="#" class="btn btn-outline-light btn-sm">Tham gia</a>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6">
                            <div class="support-card">
                                <div class="support-icon">
                                    <i class="fas fa-ticket-alt"></i>
                                </div>
                                <h5 class="mb-3">Hỗ trợ ticket</h5>
                                <p>Gửi yêu cầu hỗ trợ qua hệ thống ticket</p>
                                <a href="#" class="btn btn-outline-light btn-sm">Tạo ticket</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- FAQ Section -->
            <section class="faq-section">
                <div class="container">
                    <h2 class="section-title">Câu hỏi thường gặp</h2>
                    <p class="section-subtitle">Tìm câu trả lời nhanh chóng cho những thắc mắc phổ biến</p>
                    
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="faq-item">
                                <div class="faq-header" onclick="toggleFaq(this)">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">RentEz có tính phí sử dụng không?</h5>
                                        <i class="fas fa-chevron-down faq-icon"></i>
                                    </div>
                                </div>
                                <div class="faq-body">
                                    <p>RentEz miễn phí cho người thuê nhà. Đối với chủ nhà, chúng tôi có các gói dịch vụ phù hợp với nhu cầu khác nhau, bao gồm gói miễn phí với tính năng cơ bản và các gói trả phí với tính năng nâng cao.</p>
                                </div>
                            </div>
                            
                            <div class="faq-item">
                                <div class="faq-header" onclick="toggleFaq(this)">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">Làm thế nào để đăng tin cho thuê nhà?</h5>
                                        <i class="fas fa-chevron-down faq-icon"></i>
                                    </div>
                                </div>
                                <div class="faq-body">
                                    <p>Để đăng tin cho thuê nhà, bạn cần: 1) Đăng ký tài khoản chủ nhà, 2) Đăng nhập và chọn "Đăng tin", 3) Điền thông tin chi tiết về bất động sản, 4) Tải lên hình ảnh, 5) Xác nhận và đăng tin. Tin đăng sẽ được kiểm duyệt trong vòng 24 giờ.</p>
                                </div>
                            </div>
                            
                            <div class="faq-item">
                                <div class="faq-header" onclick="toggleFaq(this)">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">RentEz có đảm bảo tính xác thực của thông tin không?</h5>
                                        <i class="fas fa-chevron-down faq-icon"></i>
                                    </div>
                                </div>
                                <div class="faq-body">
                                    <p>Chúng tôi có quy trình kiểm duyệt nghiêm ngặt cho mọi tin đăng. Đội ngũ kiểm duyệt sẽ xác minh thông tin, hình ảnh và tính hợp pháp của bất động sản. Ngoài ra, hệ thống đánh giá và phản hồi từ người dùng cũng giúp đảm bảo tính minh bạch.</p>
                                </div>
                            </div>
                            
                            <div class="faq-item">
                                <div class="faq-header" onclick="toggleFaq(this)">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">Tôi có thể thanh toán như thế nào?</h5>
                                        <i class="fas fa-chevron-down faq-icon"></i>
                                    </div>
                                </div>
                                <div class="faq-body">
                                    <p>RentEz hỗ trợ nhiều phương thức thanh toán: chuyển khoản ngân hàng, ví điện tử (Momo, ZaloPay, VNPay), thẻ tín dụng/ghi nợ, và thanh toán trực tiếp tại văn phòng. Tất cả giao dịch đều được bảo mật với công nghệ mã hóa SSL.</p>
                                </div>
                            </div>
                            
                            <div class="faq-item">
                                <div class="faq-header" onclick="toggleFaq(this)">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">Nếu gặp vấn đề, tôi có thể liên hệ ai?</h5>
                                        <i class="fas fa-chevron-down faq-icon"></i>
                                    </div>
                                </div>
                                <div class="faq-body">
                                    <p>Bạn có thể liên hệ qua: Hotline 24/7: +84 90 123 4567, Email: support@rentez.vn, Live chat trên website, hoặc đến trực tiếp văn phòng. Đội ngũ hỗ trợ của chúng tôi luôn sẵn sàng giải đáp mọi thắc mắc của bạn.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <jsp:include page="/view/common/footer.jsp" />
        </main>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // FAQ Toggle
        function toggleFaq(element) {
            const faqItem = element.closest('.faq-item');
            const faqBody = faqItem.querySelector('.faq-body');
            const faqIcon = faqItem.querySelector('.faq-icon');
            
            if (faqItem.classList.contains('active')) {
                faqItem.classList.remove('active');
                faqBody.style.display = 'none';
            } else {
                // Close all other FAQ items
                document.querySelectorAll('.faq-item.active').forEach(item => {
                    item.classList.remove('active');
                    item.querySelector('.faq-body').style.display = 'none';
                });
                
                // Open current FAQ item
                faqItem.classList.add('active');
                faqBody.style.display = 'block';
            }
        }
        
        // Contact Form Handler
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const submitBtn = document.getElementById('submitBtn');
            const submitText = document.getElementById('submitText');
            const originalText = submitText.textContent;
            
            // Disable submit button and show loading
            submitBtn.disabled = true;
            submitText.textContent = 'Đang gửi...';
            
            // Get form data
            const formData = new FormData(this);
            
            // Send AJAX request
            fetch(this.action, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Show success message
                    showNotification(data.message, 'success');
                    
                    // Reset form
                    this.reset();
                } else {
                    // Show error message
                    showNotification(data.message, 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi gửi tin nhắn. Vui lòng thử lại.', 'error');
            })
            .finally(() => {
                // Re-enable submit button
                submitBtn.disabled = false;
                submitText.textContent = originalText;
            });
        });
        
        // Show notification function
        function showNotification(message, type) {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification notification-${type}`;
            notification.innerHTML = `
                <div class="notification-content">
                    <span>${message}</span>
                    <button class="notification-close" onclick="this.parentElement.parentElement.remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;
            
            // Add styles if not already added
            if (!document.getElementById('notificationStyles')) {
                const styles = document.createElement('style');
                styles.id = 'notificationStyles';
                styles.textContent = `
                    .notification {
                        position: fixed;
                        top: 20px;
                        right: 20px;
                        z-index: 9999;
                        min-width: 300px;
                        max-width: 500px;
                        border-radius: 8px;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                        animation: slideInRight 0.3s ease-out;
                    }
                    
                    .notification-success {
                        background: #d4edda;
                        border: 1px solid #c3e6cb;
                        color: #155724;
                    }
                    
                    .notification-error {
                        background: #f8d7da;
                        border: 1px solid #f5c6cb;
                        color: #721c24;
                    }
                    
                    .notification-content {
                        padding: 15px;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }
                    
                    .notification-content i:first-child {
                        font-size: 18px;
                    }
                    
                    .notification-close {
                        background: none;
                        border: none;
                        margin-left: auto;
                        cursor: pointer;
                        padding: 5px;
                        border-radius: 3px;
                        opacity: 0.7;
                    }
                    
                    .notification-close:hover {
                        opacity: 1;
                        background: rgba(0,0,0,0.1);
                    }
                    
                    @keyframes slideInRight {
                        from {
                            transform: translateX(100%);
                            opacity: 0;
                        }
                        to {
                            transform: translateX(0);
                            opacity: 1;
                        }
                    }
                `;
                document.head.appendChild(styles);
            }
            
            // Add to page
            document.body.appendChild(notification);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 5000);
        }
        
        // Live Chat Function
        function openLiveChat() {
            // This would typically open a live chat widget
            alert('Tính năng live chat sẽ được triển khai sớm. Vui lòng liên hệ qua hotline: +84 90 123 4567');
        }
        
        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });
    </script>
</body>
</html>
