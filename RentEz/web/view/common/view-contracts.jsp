<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Hợp đồng thuê nhà</title>

        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />

        <!-- Google Fonts for Vietnamese support -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'orange': {
                                50: '#fff7ed',
                                100: '#ffedd5',
                                200: '#fed7aa',
                                300: '#fdba74',
                                400: '#fb923c',
                                500: '#f97316',
                                600: '#ea580c',
                                700: '#c2410c',
                                800: '#9a3412',
                                900: '#7c2d12',
                            }
                        },
                        fontFamily: {
                            'sans': ['Inter', 'Roboto', 'system-ui', 'sans-serif'],
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-50 font-sans">
        <!-- Header -->
        <jsp:include page="header.jsp" />        <!-- Success/Error Messages -->
        <c:if test="${not empty param.success}">
            <div id="successMessage" class="fixed top-4 right-4 z-50 max-w-sm p-4 bg-green-500 text-white rounded-lg shadow-lg">
                <div class="flex items-center">
                    <i class="bi bi-check-circle mr-2"></i>
                    <span>
                        <c:choose>
                            <c:when test="${param.success == 'renewed'}">Hợp đồng đã được gia hạn thành công!</c:when>
                            <c:when test="${param.success == 'cancelled'}">Hợp đồng đã được hủy thành công!</c:when>
                            <c:otherwise>Thao tác đã được thực hiện thành công!</c:otherwise>
                        </c:choose>
                    </span>
                    <button onclick="this.parentElement.parentElement.remove()" class="ml-2 text-white hover:text-gray-200">
                        <i class="bi bi-x"></i>
                    </button>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div id="errorMessage" class="fixed top-4 right-4 z-50 max-w-sm p-4 bg-red-500 text-white rounded-lg shadow-lg">
                <div class="flex items-center">
                    <i class="bi bi-exclamation-circle mr-2"></i>
                    <span>
                        <c:choose>
                            <c:when test="${param.error == 'invalid_date'}">Ngày gia hạn không hợp lệ!</c:when>
                            <c:when test="${param.error == 'unauthorized'}">Bạn không có quyền thực hiện thao tác này!</c:when>
                            <c:when test="${param.error == 'not_found'}">Không tìm thấy hợp đồng!</c:when>
                            <c:when test="${param.error == 'database_error'}">Lỗi hệ thống, vui lòng thử lại sau!</c:when>
                            <c:otherwise>Có lỗi xảy ra, vui lòng thử lại!</c:otherwise>
                        </c:choose>
                    </span>
                    <button onclick="this.parentElement.parentElement.remove()" class="ml-2 text-white hover:text-gray-200">
                        <i class="bi bi-x"></i>
                    </button>
                </div>
            </div>
        </c:if>

        <!-- Main Container -->
        <div class="min-h-screen bg-gray-50 py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <!-- Page Header -->
                <div class="mb-8">
                    <h1 class="text-3xl font-bold text-gray-900 mb-2">Hợp đồng thuê nhà</h1>
                    <p class="text-gray-600">Quản lý và xem chi tiết các hợp đồng thuê nhà của bạn</p>
                </div>

                <!-- Check if user is logged in -->
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <div class="bg-white rounded-lg shadow-md p-8 text-center">
                            <div class="mb-4">
                                <i class="bi bi-person-fill-exclamation text-6xl text-gray-400"></i>
                            </div>
                            <h2 class="text-2xl font-semibold text-gray-900 mb-4">Vui lòng đăng nhập</h2>
                            <p class="text-gray-600 mb-6">Bạn cần đăng nhập để xem các hợp đồng thuê nhà của mình.</p>
                            <a href="${pageContext.request.contextPath}/login" 
                               class="inline-flex items-center px-6 py-3 bg-orange-500 text-white font-medium rounded-lg hover:bg-orange-600 transition-colors">
                                <i class="bi bi-box-arrow-in-right mr-2"></i>
                                Đăng nhập ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Tabs Navigation -->
                        <div class="mb-6">
                            <nav class="flex space-x-1 bg-white rounded-lg p-1 shadow-sm" aria-label="Tabs">
                                <button onclick="showTab('all')" id="tab-all" 
                                        class="tab-button flex-1 py-2.5 px-3 text-sm font-medium text-center rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition-colors">
                                    <i class="bi bi-list-ul mr-2"></i>
                                    Tất cả (${allBookings.size()})
                                </button>
                                <button onclick="showTab('pending')" id="tab-pending" 
                                        class="tab-button flex-1 py-2.5 px-3 text-sm font-medium text-center rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition-colors">
                                    <i class="bi bi-clock mr-2"></i>
                                    Đang chờ (${pendingBookings.size()})
                                </button>
                                <button onclick="showTab('confirmed')" id="tab-confirmed" 
                                        class="tab-button flex-1 py-2.5 px-3 text-sm font-medium text-center rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition-colors">
                                    <i class="bi bi-check-circle mr-2"></i>
                                    Đã xác nhận (${confirmedBookings.size()})
                                </button>
                                <button onclick="showTab('completed')" id="tab-completed" 
                                        class="tab-button flex-1 py-2.5 px-3 text-sm font-medium text-center rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition-colors">
                                    <i class="bi bi-check-square mr-2"></i>
                                    Hoàn thành (${completedBookings.size()})
                                </button>
                                <button onclick="showTab('cancelled')" id="tab-cancelled" 
                                        class="tab-button flex-1 py-2.5 px-3 text-sm font-medium text-center rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition-colors">
                                    <i class="bi bi-x-circle mr-2"></i>
                                    Đã hủy (${cancelledBookings.size()})
                                </button>
                            </nav>
                        </div>

                        <!-- All Contracts Tab -->
                        <div id="content-all" class="tab-content">
                            <c:choose>
                                <c:when test="${empty allBookings}">
                                    <div class="bg-white rounded-lg shadow-md p-8 text-center">
                                        <div class="mb-4">
                                            <i class="bi bi-file-earmark-text text-6xl text-gray-400"></i>
                                        </div>
                                        <h3 class="text-xl font-semibold text-gray-900 mb-2">Chưa có hợp đồng nào</h3>
                                        <p class="text-gray-600 mb-6">Bạn chưa có hợp đồng thuê nhà nào. Hãy tìm kiếm và đặt thuê một bất động sản!</p>
                                        <a href="${pageContext.request.contextPath}/search" 
                                           class="inline-flex items-center px-6 py-3 bg-orange-500 text-white font-medium rounded-lg hover:bg-orange-600 transition-colors">
                                            <i class="bi bi-search mr-2"></i>
                                            Tìm kiếm bất động sản
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="space-y-6">
                                        <c:forEach var="booking" items="${allBookings}">
                                            <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200">
                                                <div class="p-6">
                                                    <!-- Contract Header -->
                                                    <div class="flex flex-col lg:flex-row lg:justify-between lg:items-start mb-4">
                                                        <div class="flex-1">
                                                            <div class="flex items-center mb-2">
                                                                <h3 class="text-lg font-semibold text-gray-900 mr-3">
                                                                    ${booking.property.title}
                                                                </h3>
                                                                <span class="status-badge ${booking.status.toLowerCase()}">${booking.status}</span>
                                                            </div>
                                                            <p class="text-gray-600 flex items-center">
                                                                <i class="bi bi-geo-alt mr-1"></i>
                                                                ${booking.location.stateProvince}, ${booking.location.city}
                                                            </p>
                                                        </div>
                                                        <div class="text-right mt-4 lg:mt-0">
                                                            <div class="text-2xl font-bold text-orange-600">
                                                                <fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" />
                                                            </div>
                                                            <div class="text-sm text-gray-500">/ tháng</div>
                                                        </div>
                                                    </div>

                                                    <!-- Contract Details Grid -->
                                                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                                                        <div class="flex items-center">
                                                            <i class="bi bi-calendar-range text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Thời gian thuê</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /> - 
                                                                    <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex items-center">
                                                            <i class="bi bi-cash text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Tiền cọc</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex items-center">
                                                            <i class="bi bi-calculator text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Tổng giá trị</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Signing Status -->
                                                    <div class="mb-4">
                                                        <div class="text-sm text-gray-500 mb-2">Trạng thái ký hợp đồng:</div>
                                                        <div class="flex items-center space-x-4">
                                                            <div class="flex items-center">
                                                                <c:choose>
                                                                    <c:when test="${booking.signedByRenter}">
                                                                        <i class="bi bi-check-circle-fill text-green-500 mr-1"></i>
                                                                        <span class="text-green-600 text-sm">Người thuê đã ký</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="bi bi-clock text-gray-400 mr-1"></i>
                                                                        <span class="text-gray-600 text-sm">Chờ người thuê ký</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="flex items-center">
                                                                <c:choose>
                                                                    <c:when test="${booking.signedByLandlord}">
                                                                        <i class="bi bi-check-circle-fill text-green-500 mr-1"></i>
                                                                        <span class="text-green-600 text-sm">Chủ nhà đã ký</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="bi bi-clock text-gray-400 mr-1"></i>
                                                                        <span class="text-gray-600 text-sm">Chờ chủ nhà ký</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Contact Information -->
                                                    <div class="border-t pt-4">
                                                        <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                                                            <div class="flex items-center mb-2 md:mb-0">
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                        <i class="bi bi-person text-gray-400 mr-2"></i>
                                                                        <span class="text-sm text-gray-600">Người thuê: ${booking.renter.name}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="bi bi-house text-gray-400 mr-2"></i>
                                                                        <span class="text-sm text-gray-600">Chủ nhà: ${booking.landlord.name}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="flex space-x-2">
                                                                <button onclick="viewContractDetails('${booking.bookingId}')" 
                                                                        class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </button>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Pending Contracts Tab -->
                        <div id="content-pending" class="tab-content hidden">
                            <c:choose>
                                <c:when test="${empty pendingBookings}">
                                    <div class="bg-white rounded-lg shadow-md p-8 text-center">
                                        <div class="mb-4">
                                            <i class="bi bi-clock text-6xl text-gray-400"></i>
                                        </div>
                                        <h3 class="text-xl font-semibold text-gray-900 mb-2">Không có hợp đồng đang chờ</h3>
                                        <p class="text-gray-600">Hiện tại bạn không có hợp đồng nào đang chờ xử lý.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="space-y-6">
                                        <c:forEach var="booking" items="${pendingBookings}">
                                            <!-- Same contract card structure as above -->
                                            <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200">
                                                <!-- Contract card content (same as above) -->
                                                <div class="p-6">
                                                    <div class="flex flex-col lg:flex-row lg:justify-between lg:items-start mb-4">
                                                        <div class="flex-1">
                                                            <div class="flex items-center mb-2">
                                                                <h3 class="text-lg font-semibold text-gray-900 mr-3">
                                                                    ${booking.property.title}
                                                                </h3>
                                                                <span class="status-badge pending">Đang chờ</span>
                                                            </div>
                                                            <p class="text-gray-600 flex items-center">
                                                                <i class="bi bi-geo-alt mr-1"></i>
                                                                ${booking.location.stateProvince}, ${booking.location.city}
                                                            </p>
                                                        </div>
                                                        <div class="text-right mt-4 lg:mt-0">
                                                            <div class="text-2xl font-bold text-orange-600">
                                                                <fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" />
                                                            </div>
                                                            <div class="text-sm text-gray-500">/ tháng</div>
                                                        </div>
                                                    </div>
                                                    <!-- Rest of the contract card content -->
                                                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                                                        <div class="flex items-center">
                                                            <i class="bi bi-calendar-range text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Thời gian thuê</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /> - 
                                                                    <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex items-center">
                                                            <i class="bi bi-cash text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Tiền cọc</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex items-center">
                                                            <i class="bi bi-calculator text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Tổng giá trị</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Similar structure for confirmed, completed, and cancelled tabs -->                        <div id="content-confirmed" class="tab-content hidden">
                            <c:choose>
                                <c:when test="${empty confirmedBookings}">
                                    <div class="bg-white rounded-lg shadow-md p-8 text-center">
                                        <div class="mb-4">
                                            <i class="bi bi-check-circle text-6xl text-gray-400"></i>
                                        </div>
                                        <h3 class="text-xl font-semibold text-gray-900 mb-2">Không có hợp đồng đã xác nhận</h3>
                                        <p class="text-gray-600">Hiện tại bạn không có hợp đồng nào đã được xác nhận.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="space-y-6">
                                        <c:forEach var="booking" items="${confirmedBookings}">
                                            <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200">
                                                <div class="p-6">
                                                    <div class="flex flex-col lg:flex-row lg:justify-between lg:items-start mb-4">
                                                        <div class="flex-1">
                                                            <div class="flex items-center mb-2">
                                                                <h3 class="text-lg font-semibold text-gray-900 mr-3">
                                                                    ${booking.property.title}
                                                                </h3>                                                                <span class="status-badge confirmed">Đã xác nhận</span>
                                                            </div>
                                                            <p class="text-gray-600 flex items-center">
                                                                <i class="bi bi-geo-alt mr-1"></i>
                                                                ${booking.location.stateProvince}, ${booking.location.city}
                                                            </p>
                                                        </div>
                                                        <div class="text-right mt-4 lg:mt-0">
                                                            <div class="text-2xl font-bold text-orange-600">
                                                                <fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" />
                                                            </div>
                                                            <div class="text-sm text-gray-500">/ tháng</div>
                                                        </div>
                                                    </div>
                                                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                                                        <div class="flex items-center">
                                                            <i class="bi bi-calendar-range text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Thời gian thuê</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /> - 
                                                                    <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex items-center">
                                                            <i class="bi bi-cash text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Tiền cọc</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="flex items-center">
                                                            <i class="bi bi-calculator text-gray-400 mr-2"></i>
                                                            <div>
                                                                <div class="text-sm text-gray-500">Tổng giá trị</div>
                                                                <div class="font-medium">
                                                                    <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Signing Status -->
                                                    <div class="mb-4">
                                                        <div class="text-sm text-gray-500 mb-2">Trạng thái ký hợp đồng:</div>
                                                        <div class="flex items-center space-x-4">
                                                            <div class="flex items-center">
                                                                <c:choose>
                                                                    <c:when test="${booking.signedByRenter}">
                                                                        <i class="bi bi-check-circle-fill text-green-500 mr-1"></i>
                                                                        <span class="text-green-600 text-sm">Người thuê đã ký</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="bi bi-clock text-gray-400 mr-1"></i>
                                                                        <span class="text-gray-600 text-sm">Chờ người thuê ký</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="flex items-center">
                                                                <c:choose>
                                                                    <c:when test="${booking.signedByLandlord}">
                                                                        <i class="bi bi-check-circle-fill text-green-500 mr-1"></i>
                                                                        <span class="text-green-600 text-sm">Chủ nhà đã ký</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="bi bi-clock text-gray-400 mr-1"></i>
                                                                        <span class="text-gray-600 text-sm">Chờ chủ nhà ký</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="border-t pt-4">
                                                        <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                                                            <div class="flex items-center mb-2 md:mb-0">
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.role == 'Landlord'}">
                                                                        <i class="bi bi-person text-gray-400 mr-2"></i>
                                                                        <span class="text-sm text-gray-600">Người thuê: ${booking.renter.name}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="bi bi-house text-gray-400 mr-2"></i>
                                                                        <span class="text-sm text-gray-600">Chủ nhà: ${booking.landlord.name}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="flex space-x-2 flex-wrap">
                                                                <button onclick="viewContractDetails('${booking.bookingId}')" 
                                                                        class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </button>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                                <!-- Contract Management Buttons -->                                                                <button data-action="renew" 
                                                                                                                                                                            data-booking-id="${booking.bookingId}" 
                                                                                                                                                                            data-property-title="${fn:escapeXml(booking.property.title)}" 
                                                                                                                                                                            data-monthly-rent="${booking.monthlyRent}" 
                                                                                                                                                                            data-end-date="<fmt:formatDate value="${booking.endDate}" pattern="yyyy-MM-dd" />"
                                                                                                                                                                            class="contract-action-btn px-4 py-2 bg-green-500 text-white text-sm rounded-lg hover:bg-green-600 transition-colors">
                                                                    <i class="bi bi-arrow-repeat mr-1"></i>
                                                                    Gia hạn
                                                                </button>
                                                                <button data-action="cancel" 
                                                                        data-booking-id="${booking.bookingId}" 
                                                                        data-property-title="${fn:escapeXml(booking.property.title)}"
                                                                        class="contract-action-btn px-4 py-2 bg-red-500 text-white text-sm rounded-lg hover:bg-red-600 transition-colors">
                                                                    <i class="bi bi-x-circle mr-1"></i>
                                                                    Hủy hợp đồng
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="content-completed" class="tab-content hidden">
        <c:choose>
            <c:when test="${empty completedBookings}">
                <div class="bg-white rounded-lg shadow-md p-8 text-center">
                    <div class="mb-4">
                        <i class="bi bi-check-square text-6xl text-gray-400"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">Không có hợp đồng hoàn thành</h3>
                    <p class="text-gray-600">Hiện tại bạn không có hợp đồng nào đã hoàn thành.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-6">
                    <c:forEach var="booking" items="${completedBookings}">
                        <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200">
                            <div class="p-6">
                                <div class="flex flex-col lg:flex-row lg:justify-between lg:items-start mb-4">
                                    <div class="flex-1">
                                        <div class="flex items-center mb-2">
                                            <h3 class="text-lg font-semibold text-gray-900 mr-3">
                                                ${booking.property.title}
                                            </h3>
                                            <span class="status-badge completed">Hoàn thành</span>
                                        </div>
                                        <p class="text-gray-600 flex items-center">
                                            <i class="bi bi-geo-alt mr-1"></i>
                                            ${booking.location.stateProvince}, ${booking.location.city}
                                        </p>
                                    </div>
                                    <div class="text-right mt-4 lg:mt-0">
                                        <div class="text-2xl font-bold text-blue-600">
                                            <fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" />
                                        </div>
                                        <div class="text-sm text-gray-500">/ tháng</div>
                                    </div>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                                    <div class="flex items-center">
                                        <i class="bi bi-calendar-range text-gray-400 mr-2"></i>
                                        <div>
                                            <div class="text-sm text-gray-500">Thời gian thuê</div>
                                            <div class="font-medium">
                                                <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /> - 
                                                <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="bi bi-cash text-gray-400 mr-2"></i>
                                        <div>
                                            <div class="text-sm text-gray-500">Tiền cọc</div>
                                            <div class="font-medium">
                                                <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="bi bi-calculator text-gray-400 mr-2"></i>
                                        <div>
                                            <div class="text-sm text-gray-500">Tổng giá trị</div>
                                            <div class="font-medium">
                                                <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="content-cancelled" class="tab-content hidden">
        <c:choose>
            <c:when test="${empty cancelledBookings}">
                <div class="bg-white rounded-lg shadow-md p-8 text-center">
                    <div class="mb-4">
                        <i class="bi bi-x-circle text-6xl text-gray-400"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">Không có hợp đồng đã hủy</h3>
                    <p class="text-gray-600">Hiện tại bạn không có hợp đồng nào đã bị hủy.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-6">
                    <c:forEach var="booking" items="${cancelledBookings}">
                        <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200 opacity-75">
                            <div class="p-6">
                                <div class="flex flex-col lg:flex-row lg:justify-between lg:items-start mb-4">
                                    <div class="flex-1">
                                        <div class="flex items-center mb-2">
                                            <h3 class="text-lg font-semibold text-gray-900 mr-3">
                                                ${booking.property.title}
                                            </h3>
                                            <span class="status-badge cancelled">Đã hủy</span>
                                        </div>
                                        <p class="text-gray-600 flex items-center">
                                            <i class="bi bi-geo-alt mr-1"></i>
                                            ${booking.location.stateProvince}, ${booking.location.city}
                                        </p>
                                    </div>
                                    <div class="text-right mt-4 lg:mt-0">
                                        <div class="text-2xl font-bold text-gray-600">
                                            <fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" />
                                        </div>
                                        <div class="text-sm text-gray-500">/ tháng</div>
                                    </div>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-4">
                                    <div class="flex items-center">
                                        <i class="bi bi-calendar-range text-gray-400 mr-2"></i>
                                        <div>
                                            <div class="text-sm text-gray-500">Thời gian thuê</div>
                                            <div class="font-medium">
                                                <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /> - 
                                                <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="bi bi-cash text-gray-400 mr-2"></i>
                                        <div>
                                            <div class="text-sm text-gray-500">Tiền cọc</div>
                                            <div class="font-medium">
                                                <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="bi bi-calculator text-gray-400 mr-2"></i>
                                        <div>
                                            <div class="text-sm text-gray-500">Tổng giá trị</div>
                                            <div class="font-medium">
                                                <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</c:otherwise>
