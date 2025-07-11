<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách hàng - RentEz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/landlord/common/navigation.css"/>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'orange-dark': '#e65100',
                        'orange-primary': '#ff6d00',
                        'orange-light': '#ff9800',
                        'orange-lighter': '#ffb74d',
                        'orange-lightest': '#ffe0b2'
                    }
                }
            }
        }
    </script>
    <style>
        body {
            background: #fafafa;
            font-family: 'Inter', Arial, sans-serif;
        }









        .dashboard-header {
            background: #fff;
            padding: 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
        }

        .dashboard-section-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
            background: linear-gradient(135deg, #e65100, #ff6d00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .dashboard-section-subtitle {
            color: #718096;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }

        .btn-main {
            background: linear-gradient(135deg, #e65100, #ff6d00);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            box-shadow: 0 4px 15px rgba(230, 81, 0, 0.3);
        }

        .btn-main:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(230, 81, 0, 0.4);
            color: white;
        }

        .dashboard-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        .customer-table {
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
        }

        .table th {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border: none;
            font-weight: 600;
            color: #495057;
            padding: 1rem;
            border-bottom: 2px solid #dee2e6;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f8f9fa;
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-warning {
            background: #fff3cd;
            color: #856404;
        }

        .status-expired {
            background: #f8d7da;
            color: #721c24;
        }

        .customer-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .customer-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #e65100, #ff6d00);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 0.9rem;
        }

        .property-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.25rem;
        }

        .property-address {
            color: #718096;
            font-size: 0.9rem;
        }

        .success-message {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            border: 1px solid #c3e6cb;
            display: flex;
            align-items: center;
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .success-message.show {
            opacity: 1;
            transform: translateY(0);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #718096;
        }

        .empty-icon {
            font-size: 4rem;
            color: #e2e8f0;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="container-fluid">
        <div class="row">
            <!-- Navigation -->
            <jsp:include page="../common/navigation.jsp" />
            
            <!-- Main content -->
            <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                <!-- Header -->
                <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center">
                    <div>
                        <div class="dashboard-section-subtitle mb-2">Quản lý khách thuê</div>
                        <div class="dashboard-section-title">Danh sách khách hàng</div>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <span class="text-muted">Tổng số khách: <strong class="text-dark">${customerBookings.size()}</strong></span>
                    </div>
                </div>
                
                <!-- Success message -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="success-message" id="successMessage">
                        <i class="fas fa-check-circle me-2"></i>
                        ${sessionScope.successMessage}
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                
                <!-- Error message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        ${error}
                    </div>
                </c:if>
                
                <!-- Customer Table -->
                <div class="customer-table">
                    <c:choose>
                        <c:when test="${not empty customerBookings}">
                            <!-- Modern Tailwind-based Customer Cards -->
                            <div class="grid gap-4">
                                <c:forEach var="customerData" items="${customerBookings}">
                                    <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-all duration-200 hover:border-blue-200">
                                        <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                                            <!-- Customer Info -->
                                            <div class="flex items-center gap-4 flex-1">
                                                <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow-lg">
                                                    ${customerData.renter.name.substring(0, 1).toUpperCase()}
                                                </div>
                                                <div class="flex-1">
                                                    <h3 class="font-semibold text-gray-800 text-lg">${customerData.renter.name}</h3>
                                                    <p class="text-gray-500 text-sm">${customerData.renter.email}</p>
                                                    <p class="text-gray-500 text-sm">${customerData.renter.phone}</p>
                                                </div>
                                            </div>
                                            
                                            <!-- Property Info -->
                                            <div class="flex-1 lg:max-w-xs">
                                                <div class="bg-gray-50 rounded-lg p-3">
                                                    <p class="font-medium text-gray-800 truncate">${customerData.property.title}</p>
                                                    <p class="text-sm text-gray-500 mt-1">Bất động sản</p>
                                                </div>
                                            </div>
                                            
                                            <!-- Rental Period -->
                                            <div class="flex-1 lg:max-w-xs">
                                                <div class="text-center lg:text-left">
                                                    <div class="flex flex-col sm:flex-row sm:items-center sm:gap-2 justify-center lg:justify-start">
                                                        <span class="font-medium text-gray-800 text-sm">
                                                            <fmt:formatDate value="${customerData.booking.startDate}" pattern="dd/MM/yyyy"/>
                                                        </span>
                                                        <span class="text-gray-400 text-xs">→</span>
                                                        <span class="font-medium text-gray-800 text-sm">
                                                            <fmt:formatDate value="${customerData.booking.endDate}" pattern="dd/MM/yyyy"/>
                                                        </span>
                                                    </div>
                                                    <c:choose>
                                                        <c:when test="${customerData.daysLeft >= 0}">
                                                            <p class="text-emerald-600 text-xs mt-1 font-medium">Còn ${customerData.daysLeft} ngày</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="text-red-500 text-xs mt-1 font-medium">Quá hạn ${-customerData.daysLeft} ngày</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            
                                            <!-- Pricing -->
                                            <div class="flex flex-col sm:flex-row sm:gap-6 lg:flex-col lg:gap-2 items-center lg:items-end">
                                                <div class="text-center lg:text-right">
                                                    <p class="text-sm text-gray-500">Hàng tháng</p>
                                                    <p class="font-bold text-emerald-600 text-lg">
                                                        <fmt:formatNumber value="${customerData.booking.monthlyRent}" type="number" groupingUsed="true"/>đ
                                                    </p>
                                                </div>
                                                <div class="text-center lg:text-right">
                                                    <p class="text-sm text-gray-500">Tổng giá trị</p>
                                                    <p class="font-bold text-blue-600 text-lg">
                                                        <fmt:formatNumber value="${customerData.booking.totalPrice}" type="number" groupingUsed="true"/>đ
                                                    </p>
                                                </div>
                                            </div>
                                            
                                            <!-- Status -->
                                            <div class="flex flex-col items-center lg:items-end gap-3">
                                                <c:choose>
                                                    <c:when test="${customerData.status == 'Còn hạn'}">
                                                        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-emerald-100 text-emerald-700 rounded-full text-sm font-medium">
                                                            <div class="w-2 h-2 bg-emerald-500 rounded-full"></div>
                                                            Còn hạn
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${customerData.status == 'Sắp hết hạn'}">
                                                        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-amber-100 text-amber-700 rounded-full text-sm font-medium">
                                                            <div class="w-2 h-2 bg-amber-500 rounded-full animate-pulse"></div>
                                                            Sắp hết hạn
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-red-100 text-red-700 rounded-full text-sm font-medium">
                                                            <div class="w-2 h-2 bg-red-500 rounded-full"></div>
                                                            Đã quá hạn
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <!-- Action Buttons -->
                                                <div class="flex gap-2">
                                                    <button type="button" class="w-8 h-8 flex items-center justify-center bg-blue-100 hover:bg-blue-200 text-blue-600 rounded-lg transition-colors duration-200" title="Xem chi tiết">
                                                        <i class="fas fa-eye text-xs"></i>
                                                    </button>
                                                    <button type="button" class="w-8 h-8 flex items-center justify-center bg-green-100 hover:bg-green-200 text-green-600 rounded-lg transition-colors duration-200" title="Liên hệ">
                                                        <i class="fas fa-phone text-xs"></i>
                                                    </button>
                                                    <button type="button" class="w-8 h-8 flex items-center justify-center bg-amber-100 hover:bg-amber-200 text-amber-600 rounded-lg transition-colors duration-200" title="Gia hạn hợp đồng">
                                                        <i class="fas fa-calendar-plus text-xs"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Modern Empty State -->
                            <div class="flex flex-col items-center justify-center py-20 px-6">
                                <div class="w-24 h-24 bg-gradient-to-br from-blue-100 to-purple-100 rounded-full flex items-center justify-center mb-6">
                                    <i class="fas fa-users text-3xl text-blue-500"></i>
                                </div>
                                <h3 class="text-2xl font-bold text-gray-800 mb-3">Chưa có khách hàng nào</h3>
                                <p class="text-gray-500 text-center max-w-md mb-8">Bạn chưa có khách hàng thuê bất động sản nào. Hãy đăng tin để thu hút khách hàng!</p>
                                <a href="${pageContext.request.contextPath}/addProperty" class="inline-flex items-center gap-2 bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white px-6 py-3 rounded-xl font-medium transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                    <i class="fas fa-plus"></i>
                                    Đăng tin mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <jsp:include page="/view/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
    <script>
        // Function to show and hide success message
        document.addEventListener('DOMContentLoaded', function () {
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                successMessage.classList.add('show');
                setTimeout(function () {
                    successMessage.style.opacity = '0';
                    setTimeout(function () {
                        successMessage.remove();
                    }, 500);
                }, 5000);
            }
        });
        
        // Confirm logout function
        function confirmLogout() {
            if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                window.location.href = '${pageContext.request.contextPath}/logout';
            }
        }
    </script>
</body>
</html>
