<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết thanh toán #${payment.paymentId} - RentEz Admin</title>
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
                        <div class="flex items-center space-x-4">
                            <button onclick="window.history.back()" class="text-gray-600 hover:text-gray-800 transition-colors">
                                <i class="fas fa-arrow-left text-xl"></i>
                            </button>
                            <h2 class="text-2xl font-bold text-gray-800">Chi tiết thanh toán</h2>
                        </div>
                        <div class="flex space-x-3">
                            <button onclick="window.print()" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                                <i class="fas fa-print mr-2"></i>In hóa đơn
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/payment-history" 
                               class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition-colors">
                                <i class="fas fa-list mr-2"></i>Quay lại danh sách
                            </a>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="p-6">
                <c:choose>
                    <c:when test="${not empty payment}">
                        <!-- Payment Detail Card -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="p-6">
                                <!-- Payment Header -->
                                <div class="border-b pb-6 mb-6">
                                    <div class="flex justify-between items-start">
                                        <div>
                                            <h3 class="text-2xl font-bold text-gray-900">Giao dịch #${payment.paymentId}</h3>
                                            <p class="text-gray-500 text-lg mt-1">${payment.transCode}</p>
                                        </div>
                                        <div class="text-right">
                                            <c:choose>
                                                <c:when test="${payment.status == 'Completed'}">
                                                    <span class="px-4 py-2 bg-green-100 text-green-800 text-sm font-semibold rounded-full">
                                                        <i class="fas fa-check-circle mr-1"></i>Thành công
                                                    </span>
                                                </c:when>
                                                <c:when test="${payment.status == 'Pending'}">
                                                    <span class="px-4 py-2 bg-yellow-100 text-yellow-800 text-sm font-semibold rounded-full">
                                                        <i class="fas fa-clock mr-1"></i>Đang xử lý
                                                    </span>
                                                </c:when>
                                                <c:when test="${payment.status == 'Paid'}">
                                                    <span class="px-4 py-2 bg-blue-100 text-blue-800 text-sm font-semibold rounded-full">
                                                        <i class="fas fa-money-check mr-1"></i>Đã thanh toán
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-4 py-2 bg-red-100 text-red-800 text-sm font-semibold rounded-full">
                                                        <i class="fas fa-times-circle mr-1"></i>Thất bại
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            <p class="text-gray-500 text-sm mt-2">
                                                <c:if test="${not empty payment.paymentDate}">
                                                    <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                </c:if>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Payment Information Grid -->
                                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                    <!-- Left Column -->
                                    <div class="space-y-6">
                                        <!-- Payer Information -->
                                        <div class="bg-gray-50 rounded-lg p-5">
                                            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                                                <i class="fas fa-user-circle text-blue-500 mr-2"></i>Thông tin người thanh toán
                                            </h4>
                                            <div class="space-y-3">
                                                <div class="flex justify-between">
                                                    <span class="text-gray-600">Họ tên:</span>
                                                    <span class="font-medium text-gray-900">
                                                        <c:choose>
                                                            <c:when test="${not empty payer and not empty payer.name}">
                                                                ${payer.name}
                                                            </c:when>
                                                            <c:otherwise>
                                                                User #${payment.payerId}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <c:if test="${not empty payer and not empty payer.email}">
                                                    <div class="flex justify-between">
                                                        <span class="text-gray-600">Email:</span>
                                                        <span class="text-gray-900">${payer.email}</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty payer and not empty payer.phone}">
                                                    <div class="flex justify-between">
                                                        <span class="text-gray-600">Số điện thoại:</span>
                                                        <span class="text-gray-900">${payer.phone}</span>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        
                                        <!-- Payee Information (if exists) -->
                                        <c:if test="${not empty payee}">
                                            <div class="bg-gray-50 rounded-lg p-5">
                                                <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                                                    <i class="fas fa-user-plus text-green-500 mr-2"></i>Thông tin người nhận
                                                </h4>
                                                <div class="space-y-3">
                                                    <div class="flex justify-between">
                                                        <span class="text-gray-600">Họ tên:</span>
                                                        <span class="font-medium text-gray-900">${payee.name}</span>
                                                    </div>
                                                    <c:if test="${not empty payee.email}">
                                                        <div class="flex justify-between">
                                                            <span class="text-gray-600">Email:</span>
                                                            <span class="text-gray-900">${payee.email}</span>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <!-- Right Column -->
                                    <div class="space-y-6">
                                        <!-- Payment Details -->
                                        <div class="bg-green-50 rounded-lg p-5 border border-green-200">
                                            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                                                <i class="fas fa-money-bill text-green-500 mr-2"></i>Chi tiết thanh toán
                                            </h4>
                                            <div class="space-y-4">
                                                <div class="text-center">
                                                    <p class="text-sm text-gray-600 mb-1">Số tiền thanh toán</p>
                                                    <p class="text-3xl font-bold text-green-600">
                                                        <c:choose>
                                                            <c:when test="${not empty payment.amount}">
                                                                <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                0₫
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div class="border-t border-green-200 pt-3 space-y-2">
                                                    <div class="flex justify-between">
                                                        <span class="text-gray-600">Phương thức:</span>
                                                        <span class="font-medium">
                                                            <c:choose>
                                                                <c:when test="${not empty payment.paymentMethod}">
                                                                    <c:choose>
                                                                        <c:when test="${payment.paymentMethod == 'VNPay'}">
                                                                            <i class="fas fa-credit-card text-blue-500 mr-1"></i>VNPay
                                                                        </c:when>
                                                                        <c:when test="${payment.paymentMethod == 'MoMo'}">
                                                                            <i class="fas fa-wallet text-pink-500 mr-1"></i>MoMo
                                                                        </c:when>
                                                                        <c:when test="${payment.paymentMethod == 'Bank Transfer'}">
                                                                            <i class="fas fa-university text-green-500 mr-1"></i>Chuyển khoản
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fas fa-money-bill text-green-600 mr-1"></i>${payment.paymentMethod}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Không xác định
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <c:if test="${not empty payment.referenceType}">
                                                        <div class="flex justify-between">
                                                            <span class="text-gray-600">Loại giao dịch:</span>
                                                            <span class="font-medium">${payment.referenceType}</span>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Transaction Details -->
                                        <div class="bg-blue-50 rounded-lg p-5 border border-blue-200">
                                            <h4 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                                                <i class="fas fa-receipt text-blue-500 mr-2"></i>Thông tin giao dịch
                                            </h4>
                                            <div class="space-y-3">
                                                <div class="flex justify-between">
                                                    <span class="text-gray-600">Mã giao dịch:</span>
                                                    <span class="font-mono text-sm bg-white px-2 py-1 rounded border">
                                                        <c:choose>
                                                            <c:when test="${not empty payment.transCode}">
                                                                ${payment.transCode}
                                                            </c:when>
                                                            <c:otherwise>
                                                                N/A
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="flex justify-between">
                                                    <span class="text-gray-600">Mã người dùng:</span>
                                                    <span class="font-medium">#${payment.payerId}</span>
                                                </div>
                                                <c:if test="${not empty payment.payeeId and payment.payeeId > 0}">
                                                    <div class="flex justify-between">
                                                        <span class="text-gray-600">Mã người nhận:</span>
                                                        <span class="font-medium">#${payment.payeeId}</span>
                                                    </div>
                                                </c:if>
                                                <div class="flex justify-between">
                                                    <span class="text-gray-600">Thời gian tạo:</span>
                                                    <span class="font-medium">
                                                        <c:if test="${not empty payment.paymentDate}">
                                                            <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                        </c:if>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                               
                                
                                <!-- Action Buttons -->
                                <div class="mt-8 pt-6 border-t border-gray-200">
                                    <div class="flex justify-center space-x-4">
                                        
                                        <button onclick="window.print()" class="px-6 py-3 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors font-medium">
                                            <i class="fas fa-print mr-2"></i>In hóa đơn
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/payment-history" 
                                           class="px-6 py-3 bg-gray-500 text-white rounded-lg hover:bg-gray-600 transition-colors font-medium">
                                            <i class="fas fa-arrow-left mr-2"></i>Quay lại
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Error State -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            <div class="p-8 text-center">
                                <i class="fas fa-exclamation-triangle text-red-500 text-6xl mb-4"></i>
                                <h3 class="text-2xl font-semibold text-gray-900 mb-2">Không tìm thấy thông tin</h3>
                                <p class="text-gray-600 mb-6">Không thể tải thông tin chi tiết của giao dịch này.</p>
                                <a href="${pageContext.request.contextPath}/admin/payment-history" 
                                   class="px-6 py-3 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors font-medium">
                                    <i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </div>
</body>
</html>