</c:choose>
</div>
</div>        <!-- Contract Detail Modal -->
<div id="contractModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <!-- Background overlay -->
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onclick="closeModal()"></div>

        <!-- Modal panel -->
        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-4xl sm:w-full">
            <div class="bg-white px-6 pt-6 pb-4">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-medium text-gray-900">Chi tiết hợp đồng</h3>
                    <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                        <i class="bi bi-x-lg text-xl"></i>
                    </button>
                </div>
                <div id="modalContent" class="space-y-4">
                    <!-- Modal content will be loaded here -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Renew Contract Modal -->
<div id="renewModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <!-- Background overlay -->
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onclick="closeRenewModal()"></div>

        <!-- Modal panel -->
        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
            <form id="renewForm" action="${pageContext.request.contextPath}/contract-management" method="POST">
                <input type="hidden" name="action" value="renew">
                <input type="hidden" id="renewBookingId" name="bookingId" value="">

                <div class="bg-white px-6 pt-6 pb-4">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-medium text-gray-900">
                            <i class="bi bi-arrow-repeat text-green-500 mr-2"></i>
                            Gia hạn hợp đồng
                        </h3>
                        <button type="button" onclick="closeRenewModal()" class="text-gray-400 hover:text-gray-600">
                            <i class="bi bi-x-lg text-xl"></i>
                        </button>
                    </div>

                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Bất động sản</label>
                            <p id="renewPropertyTitle" class="text-gray-900 font-medium"></p>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Giá thuê hiện tại</label>
                            <p id="renewCurrentRent" class="text-orange-600 font-bold text-lg"></p>
                        </div>

                        <div>
                            <label for="renewEndDate" class="block text-sm font-medium text-gray-700 mb-1">
                                Ngày kết thúc mới <span class="text-red-500">*</span>
                            </label>
                            <input type="date" 
                                   id="renewEndDate" 
                                   name="newEndDate" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" 
                                   required>
                            <p class="text-sm text-gray-500 mt-1">Chọn ngày kết thúc cho kỳ gia hạn</p>
                        </div>

                        <div>
                            <label for="renewTerms" class="block text-sm font-medium text-gray-700 mb-1">
                                Điều khoản gia hạn (tùy chọn)
                            </label>
                            <textarea id="renewTerms" 
                                      name="renewalTerms" 
                                      rows="3" 
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500"
                                      placeholder="Nhập các điều khoản bổ sung cho kỳ gia hạn..."></textarea>
                        </div>

                        <div class="bg-orange-50 p-4 rounded-lg">
                            <div class="flex items-start">
                                <i class="bi bi-info-circle text-orange-500 mr-2 mt-0.5"></i>
                                <div class="text-sm text-orange-700">
                                    <p class="font-medium">Lưu ý:</p>
                                    <ul class="list-disc list-inside mt-1 space-y-1">
                                        <li>Hợp đồng gia hạn sẽ có trạng thái "Chờ xác nhận"</li>
                                        <li>Cả hai bên cần ký để hợp đồng có hiệu lực</li>
                                        <li>Giá thuê được giữ nguyên từ hợp đồng cũ</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 px-6 py-4 flex flex-col sm:flex-row-reverse sm:space-x-reverse sm:space-x-3">
                    <button type="submit" 
                            class="w-full sm:w-auto inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors">
                        <i class="bi bi-check-circle mr-2"></i>
                        Xác nhận gia hạn
                    </button>
                    <button type="button" 
                            onclick="closeRenewModal()" 
                            class="mt-3 sm:mt-0 w-full sm:w-auto inline-flex justify-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500 transition-colors">
                        Hủy
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Cancel Contract Modal -->
<div id="cancelModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <!-- Background overlay -->
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onclick="closeCancelModal()"></div>

        <!-- Modal panel -->
        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
            <form id="cancelForm" action="${pageContext.request.contextPath}/contract-management" method="POST">
                <input type="hidden" name="action" value="cancel">
                <input type="hidden" id="cancelBookingId" name="bookingId" value="">

                <div class="bg-white px-6 pt-6 pb-4">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-medium text-gray-900">
                            <i class="bi bi-x-circle text-red-500 mr-2"></i>
                            Hủy hợp đồng
                        </h3>
                        <button type="button" onclick="closeCancelModal()" class="text-gray-400 hover:text-gray-600">
                            <i class="bi bi-x-lg text-xl"></i>
                        </button>
                    </div>

                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Bất động sản</label>
                            <p id="cancelPropertyTitle" class="text-gray-900 font-medium"></p>
                        </div>

                        <div>
                            <label for="cancelReason" class="block text-sm font-medium text-gray-700 mb-1">
                                Lý do hủy hợp đồng <span class="text-red-500">*</span>
                            </label>
                            <select id="cancelReason" 
                                    name="cancellationReason" 
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500" 
                                    required>
                                <option value="">Chọn lý do hủy</option>
                                <option value="Người thuê vi phạm hợp đồng">Người thuê vi phạm hợp đồng</option>
                                <option value="Chủ nhà cần sử dụng lại">Chủ nhà cần sử dụng lại</option>
                                <option value="Không thanh toán đúng hạn">Không thanh toán đúng hạn</option>
                                <option value="Thỏa thuận chung">Thỏa thuận chung</option>
                                <option value="Lý do khác">Lý do khác</option>
                            </select>
                        </div>

                        <div>
                            <label for="cancelDetails" class="block text-sm font-medium text-gray-700 mb-1">
                                Chi tiết (tùy chọn)
                            </label>
                            <textarea id="cancelDetails" 
                                      name="cancellationDetails" 
                                      rows="3" 
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500"
                                      placeholder="Mô tả chi tiết về lý do hủy hợp đồng..."></textarea>
                        </div>

                        <div class="bg-red-50 p-4 rounded-lg">
                            <div class="flex items-start">
                                <i class="bi bi-exclamation-triangle text-red-500 mr-2 mt-0.5"></i>
                                <div class="text-sm text-red-700">
                                    <p class="font-medium">Cảnh báo:</p>
                                    <ul class="list-disc list-inside mt-1 space-y-1">
                                        <li>Hành động này không thể hoàn tác</li>
                                        <li>Hợp đồng sẽ được đánh dấu là đã hủy</li>
                                        <li>Các bên liên quan sẽ nhận được thông báo</li>
                                        <li>Có thể áp dụng điều khoản phạt theo hợp đồng</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 px-6 py-4 flex flex-col sm:flex-row-reverse sm:space-x-reverse sm:space-x-3">
                    <button type="submit" 
                            class="w-full sm:w-auto inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors">
                        <i class="bi bi-x-circle mr-2"></i>
                        Xác nhận hủy
                    </button>
                    <button type="button" 
                            onclick="closeCancelModal()" 
                            class="mt-3 sm:mt-0 w-full sm:w-auto inline-flex justify-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500 transition-colors">
                        Hủy
                    </button>
                </div>
            </form>
        </div>
    </div>
