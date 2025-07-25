<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Sidebar với theme cam gradient -->
<aside class="col-md-3 col-lg-2 d-none d-md-block sidebar py-4">
    <div class="d-flex flex-column h-100">
        <!-- User Profile Section -->
        <div class="text-center user-info">
            <div class="account-avatar mx-auto mb-3">T</div>
            <div class="fw-bold fs-5 mb-2">${sessionScope.user.name}</div>
            <div class="user-points">
                <i class="fas fa-star me-2"></i>0 điểm
            </div>
        </div>
        
        <!-- Navigation Menu -->
        <nav class="flex-grow-1">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('HomeServlet') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/HomeServlet">
                        <i class="fas fa-home"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('landLordHomeServlet') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/landLordHomeServlet">
                        <i class="fas fa-tachometer-alt"></i>Tổng quan
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MessageServlet?action=getUsers">
                        <i class="fas fa-chat"></i>Chat
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('viewProperties') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/viewProperties">
                        <i class="fas fa-list"></i>Quản lý tin đăng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('addProperty') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/addProperty">
                        <i class="fas fa-plus"></i>Đăng tin mới
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('customerManagement') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/customerManagement">
                        <i class="fas fa-user-friends"></i>Khách hàng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('billManagement') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/billManagement">
                        <i class="fas fa-file-invoice"></i>Quản lý hóa đơn
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('contractManagement') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/contractManagement">
                        <i class="fas fa-file-contract"></i>Quản lý hợp đồng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('service-fee') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/landlord/page/service-fees">
                        <i class="fas fa-calculator"></i>Quản lý danh mục phí
                    </a>
                </li>
<!--                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('financialManagement') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/financialManagement">
                        <i class="fas fa-wallet"></i>Quản lý tài chính
                    </a>
                </li>-->
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-cog"></i>Cài đặt tài khoản
                    </a>
                </li>
                
            </ul>
        </nav>
        
        <!-- Logout Button -->
        <div class="logout-section">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="confirmLogout()">
                        <i class="fas fa-sign-out-alt"></i>Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</aside>
