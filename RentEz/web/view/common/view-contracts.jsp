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

        <style>
            .tab-button.active {
                background-color: #f97316;
                color: white;
            }

            .status-badge {
                font-size: 0.75rem;
                font-weight: 500;
                padding: 0.125rem 0.625rem;
                border-radius: 9999px;
            }

            .status-badge.pending {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-badge.confirmed {
                background-color: #d1fae5;
                color: #065f46;
            }

            .status-badge.completed {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .status-badge.cancelled {
                background-color: #fee2e2;
                color: #991b1b;
            }

            .contract-document {
                font-family: 'Times New Roman', serif;
                line-height: 1.8;
            }

            .contract-document h1 {
                font-weight: bold;
                text-align: center;
                margin-bottom: 1rem;
            }

            .contract-document h3 {
                font-weight: bold;
                margin-top: 1.5rem;
                margin-bottom: 0.75rem;
            }

            .contract-buttons {
                display: flex;
                gap: 0.5rem;
                margin-bottom: 1rem;
                padding: 1rem;
                background-color: #f9fafb;
                border-radius: 0.5rem;
            }

            .contract-buttons button {
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.15s ease-in-out;
            }

            .btn-print {
                background-color: #059669;
                color: white;
            }

            .btn-print:hover {
                background-color: #047857;
            }

            .btn-download {
                background-color: #dc2626;
                color: white;
            }

            .btn-download:hover {
                background-color: #b91c1c;
            }

            @media print {
                .contract-buttons {
                    display: none;
                }

                .contract-document {
                    font-size: 12pt;
                    line-height: 1.5;
                }

                .contract-document h1 {
                    font-size: 16pt;
                }

                .contract-document h3 {
                    font-size: 14pt;
                }
            }
        </style>
    </head>
    <body class="bg-gray-50 font-sans">
        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Success/Error Messages -->
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
                                                                <a href="${pageContext.request.contextPath}/contract-detail?id=${booking.bookingId}" 
                                                                   class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                                
                                                                <!-- Check contract expiration and show appropriate buttons -->
                                                                <c:set var="now" value="<%= new java.util.Date() %>" />
                                                                <c:choose>
                                                                    <c:when test="${booking.endDate < now && (booking.status == 'Confirmed' || booking.status == 'Active')}">
                                                                        <!-- Contract has expired -->
                                                                        <span class="px-3 py-2 bg-red-100 text-red-800 text-sm rounded-lg border border-red-200">
                                                                            <i class="bi bi-exclamation-triangle mr-1"></i>
                                                                            Hợp đồng đã hết hạn
                                                                        </span>
                                                                        <button onclick="openRenewModal('${booking.bookingId}', '${booking.property.title}', '${booking.monthlyRent}')"
                                                                           class="px-4 py-2 bg-blue-500 text-white text-sm rounded-lg hover:bg-blue-600 transition-colors">
                                                                            <i class="bi bi-arrow-repeat mr-1"></i>
                                                                            Gia hạn hợp đồng
                                                                        </button>
                                                                    </c:when>
                                                                    <c:when test="${booking.endDate >= now && (booking.status == 'Confirmed' || booking.status == 'Active')}">
                                                                        <!-- Contract is still active -->
                                                                        <span class="px-3 py-2 bg-green-100 text-green-800 text-sm rounded-lg border border-green-200">
                                                                            <i class="bi bi-check-circle mr-1"></i>
                                                                            Hợp đồng đang hiệu lực
                                                                        </span>
                                                                        <button onclick="openCancelModal('${booking.bookingId}', '${booking.property.title}')"
                                                                           class="px-4 py-2 bg-red-500 text-white text-sm rounded-lg hover:bg-red-600 transition-colors">
                                                                            <i class="bi bi-x-circle mr-1"></i>
                                                                            Hủy hợp đồng
                                                                        </button>
                                                                    </c:when>
                                                                    <c:when test="${booking.status == 'Pending'}">
                                                                        <!-- Pending contract -->
                                                                        <span class="px-3 py-2 bg-yellow-100 text-yellow-800 text-sm rounded-lg border border-yellow-200">
                                                                            <i class="bi bi-clock mr-1"></i>
                                                                            Đang chờ xử lý
                                                                        </span>
                                                                        <button onclick="openCancelModal('${booking.bookingId}', '${booking.property.title}')"
                                                                           class="px-4 py-2 bg-red-500 text-white text-sm rounded-lg hover:bg-red-600 transition-colors">
                                                                            <i class="bi bi-x-circle mr-1"></i>
                                                                            Hủy đặt thuê
                                                                        </button>
                                                                    </c:when>
                                                                    <c:when test="${booking.status == 'Cancelled'}">
                                                                        <!-- Cancelled contract -->
                                                                        <span class="px-3 py-2 bg-gray-100 text-gray-800 text-sm rounded-lg border border-gray-200">
                                                                            <i class="bi bi-x-circle mr-1"></i>
                                                                            Đã hủy
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${booking.status == 'Completed'}">
                                                                        <!-- Completed contract -->
                                                                        <span class="px-3 py-2 bg-blue-100 text-blue-800 text-sm rounded-lg border border-blue-200">
                                                                            <i class="bi bi-check-square mr-1"></i>
                                                                            Đã hoàn thành
                                                                        </span>
                                                                    </c:when>
                                                                </c:choose>
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
                                            <div class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200">
                                                <div class="p-6">
                                                    <!-- Contract Header -->
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
                                                                <a href="${pageContext.request.contextPath}/contract-detail?id=${booking.bookingId}" 
                                                                   class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                                
                                                                <!-- Pending contract buttons -->
                                                                <span class="px-3 py-2 bg-yellow-100 text-yellow-800 text-sm rounded-lg border border-yellow-200">
                                                                    <i class="bi bi-clock mr-1"></i>
                                                                    Đang chờ xử lý
                                                                </span>
                                                                <button onclick="openCancelModal('${booking.bookingId}', '${booking.property.title}')"
                                                                   class="px-4 py-2 bg-red-500 text-white text-sm rounded-lg hover:bg-red-600 transition-colors">
                                                                    <i class="bi bi-x-circle mr-1"></i>
                                                                    Hủy đặt thuê
                                                                </button>

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

                        <!-- Confirmed Contracts Tab -->
                        <div id="content-confirmed" class="tab-content hidden">
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
                                                    <!-- Contract Header -->
                                                    <div class="flex flex-col lg:flex-row lg:justify-between lg:items-start mb-4">
                                                        <div class="flex-1">
                                                            <div class="flex items-center mb-2">
                                                                <h3 class="text-lg font-semibold text-gray-900 mr-3">
                                                                    ${booking.property.title}
                                                                </h3>
                                                                <span class="status-badge confirmed">Đã xác nhận</span>
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
                                                                <a href="${pageContext.request.contextPath}/contract-detail?id=${booking.bookingId}" 
                                                                   class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                                
                                                                <!-- Check contract expiration and show appropriate buttons -->
                                                                <c:set var="now" value="<%= new java.util.Date() %>" />
                                                                <c:choose>
                                                                    <c:when test="${booking.endDate < now}">
                                                                        <!-- Contract has expired -->
                                                                        <span class="px-3 py-2 bg-red-100 text-red-800 text-sm rounded-lg border border-red-200">
                                                                            <i class="bi bi-exclamation-triangle mr-1"></i>
                                                                            Hợp đồng đã hết hạn
                                                                        </span>
                                                                        <button onclick="openRenewModal('${booking.bookingId}', '${booking.property.title}', '${booking.monthlyRent}')"
                                                                           class="px-4 py-2 bg-blue-500 text-white text-sm rounded-lg hover:bg-blue-600 transition-colors">
                                                                            <i class="bi bi-arrow-repeat mr-1"></i>
                                                                            Gia hạn hợp đồng
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <!-- Contract is still active -->
                                                                        <span class="px-3 py-2 bg-green-100 text-green-800 text-sm rounded-lg border border-green-200">
                                                                            <i class="bi bi-check-circle mr-1"></i>
                                                                            Hợp đồng đang hiệu lực
                                                                        </span>
                                                                        <button onclick="openCancelModal('${booking.bookingId}', '${booking.property.title}')"
                                                                           class="px-4 py-2 bg-red-500 text-white text-sm rounded-lg hover:bg-red-600 transition-colors">
                                                                            <i class="bi bi-x-circle mr-1"></i>
                                                                            Hủy hợp đồng
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>
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

                        <!-- Completed Contracts Tab -->
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
                                                    <!-- Contract Header -->
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
                                                                <a href="${pageContext.request.contextPath}/contract-detail?id=${booking.bookingId}" 
                                                                   class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                                
                                                                <!-- Completed contract status -->
                                                                <span class="px-3 py-2 bg-blue-100 text-blue-800 text-sm rounded-lg border border-blue-200">
                                                                    <i class="bi bi-check-square mr-1"></i>
                                                                    Đã hoàn thành
                                                                </span>
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

                        <!-- Cancelled Contracts Tab -->
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
                                                    <!-- Contract Header -->
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
                                                                <a href="${pageContext.request.contextPath}/contract-detail?id=${booking.bookingId}" 
                                                                   class="px-4 py-2 bg-orange-500 text-white text-sm rounded-lg hover:bg-orange-600 transition-colors">
                                                                    <i class="bi bi-eye mr-1"></i>
                                                                    Xem chi tiết
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/property-detail?id=${booking.propertyId}" 
                                                                   class="px-4 py-2 bg-gray-500 text-white text-sm rounded-lg hover:bg-gray-600 transition-colors">
                                                                    <i class="bi bi-building mr-1"></i>
                                                                    Xem bất động sản
                                                                </a>
                                                                
                                                                <!-- Cancelled contract status -->
                                                                <span class="px-3 py-2 bg-gray-100 text-gray-800 text-sm rounded-lg border border-gray-200">
                                                                    <i class="bi bi-x-circle mr-1"></i>
                                                                    Đã hủy
                                                                </span>
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
        </div>

        <!-- Modal Gia hạn hợp đồng -->
        <div id="renewModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
          <div class="bg-white rounded-lg shadow-lg max-w-lg w-full mx-4">
            <div class="flex justify-between items-center border-b border-gray-200 px-6 py-4">
              <h5 class="text-xl font-semibold text-gray-800 flex items-center">
                <i class="bi bi-arrow-repeat mr-2 text-blue-600"></i> Gia hạn hợp đồng
              </h5>
              <button type="button" class="text-gray-500 hover:text-gray-700 text-2xl focus:outline-none" onclick="closeRenewModal()">&times;</button>
            </div>
            
            <!-- Property info section -->
            <div class="px-6 py-4 bg-blue-50 border-b">
              <div class="flex items-center">
                <i class="bi bi-info-circle text-blue-600 mr-2"></i>
                <div>
                  <h6 class="font-medium text-blue-800">Thông tin bất động sản</h6>
                  <p class="text-blue-700" id="renewPropertyTitle">Tên bất động sản</p>
                  <p class="text-blue-700 text-sm">Giá thuê: <span id="renewMonthlyRent" class="font-semibold">0 ₫</span>/tháng</p>
                </div>
              </div>
            </div>
            
            <form id="renewForm" method="POST">
              <input type="hidden" name="action" value="renew" />
              <input type="hidden" name="bookingId" id="renewBookingId" />
              
              <div class="px-6 py-4 space-y-4">
                <div>
                  <label for="newEndDate" class="block font-semibold mb-2 text-gray-700">
                    Ngày kết thúc mới <span class="text-red-500">*</span>
                  </label>
                  <input type="date" id="newEndDate" name="newEndDate" required 
                         class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
                  <p class="text-sm text-gray-500 mt-1">Chọn ngày kết thúc mới cho hợp đồng</p>
                </div>
                
                <div>
                  <label for="renewalTerms" class="block font-semibold mb-2 text-gray-700">
                    Điều khoản gia hạn <span class="text-red-500">*</span>
                  </label>
                  <textarea id="renewalTerms" name="renewalTerms" rows="4" required 
                            placeholder="Nhập điều khoản và ghi chú cho việc gia hạn hợp đồng..."
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>
              </div>
              
              <div class="flex justify-end space-x-3 px-6 py-4 bg-gray-50 rounded-b-lg">
                <button type="button" onclick="closeRenewModal()"
                        class="px-6 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors">
                  Hủy
                </button>
                <button type="submit"
                        class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors">
                  <i class="bi bi-arrow-repeat mr-2"></i>
                  Xác nhận gia hạn
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Modal Hủy hợp đồng -->
        <div id="cancelModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
          <div class="bg-white rounded-lg shadow-lg max-w-lg w-full mx-4">
            <div class="flex justify-between items-center border-b border-gray-200 px-6 py-4">
              <h5 class="text-xl font-semibold text-gray-800 flex items-center">
                <i class="bi bi-exclamation-triangle mr-2 text-red-600"></i> Hủy hợp đồng
              </h5>
              <button type="button" class="text-gray-500 hover:text-gray-700 text-2xl focus:outline-none" onclick="closeCancelModal()">&times;</button>
            </div>
            
            <!-- Warning section -->
            <div class="px-6 py-4 bg-red-50 border-b">
              <div class="flex items-center">
                <i class="bi bi-exclamation-triangle text-red-600 mr-2"></i>
                <div>
                  <h6 class="font-medium text-red-800">Xác nhận hủy hợp đồng</h6>
                  <p class="text-red-700">Bất động sản: <span id="cancelPropertyTitle" class="font-semibold">Tên bất động sản</span></p>
                  <p class="text-red-700 text-sm mt-1">⚠️ Hành động này không thể hoàn tác</p>
                </div>
              </div>
            </div>
            
            <form id="cancelForm" method="POST">
              <input type="hidden" name="action" value="cancel" />
              <input type="hidden" name="bookingId" id="cancelBookingId" />
              
              <div class="px-6 py-4 space-y-4">
                <div>
                  <label for="cancellationReason" class="block font-semibold mb-2 text-gray-700">
                    Lý do hủy hợp đồng <span class="text-red-500">*</span>
                  </label>
                  <textarea id="cancellationReason" name="cancellationReason" rows="4" required 
                            placeholder="Vui lòng nhập lý do hủy hợp đồng..."
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-red-500"></textarea>
                  <p class="text-sm text-gray-500 mt-1">Lý do hủy sẽ được ghi lại trong hệ thống và thông báo cho bên kia</p>
                </div>
              </div>
              
              <div class="flex justify-end space-x-3 px-6 py-4 bg-gray-50 rounded-b-lg">
                <button type="button" onclick="closeCancelModal()"
                        class="px-6 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-500 transition-colors">
                  Không hủy
                </button>
                <button type="submit"
                        class="px-6 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 transition-colors">
                  <i class="bi bi-x-circle mr-2"></i>
                  Xác nhận hủy
                </button>
              </div>
            </form>
          </div>
        </div>

        <script>
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
            }
            
            // Initialize page
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
            });

            // Renewal modal functions
            function openRenewModal(bookingId, propertyTitle, monthlyRent) {
                document.getElementById('renewBookingId').value = bookingId;
                document.getElementById('renewPropertyTitle').textContent = propertyTitle;
                document.getElementById('renewMonthlyRent').textContent = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(monthlyRent);
                document.getElementById('renewForm').action = '${pageContext.request.contextPath}/contract-management';
                
                // Set minimum date to tomorrow
                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);
                document.getElementById('newEndDate').min = tomorrow.toISOString().split('T')[0];
                
                document.getElementById('renewModal').classList.remove('hidden');
            }
            
            function closeRenewModal() {
                document.getElementById('renewModal').classList.add('hidden');
                document.getElementById('renewForm').reset();
            }

            // Cancellation modal functions
            function openCancelModal(bookingId, propertyTitle) {
                document.getElementById('cancelBookingId').value = bookingId;
                document.getElementById('cancelPropertyTitle').textContent = propertyTitle;
                document.getElementById('cancelForm').action = '${pageContext.request.contextPath}/contract-management';
                document.getElementById('cancelModal').classList.remove('hidden');
            }
            
            function closeCancelModal() {
                document.getElementById('cancelModal').classList.add('hidden');
                document.getElementById('cancelForm').reset();
            }

            // Close modals when clicking outside
            window.onclick = function(event) {
                const renewModal = document.getElementById('renewModal');
                const cancelModal = document.getElementById('cancelModal');
                
                if (event.target === renewModal) {
                    closeRenewModal();
                }
                if (event.target === cancelModal) {
                    closeCancelModal();
                }
            }
        </script>
    </body>
</html>
