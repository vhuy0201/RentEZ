<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt thuê - RentEz Admin</title>
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
                        <h2 class="text-2xl font-bold text-gray-800">Quản lý đặt thuê</h2>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="p-6">
                <!-- Search and Filter -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                            <div class="relative">
                                <input type="text" id="searchInput" placeholder="Mã đặt thuê, tên bất động sản..."
                                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                            <select id="statusFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Confirmed">Đã xác nhận</option>
                                <option value="Pending">Chờ xử lý</option>
                                <option value="Cancelled">Đã hủy</option>
                                <option value="Completed">Hoàn thành</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Từ ngày</label>
                            <input type="date" id="fromDate" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Đến ngày</label>
                            <input type="date" id="toDate" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                        </div>
                        <div class="flex items-end">
                            <button onclick="applyFilters()" 
                                    class="w-full px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">
                                <i class="fas fa-filter mr-2"></i>Lọc
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Stats Summary -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
                    <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-blue-100">Đặt thuê đã xác nhận</p>
                                <p class="text-2xl font-bold">${confirmedBookings}</p>
                            </div>
                            <i class="fas fa-check-circle text-3xl text-blue-200"></i>
                        </div>
                    </div>
                    <div class="bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-yellow-100">Đặt thuê chờ xử lý</p>
                                <p class="text-2xl font-bold">${pendingBookings}</p>
                            </div>
                            <i class="fas fa-clock text-3xl text-yellow-200"></i>
                        </div>
                    </div>
                    <div class="bg-gradient-to-br from-red-500 to-red-600 rounded-xl p-6 text-white">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-red-100">Đặt thuê đã hủy</p>
                                <p class="text-2xl font-bold">${cancelledBookings}</p>
                            </div>
                            <i class="fas fa-times-circle text-3xl text-red-200"></i>
                        </div>
                    </div>
                </div>

                <!-- Bookings Table -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gradient-to-r from-primary-500 to-primary-600">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Mã đặt thuê
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Bất động sản
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Người thuê
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Giá thuê hàng tháng
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Thời hạn
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Trạng thái
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Thao tác
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach var="bookingDTO" items="${bookingDTOs}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                            #${bookingDTO.bookingId}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-12 h-12 bg-gradient-to-br from-primary-400 to-primary-600 rounded-lg flex items-center justify-center text-white mr-3">
                                                    <i class="fas fa-home"></i>
                                                </div>
                                                <div>
                                                    <div class="text-sm font-medium text-gray-900">${bookingDTO.property.title}</div>
                                                    <div class="text-sm text-gray-500">${bookingDTO.location}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-blue-600 rounded-full flex items-center justify-center text-white font-semibold">
                                                    ${bookingDTO.renter.name.charAt(0)}
                                                </div>
                                                <div class="ml-3">
                                                    <div class="text-sm font-medium text-gray-900">${bookingDTO.renter.name}</div>
                                                    <div class="text-sm text-gray-500">${bookingDTO.renter.phone}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm font-semibold text-gray-900">
                                                <fmt:formatNumber value="${bookingDTO.monthlyRent}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                Tiền cọc: <fmt:formatNumber value="${bookingDTO.depositAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-gray-900">
                                                <fmt:formatDate value="${bookingDTO.startDate}" pattern="dd/MM/yyyy"/> - 
                                                <fmt:formatDate value="${bookingDTO.endDate}" pattern="dd/MM/yyyy"/>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <c:set var="months" value="${((bookingDTO.endDate.time - bookingDTO.startDate.time) / (1000 * 60 * 60 * 24 * 30))}" />
                                                <fmt:formatNumber value="${months}" maxFractionDigits="1" /> tháng
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${bookingDTO.status eq 'Confirmed'}">
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                        Đã xác nhận
                                                    </span>
                                                </c:when>
                                                <c:when test="${bookingDTO.status eq 'Pending'}">
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                                        Chờ xử lý
                                                    </span>
                                                </c:when>
                                                <c:when test="${bookingDTO.status eq 'Cancelled'}">
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                                        Đã hủy
                                                    </span>
                                                </c:when>
                                                <c:when test="${bookingDTO.status eq 'Completed'}">
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">
                                                        Hoàn thành
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                                                        ${bookingDTO.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="text-xs text-gray-500 mt-1">
                                                <fmt:formatDate value="${bookingDTO.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            <div class="flex space-x-2">
                                                <a href="${pageContext.request.contextPath}/admin/booking-detail?id=${bookingDTO.bookingId}" 
                                                   class="text-primary-600 hover:text-primary-800 transition-colors">
                                                    <i class="fas fa-eye"></i> Xem
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty bookingDTOs}">
                                    <tr>
                                        <td colspan="7" class="px-6 py-8 text-center text-gray-500">
                                            <div class="flex flex-col items-center justify-center">
                                                <i class="fas fa-search mb-3 text-3xl text-gray-400"></i>
                                                <p class="text-lg font-medium">Không tìm thấy đặt thuê nào</p>
                                                <p class="text-sm text-gray-400 mt-1">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="flex justify-center my-6">
                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                            <!-- Previous Page -->
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/admin/bookings?page=${currentPage - 1}" 
                                   class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>
                            
                            <!-- Page Numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage == i}">
                                        <span class="relative inline-flex items-center px-4 py-2 border border-primary-500 bg-primary-50 text-sm font-medium text-primary-600">
                                            ${i}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/bookings?page=${i}" 
                                           class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <!-- Next Page -->
                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/admin/bookings?page=${currentPage + 1}" 
                                   class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </nav>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Store original data for filtering
        let originalBookings = [];
        let filteredBookings = [];
        
        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Store original table data
            storeOriginalData();
            
            // Initialize filters from URL params
            initializeFiltersFromURL();
            
            // Add event listeners for real-time filtering
            setupEventListeners();
        });
        
        function storeOriginalData() {
            const tableRows = document.querySelectorAll('tbody tr');
            originalBookings = [];
            
            tableRows.forEach(row => {
                if (row.cells.length > 1) { // Skip empty state row
                    const booking = {
                        element: row,
                        id: row.cells[0].textContent.trim(),
                        propertyName: row.cells[1].querySelector('.text-sm.font-medium').textContent.trim(),
                        renterName: row.cells[2].querySelector('.text-sm.font-medium').textContent.trim(),
                        renterPhone: row.cells[2].querySelector('.text-sm.text-gray-500').textContent.trim(),
                        status: getStatusFromElement(row.cells[5]),
                        createdDate: getDateFromElement(row.cells[5])
                    };
                    originalBookings.push(booking);
                }
            });
            filteredBookings = [...originalBookings];
        }
        
        function getStatusFromElement(statusCell) {
            const statusSpan = statusCell.querySelector('span');
            if (statusSpan.classList.contains('bg-green-100')) return 'Confirmed';
            if (statusSpan.classList.contains('bg-yellow-100')) return 'Pending';
            if (statusSpan.classList.contains('bg-red-100')) return 'Cancelled';
            if (statusSpan.classList.contains('bg-blue-100')) return 'Completed';
            return statusSpan.textContent.trim();
        }
        
        function getDateFromElement(statusCell) {
            const dateText = statusCell.querySelector('.text-xs.text-gray-500').textContent.trim();
            return dateText;
        }
        
        function setupEventListeners() {
            // Search input - real-time filtering
            document.getElementById('searchInput').addEventListener('input', debounce(applyFilters, 300));
            
            // Status filter
            document.getElementById('statusFilter').addEventListener('change', applyFilters);
            
            // Date filters
            document.getElementById('fromDate').addEventListener('change', applyFilters);
            document.getElementById('toDate').addEventListener('change', applyFilters);
        }
        
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
            const searchTerm = document.getElementById('searchInput').value.toLowerCase().trim();
            const statusFilter = document.getElementById('statusFilter').value;
            const fromDate = document.getElementById('fromDate').value;
            const toDate = document.getElementById('toDate').value;
            
            // Filter bookings
            filteredBookings = originalBookings.filter(booking => {
                // Search filter
                if (searchTerm && !matchesSearch(booking, searchTerm)) {
                    return false;
                }
                
                // Status filter
                if (statusFilter && booking.status !== statusFilter) {
                    return false;
                }
                
                // Date filter
                if ((fromDate || toDate) && !matchesDateRange(booking, fromDate, toDate)) {
                    return false;
                }
                
                return true;
            });
            
            // Update table display
            updateTableDisplay();
            
            // Update stats
            updateStats();
            
            // Update URL (optional)
            updateURL(searchTerm, statusFilter, fromDate, toDate);
        }
        
        function matchesSearch(booking, searchTerm) {
            return (
                booking.id.toLowerCase().includes(searchTerm) ||
                booking.propertyName.toLowerCase().includes(searchTerm) ||
                booking.renterName.toLowerCase().includes(searchTerm) ||
                booking.renterPhone.toLowerCase().includes(searchTerm)
            );
        }
        
        function matchesDateRange(booking, fromDate, toDate) {
            const bookingDate = parseBookingDate(booking.createdDate);
            if (!bookingDate) return true;
            
            if (fromDate) {
                const from = new Date(fromDate);
                if (bookingDate < from) return false;
            }
            
            if (toDate) {
                const to = new Date(toDate);
                to.setHours(23, 59, 59, 999); // End of day
                if (bookingDate > to) return false;
            }
            
            return true;
        }
        
        function parseBookingDate(dateString) {
            // Parse date from format "dd/MM/yyyy HH:mm"
            const match = dateString.match(/(\d{2})\/(\d{2})\/(\d{4})\s+(\d{2}):(\d{2})/);
            if (match) {
                const [, day, month, year, hour, minute] = match;
                return new Date(year, month - 1, day, hour, minute);
            }
            return null;
        }
        
        function updateTableDisplay() {
            const tbody = document.querySelector('tbody');
            
            // Hide all original rows
            originalBookings.forEach(booking => {
                booking.element.style.display = 'none';
            });
            
            // Show filtered rows
            if (filteredBookings.length > 0) {
                filteredBookings.forEach(booking => {
                    booking.element.style.display = '';
                });
                
                // Hide empty state if it exists
                const emptyRow = tbody.querySelector('td[colspan="7"]');
                if (emptyRow) {
                    emptyRow.parentElement.style.display = 'none';
                }
            } else {
                // Show empty state
                showEmptyState(tbody);
            }
        }
        
        function showEmptyState(tbody) {
            // Remove existing empty state
            const existingEmpty = tbody.querySelector('.empty-state-row');
            if (existingEmpty) {
                existingEmpty.remove();
            }
            
            // Create new empty state
            const emptyRow = document.createElement('tr');
            emptyRow.className = 'empty-state-row';
            emptyRow.innerHTML = `
                <td colspan="7" class="px-6 py-8 text-center text-gray-500">
                    <div class="flex flex-col items-center justify-center">
                        <i class="fas fa-search mb-3 text-3xl text-gray-400"></i>
                        <p class="text-lg font-medium">Không tìm thấy đặt thuê nào</p>
                        <p class="text-sm text-gray-400 mt-1">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
                    </div>
                </td>
            `;
            tbody.appendChild(emptyRow);
        }
        
        function updateStats() {
            const stats = {
                confirmed: filteredBookings.filter(b => b.status === 'Confirmed').length,
                pending: filteredBookings.filter(b => b.status === 'Pending').length,
                cancelled: filteredBookings.filter(b => b.status === 'Cancelled').length,
                completed: filteredBookings.filter(b => b.status === 'Completed').length,
                total: filteredBookings.length
            };
            
            // Update stats display
            const statsCards = document.querySelectorAll('.grid .bg-gradient-to-br');
            if (statsCards.length >= 4) {
                statsCards[0].querySelector('.text-2xl').textContent = stats.confirmed;
                statsCards[1].querySelector('.text-2xl').textContent = stats.pending;
                statsCards[2].querySelector('.text-2xl').textContent = stats.cancelled;
                // Keep total revenue as is for the 4th card
            }
            
            // Show filter info
            showFilterInfo(stats.total);
        }
        
        function showFilterInfo(totalShowing) {
            const existingInfo = document.querySelector('.filter-info');
            if (existingInfo) {
                existingInfo.remove();
            }
            
            if (totalShowing !== originalBookings.length) {
                const info = document.createElement('div');
                info.className = 'filter-info bg-blue-50 border border-blue-200 rounded-lg p-3 mb-4 text-blue-700';
                info.innerHTML = `
                    <i class="fas fa-info-circle mr-2"></i>
                    Đang hiển thị ${totalShowing} trong tổng số ${originalBookings.length} đặt thuê
                    <button onclick="clearFilters()" class="ml-4 text-blue-600 hover:text-blue-800 underline">
                        Xóa bộ lọc
                    </button>
                `;
                
                const table = document.querySelector('.bg-white.rounded-xl.shadow-sm.border');
                table.parentNode.insertBefore(info, table);
            }
        }
        
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = '';
            document.getElementById('fromDate').value = '';
            document.getElementById('toDate').value = '';
            
            // Apply filters to show all
            applyFilters();
        }
        
        function updateURL(search, status, fromDate, toDate) {
            const url = new URL(window.location);
            
            if (search) url.searchParams.set('search', search);
            else url.searchParams.delete('search');
            
            if (status) url.searchParams.set('status', status);
            else url.searchParams.delete('status');
            
            if (fromDate) url.searchParams.set('dateFrom', fromDate);
            else url.searchParams.delete('dateFrom');
            
            if (toDate) url.searchParams.set('dateTo', toDate);
            else url.searchParams.delete('dateTo');
            
            // Update URL without reloading page
            window.history.replaceState({}, '', url);
        }
        
        function initializeFiltersFromURL() {
            const urlParams = new URLSearchParams(window.location.search);
            
            if (urlParams.has('search')) {
                document.getElementById('searchInput').value = urlParams.get('search');
            }
            
            if (urlParams.has('status')) {
                document.getElementById('statusFilter').value = urlParams.get('status');
            }
            
            if (urlParams.has('dateFrom')) {
                document.getElementById('fromDate').value = urlParams.get('dateFrom');
            }
            
            if (urlParams.has('dateTo')) {
                document.getElementById('toDate').value = urlParams.get('dateTo');
            }
            
            // Apply filters if any were set
            if (urlParams.toString()) {
                applyFilters();
            }
        }
        
        function exportBookings() {
            // Get current filter values
            const search = document.getElementById('searchInput').value;
            const status = document.getElementById('statusFilter').value;
            const fromDate = document.getElementById('fromDate').value;
            const toDate = document.getElementById('toDate').value;
            
            // Create form for POST submission
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/admin/bookings';
            
            // Add action parameter
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'export';
            form.appendChild(actionInput);
            
            // Add filter parameters
            if (search) {
                const searchInput = document.createElement('input');
                searchInput.type = 'hidden';
                searchInput.name = 'search';
                searchInput.value = search;
                form.appendChild(searchInput);
            }
            
            if (status) {
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = status;
                form.appendChild(statusInput);
            }
            
            if (fromDate) {
                const fromInput = document.createElement('input');
                fromInput.type = 'hidden';
                fromInput.name = 'dateFrom';
                fromInput.value = fromDate;
                form.appendChild(fromInput);
            }
            
            if (toDate) {
                const toInput = document.createElement('input');
                toInput.type = 'hidden';
                toInput.name = 'dateTo';
                toInput.value = toDate;
                form.appendChild(toInput);
            }
            
            // Submit form
            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);
        }
    </script>
</body>
</html>
