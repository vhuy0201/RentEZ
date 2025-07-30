<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - RentEz</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        <h2 class="text-2xl font-bold text-gray-800">Dashboard Tổng quan</h2>
                        <div class="flex items-center space-x-4">
                            <div class="text-sm text-gray-600">
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                            <button class="p-2 rounded-lg bg-primary-50 text-primary-600 hover:bg-primary-100 transition-colors">
                                <i class="fas fa-bell"></i>
                            </button>
                            <button class="p-2 rounded-lg bg-primary-50 text-primary-600 hover:bg-primary-100 transition-colors">
                                <i class="fas fa-cog"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Dashboard Content -->
            <main class="p-6">
                <!-- a. Thống kê nhanh - Quick Statistics -->
                <div class="mb-8">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Thống kê nhanh</h3>
                    
                    <!-- First Row - Main Stats -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                        <!-- Tổng phòng trọ -->
                        <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-blue-100">Tổng phòng trọ</p>
                                    <p class="text-3xl font-bold">${totalProperties}</p>
                                    <p class="text-sm text-blue-200 mt-1">Tất cả bất động sản</p>
                                </div>
                                <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-building text-2xl"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Phòng đang thuê -->
                        <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-xl p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-green-100">Phòng đang thuê</p>
                                    <p class="text-3xl font-bold">${rentedProperties}</p>
                                    <p class="text-sm text-green-200 mt-1">${rentedPercentage}% tổng số phòng</p>
                                </div>
                                <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-home text-2xl"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Phòng còn trống -->
                        <div class="bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-xl p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-yellow-100">Phòng còn trống</p>
                                    <p class="text-3xl font-bold">${availableProperties}</p>
                                    <p class="text-sm text-yellow-200 mt-1">${availablePercentage}% tổng số phòng</p>
                                </div>
                                <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-door-open text-2xl"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Người dùng hoạt động -->
                        <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-purple-100">Người dùng hoạt động</p>
                                    <p class="text-3xl font-bold">${totalActiveUsers}</p>
                                    <p class="text-sm text-purple-200 mt-1">${activeLandlords} chủ trọ, ${activeRenters} khách thuê</p>
                                </div>
                                <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-users text-2xl"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Second Row - Revenue Stats -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                        <!-- Tổng doanh thu -->
                        <div class="bg-gradient-to-br from-rose-500 to-rose-600 rounded-xl p-6 text-white">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-rose-100">Tổng doanh thu</p>
                                    <p class="text-2xl font-bold">
                                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </p>
                                </div>
                                <div class="w-12 h-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-money-bill-wave text-2xl"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- b. Biểu đồ trực quan - Visual Charts -->
                <div class="mb-8">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Biểu đồ trực quan</h3>
                    
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                        <!-- Biểu đồ doanh thu theo thời gian -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <h4 class="text-lg font-semibold text-gray-800 mb-4">Doanh thu theo thời gian (12 tháng)</h4>
                            <div class="h-80">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>

                        <!-- Tỷ lệ phòng trống vs đã thuê -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <h4 class="text-lg font-semibold text-gray-800 mb-4">Tỷ lệ phòng trống vs đã thuê</h4>
                            <div class="h-80 flex items-center justify-center">
                                <canvas id="occupancyChart"></canvas>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Recent Activities and Support -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                    <!-- Hoạt động gần đây -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4">Hoạt động gần đây</h3>
                        <div class="space-y-4">
                            <c:forEach var="payment" items="${recentPayments}" begin="0" end="4">
                                <div class="flex items-center p-3 bg-green-50 rounded-lg">
                                    <div class="w-10 h-10 bg-green-500 rounded-full flex items-center justify-center text-white mr-3">
                                        <i class="fas fa-credit-card"></i>
                                    </div>
                                    <div class="flex-1">
                                        <p class="font-medium text-gray-800">Thanh toán thành công</p>
                                        <p class="text-sm text-gray-600">
                                            <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                    </div>
                                    <span class="text-xs text-gray-500">
                                        <fmt:formatDate value="${payment.paymentDate}" pattern="HH:mm"/>
                                    </span>
                                </div>
                            </c:forEach>
                            
                            <div class="flex items-center p-3 bg-blue-50 rounded-lg">
                                <div class="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white mr-3">
                                    <i class="fas fa-handshake"></i>
                                </div>
                                <div class="flex-1">
                                    <p class="font-medium text-gray-800">Đặt thuê mới</p>
                                    <p class="text-sm text-gray-600">${confirmedBookings} đặt thuê đã được xác nhận</p>
                                </div>
                                <span class="text-xs text-gray-500">Hôm nay</span>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Recent Users and Properties -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Recent Users -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-lg font-semibold text-gray-800">Người dùng mới nhất</h3>
                            <a href="${pageContext.request.contextPath}/admin/users" 
                               class="text-primary-600 hover:text-primary-700 text-sm font-medium">
                                Xem tất cả →
                            </a>
                        </div>
                        <div class="space-y-3">
                            <c:forEach var="user" items="${recentUsers}" begin="0" end="4">
                                <div class="flex items-center p-3 hover:bg-gray-50 rounded-lg transition-colors">
                                    <div class="w-10 h-10 bg-primary-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="fas fa-user text-primary-600"></i>
                                    </div>
                                    <div class="flex-1">
                                        <p class="font-medium text-gray-800">${user.name}</p>
                                        <p class="text-sm text-gray-600">${user.email}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Recent Properties -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-lg font-semibold text-gray-800">Bất động sản mới nhất</h3>
                            <a href="${pageContext.request.contextPath}/admin/posts" 
                               class="text-primary-600 hover:text-primary-700 text-sm font-medium">
                                Xem tất cả →
                            </a>
                        </div>
                        <div class="space-y-3">
                            <c:forEach var="property" items="${recentProperties}" begin="0" end="4">
                                <div class="flex items-center p-3 hover:bg-gray-50 rounded-lg transition-colors">
                                    <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center mr-3">
                                        <i class="fas fa-building text-green-600"></i>
                                    </div>
                                    <div class="flex-1">
                                        <p class="font-medium text-gray-800">${property.title}</p>
                                        <p class="text-sm text-gray-600">
                                            <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        // Chart.js configurations
        document.addEventListener('DOMContentLoaded', function() {
            // Biểu đồ doanh thu theo thời gian
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            const revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: [
                        <c:forEach var="label" items="${monthLabels}" varStatus="status">
                            '${label}'<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Doanh thu (₫)',
                        data: [
                            <c:forEach var="revenue" items="${monthlyRevenueChart}" varStatus="status">
                                ${revenue}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                        borderColor: 'rgb(59, 130, 246)',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND',
                                        maximumFractionDigits: 0
                                    }).format(value);
                                }
                            }
                        }
                    }
                }
            });

            // Biểu đồ tỷ lệ phòng trống vs đã thuê
            const occupancyCtx = document.getElementById('occupancyChart').getContext('2d');
            const occupancyChart = new Chart(occupancyCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Phòng đã thuê', 'Phòng còn trống'],
                    datasets: [{
                        data: [${rentedProperties}, ${availableProperties}],
                        backgroundColor: [
                            'rgb(34, 197, 94)',
                            'rgb(251, 191, 36)'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                padding: 20,
                                usePointStyle: true
                            }
                        }
                    }
                }
            });

            // Biểu đồ người thuê mới
            const newRentersCtx = document.getElementById('newRentersChart').getContext('2d');
            const newRentersChart = new Chart(newRentersCtx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:forEach var="label" items="${monthLabels}" varStatus="status">
                            '${label}'<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Người thuê mới',
                        data: [
                            <c:forEach var="count" items="${newRentersChart}" varStatus="status">
                                ${count}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                        backgroundColor: 'rgba(139, 69, 19, 0.8)',
                        borderColor: 'rgb(139, 69, 19)',
                        borderWidth: 1,
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
