<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đăng bài - RentEz Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                            900: '#7c2d12'
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50">
    <!-- Include Sidebar -->
    <jsp:include page="sidebar.jsp" />
    
    <!-- Main Content -->
    <div class="ml-64 min-h-screen">
        <div class="p-8">
            <!-- Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Quản lý đăng bài</h1>
                <p class="text-gray-600">Duyệt và quản lý các bài đăng bất động sản</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.success}">
                <div class="mb-6 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg">
                    <i class="fas fa-check-circle mr-2"></i>
                    ${sessionScope.success}
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>
            
            <c:if test="${not empty sessionScope.error}">
                <div class="mb-6 bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    ${sessionScope.error}
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- Statistics Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="w-8 h-8 bg-yellow-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-clock text-yellow-600"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Chờ duyệt</p>
                            <p class="text-2xl font-semibold text-gray-900">${pendingCount}</p>
                        </div>
                    </div>
                </div>
                
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-check text-green-600"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Đã duyệt</p>
                            <p class="text-2xl font-semibold text-gray-900">${approvedCount}</p>
                        </div>
                    </div>
                </div>
                
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-home text-blue-600"></i>
                            </div>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Tổng bài đăng</p>
                            <p class="text-2xl font-semibold text-gray-900">${totalProperties}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filters and Search -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <div class="flex flex-wrap gap-4">
                    <div class="flex-1 min-w-64">
                        <input type="text" id="searchInput" value="${searchQuery}" 
                               placeholder="Tìm kiếm theo tiêu đề, mô tả, địa chỉ..."
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <select id="statusFilter" class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent">
                            <option value="">Tất cả trạng thái</option>
                            <option value="pending" ${statusFilter == 'pending' ? 'selected' : ''}>Chờ duyệt</option>
                            <option value="approved" ${statusFilter == 'approved' ? 'selected' : ''}>Đã duyệt</option>
                        </select>
                    </div>
                    
                    <button onclick="applyFilters()" class="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">
                        <i class="fas fa-search mr-2"></i>Tìm kiếm
                    </button>
                </div>
            </div>

            <!-- Bulk Actions -->
            <div class="bg-white rounded-lg shadow-md mb-6">
                <div class="p-4 border-b border-gray-200">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center gap-4">
                            <label class="flex items-center">
                                <input type="checkbox" id="selectAll" class="rounded border-gray-300 text-primary-600 focus:ring-primary-500">
                                <span class="ml-2 text-sm text-gray-700">Chọn tất cả</span>
                            </label>
                            <span id="selectedCount" class="text-sm text-gray-500">0 mục được chọn</span>
                        </div>
                        
                        <div class="flex items-center gap-2">
                            <button id="bulkApproveBtn" onclick="bulkApprove()" 
                                    class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed" 
                                    disabled>
                                <i class="fas fa-check mr-2"></i>Duyệt hàng loạt
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Properties Table -->
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <input type="checkbox" class="rounded border-gray-300 text-primary-600 focus:ring-primary-500">
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Bài đăng
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Chủ sở hữu
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Giá
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Trạng thái
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Thao tác
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="property" items="${properties}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <input type="checkbox" class="property-checkbox rounded border-gray-300 text-primary-600 focus:ring-primary-500" 
                                               value="${property.propertyId}">
                                    </td>
                                    
                                    <td class="px-6 py-4">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-16 w-16">
                                                <img class="h-16 w-16 rounded-lg object-cover" 
                                                     src="${property.avatar != null ? property.avatar : '/api/placeholder/64/64'}" 
                                                     alt="Property Image">
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">
                                                    ${property.title}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    ${property.address}
                                                </div>
                                                <div class="text-xs text-gray-400">
                                                    ${propertyTypeMap[property.typeId].typeName} • 
                                                    ${property.numberOfBedrooms} phòng ngủ • 
                                                    ${property.numberOfBathrooms} phòng tắm
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">
                                            ${landlordMap[property.landlordId].name}
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            ${landlordMap[property.landlordId].email}
                                        </div>
                                    </td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">
                                            <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </div>
                                        <div class="text-xs text-gray-500">
                                            ${property.size} m²
                                        </div>
                                    </td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${property.publicStatus}">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                    <i class="fas fa-check-circle mr-1"></i>
                                                    Đã duyệt
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                                    <i class="fas fa-clock mr-1"></i>
                                                    Chờ duyệt
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div class="flex items-center gap-2">
                                            <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                               class="text-blue-600 hover:text-blue-900 transition-colors">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            
                                            <c:if test="${!property.publicStatus}">
                                                <button onclick="approveProperty('${property.propertyId}')" 
                                                        class="text-green-600 hover:text-green-900 transition-colors" 
                                                        title="Duyệt bài đăng">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </c:if>
                                            
                                            <c:if test="${property.publicStatus}">
                                                <button onclick="rejectProperty('${property.propertyId}')" 
                                                        class="text-red-600 hover:text-red-900 transition-colors" 
                                                        title="Từ chối bài đăng">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <c:if test="${empty properties}">
                        <div class="text-center py-12">
                            <i class="fas fa-home text-gray-400 text-4xl mb-4"></i>
                            <p class="text-gray-500">Không tìm thấy bài đăng nào</p>
                        </div>
                    </c:if>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="px-6 py-3 border-t border-gray-200">
                        <div class="flex items-center justify-between">
                            <div class="text-sm text-gray-700">
                                Hiển thị ${properties.size()} trên ${totalProperties} bài đăng
                            </div>
                            
                            <div class="flex items-center gap-2">
                                <c:if test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}&status=${statusFilter}&search=${searchQuery}" 
                                       class="px-3 py-2 text-sm bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                                        Trước
                                    </a>
                                </c:if>
                                
                                <c:forEach begin="${currentPage - 2 > 0 ? currentPage - 2 : 1}" 
                                          end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" var="i">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <span class="px-3 py-2 text-sm bg-primary-600 text-white rounded-md">${i}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="?page=${i}&status=${statusFilter}&search=${searchQuery}" 
                                               class="px-3 py-2 text-sm bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                                                ${i}
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                
                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}&status=${statusFilter}&search=${searchQuery}" 
                                       class="px-3 py-2 text-sm bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                                        Sau
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        // Store original data for filtering
        let originalProperties = [];
        let filteredProperties = [];
        
        // Checkbox functionality elements
        const selectAllCheckbox = document.getElementById('selectAll');
        const selectedCountSpan = document.getElementById('selectedCount');
        const bulkApproveBtn = document.getElementById('bulkApproveBtn');
        
        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Store original table data
            storeOriginalData();
            
            // Initialize filters from URL params or current values
            initializeFiltersFromCurrent();
            
            // Add event listeners for real-time filtering
            setupEventListeners();
            
            // Setup checkbox functionality
            setupCheckboxFunctionality();
        });
        
        function storeOriginalData() {
            const tableRows = document.querySelectorAll('tbody tr');
            originalProperties = [];
            
            tableRows.forEach(row => {
                if (row.cells.length > 1) { // Skip empty state row
                    const property = {
                        element: row,
                        checkbox: row.querySelector('.property-checkbox'),
                        title: row.cells[1].querySelector('.text-sm.font-medium').textContent.trim(),
                        address: row.cells[1].querySelector('.text-sm.text-gray-500').textContent.trim(),
                        owner: row.cells[2].textContent.trim(),
                        price: row.cells[3].textContent.trim(),
                        status: getStatusFromElement(row.cells[4])
                    };
                    originalProperties.push(property);
                }
            });
            filteredProperties = [...originalProperties];
        }
        
        function getStatusFromElement(statusCell) {
            const statusSpan = statusCell.querySelector('span');
            if (statusSpan.classList.contains('bg-yellow-100')) return 'pending';
            if (statusSpan.classList.contains('bg-green-100')) return 'approved';
            return '';
        }
        
        function setupEventListeners() {
            // Search input - real-time filtering
            document.getElementById('searchInput').addEventListener('input', debounce(applyFilters, 300));
            
            // Status filter
            document.getElementById('statusFilter').addEventListener('change', applyFilters);
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
            
            // Filter properties
            filteredProperties = originalProperties.filter(property => {
                // Search filter
                if (searchTerm && !matchesSearch(property, searchTerm)) {
                    return false;
                }
                
                // Status filter
                if (statusFilter && property.status !== statusFilter) {
                    return false;
                }
                
                return true;
            });
            
            // Update table display
            updateTableDisplay();
            
            // Update stats
            updateStats();
            
            // Reset checkbox selections
            resetCheckboxes();
            
            // Update URL (optional)
            updateURL(searchTerm, statusFilter);
        }
        
        function matchesSearch(property, searchTerm) {
            return (
                property.title.toLowerCase().includes(searchTerm) ||
                property.address.toLowerCase().includes(searchTerm) ||
                property.owner.toLowerCase().includes(searchTerm)
            );
        }
        
        function updateTableDisplay() {
            const tbody = document.querySelector('tbody');
            
            // Hide all original rows
            originalProperties.forEach(property => {
                property.element.style.display = 'none';
            });
            
            // Show filtered rows
            if (filteredProperties.length > 0) {
                filteredProperties.forEach(property => {
                    property.element.style.display = '';
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
                <td colspan="6" class="px-6 py-8 text-center text-gray-500">
                    <div class="flex flex-col items-center justify-center">
                        <i class="fas fa-home mb-3 text-3xl text-gray-400"></i>
                        <p class="text-lg font-medium">Không tìm thấy bài đăng nào</p>
                        <p class="text-sm text-gray-400 mt-1">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
                    </div>
                </td>
            `;
            tbody.appendChild(emptyRow);
        }
        
        function updateStats() {
            const stats = {
                pending: filteredProperties.filter(p => p.status === 'pending').length,
                approved: filteredProperties.filter(p => p.status === 'approved').length,
                total: filteredProperties.length
            };
            
            // Update stats cards
            const statsCards = document.querySelectorAll('.grid .bg-white.rounded-lg.shadow-md');
            if (statsCards.length >= 3) {
                const pendingCard = statsCards[0].querySelector('.text-2xl');
                const approvedCard = statsCards[1].querySelector('.text-2xl');
                const totalCard = statsCards[2].querySelector('.text-2xl');
                
                if (pendingCard) pendingCard.textContent = stats.pending;
                if (approvedCard) approvedCard.textContent = stats.approved;
                if (totalCard) totalCard.textContent = stats.total;
            }
            
            // Show filter info
            showFilterInfo(stats.total);
        }
        
        function showFilterInfo(totalShowing) {
            const existingInfo = document.querySelector('.filter-info');
            if (existingInfo) {
                existingInfo.remove();
            }
            
            if (totalShowing !== originalProperties.length) {
                const info = document.createElement('div');
                info.className = 'filter-info bg-blue-50 border border-blue-200 rounded-lg p-3 mb-4 text-blue-700';
                info.innerHTML = `
                    <i class="fas fa-info-circle mr-2"></i>
                    Đang hiển thị ${totalShowing} trong tổng số ${originalProperties.length} bài đăng
                    <button onclick="clearFilters()" class="ml-4 text-blue-600 hover:text-blue-800 underline">
                        Xóa bộ lọc
                    </button>
                `;
                
                const bulkActionsCard = document.querySelector('.bg-white.rounded-lg.shadow-md.mb-6');
                bulkActionsCard.parentNode.insertBefore(info, bulkActionsCard);
            }
        }
        
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = '';
            
            // Apply filters to show all
            applyFilters();
        }
        
        function resetCheckboxes() {
            // Uncheck all checkboxes and update count
            selectAllCheckbox.checked = false;
            filteredProperties.forEach(property => {
                if (property.checkbox) {
                    property.checkbox.checked = false;
                }
            });
            updateSelectedCount();
        }
        
        function updateURL(search, status) {
            const url = new URL(window.location);
            
            if (search) url.searchParams.set('search', search);
            else url.searchParams.delete('search');
            
            if (status) url.searchParams.set('status', status);
            else url.searchParams.delete('status');
            
            // Update URL without reloading page
            window.history.replaceState({}, '', url);
        }
        
        function initializeFiltersFromCurrent() {
            // Get current filter values from the form elements
            const searchValue = document.getElementById('searchInput').value;
            const statusValue = document.getElementById('statusFilter').value;
            
            // Apply filters if any are set
            if (searchValue || statusValue) {
                applyFilters();
            }
        }
        
        function setupCheckboxFunctionality() {
            selectAllCheckbox.addEventListener('change', function() {
                const visibleCheckboxes = filteredProperties.map(p => p.checkbox).filter(cb => cb && cb.offsetParent !== null);
                visibleCheckboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                });
                updateSelectedCount();
            });

            // Add event listeners to existing checkboxes
            originalProperties.forEach(property => {
                if (property.checkbox) {
                    property.checkbox.addEventListener('change', updateSelectedCount);
                }
            });
        }

        function updateSelectedCount() {
            const visibleCheckboxes = filteredProperties.map(p => p.checkbox).filter(cb => cb && cb.offsetParent !== null);
            const selectedCount = visibleCheckboxes.filter(cb => cb.checked).length;
            selectedCountSpan.textContent = `${selectedCount} mục được chọn`;
            bulkApproveBtn.disabled = selectedCount === 0;
            
            // Update select all checkbox state
            selectAllCheckbox.checked = selectedCount === visibleCheckboxes.length && visibleCheckboxes.length > 0;
            selectAllCheckbox.indeterminate = selectedCount > 0 && selectedCount < visibleCheckboxes.length;
        }

        function approveProperty(propertyId) {
            if (confirm('Bạn có chắc chắn muốn duyệt bài đăng này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/posts';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'approve';
                
                const propertyIdInput = document.createElement('input');
                propertyIdInput.type = 'hidden';
                propertyIdInput.name = 'propertyId';
                propertyIdInput.value = propertyId;
                
                form.appendChild(actionInput);
                form.appendChild(propertyIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function rejectProperty(propertyId) {
            if (confirm('Bạn có chắc chắn muốn từ chối bài đăng này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/posts';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'reject';
                
                const propertyIdInput = document.createElement('input');
                propertyIdInput.type = 'hidden';
                propertyIdInput.name = 'propertyId';
                propertyIdInput.value = propertyId;
                
                form.appendChild(actionInput);
                form.appendChild(propertyIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function bulkApprove() {
            const selectedCheckboxes = document.querySelectorAll('.property-checkbox:checked');
            if (selectedCheckboxes.length === 0) {
                alert('Vui lòng chọn ít nhất một bài đăng');
                return;
            }
            
            if (confirm(`Bạn có chắc chắn muốn duyệt ${selectedCheckboxes.length} bài đăng đã chọn?`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/posts';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'bulk-approve';
                
                form.appendChild(actionInput);
                
                selectedCheckboxes.forEach(checkbox => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'propertyIds';
                    input.value = checkbox.value;
                    form.appendChild(input);
                });
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
