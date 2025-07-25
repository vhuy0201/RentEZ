<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu - RentEz</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            background: url('${pageContext.request.contextPath}/view/guest/asset/img/property-bg.jpg') center/cover;
            opacity: 0.1;
            z-index: 1;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            border: 1px solid #f0f0f0;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 35px;
            color: white;
        }
        
        .stats-section {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 80px 0;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        
        .stat-number {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .stat-label {
            font-size: 1.2rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .team-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            margin-bottom: 30px;
        }
        
        .team-card:hover {
            transform: translateY(-5px);
        }
        
        .team-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            font-weight: bold;
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
        
        .timeline {
            position: relative;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .timeline::after {
            content: '';
            position: absolute;
            width: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            top: 0;
            bottom: 0;
            left: 50%;
            margin-left: -2px;
        }
        
        .timeline-item {
            padding: 20px 40px;
            position: relative;
            background-color: inherit;
            width: 50%;
        }
        
        .timeline-item::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            right: -10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            top: 25px;
        }
        
        .timeline-item:nth-child(even) {
            left: 50%;
        }
        
        .timeline-item:nth-child(even)::after {
            left: -10px;
        }
        
        .timeline-content {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .mission-vision {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            padding: 80px 0;
        }
        
        .mission-card {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            height: 100%;
            text-align: center;
        }
        
        .mission-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            font-size: 3rem;
            color: white;
        }
        
        @media (max-width: 768px) {
            .timeline::after {
                left: 31px;
            }
            
            .timeline-item {
                width: 100%;
                padding-left: 70px;
                padding-right: 25px;
            }
            
            .timeline-item::after {
                left: 21px;
            }
            
            .timeline-item:nth-child(even) {
                left: 0%;
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
                                <h1 class="display-3 fw-bold mb-4">Chào mừng đến với RentEz</h1>
                                <p class="lead mb-5">Nền tảng cho thuê bất động sản hàng đầu Việt Nam, kết nối chủ nhà và người thuê một cách dễ dàng, minh bạch và hiệu quả.</p>
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="${pageContext.request.contextPath}/search" class="btn btn-light btn-lg px-4 py-3">
                                        <i class="fas fa-search me-2"></i>Tìm kiếm ngay
                                    </a>
                                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-light btn-lg px-4 py-3">
                                        <i class="fas fa-phone me-2"></i>Liên hệ
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- About Section -->
            <section class="py-5">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <h2 class="display-5 fw-bold mb-4">Về RentEz</h2>
                            <p class="lead mb-4">RentEz là nền tảng công nghệ tiên phong trong lĩnh vực cho thuê bất động sản tại Việt Nam, được thành lập với sứ mệnh tạo ra một hệ sinh thái cho thuê minh bạch, tin cậy và hiệu quả.</p>
                            
                            <div class="mb-4">
                                <h5><i class="fas fa-check-circle text-success me-2"></i>Công nghệ hiện đại</h5>
                                <p>Sử dụng các công nghệ mới nhất để mang lại trải nghiệm tối ưu cho người dùng.</p>
                            </div>
                            
                            <div class="mb-4">
                                <h5><i class="fas fa-shield-alt text-primary me-2"></i>Bảo mật an toàn</h5>
                                <p>Hệ thống bảo mật đa lớp đảm bảo thông tin cá nhân và giao dịch luôn được bảo vệ tuyệt đối.</p>
                            </div>
                            
                            <div class="mb-4">
                                <h5><i class="fas fa-handshake text-warning me-2"></i>Dịch vụ tận tâm</h5>
                                <p>Đội ngũ hỗ trợ chuyên nghiệp 24/7, luôn sẵn sàng giải đáp mọi thắc mắc của khách hàng.</p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <img src="${pageContext.request.contextPath}/view/guest/asset/img/about-image.jpg" 
                                 alt="Về RentEz" class="img-fluid rounded-3 shadow-lg"
                                 onerror="this.src='https://via.placeholder.com/600x400/667eea/ffffff?text=RentEz'">
                        </div>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="py-5 bg-light">
                <div class="container">
                    <h2 class="section-title">Tính năng nổi bật</h2>
                    <p class="section-subtitle">RentEz cung cấp giải pháp toàn diện cho việc cho thuê bất động sản với các tính năng tiên tiến và thân thiện với người dùng</p>
                    
                    <div class="row g-4">
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-search"></i>
                                </div>
                                <h4 class="mb-3">Tìm kiếm thông minh</h4>
                                <p>Hệ thống tìm kiếm AI giúp bạn tìm được căn nhà phù hợp nhất với nhu cầu và ngân sách trong vài giây.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-file-contract"></i>
                                </div>
                                <h4 class="mb-3">Hợp đồng điện tử</h4>
                                <p>Ký kết hợp đồng thuê nhà hoàn toàn trực tuyến với chữ ký số, tiết kiệm thời gian và chi phí.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-credit-card"></i>
                                </div>
                                <h4 class="mb-3">Thanh toán online</h4>
                                <p>Hệ thống thanh toán đa dạng: ví điện tử, chuyển khoản ngân hàng, thanh toán trực tiếp.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <h4 class="mb-3">Đặt lịch xem nhà</h4>
                                <p>Đặt lịch xem nhà trực tuyến, tự động gửi thông báo và nhắc nhở cho cả hai bên.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-comments"></i>
                                </div>
                                <h4 class="mb-3">Chat trực tiếp</h4>
                                <p>Hệ thống chat real-time giúp chủ nhà và người thuê giao tiếp trực tiếp, nhanh chóng.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <h4 class="mb-3">Đánh giá và phản hồi</h4>
                                <p>Hệ thống đánh giá minh bạch giúp xây dựng uy tín và niềm tin trong cộng đồng.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Stats Section -->
            <section class="stats-section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-6">
                            <div class="stat-item">
                                <div class="stat-number">10,000+</div>
                                <div class="stat-label">Bất động sản</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <div class="stat-item">
                                <div class="stat-number">50,000+</div>
                                <div class="stat-label">Người dùng</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <div class="stat-item">
                                <div class="stat-number">1,000+</div>
                                <div class="stat-label">Giao dịch/tháng</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-6">
                            <div class="stat-item">
                                <div class="stat-number">99.9%</div>
                                <div class="stat-label">Độ tin cậy</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Mission & Vision -->
            <section class="mission-vision">
                <div class="container">
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="mission-card">
                                <div class="mission-icon">
                                    <i class="fas fa-bullseye"></i>
                                </div>
                                <h3 class="mb-4">Sứ mệnh</h3>
                                <p class="mb-0">Tạo ra một nền tảng cho thuê bất động sản minh bạch, an toàn và hiệu quả, giúp kết nối chủ nhà và người thuê một cách dễ dàng nhất. Chúng tôi cam kết mang lại giá trị thực sự cho cộng đồng thông qua việc ứng dụng công nghệ hiện đại và dịch vụ chất lượng cao.</p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="mission-card">
                                <div class="mission-icon">
                                    <i class="fas fa-eye"></i>
                                </div>
                                <h3 class="mb-4">Tầm nhìn</h3>
                                <p class="mb-0">Trở thành nền tảng cho thuê bất động sản số 1 Việt Nam và mở rộng ra khu vực Đông Nam Á vào năm 2030. Chúng tôi hướng tới việc xây dựng một hệ sinh thái bất động sản hoàn chỉnh, nơi mọi giao dịch đều được thực hiện một cách thuận tiện và đáng tin cậy.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Timeline -->
            <section class="py-5">
                <div class="container">
                    <h2 class="section-title">Hành trình phát triển</h2>
                    <p class="section-subtitle">Từ những ngày đầu khởi nghiệp đến hiện tại, RentEz đã không ngừng phát triển và hoàn thiện</p>
                    
                    <div class="timeline">
                        <div class="timeline-item">
                            <div class="timeline-content">
                                <h4>2022 - Khởi nghiệp</h4>
                                <p>Ý tưởng về RentEz được hình thành từ nhu cầu thực tế của thị trường bất động sản Việt Nam. Đội ngũ sáng lập bắt đầu nghiên cứu và phát triển sản phẩm.</p>
                            </div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-content">
                                <h4>2023 - Ra mắt Beta</h4>
                                <p>Phiên bản Beta đầu tiên được ra mắt với các tính năng cơ bản: đăng tin, tìm kiếm và liên hệ. Thu hút được 1,000 người dùng đầu tiên.</p>
                            </div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-content">
                                <h4>2024 - Phát triển mạnh</h4>
                                <p>Tích hợp thêm các tính năng nâng cao: hợp đồng điện tử, thanh toán online, chat trực tiếp. Người dùng tăng lên 10,000+.</p>
                            </div>
                        </div>
                        
                        <div class="timeline-item">
                            <div class="timeline-content">
                                <h4>2025 - Hiện tại</h4>
                                <p>RentEz đã trở thành một trong những nền tảng cho thuê bất động sản hàng đầu với 50,000+ người dùng và hơn 10,000 bất động sản.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Team Section -->
            <section class="py-5 bg-light">
                <div class="container">
                    <h2 class="section-title">Đội ngũ của chúng tôi</h2>
                    <p class="section-subtitle">Những con người tài năng và tận tâm đằng sau thành công của RentEz</p>
                    
                    <div class="row g-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="team-card">
                                <div class="team-avatar">NT</div>
                                <h5 class="mb-2">Nguyễn Văn Tài</h5>
                                <p class="text-muted mb-3">CEO & Founder</p>
                                <p class="small">Với hơn 10 năm kinh nghiệm trong lĩnh vực công nghệ và bất động sản, anh Tài đã dẫn dắt RentEz từ những ngày đầu.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6">
                            <div class="team-card">
                                <div class="team-avatar">LH</div>
                                <h5 class="mb-2">Lê Thị Hương</h5>
                                <p class="text-muted mb-3">CTO</p>
                                <p class="small">Chuyên gia công nghệ với bằng Thạc sĩ Khoa học Máy tính, chịu tr책 nhiệm phát triển và duy trì hệ thống công nghệ của RentEz.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6">
                            <div class="team-card">
                                <div class="team-avatar">PD</div>
                                <h5 class="mb-2">Phạm Minh Đức</h5>
                                <p class="text-muted mb-3">Head of Marketing</p>
                                <p class="small">Có 8 năm kinh nghiệm trong marketing số, anh Đức đã giúp RentEz xây dựng thương hiệu mạnh mẽ trên thị trường.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-3 col-md-6">
                            <div class="team-card">
                                <div class="team-avatar">VM</div>
                                <h5 class="mb-2">Vũ Thị Minh</h5>
                                <p class="text-muted mb-3">Head of Customer Success</p>
                                <p class="small">Chuyên gia về trải nghiệm khách hàng, chị Minh đảm bảo mọi người dùng đều có trải nghiệm tốt nhất với RentEz.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Technology Stack -->
            <section class="py-5">
                <div class="container">
                    <h2 class="section-title">Công nghệ sử dụng</h2>
                    <p class="section-subtitle">RentEz được xây dựng trên nền tảng công nghệ hiện đại và đáng tin cậy</p>
                    
                    <div class="row g-4">
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fab fa-java"></i>
                                </div>
                                <h4 class="mb-3">Java Enterprise</h4>
                                <p>Backend mạnh mẽ được xây dựng trên Java EE với JSP, Servlet, đảm bảo hiệu suất cao và bảo mật tốt.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-database"></i>
                                </div>
                                <h4 class="mb-3">SQL Server</h4>
                                <p>Cơ sở dữ liệu Microsoft SQL Server đảm bảo tính toàn vẹn và hiệu suất xử lý dữ liệu tối ưu.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fab fa-html5"></i>
                                </div>
                                <h4 class="mb-3">Modern Frontend</h4>
                                <p>Giao diện người dùng được xây dựng với HTML5, CSS3, JavaScript và Bootstrap 5 cho trải nghiệm tối ưu.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-cloud"></i>
                                </div>
                                <h4 class="mb-3">Cloud Storage</h4>
                                <p>Sử dụng Cloudinary để lưu trữ và xử lý hình ảnh, đảm bảo tốc độ tải nhanh và chất lượng cao.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <h4 class="mb-3">Email Service</h4>
                                <p>Tích hợp JavaMail API để gửi thông báo, xác nhận và báo cáo tự động đến người dùng.</p>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <h4 class="mb-3">Security</h4>
                                <p>Hệ thống bảo mật đa lớp với mã hóa dữ liệu, xác thực người dùng và bảo vệ khỏi các cuộc tấn công.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Call to Action -->
            <section class="py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <h2 class="text-white mb-3">Sẵn sàng bắt đầu với RentEz?</h2>
                            <p class="text-white-50 mb-0">Tham gia cùng hàng ngàn người dùng đã tin tưởng và sử dụng RentEz để tìm kiếm hoặc cho thuê bất động sản.</p>
                        </div>
                        <div class="col-lg-4 text-lg-end">
                            <a href="${pageContext.request.contextPath}/search" class="btn btn-light btn-lg px-4 py-3">
                                <i class="fas fa-rocket me-2"></i>Bắt đầu ngay
                            </a>
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
    
    <!-- Smooth scroll animation -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate numbers when in viewport
            const observerOptions = {
                threshold: 0.5,
                rootMargin: '0px 0px -100px 0px'
            };

            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        animateNumber(entry.target);
                        observer.unobserve(entry.target);
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.stat-number').forEach(stat => {
                observer.observe(stat);
            });

            function animateNumber(element) {
                const finalNumber = element.textContent;
                const numericValue = parseInt(finalNumber.replace(/[^\d]/g, ''));
                const suffix = finalNumber.replace(/[\d,]/g, '');
                let currentNumber = 0;
                const increment = numericValue / 50;
                
                const timer = setInterval(() => {
                    currentNumber += increment;
                    if (currentNumber >= numericValue) {
                        element.textContent = numericValue.toLocaleString() + suffix;
                        clearInterval(timer);
                    } else {
                        element.textContent = Math.floor(currentNumber).toLocaleString() + suffix;
                    }
                }, 40);
            }
        });
    </script>
</body>
</html>
