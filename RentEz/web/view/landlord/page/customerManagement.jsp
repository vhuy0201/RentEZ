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

        /* Filter Styles */
        .filter-bar {
            background: #fff;
            padding: 1.5rem;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
            margin-bottom: 2rem;
        }

        .search-box {
            position: relative;
            flex: 1;
            min-width: 250px;
        }

        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .search-input:focus {
            outline: none;
            border-color: #ff6d00;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(255, 109, 0, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 0.9rem;
        }

        .filter-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            white-space: nowrap;
        }

        .filter-label {
            font-weight: 600;
            color: #4a5568;
            font-size: 0.9rem;
        }

        .filter-select {
            padding: 0.5rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            background: #f8f9fa;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            min-width: 120px;
        }

        .filter-select:focus {
            outline: none;
            border-color: #ff6d00;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(255, 109, 0, 0.1);
        }

        .filter-reset-btn {
            background: linear-gradient(135deg, #e53e3e, #c53030);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .filter-reset-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(229, 62, 62, 0.3);
        }

        .customer-count {
            font-size: 0.9rem;
            font-weight: 500;
        }

        .hidden-customer {
            display: none !important;
        }

        .no-results {
            text-align: center;
            padding: 3rem;
            color: #718096;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
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
                
                <!-- Filter bar -->
                <div class="filter-bar mb-4">
                    <div class="search-box">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" class="search-input" id="searchInput" placeholder="Tìm kiếm khách hàng..." oninput="filterCustomers()">
                    </div>
                    <div class="filter-item">
                        <span class="filter-label">Trạng thái:</span>
                        <select class="filter-select" id="statusFilter" onchange="filterCustomers()">
                            <option value="">Tất cả</option>
                            <option value="Còn hạn">Còn hạn</option>
                            <option value="Sắp hết hạn">Sắp hết hạn</option>
                            <option value="Đã quá hạn">Đã quá hạn</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <span class="filter-label">Thời hạn:</span>
                        <select class="filter-select" id="periodFilter" onchange="filterCustomers()">
                            <option value="">Tất cả</option>
                            <option value="next-7">7 ngày tới</option>
                            <option value="next-30">30 ngày tới</option>
                            <option value="expired">Đã quá hạn</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <span class="filter-label">Sắp xếp:</span>
                        <select class="filter-select" id="sortFilter" onchange="sortCustomers()">
                            <option value="name">Tên A-Z</option>
                            <option value="endDate">Ngày hết hạn</option>
                            <option value="totalPrice">Giá trị hợp đồng</option>
                            <option value="daysLeft">Số ngày còn lại</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <button type="button" class="filter-reset-btn" onclick="resetFilters()" title="Đặt lại bộ lọc">
                            <i class="fas fa-undo"></i>Reset
                        </button>
                    </div>
                    <div class="filter-item">
                        <span class="customer-count text-muted">(${customerBookings.size()} khách hàng)</span>
                    </div>
                </div>
                
                <!-- Customer Table -->
                <div class="customer-table">
                    <c:choose>
                        <c:when test="${not empty customerBookings}">
                            <!-- Modern Tailwind-based Customer Cards -->
                            <div class="grid gap-4" id="customerGrid">
                                <c:forEach var="customerData" items="${customerBookings}">
                                    <div class="customer-card bg-white rounded-xl shadow-sm border border-gray-100 p-6 hover:shadow-md transition-all duration-200 hover:border-blue-200"
                                         data-customer-name="${customerData.renter.name}"
                                         data-customer-email="${customerData.renter.email}"
                                         data-customer-phone="${customerData.renter.phone}"
                                         data-property-title="${customerData.property.title}"
                                         data-status="${customerData.status}"
                                         data-days-left="${customerData.daysLeft}"
                                         data-start-date="${customerData.booking.startDate.time}"
                                         data-end-date="${customerData.booking.endDate.time}"
                                         data-total-price="${customerData.booking.totalPrice}"
                                         data-monthly-rent="${customerData.booking.monthlyRent}">
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
                                                    <!-- Chat Button -->
                                                    <button type="button" 
                                                            class="w-8 h-8 flex items-center justify-center bg-orange-100 hover:bg-orange-200 text-orange-600 rounded-lg transition-colors duration-200" 
                                                            title="Nhắn tin"
                                                            onclick="openChatWithCustomer('${customerData.renter.userId}', '${customerData.renter.name}', '${customerData.property.propertyId}', '${customerData.property.title}')">
                                                        <i class="fas fa-comments text-xs"></i>
                                                    </button>
                                                    <!-- View User Detail Button -->
                                                    <a type="button" 
                                                            class="w-8 h-8 flex items-center justify-center bg-blue-100 hover:bg-blue-200 text-blue-600 rounded-lg transition-colors duration-200" 
                                                            title="Xem thông tin chi tiết"
                                                            href="${pageContext.request.contextPath}/user-detail?userId=${customerData.renter.userId}">
                                                        <i class="fas fa-eye text-xs"></i>
                                                    </a>
                                                    <!-- Contact Button -->
                                                    <button type="button" 
                                                            class="w-8 h-8 flex items-center justify-center bg-green-100 hover:bg-green-200 text-green-600 rounded-lg transition-colors duration-200" 
                                                            title="Gọi điện"
                                                            onclick="contactCustomer('${customerData.renter.phone}', '${customerData.renter.name}')">
                                                        <i class="fas fa-phone text-xs"></i>
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

        // Filter customers function with debounce
        let filterTimeout;
        function filterCustomers() {
            clearTimeout(filterTimeout);
            filterTimeout = setTimeout(() => {
                const searchTerm = document.getElementById('searchInput').value.toLowerCase();
                const statusFilter = document.getElementById('statusFilter').value;
                const periodFilter = document.getElementById('periodFilter').value;
                const customers = document.querySelectorAll('.customer-card');
                let visibleCount = 0;
                const currentTime = new Date().getTime();

                customers.forEach(customer => {
                    const customerName = customer.dataset.customerName.toLowerCase();
                    const customerEmail = customer.dataset.customerEmail.toLowerCase();
                    const customerPhone = customer.dataset.customerPhone.toLowerCase();
                    const propertyTitle = customer.dataset.propertyTitle.toLowerCase();
                    const status = customer.dataset.status;
                    const daysLeft = parseInt(customer.dataset.daysLeft);
                    const endDate = parseInt(customer.dataset.endDate);

                    let showCustomer = true;

                    // Search filter
                    if (searchTerm) {
                        const searchMatch = customerName.includes(searchTerm) || 
                                          customerEmail.includes(searchTerm) || 
                                          customerPhone.includes(searchTerm) || 
                                          propertyTitle.includes(searchTerm);
                        if (!searchMatch) showCustomer = false;
                    }

                    // Status filter
                    if (statusFilter && status !== statusFilter) {
                        showCustomer = false;
                    }

                    // Period filter
                    if (periodFilter) {
                        switch (periodFilter) {
                            case 'next-7':
                                if (daysLeft < 0 || daysLeft > 7) showCustomer = false;
                                break;
                            case 'next-30':
                                if (daysLeft < 0 || daysLeft > 30) showCustomer = false;
                                break;
                            case 'expired':
                                if (daysLeft >= 0) showCustomer = false;
                                break;
                        }
                    }

                    if (showCustomer) {
                        customer.classList.remove('hidden-customer');
                        visibleCount++;
                    } else {
                        customer.classList.add('hidden-customer');
                    }
                });

                updateCustomerCount(visibleCount);
                showNoResultsMessage(visibleCount === 0);
            }, 300);
        }

        // Sort customers function
        function sortCustomers() {
            const sortBy = document.getElementById('sortFilter').value;
            const customerGrid = document.getElementById('customerGrid');
            const customers = Array.from(document.querySelectorAll('.customer-card'));

            customers.sort((a, b) => {
                switch (sortBy) {
                    case 'name':
                        return a.dataset.customerName.localeCompare(b.dataset.customerName);
                    case 'endDate':
                        return parseInt(a.dataset.endDate) - parseInt(b.dataset.endDate);
                    case 'totalPrice':
                        return parseFloat(b.dataset.totalPrice) - parseFloat(a.dataset.totalPrice);
                    case 'daysLeft':
                        return parseInt(a.dataset.daysLeft) - parseInt(b.dataset.daysLeft);
                    default:
                        return 0;
                }
            });

            // Clear and re-append sorted customers
            customerGrid.innerHTML = '';
            customers.forEach(customer => customerGrid.appendChild(customer));
        }

        // Reset all filters
        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = '';
            document.getElementById('periodFilter').value = '';
            document.getElementById('sortFilter').value = 'name';
            
            const customers = document.querySelectorAll('.customer-card');
            customers.forEach(customer => {
                customer.classList.remove('hidden-customer');
            });
            
            updateCustomerCount(customers.length);
            showNoResultsMessage(false);
            sortCustomers();
        }

        // Update customer count
        function updateCustomerCount(count) {
            const countElement = document.querySelector('.customer-count');
            if (countElement) {
                countElement.textContent = `(${count} khách hàng)`;
            }
        }

        // Show/hide no results message
        function showNoResultsMessage(show) {
            let noResultsDiv = document.getElementById('noResultsMessage');
            
            if (show) {
                if (!noResultsDiv) {
                    noResultsDiv = document.createElement('div');
                    noResultsDiv.id = 'noResultsMessage';
                    noResultsDiv.className = 'no-results';
                    noResultsDiv.innerHTML = `
                        <div class="w-24 h-24 bg-gradient-to-br from-gray-100 to-gray-200 rounded-full flex items-center justify-center mb-6 mx-auto">
                            <i class="fas fa-search text-3xl text-gray-400"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-600 mb-3">Không tìm thấy khách hàng</h3>
                        <p class="text-gray-500">Hãy thử điều chỉnh bộ lọc hoặc từ khóa tìm kiếm</p>
                    `;
                    document.getElementById('customerGrid').appendChild(noResultsDiv);
                }
            } else {
                if (noResultsDiv) {
                    noResultsDiv.remove();
                }
            }
        }

        // Action button functions
        function openChatWithCustomer(userId, userName, propertyId, propertyTitle) {
            // Placeholder for chat functionality
            // Will be integrated with the chat system later
            alert(`Tính năng chat sẽ được tích hợp sau.\nSẽ mở chat với: ${userName}\nVề bất động sản: ${propertyTitle}`);
            
            // Future implementation:
            // if (typeof window.openMiniChat === 'function') {
            //     window.openMiniChat(userId, propertyId, userName, propertyTitle);
            // } else {
            //     window.location.href = `${pageContext.request.contextPath}/chat?userId=${userId}&propertyId=${propertyId}`;
            // }
        }

        function viewUserDetail(userId) {
            // Redirect to user detail page
            window.location.href = `${pageContext.request.contextPath}/user-detail?userId=${userId}`;
        }

        function contactCustomer(phone, customerName) {
            if (phone) {
                // Show contact options
                const options = [
                    `Gọi điện: ${phone}`,
                    'Hủy'
                ];
                
                const choice = confirm(`Liên hệ với ${customerName}\n\nSố điện thoại: ${phone}\n\nBạn có muốn gọi điện không?`);
                if (choice) {
                    // Open phone dialer on mobile or show phone number on desktop
                    if (/Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                        window.location.href = `tel:${phone}`;
                    } else {
                        // Copy to clipboard and show notification
                        navigator.clipboard.writeText(phone).then(() => {
                            alert(`Số điện thoại ${phone} đã được sao chép vào clipboard.`);
                        }).catch(() => {
                            alert(`Số điện thoại: ${phone}`);
                        });
                    }
                }
            } else {
                alert('Không có thông tin số điện thoại.');
            }
        }
    </script>
</body>
</html>
