<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!-- Link to Vietnamese fonts -->
<link href="${pageContext.request.contextPath}/view/guest/asset/css/vietnamese-fonts.css" rel="stylesheet">

<footer class="footer footer-two padding-y-120">
  <div class="container container-two">
    <div class="row gy-5">
      <div class="col-xl-4 col-lg-6">
        <div class="footer-item">
          <div class="footer-item__logo">
            <a class="mobile-menu__logo" href="${pageContext.request.contextPath}/">
              <img src="${pageContext.request.contextPath}/view/guest/asset/img/logo-DHG6Mbuc.png" alt="RentEz Logo"/>
            </a>
          </div>          <p class="footer-item__desc">
            Tìm phòng cho thuê giá rẻ với đầy đủ tiện nghi cho sinh viên và người đi làm
          </p>
          <h6 class="footer-item__title mt-4 mt-lg-5">Liên hệ với chúng tôi</h6>
          <div class="row gy-4">
            <div class="col-6">
              <div class="contact-info d-flex gap-2">
                <span class="contact-info__icon text-gradient">
                  <i class="fas fa-map-marker-alt"></i>
                </span>
                <div class="contact-info__content">                  <span class="contact-info__text text-white">Địa chỉ</span>
                  <span class="contact-info__address text-white">123 Đường Chính, Hà Nội, Việt Nam</span>
                </div>
              </div>
            </div>
            <div class="col-6">
              <div class="contact-info d-flex gap-2">
                <span class="contact-info__icon text-gradient">
                  <i class="fas fa-phone"></i>
                </span>
                <div class="contact-info__content">                  <span class="contact-info__text text-white">Số điện thoại</span>
                  <span class="contact-info__address text-white">+84 123 456 789</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-xl-1 d-xl-block d-none"></div>
      <div class="col-xl-3 col-sm-6">
        <div class="footer-item">          <h6 class="footer-item__title">Loại phòng</h6>
          <ul class="footer-menu">
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/search?roomType=single">
                Phòng đơn
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/search?roomType=double">
                Phòng đôi
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/search?roomType=studio">
                Phòng studio
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/search?roomType=apartment">
                Căn hộ mini
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/search?roomType=shared">
                Phòng ở ghép
              </a>
            </li>
          </ul>
        </div>
      </div>
      <div class="col-xl-1 d-xl-block d-none"></div>
      <div class="col-xl-3 col-sm-6">
        <div class="footer-item">          <h6 class="footer-item__title">Liên kết nhanh</h6>
          <ul class="footer-menu">
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/about">
                Về chúng tôi
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/search">
                Tìm phòng
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/membership">
                Gói thành viên
              </a>
            </li>
            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/blog">
                Mẹo thuê phòng
              </a>
            </li>            <li class="footer-menu__item">
              <a class="footer-menu__link" href="${pageContext.request.contextPath}/contact">
                Liên hệ
              </a>
            </li>
          </ul>
          
          <h6 class="footer-item__title mt-4">Nhận thông báo</h6>
          <form action="${pageContext.request.contextPath}/subscribe" class="mt-3 subscribe-box">
            <div class="input-group">
              <input type="email" class="form-control common-input common-input--md text-white" placeholder="Địa chỉ email của bạn" />
              <button type="submit" class="px-4 input-group-text bg--gradient border-0 text-white">
                <i class="fas fa-paper-plane"></i>
              </button>
            </div>
          </form>
          <ul class="social-list">
            <li class="social-list__item">
              <a class="social-list__link flx-center" href="#"><i class="fab fa-facebook-f"></i></a>
            </li>
            <li class="social-list__item">
              <a class="social-list__link flx-center" href="#"><i class="fab fa-twitter"></i></a>
            </li>
            <li class="social-list__item">
              <a class="social-list__link flx-center" href="#"><i class="fab fa-linkedin-in"></i></a>
            </li>
            <li class="social-list__item">
              <a class="social-list__link flx-center" href="#"><i class="fab fa-instagram"></i></a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</footer>
<div class="bottom-footer">
  <div class="container container-two">
    <div class="bottom-footer__inner flx-between gap-3">      <p class="bottom-footer__text">© RentEz 2025 | Đã đăng ký bản quyền</p>
      <div class="footer-links">
        <a class="footer-link" href="${pageContext.request.contextPath}/terms">Điều khoản & Điều kiện</a>
        <a class="footer-link" href="${pageContext.request.contextPath}/privacy">Chính sách bảo mật</a>
        <a class="footer-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
      </div>
    </div>
  </div>
</div>

<style>
  .footer {
    background-color: #222;
    color: #f8f9fa;
    padding: 60px 0 20px;
    margin-top: 50px;
  }

  .footer-logo {
    margin-bottom: 20px;
  }

  .footer-heading {
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 20px;
    color: #fff;
  }

  .footer-links,
  .footer-contact-info {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .footer-links li,
  .footer-contact-info li {
    margin-bottom: 10px;
  }

  .footer-links a {
    color: #ccc;
    text-decoration: none;
    transition: color 0.3s;
  }

  .footer-links a:hover {
    color: var(--primary-color);
  }

  .footer-contact-info li {
    display: flex;
    align-items: center;
    color: #ccc;
  }

  .footer-contact-info li i {
    margin-right: 10px;
    color: var(--primary-color);
  }

  .social-links a {
    display: inline-block;
    width: 36px;
    height: 36px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    margin-right: 10px;
    text-align: center;
    line-height: 36px;
    color: #fff;
    transition: all 0.3s;
  }

  .social-links a:hover {
    background-color: var(--primary-color);
    color: #fff;
    transform: translateY(-3px);
  }

  .footer-bottom {
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    margin-top: 40px;
    padding-top: 20px;
  }

  .copyright {
    color: #aaa;
    margin: 0;
  }

  .policy-links {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    justify-content: flex-end;
    flex-wrap: wrap;
  }

  .policy-links li {
    margin-left: 20px;
  }

  .policy-links a {
    color: #aaa;
    text-decoration: none;
    font-size: 14px;
    transition: color 0.3s;
  }

  .policy-links a:hover {
    color: var(--primary-color);
  }

  @media (max-width: 768px) {
    .policy-links {
      justify-content: flex-start;
      margin-top: 10px;
    }

    .policy-links li {
      margin-left: 0;
      margin-right: 20px;
    }
  }
</style>