</div><style>
    /* Status badges */
    .status-badge {
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
    }

    .status-badge.pending {
        background-color: #fef3c7;
        color: #d69e2e;
    }

    .status-badge.confirmed {
        background-color: #d1fae5;
        color: #10b981;
    }

    .status-badge.completed {
        background-color: #dbeafe;
        color: #3b82f6;
    }

    .status-badge.cancelled {
        background-color: #fee2e2;
        color: #ef4444;
    }

    /* Tab styles */
    .tab-button.active {
        background-color: #f97316;
        color: white;
    }

    .tab-button:not(.active) {
        color: #6b7280;
    }

    .tab-button:not(.active):hover {
        color: #374151;
        background-color: #f9fafb;
    }

    /* Responsive improvements */
    @media (max-width: 768px) {
        .grid-cols-3 {
            grid-template-columns: repeat(1, minmax(0, 1fr));
        }

        .flex-row {
            flex-direction: column;
        }
    }
</style>        <script>
    // Tab functionality
    function showTab(tabName) {
        // Hide all tab contents
        const contents = document.querySelectorAll('.tab-content');
        contents.forEach(content => content.classList.add('hidden'));

        // Remove active class from all buttons
        const buttons = document.querySelectorAll('.tab-button');
        buttons.forEach(button => button.classList.remove('active'));

        // Show selected tab content
        document.getElementById('content-' + tabName).classList.remove('hidden');

        // Add active class to selected button
        document.getElementById('tab-' + tabName).classList.add('active');
    }            // Contract detail modal
    function viewContractDetails(bookingId) {
        // Here you would typically fetch detailed contract information
        // For now, we'll show a placeholder
        const modalContent = document.getElementById('modalContent');
        modalContent.innerHTML =
                '<div class="text-center py-8">' +
                '<div class="animate-spin rounded-full h-12 w-12 border-4 border-orange-500 border-t-transparent mx-auto mb-4"></div>' +
                '<p class="text-gray-600">Đang tải chi tiết hợp đồng...</p>' +
                '</div>';

        document.getElementById('contractModal').classList.remove('hidden');

        // Simulate loading (in real implementation, you'd make an AJAX call)
        setTimeout(() => {
            modalContent.innerHTML =
                    '<div class="space-y-6">' +
                    '<h4 class="text-lg font-semibold text-gray-900">Thông tin hợp đồng #' + bookingId + '</h4>' +
                    '<div class="bg-gray-50 p-4 rounded-lg">' +
                    '<p class="text-gray-600">Chi tiết đầy đủ của hợp đồng sẽ được hiển thị ở đây, bao gồm:</p>' +
                    '<ul class="list-disc list-inside mt-2 text-gray-600 space-y-1">' +
                    '<li>Điều khoản và điều kiện chi tiết</li>' +
                    '<li>Điều khoản phạt</li>' +
                    '<li>Thông tin ký kết</li>' +
                    '<li>Lịch sử thay đổi hợp đồng</li>' +
                    '</ul>' +
                    '</div>' +
                    '</div>';
        }, 1000);
    }    function closeModal() {
        document.getElementById('contractModal').classList.add('hidden');
    }

    // Contract Management Modal Functions
    function openRenewModal(bookingId, propertyTitle, monthlyRent, endDate) {
        // Set form data
        document.getElementById('renewBookingId').value = bookingId;
        document.getElementById('renewPropertyTitle').textContent = propertyTitle;
        document.getElementById('renewCurrentRent').textContent = formatCurrency(monthlyRent);

        // Set minimum date for new end date (must be after current end date)
        const newEndDateInput = document.getElementById('renewEndDate');
        const currentEndDate = new Date(endDate);
        const minDate = new Date(currentEndDate);
        minDate.setDate(minDate.getDate() + 1); // At least one day after current end date

        newEndDateInput.min = minDate.toISOString().split('T')[0];

        // Show modal
        document.getElementById('renewModal').classList.remove('hidden');

        // Focus on first input
        setTimeout(() => {
            newEndDateInput.focus();
        }, 100);
    }

    function closeRenewModal() {
        document.getElementById('renewModal').classList.add('hidden');
        // Reset form
        document.getElementById('renewForm').reset();
    }

    function openCancelModal(bookingId, propertyTitle) {
        // Set form data
        document.getElementById('cancelBookingId').value = bookingId;
        document.getElementById('cancelPropertyTitle').textContent = propertyTitle;

        // Show modal
        document.getElementById('cancelModal').classList.remove('hidden');

        // Focus on reason select
        setTimeout(() => {
            document.getElementById('cancelReason').focus();
        }, 100);
    }

    function closeCancelModal() {
        document.getElementById('cancelModal').classList.add('hidden');
        // Reset form
        document.getElementById('cancelForm').reset();
    }

    // Utility function to format currency
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    // Event delegation for contract action buttons
    document.addEventListener('click', function (e) {
        if (e.target.closest('.contract-action-btn')) {
            const button = e.target.closest('.contract-action-btn');
            const action = button.getAttribute('data-action');
            const bookingId = button.getAttribute('data-booking-id');
            const propertyTitle = button.getAttribute('data-property-title');

            if (action === 'renew') {
                const monthlyRent = button.getAttribute('data-monthly-rent');
                const endDate = button.getAttribute('data-end-date');
                openRenewModal(bookingId, propertyTitle, monthlyRent, endDate);
            } else if (action === 'cancel') {
                openCancelModal(bookingId, propertyTitle);
            }
        }
    });    // Form validation and submission
    document.addEventListener('DOMContentLoaded', function () {
        // Renew form validation
        const renewForm = document.getElementById('renewForm');
        if (renewForm) {
            renewForm.addEventListener('submit', function (e) {
                const newEndDate = document.getElementById('renewEndDate').value;
                const currentDate = new Date();
                const selectedDate = new Date(newEndDate);

                if (selectedDate <= currentDate) {
                    e.preventDefault();
                    showToast('Ngày kết thúc mới phải sau ngày hiện tại', 'error');
                    return false;
                }

                // Show loading state
                const submitBtn = renewForm.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="bi bi-arrow-clockwise animate-spin mr-2"></i>Đang xử lý...';
                submitBtn.disabled = true;

                // Re-enable button after a delay (in case of errors)
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }, 5000);
            });
        }

        // Cancel form validation
        const cancelForm = document.getElementById('cancelForm');
        if (cancelForm) {
            cancelForm.addEventListener('submit', function (e) {
                const reason = document.getElementById('cancelReason').value;
                if (!reason) {
                    e.preventDefault();
                    showToast('Vui lòng chọn lý do hủy hợp đồng', 'error');
                    return false;
                }

                // Show confirmation dialog
                if (!confirm('Bạn có chắc chắn muốn hủy hợp đồng này? Hành động này không thể hoàn tác.')) {
                    e.preventDefault();
                    return false;
                }

                // Show loading state
                const submitBtn = cancelForm.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="bi bi-arrow-clockwise animate-spin mr-2"></i>Đang xử lý...';
                submitBtn.disabled = true;

                // Re-enable button after a delay (in case of errors)
                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                }, 5000);
            });
        }
    });            // Toast notification function
    function showToast(message, type = 'info') {
        // Remove existing toast
        const existingToast = document.getElementById('toast');
        if (existingToast) {
            existingToast.remove();
        }

        // Create toast element
        const toast = document.createElement('div');
        toast.id = 'toast';

        let bgColor = 'bg-blue-500 text-white';
        let icon = 'bi-info-circle';

        if (type === 'error') {
            bgColor = 'bg-red-500 text-white';
            icon = 'bi-exclamation-circle';
        } else if (type === 'success') {
            bgColor = 'bg-green-500 text-white';
            icon = 'bi-check-circle';
        }

        toast.className = 'fixed top-4 right-4 z-50 max-w-xs p-4 rounded-lg shadow-lg transform transition-all duration-300 ' + bgColor;

        toast.innerHTML =
                '<div class="flex items-center">' +
                '<i class="bi ' + icon + ' mr-2"></i>' +
                '<span>' + message + '</span>' +
                '<button onclick="this.parentElement.parentElement.remove()" class="ml-2 text-white hover:text-gray-200">' +
                '<i class="bi bi-x"></i>' +
                '</button>' +
                '</div>';

        document.body.appendChild(toast);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (toast && toast.parentNode) {
                toast.remove();
            }
        }, 5000);
    }            // Initialize page
    document.addEventListener('DOMContentLoaded', function () {
        // Show 'all' tab by default
        showTab('all');

        // Auto-hide success/error messages
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');

        if (successMessage) {
            setTimeout(() => {
                successMessage.remove();
            }, 5000);
        }

        if (errorMessage) {
            setTimeout(() => {
                errorMessage.remove();
            }, 5000);
        }
    });            // Close modal on escape key
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            // Close any open modal
            closeModal();
            closeRenewModal();
            closeCancelModal();
        }
    });
</script>
</body>
</html>
