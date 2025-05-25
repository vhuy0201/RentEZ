/**
 * vietnamese-effects.js
 * Mã JavaScript để hỗ trợ các hiệu ứng cho RentEz tiếng Việt
 * Thêm hiệu ứng xuất hiện dần dần khi cuộn trang
 */

document.addEventListener('DOMContentLoaded', function() {
    // Thêm lớp fade-in-element vào các phần tử cần hiệu ứng
    const elementsToAnimate = [
        '.banner-content',
        '.section-heading',
        '.property-item',
        '.property-type-item',
        '.about-box',
        '.pricing-item',
        '.testimonial-item',
        '.feature-item',
        '.counter-item'
    ];
    
    // Thêm delay khác nhau cho từng phần tử
    elementsToAnimate.forEach((selector, index) => {
        const elements = document.querySelectorAll(selector);
        elements.forEach((el, i) => {
            el.style.opacity = '0';
            el.style.animation = 'none';
            el.style.animationDelay = `${0.1 * (i + 1)}s`;
        });
    });
    
    // Hàm kiểm tra khi phần tử xuất hiện trong viewport
    function checkIfInView() {
        elementsToAnimate.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            elements.forEach(el => {
                const rect = el.getBoundingClientRect();
                const isInViewport = (
                    rect.top <= (window.innerHeight || document.documentElement.clientHeight) * 0.8 &&
                    rect.bottom >= 0
                );
                
                if (isInViewport && !el.classList.contains('fade-in-element')) {
                    el.classList.add('fade-in-element');
                }
            });
        });
    }
    
    // Thêm sự kiện scroll để kiểm tra các phần tử
    window.addEventListener('scroll', checkIfInView);
    
    // Kiểm tra ngay khi trang tải
    checkIfInView();
    
    // Cải thiện hiển thị font chữ sau khi tải trang
    document.body.style.opacity = '0';
    setTimeout(() => {
        document.body.style.transition = 'opacity 0.5s ease';
        document.body.style.opacity = '1';
    }, 100);
    
    // Làm mượt hiệu ứng cuộn trang cho các liên kết
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Tạo nút trở về đầu trang
    const backToTopButton = document.createElement('button');
    backToTopButton.innerHTML = '<i class="fas fa-arrow-up"></i>';
    backToTopButton.className = 'back-to-top';
    backToTopButton.style.position = 'fixed';
    backToTopButton.style.bottom = '20px';
    backToTopButton.style.right = '20px';
    backToTopButton.style.width = '40px';
    backToTopButton.style.height = '40px';
    backToTopButton.style.borderRadius = '50%';
    backToTopButton.style.backgroundColor = '#007bff';
    backToTopButton.style.color = 'white';
    backToTopButton.style.border = 'none';
    backToTopButton.style.cursor = 'pointer';
    backToTopButton.style.zIndex = '999';
    backToTopButton.style.opacity = '0';
    backToTopButton.style.transform = 'translateY(20px)';
    backToTopButton.style.transition = 'all 0.3s ease';
    
    document.body.appendChild(backToTopButton);
    
    // Hiển thị hoặc ẩn nút trở về đầu trang khi cuộn
    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            backToTopButton.style.opacity = '1';
            backToTopButton.style.transform = 'translateY(0)';
        } else {
            backToTopButton.style.opacity = '0';
            backToTopButton.style.transform = 'translateY(20px)';
        }
    });
    
    // Xử lý sự kiện nhấn vào nút trở về đầu trang
    backToTopButton.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
    
    // Làm nổi bật menu hiện tại
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-menu__link').forEach(link => {
        const linkPath = link.getAttribute('href');
        if (currentPath === linkPath || currentPath.includes(linkPath) && linkPath !== '/') {
            link.style.fontWeight = '700';
            link.style.color = '#007bff';
        }
    });
});
