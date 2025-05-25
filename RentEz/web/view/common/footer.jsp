<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="footer-logo">
                    <img src="${pageContext.request.contextPath}/view/guest/asset/img/logo-DHG6Mbuc.png" alt="Logo" width="150" />
                </div>
                <p class="mt-3">
                    RentEz - Your trusted platform for property rentals. Find your perfect home or list your property with ease.
                </p>
            </div>
            
            <div class="col-md-2">
                <h5 class="footer-heading">Company</h5>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Partners</a></li>
                </ul>
            </div>
            
            <div class="col-md-2">
                <h5 class="footer-heading">Services</h5>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/property">Property Listings</a></li>
                    <li><a href="#">Rental Management</a></li>
                    <li><a href="#">Tenant Applications</a></li>
                    <li><a href="${pageContext.request.contextPath}/membership">Membership Plans</a></li>
                </ul>
            </div>
            
            <div class="col-md-4">
                <h5 class="footer-heading">Contact Us</h5>
                <ul class="footer-contact-info">
                    <li><i class="fas fa-map-marker-alt"></i> 123 Main Street, City, Country</li>
                    <li><i class="fas fa-phone"></i> +1 (123) 456-7890</li>
                    <li><i class="fas fa-envelope"></i> support@rentez.com</li>
                </ul>
                
                <div class="social-links mt-3">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <h4 class="footer-title">Room Types</h4>
                <ul class="footer-links">
                    <li><a href="#">Single Rooms</a></li>
                    <li><a href="#">Studio Apartments</a></li>
                    <li><a href="#">Double Rooms</a></li>
                    <li><a href="#">Shared Accommodations</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 col-md-6">
                <h4 class="footer-title">Popular Areas</h4>
                <ul class="footer-links">
                    <li><a href="#">City Center</a></li>
                    <li><a href="#">Near Universities</a></li>
                    <li><a href="#">Suburban Options</a></li>
                    <li><a href="#">Budget-Friendly Areas</a></li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="row">
                <div class="col-md-6">
                    <p class="copyright">
                        &copy; ${java.time.Year.now().getValue()} RentEz. All rights reserved.
                    </p>
                </div>
                <div class="col-md-6">
                    <ul class="policy-links">
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Cookies Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>

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
    
    .footer-links, .footer-contact-info {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-links li, .footer-contact-info li {
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
