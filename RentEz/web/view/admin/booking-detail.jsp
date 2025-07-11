<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đặt thuê - RentEz Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
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
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
    <div class="flex">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <div class="ml-64 flex-1">
            <!-- Top Header -->
            <header class="bg-white shadow-sm border-b border-gray-200">
                <div class="px-6 py-4">
                    <div class="flex items-center justify-between">
                        <h2 class="text-2xl font-bold text-gray-800">Chi tiết đặt thuê #${bookingDTO.bookingId}</h2>
                        <div class="flex items-center space-x-4">
                            <a href="${pageContext.request.contextPath}/admin/bookings" 
                               class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition-all shadow-md">
                                <i class="fas fa-arrow-left mr-2"></i>
                                Quay lại
                            </a>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="p-6">
                <!-- Status Banner -->
                <c:choose>
                    <c:when test="${bookingDTO.status eq 'Confirmed'}">
                        <div class="bg-gradient-to-r from-green-500 to-green-600 rounded-xl shadow-md p-6 mb-6 text-white">
                            <div class="flex items-center">
                                <i class="fas fa-check-circle text-3xl text-green-200 mr-4"></i>
                                <div>
                                    <h3 class="text-xl font-bold">Đặt thuê đã được xác nhận</h3>
                                    <p class="text-green-100">
                                        <c:if test="${bookingDTO.signedByRenter && bookingDTO.signedByLandlord}">
                                            Đã ký bởi cả người thuê và chủ nhà vào <fmt:formatDate value="${bookingDTO.signedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:if>
                                        <c:if test="${!(bookingDTO.signedByRenter && bookingDTO.signedByLandlord)}">
                                            <c:if test="${bookingDTO.signedByRenter}">Đã ký bởi người thuê</c:if>
                                            <c:if test="${bookingDTO.signedByLandlord}">Đã ký bởi chủ nhà</c:if>
                                            <c:if test="${!bookingDTO.signedByRenter && !bookingDTO.signedByLandlord}">Chưa được ký bởi hai bên</c:if>
                                        </c:if>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${bookingDTO.status eq 'Pending'}">
                        <div class="bg-gradient-to-r from-yellow-500 to-yellow-600 rounded-xl shadow-md p-6 mb-6 text-white">
                            <div class="flex items-center">
                                <i class="fas fa-clock text-3xl text-yellow-200 mr-4"></i>
                                <div>
                                    <h3 class="text-xl font-bold">Đặt thuê đang chờ xử lý</h3>
                                    <p class="text-yellow-100">Đặt thuê này đang chờ xác nhận từ chủ nhà và người thuê</p>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${bookingDTO.status eq 'Cancelled'}">
                        <div class="bg-gradient-to-r from-red-500 to-red-600 rounded-xl shadow-md p-6 mb-6 text-white">
                            <div class="flex items-center">
                                <i class="fas fa-times-circle text-3xl text-red-200 mr-4"></i>
                                <div>
                                    <h3 class="text-xl font-bold">Đặt thuê đã bị hủy</h3>
                                    <p class="text-red-100">Đặt thuê này đã bị hủy</p>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${bookingDTO.status eq 'Completed'}">
                        <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl shadow-md p-6 mb-6 text-white">
                            <div class="flex items-center">
                                <i class="fas fa-check-double text-3xl text-blue-200 mr-4"></i>
                                <div>
                                    <h3 class="text-xl font-bold">Đặt thuê đã hoàn thành</h3>
                                    <p class="text-blue-100">Đặt thuê này đã kết thúc thành công</p>
                                </div>
                            </div>
                        </div>
                    </c:when>
                </c:choose>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <!-- Booking Details -->
                    <div class="md:col-span-2">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden mb-6">
                            <div class="px-6 py-4 border-b border-gray-200 bg-gray-50">
                                <h3 class="text-lg font-semibold text-gray-800">Thông tin đặt thuê</h3>
                            </div>
                            <div class="p-6">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Mã đặt thuê</p>
                                        <p class="mt-1 text-lg font-semibold text-gray-900">#${bookingDTO.bookingId}</p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Ngày tạo</p>
                                        <p class="mt-1 text-lg font-semibold text-gray-900"><fmt:formatDate value="${bookingDTO.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Thời gian thuê</p>
                                        <p class="mt-1 text-lg font-semibold text-gray-900">
                                            <fmt:formatDate value="${bookingDTO.startDate}" pattern="dd/MM/yyyy"/> - 
                                            <fmt:formatDate value="${bookingDTO.endDate}" pattern="dd/MM/yyyy"/>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Tổng giá trị</p>
                                        <p class="mt-1 text-lg font-semibold text-primary-600">
                                            <fmt:formatNumber value="${bookingDTO.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Giá thuê hàng tháng</p>
                                        <p class="mt-1 text-lg font-semibold text-gray-900">
                                            <fmt:formatNumber value="${bookingDTO.monthlyRent}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Tiền cọc</p>
                                        <p class="mt-1 text-lg font-semibold text-gray-900">
                                            <fmt:formatNumber value="${bookingDTO.depositAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Trạng thái ký từ người thuê</p>
                                        <p class="mt-1">
                                            <c:choose>
                                                <c:when test="${bookingDTO.signedByRenter}">
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                        <i class="fas fa-check mr-1"></i> Đã ký
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                                                        <i class="fas fa-times mr-1"></i> Chưa ký
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Trạng thái ký từ chủ nhà</p>
                                        <p class="mt-1">
                                            <c:choose>
                                                <c:when test="${bookingDTO.signedByLandlord}">
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                        <i class="fas fa-check mr-1"></i> Đã ký
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                                                        <i class="fas fa-times mr-1"></i> Chưa ký
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>

                                <!-- Clauses -->
                                <div class="mt-8">
                                    <h4 class="text-lg font-semibold text-gray-800 mb-3">Điều khoản phạt</h4>
                                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                                        <p class="text-gray-700 whitespace-pre-line">${bookingDTO.penaltyClause}</p>
                                    </div>
                                </div>

                                <div class="mt-6">
                                    <h4 class="text-lg font-semibold text-gray-800 mb-3">Điều khoản và điều kiện</h4>
                                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                                        <p class="text-gray-700 whitespace-pre-line">${bookingDTO.termsAndConditions}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <div class="md:col-span-1">
                        <!-- Property Info -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden mb-6">
                            <div class="px-6 py-4 border-b border-gray-200 bg-gray-50">
                                <h3 class="text-lg font-semibold text-gray-800">Thông tin bất động sản</h3>
                            </div>
                            <div class="p-6">
                                <div class="flex items-center mb-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-primary-400 to-primary-600 rounded-lg flex items-center justify-center text-white mr-4">
                                        <i class="fas fa-home text-2xl"></i>
                                    </div>
                                    <div>
                                        <h4 class="text-lg font-bold text-gray-900">${bookingDTO.property.title}</h4>
                                        <p class="text-gray-500">${bookingDTO.location}</p>
                                    </div>
                                </div>
                                <div class="mt-4 space-y-3">
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Loại bất động sản</p>
                                        <p class="mt-1 text-gray-900">${bookingDTO.type.typeName}</p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Diện tích</p>
                                        <p class="mt-1 text-gray-900">${bookingDTO.property.size} m²</p>
                                    </div>
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Số phòng ngủ</p>
                                        <p class="mt-1 text-gray-900">${bookingDTO.property.numberOfBedrooms}</p>
                                    </div>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/property?id=${bookingDTO.property.propertyId}" 
                                           class="inline-flex items-center px-4 py-2 border border-primary-500 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors">
                                            <i class="fas fa-external-link-alt mr-2"></i>
                                            Xem chi tiết bất động sản
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- User Info -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden mb-6">
                            <div class="px-6 py-4 border-b border-gray-200 bg-gray-50">
                                <h3 class="text-lg font-semibold text-gray-800">Thông tin người thuê</h3>
                            </div>
                            <div class="p-6">
                                <div class="flex items-center mb-4">
                                    <div class="w-12 h-12 bg-gradient-to-br from-blue-400 to-blue-600 rounded-full flex items-center justify-center text-white font-semibold mr-4">
                                        ${bookingDTO.renter.name.charAt(0)}
                                    </div>
                                    <div>
                                        <h4 class="text-lg font-bold text-gray-900">${bookingDTO.renter.name}</h4>
                                        <p class="text-gray-500">${bookingDTO.renter.email}</p>
                                    </div>
                                </div>
                                <div class="mt-4 space-y-3">
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Số điện thoại</p>
                                        <p class="mt-1 text-gray-900">${bookingDTO.renter.phone}</p>
                                    </div>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/user?id=${bookingDTO.renter.userId}" 
                                           class="inline-flex items-center px-4 py-2 border border-primary-500 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors">
                                            <i class="fas fa-user mr-2"></i>
                                            Xem hồ sơ người thuê
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Landlord Info -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="px-6 py-4 border-b border-gray-200 bg-gray-50">
                                <h3 class="text-lg font-semibold text-gray-800">Thông tin chủ nhà</h3>
                            </div>
                            <div class="p-6">
                                <div class="flex items-center mb-4">
                                    <div class="w-12 h-12 bg-gradient-to-br from-green-400 to-green-600 rounded-full flex items-center justify-center text-white font-semibold mr-4">
                                        ${bookingDTO.landlord.name.charAt(0)}
                                    </div>
                                    <div>
                                        <h4 class="text-lg font-bold text-gray-900">${bookingDTO.landlord.name}</h4>
                                        <p class="text-gray-500">${bookingDTO.landlord.email}</p>
                                    </div>
                                </div>
                                <div class="mt-4 space-y-3">
                                    <div>
                                        <p class="text-sm font-medium text-gray-500">Số điện thoại</p>
                                        <p class="mt-1 text-gray-900">${bookingDTO.landlord.phone}</p>
                                    </div>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/user?id=${bookingDTO.landlord.userId}" 
                                           class="inline-flex items-center px-4 py-2 border border-primary-500 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors">
                                            <i class="fas fa-user mr-2"></i>
                                            Xem hồ sơ chủ nhà
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
