<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="w-64 bg-gradient-to-b from-primary-600 via-primary-700 to-gray-900 text-white min-h-screen fixed left-0 top-0 z-30">
    <div class="p-6">
        <div class="flex items-center mb-8">
            <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center mr-3">
                <i class="fas fa-home text-primary-600 text-xl"></i>
            </div>
            <h1 class="text-xl font-bold">RentEz Admin</h1>
        </div>
        
        <nav class="space-y-2">
            <a href="${pageContext.request.contextPath}/admin/dashboard" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors 
               ${pageContext.request.requestURI.contains('dashboard') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-chart-line mr-3"></i>
                Dashboard
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('user') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-users mr-3"></i>
                Quản lý người dùng
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/property-types" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('property-type') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-building mr-3"></i>
                Quản lý loại phòng
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/posts" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('posts') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-newspaper mr-3"></i>
                Quản lý đăng bài
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/tiers" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('tier') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-crown mr-3"></i>
                Quản lý gói thành viên
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/payment-history" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('payment') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-credit-card mr-3"></i>
                Lịch sử thanh toán
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/bookings" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('booking') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-file-contract mr-3"></i>
                Quản lý đặt thuê
            </a>
            
<!--            <a href="${pageContext.request.contextPath}/admin/contact-messages" 
               class="flex items-center px-4 py-3 rounded-lg hover:bg-white hover:bg-opacity-10 transition-colors
               ${pageContext.request.requestURI.contains('support') ? 'bg-white bg-opacity-20 text-white font-medium' : ''}">
                <i class="fas fa-headset mr-3"></i>
                Hỗ trợ & Phản hồi
            </a>-->
        </nav>
    </div>
    
    <!-- User info at bottom -->
    <div class="absolute bottom-0 left-0 right-0 p-6 border-t border-white border-opacity-20">
        <div class="flex items-center">
            <div class="w-8 h-8 bg-primary-300 rounded-full flex items-center justify-center mr-3">
                <i class="fas fa-user text-primary-800"></i>
            </div>
            <div>
                <p class="font-medium">${sessionScope.user.name}</p>
                <p class="text-xs text-primary-200">Administrator</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout" 
           class="mt-3 flex items-center text-sm text-primary-200 hover:text-white transition-colors">
            <i class="fas fa-sign-out-alt mr-2"></i>
            Đăng xuất
        </a>
    </div>
</div>
