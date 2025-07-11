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
                    <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                            <div class="relative">
                                <input type="text" id="searchInput" placeholder="Mã giao dịch, người dùng..."
                                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                            <select id="statusFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="">Tất cả trạng thái</option>
                                <option value="completed">Thành công</option>
                                <option value="pending">Đang xử lý</option>
                                <option value="failed">Thất bại</option>
                                <option value="refunded">Đã hoàn tiền</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Phương thức</label>
                            <select id="methodFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="">Tất cả phương thức</option>
                                <option value="vnpay">VNPay</option>
                                <option value="momo">MoMo</option>
                                <option value="bank_transfer">Chuyển khoản</option>
                                <option value="cash">Tiền mặt</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Từ ngày</label>
                            <input type="date" id="fromDate" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
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

    <!-- Payment Detail Modal -->
    <div id="paymentDetailModal" class="fixed inset-0 bg-black bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-[600px] shadow-lg rounded-xl bg-white">
            <div class="mt-3">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-semibold text-gray-900">Chi tiết giao dịch</h3>
                    <button onclick="closePaymentDetailModal()" class="text-gray-400 hover:text-gray-600">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
                
                <div id="paymentDetailContent" class="space-y-4">
                    <!-- Payment details will be loaded here -->
                    <div class="flex justify-center items-center py-8 hidden" id="paymentDetailLoader">
                        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-600"></div>
                    </div>
                </div>
                
                <div class="mt-6 flex justify-end space-x-3">
                    <button onclick="closePaymentDetailModal()" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors">
                        Đóng
                    </button>
                    <button id="printPaymentBtn" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                        <i class="fas fa-print mr-2"></i>In hóa đơn
                    </button>
                </div>
            </div>
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
            document.getElementById('searchInput').addEventListener('input', applyFilters);
            document.getElementById('statusFilter').addEventListener('change', applyFilters);
            document.getElementById('methodFilter').addEventListener('change', applyFilters);
            document.getElementById('fromDate').addEventListener('change', applyFilters);
            
            // Set up today's date minus 30 days as default for the date filter
            const today = new Date();
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(today.getDate() - 30);
            
            const dateInput = document.getElementById('fromDate');
            dateInput.value = formatDateForInput(thirtyDaysAgo);
            
            // Apply filters initially
            applyFilters();
        });
        
        function formatDateForInput(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }
        
        function applyFilters() {
            const search = document.getElementById('searchInput').value.toLowerCase();
            const status = document.getElementById('statusFilter').value;
            const method = document.getElementById('methodFilter').value;
            const dateFrom = document.getElementById('fromDate').value;
            
            // Filter the payments
            filteredPayments = allPayments.filter(payment => {
                // Search filter
                if (search && !payment.transCode.toLowerCase().includes(search) && 
                    !document.querySelector(`[data-payer-id="${payment.payerId}"]`).textContent.toLowerCase().includes(search)) {
                    return false;
                }
                
                // Status filter
                if (status && payment.status !== status) {
                    return false;
                }
                
                // Method filter
                if (method && payment.method !== method) {
                    return false;
                }
                
                // Date filter
                if (dateFrom) {
                    const fromDate = new Date(dateFrom);
                    const paymentDate = new Date(payment.date);
                    if (paymentDate < fromDate) {
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
                // Add to total revenue
                totalRevenue += payment.amount;
                
                // Count by status
                if (payment.status === 'Completed') {
                    completed++;
                } else if (payment.status === 'Pending') {
                    pending++;
                } else if (payment.status === 'Paid') {
                    failed++;
                }
            });
            
            // Update the display
            document.getElementById('totalRevenueDisplay').textContent = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND',
                maximumFractionDigits: 0
            }).format(totalRevenue);
            
            document.getElementById('completedPaymentsDisplay').textContent = completed;
            document.getElementById('pendingPaymentsDisplay').textContent = pending;
            document.getElementById('failedPaymentsDisplay').textContent = failed;
        }
       
        
        function viewPaymentDetail(paymentId) {
            // Show the modal first with loading state
            const modal = document.getElementById('paymentDetailModal');
            const contentArea = document.getElementById('paymentDetailContent');
            const loader = document.getElementById('paymentDetailLoader');
            
            // Clear previous content and show loader
            contentArea.innerHTML = '';
            contentArea.appendChild(loader);
            loader.classList.remove('hidden');
            modal.classList.remove('hidden');
            
            // Load payment details via AJAX
            fetch('${pageContext.request.contextPath}/admin/payment-action?action=view-detail&paymentId=' + paymentId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text();
                })
                .then(html => {
                    // Hide loader and show content
                    loader.classList.add('hidden');
                    
                    if (html.trim().length === 0) {
                        contentArea.innerHTML = `
                            <div class="flex flex-col items-center justify-center p-6 text-center">
                                <i class="fas fa-exclamation-circle text-yellow-500 text-5xl mb-4"></i>
                                <h3 class="text-lg font-semibold text-gray-900 mb-2">Không tìm thấy chi tiết</h3>
                                <p class="text-gray-600">Không thể tải thông tin chi tiết của giao dịch này.</p>
                            </div>
                        `;
                    } else {
                        contentArea.innerHTML = html;
                    }
                    
                    // Setup print button functionality
                    document.getElementById('printPaymentBtn').onclick = () => printPaymentDetails(paymentId);
                })
                .catch(error => {
                    console.error('Error fetching payment details:', error);
                    loader.classList.add('hidden');
                    contentArea.innerHTML = `
                        <div class="flex flex-col items-center justify-center p-6 text-center">
                            <i class="fas fa-exclamation-triangle text-red-500 text-5xl mb-4"></i>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Đã xảy ra lỗi</h3>
                            <p class="text-gray-600">Không thể tải thông tin chi tiết. Vui lòng thử lại sau.</p>
                        </div>
                    `;
                });
        }
        
        function closePaymentDetailModal() {
            document.getElementById('paymentDetailModal').classList.add('hidden');
            // Clear content when closing
            document.getElementById('paymentDetailContent').innerHTML = '';
            document.getElementById('paymentDetailLoader').classList.remove('hidden');
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
        
        function openDeleteModal(paymentId, transactionId) {
            document.getElementById('deleteId').value = paymentId;
            document.getElementById('deleteName').innerText = transactionId;
            document.getElementById('deleteModal').classList.remove('hidden');
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.add('hidden');
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const paymentDetailModal = document.getElementById('paymentDetailModal');
            const deleteModal = document.getElementById('deleteModal');
            
            if (event.target === paymentDetailModal) {
                closePaymentDetailModal();
            } else if (event.target === deleteModal) {
                closeDeleteModal();
            }
        }
    </script>
</body>
</html>
