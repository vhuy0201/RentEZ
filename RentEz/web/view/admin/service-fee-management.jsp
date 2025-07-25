<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục phí - RentEz Admin</title>
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
                        <h2 class="text-2xl font-bold text-gray-800">Quản lý danh mục phí</h2>
                        <div class="flex items-center space-x-4">
                            <button onclick="openCreateModal()" 
                                    class="px-4 py-2 bg-gradient-to-r from-primary-500 to-primary-600 text-white rounded-lg hover:from-primary-600 hover:to-primary-700 transition-all shadow-md">
                                <i class="fas fa-plus mr-2"></i>
                                Thêm danh mục phí
                            </button>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="p-6">
                <!-- Search and Filter -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                            <div class="relative">
                                <input type="text" id="searchInput" placeholder="Tên danh mục phí..." value="${search}"
                                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        <div class="flex items-end mt-auto">
                            <button onclick="applyFilters()" 
                                    class="w-full px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">
                                <i class="fas fa-filter mr-2"></i>Tìm kiếm
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Service Fees Table -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gradient-to-r from-primary-500 to-primary-600">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        ID
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Tên danh mục phí
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Đơn giá
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Đơn vị
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Thao tác
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach var="feeCategory" items="${feeCategories}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                            #${feeCategory.categoryId}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 bg-gradient-to-br from-primary-400 to-primary-600 rounded-lg flex items-center justify-center text-white mr-3">
                                                    <i class="fas fa-calculator"></i>
                                                </div>
                                                <div>
                                                    <div class="text-sm font-medium text-gray-900">${feeCategory.name}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            <span class="font-semibold text-green-600">
                                                ${feeCategory.unitPrice}₫
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${feeCategory.unit}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex space-x-2">
                                                <button onclick="openEditModal('${feeCategory.categoryId}')" 
                                                        class="bg-blue-50 text-blue-600 px-3 py-1.5 rounded-lg hover:bg-blue-100 transition-colors">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button onclick="confirmDelete('${feeCategory.categoryId}', '${feeCategory.name}')" 
                                                        class="bg-red-50 text-red-600 px-3 py-1.5 rounded-lg hover:bg-red-100 transition-colors">
                                                    <i class="fas fa-trash"></i>
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
                        Hiển thị <span class="font-medium">${feeCategories.size()}</span> danh mục phí
                    </div>
                    <div class="flex space-x-2">
                            1
                        </button>
                        <button class="px-3 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-50">
                            2
                        </button>
                        <button class="px-3 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-50">
                            Sau
                        </button>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Create/Edit Service Fee Modal -->
    <div id="feeCategoryModal" class="fixed inset-0 bg-black bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-[500px] shadow-lg rounded-xl bg-white">
            <div class="mt-3">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-semibold text-gray-900" id="modalTitle">Tạo danh mục phí mới</h3>
                    <button onclick="closeFeeCategoryModal()" class="text-gray-400 hover:text-gray-600">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
                
                <form method="post" action="${pageContext.request.contextPath}/admin/service-fee-action" id="feeCategoryForm">
                    <input type="hidden" name="action" value="create" id="formAction">
                    <input type="hidden" name="categoryId" id="categoryId">
                    
                    <div class="mb-4">
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-2">Tên danh mục phí</label>
                        <input type="text" id="name" name="name" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500"
                               placeholder="Ví dụ: Điện, Nước, Internet...">
                    </div>
                    
                    <div class="mb-4">
                        <label for="unitPrice" class="block text-sm font-medium text-gray-700 mb-2">Đơn giá</label>
                        <input type="number" id="unitPrice" name="unitPrice" required
                               class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                    </div>
                    
                    <div class="mb-4">
                        <label for="unit" class="block text-sm font-medium text-gray-700 mb-2">Đơn vị</label>
                        <input type="text" id="unit" name="unit" required
                               class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500"
                               placeholder="Ví dụ: kWh, m3, người/tháng...">
                    </div>
                    
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="closeFeeCategoryModal()" 
                                class="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
                            Hủy
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 bg-gradient-to-r from-primary-500 to-primary-600 text-white rounded-lg hover:from-primary-600 hover:to-primary-700 transition-all">
                            <i class="fas fa-save mr-2"></i>Lưu
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-xl bg-white">
            <div class="mt-3 text-center">
                <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-exclamation-triangle text-red-500 text-2xl"></i>
                </div>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Xác nhận xóa</h3>
                <p class="text-sm text-gray-600 mb-6">
                    Bạn có chắc chắn muốn xóa danh mục phí <span id="deleteName" class="font-semibold text-red-600"></span>?
                    <br>Hành động này không thể hoàn tác.
                </p>
                
                <div class="flex justify-center space-x-3">
                    <button type="button" onclick="closeDeleteModal()" 
                            class="px-6 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
                        Hủy
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/admin/service-fee-action" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="categoryId" id="deleteId">
                        <button type="submit" 
                                class="px-6 py-2 bg-gradient-to-r from-red-500 to-red-600 text-white rounded-lg hover:from-red-600 hover:to-red-700 transition-all">
                            <i class="fas fa-trash mr-2"></i>Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Store original data for filtering
        let originalFeeCategories = [];
        let filteredFeeCategories = [];
        
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
            originalFeeCategories = [];
            
            tableRows.forEach(row => {
                if (row.cells.length > 1) { // Skip empty state row
                    const feeCategory = {
                        element: row,
                        id: row.cells[0].textContent.trim().replace('#', ''),
                        name: row.cells[1].querySelector('.text-sm.font-medium').textContent.trim(),
                        unitPrice: row.cells[2].textContent.trim(),
                        unit: row.cells[3].textContent.trim()
                    };
                    originalFeeCategories.push(feeCategory);
                }
            });
            filteredFeeCategories = [...originalFeeCategories];
        }
        
        function setupEventListeners() {
            // Search input - real-time filtering
            document.getElementById('searchInput').addEventListener('input', debounce(applyFilters, 300));
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
            
            // Filter fee categories
            filteredFeeCategories = originalFeeCategories.filter(feeCategory => {
                // Search filter
                if (searchTerm && !matchesSearch(feeCategory, searchTerm)) {
                    return false;
                }
                
                return true;
            });
            
            // Update table display
            updateTableDisplay();
            
            // Update pagination info
            updatePaginationInfo();
            
            // Update URL (optional)
            updateURL(searchTerm);
        }
        
        function matchesSearch(feeCategory, searchTerm) {
            return (
                feeCategory.name.toLowerCase().includes(searchTerm) ||
                feeCategory.unit.toLowerCase().includes(searchTerm) ||
                feeCategory.unitPrice.toLowerCase().includes(searchTerm)
            );
        }
        
        function updateTableDisplay() {
            const tbody = document.querySelector('tbody');
            
            // Hide all original rows
            originalFeeCategories.forEach(feeCategory => {
                feeCategory.element.style.display = 'none';
            });
            
            // Show filtered rows
            if (filteredFeeCategories.length > 0) {
                filteredFeeCategories.forEach(feeCategory => {
                    feeCategory.element.style.display = '';
                });
                
                // Hide empty state if it exists
                const emptyRow = tbody.querySelector('.empty-state-row');
                if (emptyRow) {
                    emptyRow.style.display = 'none';
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
                <td colspan="5" class="px-6 py-8 text-center text-gray-500">
                    <div class="flex flex-col items-center justify-center">
                        <i class="fas fa-calculator mb-3 text-3xl text-gray-400"></i>
                        <p class="text-lg font-medium">Không tìm thấy danh mục phí nào</p>
                        <p class="text-sm text-gray-400 mt-1">Thử thay đổi từ khóa tìm kiếm</p>
                    </div>
                </td>
            `;
            tbody.appendChild(emptyRow);
        }
        
        function updatePaginationInfo() {
            const totalShowing = filteredFeeCategories.length;
            const paginationInfo = document.querySelector('.text-sm.text-gray-700');
            if (paginationInfo) {
                paginationInfo.innerHTML = `
                    Hiển thị <span class="font-medium">${totalShowing}</span> danh mục phí
                `;
            }
            
            // Show filter info if filters are active
            showFilterInfo(totalShowing);
        }
        
        function showFilterInfo(totalShowing) {
            const existingInfo = document.querySelector('.filter-info');
            if (existingInfo) {
                existingInfo.remove();
            }
            
            if (totalShowing !== originalFeeCategories.length) {
                const info = document.createElement('div');
                info.className = 'filter-info bg-blue-50 border border-blue-200 rounded-lg p-3 mb-4 text-blue-700';
                info.innerHTML = `
                    <i class="fas fa-info-circle mr-2"></i>
                    Đang hiển thị ${totalShowing} trong tổng số ${originalFeeCategories.length} danh mục phí
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
            
            // Apply filters to show all
            applyFilters();
        }
        
        function updateURL(search) {
            const url = new URL(window.location);
            
            if (search) url.searchParams.set('search', search);
            else url.searchParams.delete('search');
            
            // Update URL without reloading page
            window.history.replaceState({}, '', url);
        }
        
        function initializeFiltersFromURL() {
            const urlParams = new URLSearchParams(window.location.search);
            
            if (urlParams.has('search')) {
                document.getElementById('searchInput').value = urlParams.get('search');
            }
            
            // Apply filters if any were set
            if (urlParams.toString()) {
                applyFilters();
            }
        }
        
        function openCreateModal() {
            document.getElementById('modalTitle').textContent = 'Tạo danh mục phí mới';
            document.getElementById('formAction').value = 'create';
            document.getElementById('feeCategoryForm').reset();
            document.getElementById('feeCategoryModal').classList.remove('hidden');
        }
        
        function openEditModal(categoryId) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa danh mục phí';
            document.getElementById('formAction').value = 'edit';
            
            // Gọi API để lấy thông tin fee category
            fetch('${pageContext.request.contextPath}/admin/service-fees?action=get&categoryId=' + categoryId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Không thể lấy thông tin danh mục phí');
                    }
                    return response.json();
                })
                .then(data => {
                    document.getElementById('categoryId').value = data.categoryId;
                    document.getElementById('name').value = data.name;
                    document.getElementById('unitPrice').value = data.unitPrice;
                    document.getElementById('unit').value = data.unit;
                    document.getElementById('feeCategoryModal').classList.remove('hidden');
                })
                .catch(error => {
                    alert('Lỗi: ' + error.message);
                });
        }
        
        function closeFeeCategoryModal() {
            document.getElementById('feeCategoryModal').classList.add('hidden');
        }
        
        function confirmDelete(categoryId, name) {
            document.getElementById('deleteId').value = categoryId;
            document.getElementById('deleteName').textContent = name;
            document.getElementById('deleteModal').classList.remove('hidden');
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.add('hidden');
        }
        
        // Close modals when clicking outside
        window.onclick = function(event) {
            const feeCategoryModal = document.getElementById('feeCategoryModal');
            const deleteModal = document.getElementById('deleteModal');
            
            if (event.target === feeCategoryModal) {
                closeFeeCategoryModal();
            }
            if (event.target === deleteModal) {
                closeDeleteModal();
            }
        }
    </script>
</body>
</html>
