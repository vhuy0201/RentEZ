<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Lịch xem nhà</title>

        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
        
    </head>
    
    <body>
        <!-- Loading overlay -->
        <div id="loadingOverlay" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
            <div class="bg-white rounded-lg p-8 flex flex-col items-center shadow-lg">
                <div class="animate-spin rounded-full h-12 w-12 border-4 border-orange-500 border-t-transparent mb-4" role="status">
                    <span class="sr-only">Đang tải...</span>
                </div>
                <div id="loadingMessage" class="text-gray-700 font-medium">Đang xử lý yêu cầu...</div>
            </div>
        </div>
        
        <div id="root">
            <main class="min-h-screen bg-gradient-to-br from-orange-50 via-white to-orange-100">
                <jsp:include page="/view/common/header.jsp" />
                
                <section class="relative py-20 bg-gradient-to-r from-orange-500 to-orange-600 text-white">
                    <img src="${pageContext.request.contextPath}/view/guest/asset/img/breadcrumb-img-DVKBF4db.png" 
                         alt="Breadcrumb Image" 
                         class="absolute inset-0 w-full h-full object-cover opacity-10" />
                    <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="flex justify-center">
                            <div class="max-w-2xl text-center">
                                <div class="space-y-4">
                                    <h2 class="text-4xl font-bold text-white">Lịch xem nhà</h2>
                                    <nav class="flex justify-center" aria-label="Breadcrumb">
                                        <ol class="flex items-center space-x-2 text-orange-100">
                                            <li class="flex items-center">
                                                <a class="hover:text-white transition-colors duration-200" href="${pageContext.request.contextPath}/">Trang chủ</a>
                                            </li>
                                            <li class="flex items-center">
                                                <i class="bi bi-chevron-right mx-2"></i>
                                                <span class="text-white">Lịch xem nhà</span>
                                            </li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <section class="py-16">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <c:if test="${sessionScope.user == null}">
                            <!-- Not logged in -->
                            <div class="flex justify-center">
                                <div class="max-w-md w-full">
                                    <div class="bg-white rounded-xl shadow-lg p-8 text-center border border-orange-100">
                                        <i class="bi bi-lock text-6xl text-orange-500 mb-4"></i>
                                        <h3 class="text-2xl font-bold text-gray-800 mb-3">Yêu cầu đăng nhập</h3>
                                        <p class="text-gray-600 mb-6">Vui lòng đăng nhập để xem lịch hẹn xem nhà của bạn.</p>
                                        <a href="${pageContext.request.contextPath}/login" class="w-full bg-gradient-to-r from-orange-500 to-orange-600 text-white px-6 py-3 rounded-lg font-semibold hover:from-orange-600 hover:to-orange-700 transition-all duration-200 transform hover:scale-105 shadow-lg inline-block">Đăng nhập</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${sessionScope.user != null}">
                            <div class="w-full">
                                <div class="w-full">
                                    <h3 class="text-3xl font-bold text-gray-800 mb-8 text-center">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                <span class="bg-gradient-to-r from-orange-600 to-orange-500 bg-clip-text text-transparent">Yêu cầu xem nhà của khách hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="bg-gradient-to-r from-orange-600 to-orange-500 bg-clip-text text-transparent">Lịch xem nhà của bạn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </h3>
                                    
                                    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
                                        <!-- Sorting options -->
                                        <div class="w-full sm:w-auto">
                                            <select id="sortSchedules" class="w-full sm:w-72 px-4 py-2 border border-orange-200 rounded-lg bg-white text-gray-700 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent shadow-sm">
                                                <option value="date-desc">Sắp xếp theo: Ngày xem (mới nhất)</option>
                                                <option value="date-asc">Sắp xếp theo: Ngày xem (cũ nhất)</option>
                                                <option value="name-asc">Sắp xếp theo: Tên bất động sản (A-Z)</option>
                                                <option value="name-desc">Sắp xếp theo: Tên bất động sản (Z-A)</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <!-- Tab navigation -->
                                    <div class="bg-white rounded-xl shadow-lg border border-orange-100 overflow-hidden">
                                        <div class="border-b border-orange-100">
                                            <nav class="flex space-x-0" id="scheduleTabs" role="tablist">
                                                <button class="flex-1 flex items-center justify-center px-6 py-4 text-sm font-medium text-white bg-gradient-to-r from-orange-500 to-orange-600 hover:from-orange-600 hover:to-orange-700 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-inset transition-all duration-200" 
                                                        id="all-tab" data-bs-toggle="tab" data-bs-target="#all-schedules" 
                                                        type="button" role="tab" aria-controls="all-schedules" aria-selected="true">
                                                    <i class="bi bi-calendar-week mr-2"></i>Tất cả
                                                    <c:if test="${not empty schedules}">
                                                        <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-white text-orange-600">${schedules.size()}</span>
                                                    </c:if>
                                                </button>
                                                <button class="flex-1 flex items-center justify-center px-6 py-4 text-sm font-medium text-gray-600 bg-gray-50 hover:text-gray-800 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-inset transition-all duration-200" 
                                                        id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-schedules" 
                                                        type="button" role="tab" aria-controls="pending-schedules" aria-selected="false">
                                                    <i class="bi bi-hourglass-split mr-2"></i>Chờ xác nhận
                                                    <c:if test="${not empty pendingSchedules}">
                                                        <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">${pendingSchedules.size()}</span>
                                                    </c:if>
                                                </button>
                                                <button class="flex-1 flex items-center justify-center px-6 py-4 text-sm font-medium text-gray-600 bg-gray-50 hover:text-gray-800 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-inset transition-all duration-200" 
                                                        id="confirmed-tab" data-bs-toggle="tab" data-bs-target="#confirmed-schedules" 
                                                        type="button" role="tab" aria-controls="confirmed-schedules" aria-selected="false">
                                                    <i class="bi bi-check-circle mr-2"></i>Đã xác nhận
                                                    <c:if test="${not empty confirmedSchedules}">
                                                        <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">${confirmedSchedules.size()}</span>
                                                    </c:if>
                                                </button>
                                                <button class="flex-1 flex items-center justify-center px-6 py-4 text-sm font-medium text-gray-600 bg-gray-50 hover:text-gray-800 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-inset transition-all duration-200" 
                                                        id="cancelled-tab" data-bs-toggle="tab" data-bs-target="#cancelled-schedules" 
                                                        type="button" role="tab" aria-controls="cancelled-schedules" aria-selected="false">
                                                    <i class="bi bi-x-circle mr-2"></i>Đã hủy
                                                    <c:if test="${not empty cancelledSchedules}">
                                                        <span class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">${cancelledSchedules.size()}</span>
                                                    </c:if>
                                                </button>
                                            </nav>
                                        </div>
                                    
                                    <!-- Tab content -->
                                    <div class="tab-content" id="scheduleTabContent">
                                        <!-- All schedules tab -->
                                        <div class="tab-pane fade show active p-6" id="all-schedules" role="tabpanel" aria-labelledby="all-tab">
                                            <c:if test="${empty schedules}">
                                                <div class="text-center py-16">
                                                    <i class="bi bi-calendar-x text-6xl text-gray-400 mb-4"></i>
                                                    <h3 class="text-xl font-semibold text-gray-700 mb-3">Không có lịch hẹn nào</h3>
                                                    <p class="text-gray-500 mb-6 max-w-md mx-auto">
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                Hiện tại bạn không có yêu cầu xem nhà nào từ khách hàng.
                                                            </c:when>
                                                            <c:otherwise>
                                                                Bạn chưa đặt lịch xem bất động sản nào.
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                        <a href="${pageContext.request.contextPath}/search" class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-orange-500 to-orange-600 text-white font-semibold rounded-lg hover:from-orange-600 hover:to-orange-700 transition-all duration-200 transform hover:scale-105 shadow-lg">
                                                            <i class="bi bi-search mr-2"></i>Tìm nhà ngay
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty schedules}">
                                                <div class="overflow-x-auto">
                                                    <table class="min-w-full bg-white rounded-lg shadow-sm border border-orange-100 schedule-table">
                                                        <thead class="bg-gradient-to-r from-orange-50 to-orange-100">
                                                            <tr>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Chủ nhà</th>
                                                                </c:if>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Ngày giờ xem</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Trạng thái</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="bg-white divide-y divide-orange-100">
                                                            <c:forEach items="${schedules}" var="schedule">
                                                                <tr class="hover:bg-orange-50 transition-colors duration-200">
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="h-16 w-16 rounded-lg object-cover border border-orange-200 mr-4">
                                                                            <div>
                                                                                <div class="text-sm font-semibold text-gray-900 property-title">${schedule.property.title}</div>
                                                                                <div class="text-sm text-gray-500 flex items-center mt-1 property-address"><i class="bi bi-geo-alt-fill text-orange-500 mr-1"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.renter.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.renter.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.renter.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.landlord.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.landlord.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.landlord.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center text-sm text-gray-900 schedule-date">
                                                                            <i class="bi bi-calendar-event text-orange-500 mr-2"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <c:choose>
                                                                            <c:when test="${schedule.status eq 'Pending'}">
                                                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                                                                    <i class="bi bi-hourglass-split mr-1"></i> Chờ xác nhận
                                                                                </span>
                                                                            </c:when>
                                                                            <c:when test="${schedule.status eq 'Confirmed'}">
                                                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                                                    <i class="bi bi-check-circle mr-1"></i> Đã xác nhận
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                                                                    <i class="bi bi-x-circle mr-1"></i> Đã hủy
                                                                                </span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                                        <c:if test="${schedule.status eq 'Pending'}">
                                                                            <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                                <form action="${pageContext.request.contextPath}/updateSchedule" method="POST" class="inline-block mr-2">
                                                                                    <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                    <input type="hidden" name="action" value="confirm">
                                                                                    <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-200">
                                                                                        <i class="bi bi-check-lg mr-1"></i> Xác nhận
                                                                                    </button>
                                                                                </form>
                                                                                <form action="${pageContext.request.contextPath}/updateSchedule" method="POST" class="inline-block">
                                                                                    <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                    <input type="hidden" name="action" value="cancel">
                                                                                    <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors duration-200">
                                                                                        <i class="bi bi-x-lg mr-1"></i> Từ chối
                                                                                    </button>
                                                                                </form>
                                                                            </c:if>
                                                                            <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                                <form action="${pageContext.request.contextPath}/updateSchedule" method="POST">
                                                                                    <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                    <input type="hidden" name="action" value="cancel">
                                                                                    <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors duration-200">
                                                                                        <i class="bi bi-x-lg mr-1"></i> Hủy lịch
                                                                                    </button>
                                                                                </form>
                                                                            </c:if>
                                                                        </c:if>
                                                                        <c:if test="${schedule.status ne 'Pending'}">
                                                                            <a href="${pageContext.request.contextPath}/property-detail?id=${schedule.propertyId}" 
                                                                               class="inline-flex items-center px-3 py-2 border border-orange-300 text-sm leading-4 font-medium rounded-md text-orange-700 bg-white hover:bg-orange-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500 transition-colors duration-200">
                                                                                <i class="bi bi-eye mr-1"></i> Xem chi tiết
                                                                            </a>
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Pending schedules tab -->
                                        <div class="tab-pane fade p-6" id="pending-schedules" role="tabpanel" aria-labelledby="pending-tab">
                                            <c:if test="${empty pendingSchedules}">
                                                <div class="text-center py-16">
                                                    <i class="bi bi-hourglass-split text-6xl text-gray-400 mb-4"></i>
                                                    <h3 class="text-xl font-semibold text-gray-700 mb-3">Không có lịch hẹn đang chờ xác nhận</h3>
                                                    <p class="text-gray-500 mb-6 max-w-md mx-auto">
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                Hiện tại không có yêu cầu xem nhà nào cần xác nhận.
                                                            </c:when>
                                                            <c:otherwise>
                                                                Bạn không có lịch xem nhà nào đang chờ xác nhận.
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty pendingSchedules}">
                                                <div class="overflow-x-auto">
                                                    <table class="min-w-full bg-white rounded-lg shadow-sm border border-orange-100 schedule-table">
                                                        <thead class="bg-gradient-to-r from-orange-50 to-orange-100">
                                                            <tr>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Chủ nhà</th>
                                                                </c:if>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Ngày giờ xem</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Trạng thái</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="bg-white divide-y divide-orange-100">
                                                            <c:forEach items="${pendingSchedules}" var="schedule">
                                                                <tr class="hover:bg-orange-50 transition-colors duration-200">
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="h-16 w-16 rounded-lg object-cover border border-orange-200 mr-4">
                                                                            <div>
                                                                                <div class="text-sm font-semibold text-gray-900 property-title">${schedule.property.title}</div>
                                                                                <div class="text-sm text-gray-500 flex items-center mt-1 property-address"><i class="bi bi-geo-alt-fill text-orange-500 mr-1"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.renter.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.renter.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.renter.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.landlord.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.landlord.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.landlord.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center text-sm text-gray-900 schedule-date">
                                                                            <i class="bi bi-calendar-event text-orange-500 mr-2"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                                                            <i class="bi bi-hourglass-split mr-1"></i> Chờ xác nhận
                                                                        </span>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                                        <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                            <form action="${pageContext.request.contextPath}/updateSchedule" method="POST">
                                                                                <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                <input type="hidden" name="action" value="confirm">
                                                                                <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-200">
                                                                                    <i class="bi bi-check-lg mr-1"></i> Xác nhận
                                                                                </button>
                                                                            </form>
                                                                            <form action="${pageContext.request.contextPath}/updateSchedule" method="POST"">
                                                                                <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                <input type="hidden" name="action" value="cancel">
                                                                                <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors duration-200">
                                                                                    <i class="bi bi-x-lg mr-1"></i> Từ chối
                                                                                </button>
                                                                            </form>
                                                                        </c:if>
                                                                        <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                            <form action="${pageContext.request.contextPath}/updateSchedule" method="POST">
                                                                                <input type="hidden" name="scheduleId" value="${schedule.scheduleId}">
                                                                                <input type="hidden" name="action" value="cancel">
                                                                                <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors duration-200">
                                                                                    <i class="bi bi-x-lg mr-1"></i> Hủy lịch
                                                                                </button>
                                                                            </form>
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Confirmed schedules tab -->
                                        <div class="tab-pane fade p-6" id="confirmed-schedules" role="tabpanel" aria-labelledby="confirmed-tab">
                                            <c:if test="${empty confirmedSchedules}">
                                                <div class="text-center py-16">
                                                    <i class="bi bi-calendar-check text-6xl text-gray-400 mb-4"></i>
                                                    <h3 class="text-xl font-semibold text-gray-700 mb-3">Không có lịch hẹn đã xác nhận</h3>
                                                    <p class="text-gray-500 mb-6 max-w-md mx-auto">
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                Bạn chưa xác nhận lịch xem nhà nào.
                                                            </c:when>
                                                            <c:otherwise>
                                                                Chưa có lịch xem nhà nào được xác nhận.
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty confirmedSchedules}">
                                                <div class="overflow-x-auto">
                                                    <table class="min-w-full bg-white rounded-lg shadow-sm border border-orange-100 schedule-table">
                                                        <thead class="bg-gradient-to-r from-orange-50 to-orange-100">
                                                            <tr>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Chủ nhà</th>
                                                                </c:if>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Ngày giờ xem</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Trạng thái</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="bg-white divide-y divide-orange-100">
                                                            <c:forEach items="${confirmedSchedules}" var="schedule">
                                                                <tr class="hover:bg-orange-50 transition-colors duration-200">
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="h-16 w-16 rounded-lg object-cover border border-orange-200 mr-4">
                                                                            <div>
                                                                                <div class="text-sm font-semibold text-gray-900 property-title">${schedule.property.title}</div>
                                                                                <div class="text-sm text-gray-500 flex items-center mt-1 property-address"><i class="bi bi-geo-alt-fill text-orange-500 mr-1"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.renter.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.renter.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.renter.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.landlord.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.landlord.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.landlord.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center text-sm text-gray-900 schedule-date">
                                                                            <i class="bi bi-calendar-event text-orange-500 mr-2"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                                            <i class="bi bi-check-circle mr-1"></i> Đã xác nhận
                                                                        </span>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                                        <a href="${pageContext.request.contextPath}/property-detail?id=${schedule.propertyId}" 
                                                                           class="inline-flex items-center px-3 py-2 border border-orange-300 text-sm leading-4 font-medium rounded-md text-orange-700 bg-white hover:bg-orange-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500 transition-colors duration-200">
                                                                            <i class="bi bi-eye mr-1"></i> Xem chi tiết
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                        
                                        <!-- Cancelled schedules tab -->
                                        <div class="tab-pane fade p-6" id="cancelled-schedules" role="tabpanel" aria-labelledby="cancelled-tab">
                                            <c:if test="${empty cancelledSchedules}">
                                                <div class="text-center py-16">
                                                    <i class="bi bi-calendar-x text-6xl text-gray-400 mb-4"></i>
                                                    <h3 class="text-xl font-semibold text-gray-700 mb-3">Không có lịch hẹn đã hủy</h3>
                                                    <p class="text-gray-500 mb-6 max-w-md mx-auto">
                                                        Không có lịch xem nhà nào đã bị hủy.
                                                    </p>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty cancelledSchedules}">
                                                <div class="overflow-x-auto">
                                                    <table class="min-w-full bg-white rounded-lg shadow-sm border border-orange-100 schedule-table">
                                                        <thead class="bg-gradient-to-r from-orange-50 to-orange-100">
                                                            <tr>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Bất động sản</th>
                                                                <c:if test="${sessionScope.user.role == 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Người thuê</th>
                                                                </c:if>
                                                                <c:if test="${sessionScope.user.role != 'Landlord'}">
                                                                    <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Chủ nhà</th>
                                                                </c:if>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Ngày giờ xem</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Trạng thái</th>
                                                                <th class="px-6 py-4 text-left text-xs font-semibold text-orange-900 uppercase tracking-wider">Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="bg-white divide-y divide-orange-100">
                                                            <c:forEach items="${cancelledSchedules}" var="schedule">
                                                                <tr class="hover:bg-orange-50 transition-colors duration-200">
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center">
                                                                            <img src="${schedule.property.avatar}" alt="Property" class="h-16 w-16 rounded-lg object-cover border border-orange-200 mr-4">
                                                                            <div>
                                                                                <div class="text-sm font-semibold text-gray-900 property-title">${schedule.property.title}</div>
                                                                                <div class="text-sm text-gray-500 flex items-center mt-1 property-address"><i class="bi bi-geo-alt-fill text-orange-500 mr-1"></i> ${schedule.location.address}</div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.renter.avatar != null && !schedule.renter.avatar.isEmpty() ? schedule.renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Renter" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.renter.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.renter.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.renter.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="flex items-center">
                                                                                    <img src="${schedule.landlord.avatar != null && !schedule.landlord.avatar.isEmpty() ? schedule.landlord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" 
                                                                                         alt="Landlord" class="h-10 w-10 rounded-full mr-3">
                                                                                    <div>
                                                                                        <div class="text-sm font-medium text-gray-900">${schedule.landlord.name}</div>
                                                                                        <div class="text-xs text-gray-500 space-y-1">
                                                                                            <div class="flex items-center"><i class="bi bi-telephone-fill text-orange-500 mr-1"></i> ${schedule.landlord.phone}</div>
                                                                                            <div class="flex items-center"><i class="bi bi-envelope-fill text-orange-500 mr-1"></i> ${schedule.landlord.email}</div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <div class="flex items-center text-sm text-gray-900 schedule-date">
                                                                            <i class="bi bi-calendar-event text-orange-500 mr-2"></i>
                                                                            <fmt:formatDate value="${schedule.scheduleDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                        </div>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap">
                                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                                                            <i class="bi bi-x-circle mr-1"></i> Đã hủy
                                                                        </span>
                                                                    </td>
                                                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                                        <a href="${pageContext.request.contextPath}/property-detail?id=${schedule.propertyId}" 
                                                                           class="inline-flex items-center px-3 py-2 border border-orange-300 text-sm leading-4 font-medium rounded-md text-orange-700 bg-white hover:bg-orange-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500 transition-colors duration-200">
                                                                            <i class="bi bi-eye mr-1"></i> Xem chi tiết
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </section>

                <jsp:include page="/view/common/footer.jsp" />
            </main>
        </div>
        
        <!-- Bootstrap JS bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" 
                crossorigin="anonymous"></script>
        
        
    </body>
</html>
