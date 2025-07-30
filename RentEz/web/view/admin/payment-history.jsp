<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử thanh toán - RentEz Admin</title>
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
                        <h2 class="text-2xl font-bold text-gray-800">Lịch sử thanh toán</h2>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="p-6">
                <!-- Search and Filter -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                    <h5 class="text-lg font-semibold text-gray-800 mb-4">
                        <i class="fas fa-filter mr-2 text-primary-600"></i>Tìm kiếm và lọc
                    </h5>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-6 gap-4">
                        <!-- Search Input -->
                        <div class="lg:col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                            <div class="relative">
                                <input type="text" id="searchInput" placeholder="Mã giao dịch, tên người dùng, email..."
                                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        
                        <!-- Status Filter -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                            <select id="statusFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Completed">Thành công</option>
                                <option value="Pending">Đang xử lý</option>
                                <option value="Failed">Thất bại</option>
                                <option value="Paid">Đã thanh toán</option>
                            </select>
                        </div>
                        
                        <!-- Payment Method Filter -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Phương thức</label>
                            <select id="methodFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors">
                                <option value="">Tất cả phương thức</option>
                                <option value="VNPay">VNPay</option>
                                <option value="MoMo">MoMo</option>
                                <option value="Banking">Chuyển khoản ngân hàng</option>
                                <option value="Cash">Tiền mặt</option>
                                <option value="Credit Card">Thẻ tín dụng</option>
                            </select>
                        </div>
                        
                        <!-- Date From -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Từ ngày</label>
                            <input type="date" id="fromDate" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors">
                        </div>
                        
                        <!-- Date To -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Đến ngày</label>
                            <input type="date" id="toDate" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors">
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="flex flex-wrap gap-3 mt-4 pt-4 border-t border-gray-200">
                        <button type="button" onclick="applyFilters()" 
                                class="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 focus:ring-2 focus:ring-primary-500 transition-all duration-200 flex items-center">
                            <i class="fas fa-filter mr-2"></i>Áp dụng lọc
                        </button>
                        <button type="button" onclick="clearFilters()" 
                                class="px-6 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600 focus:ring-2 focus:ring-gray-500 transition-all duration-200 flex items-center">
                            <i class="fas fa-times mr-2"></i>Xóa bộ lọc
                        </button>
                    </div>
                </div>

                <!-- Stats Summary -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-green-100">Tổng doanh thu</p>
                                <p id="totalRevenueDisplay" class="text-2xl font-bold">
                                    <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </p>
                            </div>
                            <i class="fas fa-chart-line text-3xl text-green-200"></i>
                        </div>
                    </div>
                    <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-blue-100">Giao dịch thành công</p>
                                <p id="completedPaymentsDisplay" class="text-2xl font-bold">${completedPayments}</p>
                            </div>
                            <i class="fas fa-check-circle text-3xl text-blue-200"></i>
                        </div>
                    </div>
                    <div class="bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-yellow-100">Đang xử lý</p>
                                <p id="pendingPaymentsDisplay" class="text-2xl font-bold">${pendingPayments}</p>
                            </div>
                            <i class="fas fa-clock text-3xl text-yellow-200"></i>
                        </div>
                    </div>
                    <div class="bg-gradient-to-br from-red-500 to-red-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-red-100">Thất bại</p>
                                <p id="failedPaymentsDisplay" class="text-2xl font-bold">${failedPayments > 0 ? failedPayments : 0}</p>
                            </div>
                            <i class="fas fa-times-circle text-3xl text-red-200"></i>
                        </div>
                    </div>
                </div>

                <!-- Payments Table -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gradient-to-r from-primary-500 to-primary-600">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Mã giao dịch
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Người dùng
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Số tiền
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Phương thức
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Trạng thái
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Ngày tạo
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Thao tác
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach var="payment" items="${payments}">
                                    <tr class="hover:bg-gray-50 transition-colors" 
                                        data-payment-id="${payment.paymentId}" 
                                        data-status="${payment.status}" 
                                        data-method="${payment.paymentMethod}" 
                                        data-amount="${payment.amount}"
                                        data-date="<fmt:formatDate value="${payment.paymentDate}" pattern="yyyy-MM-dd"/>">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                            #${payment.paymentId}
                                            <div class="text-xs text-gray-500">${payment.transCode}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center" data-payer-id="${payment.payerId}">
                                                <c:set var="payer" value="${requestScope['user_'.concat(payment.paymentId)]}" />
                                                <div class="w-10 h-10 bg-gradient-to-br from-primary-400 to-primary-600 rounded-full flex items-center justify-center text-white font-semibold">
                                                    ${not empty payer ? fn:substring(payer.name, 0, 1) : 'U'}
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-gray-900">${not empty payer ? payer.name : 'User '.concat(payment.payerId)}</div>
                                                    <div class="text-sm text-gray-500">${not empty payer ? payer.email : ''}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="text-lg font-bold text-green-600">
                                                <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            
                                                ${payment.paymentMethod}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                                ${payment.status == 'Completed' ? 'bg-green-100 text-green-800' : 
                                                  payment.status == 'Pending' ? 'bg-yellow-100 text-yellow-800' : 
                                                  payment.status == 'Paid' ? 'bg-red-100 text-red-800' : 
                                                  'bg-purple-100 text-purple-800'}">
                                                ${payment.status == 'Completed' ? 'Thành công' : 
                                                  payment.status == 'Pending' ? 'Đang xử lý' : 
                                                  payment.status == 'Paid' ? 'Đã hoàn tiền' : 'Thất bại' }
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex space-x-2">
                                                <button onclick="viewPaymentDetail('${payment.paymentId}')" 
                                                        class="bg-blue-50 text-blue-600 px-3 py-1.5 rounded-lg hover:bg-blue-100 transition-colors">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="mt-6 flex items-center justify-between">
                    <div class="text-sm text-gray-700">
                        Hiển thị <span id="startItem" class="font-medium">1</span> đến <span id="endItem" class="font-medium">20</span> 
                        của <span id="totalItems" class="font-medium">${totalPayments}</span> giao dịch
                    </div>
                    <div id="pagination" class="flex space-x-2">
                        <!-- Pagination buttons will be generated here -->
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        // Global variables
        let allPayments = [];
        let filteredPayments = [];
        let currentPage = 1;
        let itemsPerPage = 10;
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            // Load the initial data from server - we'll use the data attributes instead of duplicating data in JS
            const paymentRows = document.querySelectorAll('tr[data-payment-id]');
            allPayments = [];
            
            paymentRows.forEach(row => {
                const paymentId = parseInt(row.getAttribute('data-payment-id'));
                const payerId = parseInt(row.querySelector('[data-payer-id]').getAttribute('data-payer-id'));
                const status = row.getAttribute('data-status');
                const method = row.getAttribute('data-method');
                const amount = parseFloat(row.getAttribute('data-amount'));
                const date = row.getAttribute('data-date');
                const transCode = row.querySelector('.text-xs').textContent;
                
                allPayments.push({
                    id: paymentId,
                    payerId: payerId,
                    amount: amount,
                    method: method,
                    status: status,
                    date: new Date(date),
                    transCode: transCode,
                    rowElement: row
                });
            });
            
            // Initial filtering and display
            filteredPayments = [...allPayments];
            updatePagination();
            displayPayments();
            
            // Set up event listeners for filters
            document.getElementById('searchInput').addEventListener('input', debounce(applyFilters, 500));
            document.getElementById('statusFilter').addEventListener('change', applyFilters);
            document.getElementById('methodFilter').addEventListener('change', applyFilters);
            document.getElementById('fromDate').addEventListener('change', applyFilters);
            document.getElementById('toDate').addEventListener('change', applyFilters);
            
            // Set up today's date as default for the "to" date and 30 days ago for "from" date
            const today = new Date();
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(today.getDate() - 30);
            
            const fromDateInput = document.getElementById('fromDate');
            const toDateInput = document.getElementById('toDate');
            
            fromDateInput.value = formatDateForInput(thirtyDaysAgo);
            toDateInput.value = formatDateForInput(today);
            
            // Apply filters initially with default date range
            applyFilters();
        });
        
        function formatDateForInput(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }
        
        // Debounce function for search input
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }
        
        function applyFilters() {
            const search = document.getElementById('searchInput').value.toLowerCase().trim();
            const status = document.getElementById('statusFilter').value;
            const method = document.getElementById('methodFilter').value;
            const dateFrom = document.getElementById('fromDate').value;
            const dateTo = document.getElementById('toDate').value;
            
            // Filter the payments
            filteredPayments = allPayments.filter(payment => {
                // Search filter - search in transaction code, user name, and email
                if (search) {
                    const userElement = document.querySelector(`[data-payer-id="${payment.payerId}"]`);
                    const userText = userElement ? userElement.textContent.toLowerCase() : '';
                    const transCodeMatch = payment.transCode.toLowerCase().includes(search);
                    const userInfoMatch = userText.includes(search);
                    const paymentIdMatch = payment.id.toString().includes(search);
                    
                    if (!transCodeMatch && !userInfoMatch && !paymentIdMatch) {
                        return false;
                    }
                }
                
                // Status filter
                if (status && payment.status !== status) {
                    return false;
                }
                
                // Method filter
                if (method && payment.method !== method) {
                    return false;
                }
                
                // Date from filter
                if (dateFrom) {
                    const fromDate = new Date(dateFrom);
                    fromDate.setHours(0, 0, 0, 0);
                    const paymentDate = new Date(payment.date);
                    paymentDate.setHours(0, 0, 0, 0);
                    if (paymentDate < fromDate) {
                        return false;
                    }
                }
                
                // Date to filter
                if (dateTo) {
                    const toDate = new Date(dateTo);
                    toDate.setHours(23, 59, 59, 999);
                    const paymentDate = new Date(payment.date);
                    if (paymentDate > toDate) {
                        return false;
                    }
                }
                
                return true;
            });
            
            // Reset to first page after filtering
            currentPage = 1;
            
            // Update display
            updatePagination();
            displayPayments();
            updateStatistics();
            
            // Show filter results message
            showFilterResults();
        }
        
        function clearFilters() {
            // Clear all filter inputs
            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = '';
            document.getElementById('methodFilter').value = '';
            document.getElementById('fromDate').value = '';
            document.getElementById('toDate').value = '';
            
            // Reset filtered payments to show all
            filteredPayments = [...allPayments];
            currentPage = 1;
            
            // Update display
            updatePagination();
            displayPayments();
            updateStatistics();
            
            // Show success message
            showNotification('Đã xóa tất cả bộ lọc', 'success');
        }
        
        function exportPayments() {
            if (filteredPayments.length === 0) {
                showNotification('Không có dữ liệu để xuất', 'warning');
                return;
            }
            
            // Create CSV content
            let csvContent = "Mã giao dịch,Người dùng,Số tiền,Phương thức,Trạng thái,Ngày tạo\n";
            
            filteredPayments.forEach(payment => {
                const userElement = document.querySelector(`[data-payer-id="${payment.payerId}"]`);
                const userName = userElement ? userElement.querySelector('.text-sm.font-medium').textContent : 'N/A';
                const amount = new Intl.NumberFormat('vi-VN').format(payment.amount);
                const date = new Date(payment.date).toLocaleDateString('vi-VN');
                
                csvContent += `"#${payment.id}","${userName}","${amount}","${payment.method}","${payment.status}","${date}"\n`;
            });
            
            // Download CSV
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = `payment_history.csv`;
            link.click();
            
            showNotification('Đã xuất dữ liệu thành công', 'success');
        }
        
        function refreshData() {
            showNotification('Đang làm mới dữ liệu...', 'info');
            
            // Reload the page to get fresh data
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        }
        
        function showFilterResults() {
            const total = allPayments.length;
            const filtered = filteredPayments.length;
            
            if (filtered < total) {
                showNotification(`Đã lọc ${filtered} / ${total} giao dịch`, 'info');
            }
        }
        
        function showNotification(message, type = 'info') {
            // Remove existing notifications
            const existingNotifications = document.querySelectorAll('.notification-toast');
            existingNotifications.forEach(n => n.remove());
            
            // Create notification
            const notification = document.createElement('div');
            notification.className = `notification-toast fixed top-4 right-4 z-50 px-6 py-3 rounded-lg shadow-lg transition-all duration-300 transform translate-x-full`;
            
            // Set colors based on type
            let bgColor, textColor, icon;
            switch (type) {
                case 'success':
                    bgColor = 'bg-green-500';
                    textColor = 'text-white';
                    icon = 'fas fa-check-circle';
                    break;
                case 'warning':
                    bgColor = 'bg-yellow-500';
                    textColor = 'text-white';
                    icon = 'fas fa-exclamation-triangle';
                    break;
                case 'error':
                    bgColor = 'bg-red-500';
                    textColor = 'text-white';
                    icon = 'fas fa-times-circle';
                    break;
                default:
                    bgColor = 'bg-blue-500';
                    textColor = 'text-white';
                    icon = 'fas fa-info-circle';
            }
            
            notification.className += ` ${bgColor} ${textColor}`;
            notification.innerHTML = `
                <div class="flex items-center">
                    <i class="${icon} mr-2"></i>
                    <span>${message}</span>
                </div>
            `;
            
            document.body.appendChild(notification);
            
            // Animate in
            setTimeout(() => {
                notification.classList.remove('translate-x-full');
            }, 100);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                notification.classList.add('translate-x-full');
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }
        
        function displayPayments() {
            const startIndex = (currentPage - 1) * itemsPerPage;
            const endIndex = Math.min(startIndex + itemsPerPage, filteredPayments.length);
            
            // Hide all payment rows first
            allPayments.forEach(payment => {
                if (payment.rowElement) {
                    payment.rowElement.style.display = 'none';
                }
            });
            
            // Show only the filtered rows for current page
            for (let i = startIndex; i < endIndex; i++) {
                const payment = filteredPayments[i];
                if (payment.rowElement) {
                    payment.rowElement.style.display = '';
                }
            }
            
            // Update the display info
            document.getElementById('startItem').textContent = filteredPayments.length > 0 ? startIndex + 1 : 0;
            document.getElementById('endItem').textContent = endIndex;
            document.getElementById('totalItems').textContent = filteredPayments.length;
        }
        
        function updatePagination() {
            const paginationContainer = document.getElementById('pagination');
            paginationContainer.innerHTML = '';
            
            const totalPages = Math.ceil(filteredPayments.length / itemsPerPage);
            
            // Previous button
            const prevButton = document.createElement('button');
            prevButton.innerHTML = 'Trước';
            prevButton.className = 'px-3 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium ' +
                                  (currentPage === 1 ? 'text-gray-300 cursor-not-allowed' : 'text-gray-500 hover:bg-gray-50');
            prevButton.disabled = currentPage === 1;
            prevButton.onclick = () => {
                if (currentPage > 1) {
                    currentPage--;
                    displayPayments();
                    updatePagination();
                }
            };
            paginationContainer.appendChild(prevButton);
            
            // Page numbers
            const maxPagesToShow = 5;
            let startPage = Math.max(1, currentPage - Math.floor(maxPagesToShow / 2));
            let endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);
            
            if (endPage - startPage + 1 < maxPagesToShow) {
                startPage = Math.max(1, endPage - maxPagesToShow + 1);
            }
            
            for (let i = startPage; i <= endPage; i++) {
                const pageButton = document.createElement('button');
                pageButton.innerHTML = i.toString();
                pageButton.className = i === currentPage 
                    ? 'px-3 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium'
                    : 'px-3 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-50';
                pageButton.onclick = () => {
                    currentPage = i;
                    displayPayments();
                    updatePagination();
                };
                paginationContainer.appendChild(pageButton);
            }
            
            // Next button
            const nextButton = document.createElement('button');
            nextButton.innerHTML = 'Sau';
            nextButton.className = 'px-3 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium ' +
                                  (currentPage === totalPages ? 'text-gray-300 cursor-not-allowed' : 'text-gray-500 hover:bg-gray-50');
            nextButton.disabled = currentPage === totalPages;
            nextButton.onclick = () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    displayPayments();
                    updatePagination();
                }
            };
            paginationContainer.appendChild(nextButton);
        }
        
        function updateStatistics() {
            // Calculate statistics based on filtered payments
            let totalRevenue = 0;
            let completed = 0;
            let pending = 0;
            let failed = 0;
            
            filteredPayments.forEach(payment => {
                // Add to total revenue only for completed payments
                if (payment.status === 'Completed' || payment.status === 'Paid') {
                    totalRevenue += payment.amount;
                }
                
                // Count by status
                if (payment.status === 'Completed') {
                    completed++;
                } else if (payment.status === 'Pending') {
                    pending++;
                } else if (payment.status === 'Failed') {
                    failed++;
                }
            });
            
            // Update the display
            const totalRevenueElement = document.getElementById('totalRevenueDisplay');
            if (totalRevenueElement) {
                totalRevenueElement.textContent = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND',
                    maximumFractionDigits: 0
                }).format(totalRevenue);
            }
            
            const completedElement = document.getElementById('completedPaymentsDisplay');
            if (completedElement) {
                completedElement.textContent = completed;
            }
            
            const pendingElement = document.getElementById('pendingPaymentsDisplay');
            if (pendingElement) {
                pendingElement.textContent = pending;
            }
            
            // Update failed payments display if exists
            const failedElement = document.getElementById('failedPaymentsDisplay');
            if (failedElement) {
                failedElement.textContent = failed;
            }
        }
       
        
        function viewPaymentDetail(paymentId) {
            // Redirect to payment detail page instead of opening modal
            window.location.href = '${pageContext.request.contextPath}/admin/payment-action?action=view-detail&paymentId=' + paymentId;
        }
        
        function printPaymentDetails(paymentId) {
            // Open a new window with printable version
            const printWindow = window.open('${pageContext.request.contextPath}/admin/payment-action?action=print-detail&paymentId=' + paymentId, 'PrintWindow', 'height=600,width=800');
            
            // Wait for content to load then print
            printWindow.addEventListener('load', function() {
                setTimeout(() => {
                    printWindow.print();
                    // Some browsers close automatically after print, some don't
                }, 500);
            });
        }
        
        function refundPayment(paymentId) {
            if (confirm('Bạn có chắc chắn muốn hoàn tiền cho giao dịch này?')) {
                console.log('Refunding payment:', paymentId);
            }
        }
    </script>
    </script>
</body>
</html>
