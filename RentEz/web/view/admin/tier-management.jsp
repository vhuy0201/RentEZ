<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý gói thành viên - RentEz Admin</title>
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
                        <h2 class="text-2xl font-bold text-gray-800">Quản lý gói thành viên</h2>
                        <div class="flex items-center space-x-4">
                            <button onclick="openCreateModal()" 
                                    class="px-4 py-2 bg-gradient-to-r from-primary-500 to-primary-600 text-white rounded-lg hover:from-primary-600 hover:to-primary-700 transition-all shadow-md">
                                <i class="fas fa-plus mr-2"></i>
                                Tạo gói mới
                            </button>
                            <form method="post" action="${pageContext.request.contextPath}/admin/tier-action" class="inline">
                                <input type="hidden" name="action" value="expire-memberships">
                                <button type="submit" class="px-4 py-2 bg-white border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors shadow-sm">
                                    <i class="fas fa-sync mr-2"></i>
                                    Cập nhật hết hạn
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="p-6">
                <!-- Search and Filter -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                            <div class="relative">
                                <input type="text" id="searchInput" placeholder="Tên gói, mô tả..."
                                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Độ ưu tiên</label>
                            <select id="priorityFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="">Tất cả độ ưu tiên</option>
                                <option value="1">1 - Cao nhất (VIP)</option>
                                <option value="2">2 - Cao (Premium)</option>
                                <option value="3">3 - Trung bình (Basic)</option>
                                <option value="99">99 - Thấp nhất (Free)</option>
                            </select>
                        </div>
                        <div class="flex items-end">
                            <button onclick="applyFilters()" 
                                    class="w-full px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors">
                                <i class="fas fa-filter mr-2"></i>Lọc
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Success/Error Messages -->
                <c:if test="${param.success != null}">
                    <div class="mb-4 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg">
                        <div class="flex">
                            <i class="fas fa-check-circle mr-3 mt-0.5"></i>
                            <span>${param.success}</span>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${param.error != null}">
                    <div class="mb-4 bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg">
                        <div class="flex">
                            <i class="fas fa-exclamation-circle mr-3 mt-0.5"></i>
                            <span>${param.error}</span>
                        </div>
                    </div>
                </c:if>

                <!-- Tier Management Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                    <c:forEach var="tier" items="${tiers}">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 hover:shadow-md transition-shadow">
                            <div class="p-6">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-lg font-semibold text-gray-900">${tier.tierName}</h3>
                                    <div class="flex items-center space-x-2">
                                        <span class="px-3 py-1 text-xs font-medium rounded-full 
                                            ${tier.priorityLevel == 1 ? 'bg-red-100 text-red-800' : 
                                              tier.priorityLevel == 2 ? 'bg-primary-100 text-primary-800' : 
                                              tier.priorityLevel == 3 ? 'bg-green-100 text-green-800' : 
                                              'bg-gray-100 text-gray-800'}">
                                            Độ ưu tiên ${tier.priorityLevel}
                                        </span>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <p class="text-2xl font-bold text-gray-900">
                                        <fmt:formatNumber value="${tier.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        <span class="text-sm font-normal text-gray-500">/tháng</span>
                                    </p>
                                </div>
                                
                                <p class="text-sm text-gray-600 mb-6">${tier.description}</p>
                                
                                <div class="flex space-x-2">
                                    <button onclick="openEditModal('${tier.tierId}', '${tier.tierName}', '${tier.description}', '${tier.price}', '${tier.priorityLevel}')" 
                                           class="flex-1 bg-blue-50 text-blue-700 text-center py-2 px-3 rounded-lg text-sm font-medium hover:bg-blue-100 transition-colors">
                                        <i class="fas fa-edit mr-1"></i>Chỉnh sửa
                                    </button>
                                    <c:if test="${tier.price > 0}">
                                        <button onclick="confirmDelete('${tier.tierId}', '${tier.tierName}')" 
                                                class="bg-red-50 text-red-700 py-2 px-3 rounded-lg text-sm font-medium hover:bg-red-100 transition-colors">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Quick Actions -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">
                        <i class="fas fa-tools text-gray-500 mr-2"></i>
                        Thao tác nhanh
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <a href="${pageContext.request.contextPath}/admin/tiers?action=view-memberships" 
                           class="flex items-center p-4 border rounded-lg hover:bg-gray-50 transition-colors">
                            <i class="fas fa-users text-blue-500 text-xl mr-3"></i>
                            <div>
                                <p class="font-medium text-gray-900">Xem thành viên</p>
                                <p class="text-sm text-gray-500">Danh sách người dùng đã đăng ký</p>
                            </div>
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/reports?type=tier-revenue" 
                           class="flex items-center p-4 border rounded-lg hover:bg-gray-50 transition-colors">
                            <i class="fas fa-chart-line text-green-500 text-xl mr-3"></i>
                            <div>
                                <p class="font-medium text-gray-900">Báo cáo doanh thu</p>
                                <p class="text-sm text-gray-500">Thống kê thu nhập từ gói</p>
                            </div>
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/admin/settings?section=tiers" 
                           class="flex items-center p-4 border rounded-lg hover:bg-gray-50 transition-colors">
                            <i class="fas fa-cog text-gray-500 text-xl mr-3"></i>
                            <div>
                                <p class="font-medium text-gray-900">Cài đặt gói</p>
                                <p class="text-sm text-gray-500">Cấu hình và quy tắc</p>
                            </div>
                        </a>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Create/Edit Tier Modal -->
    <div id="tierModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3">
                <h3 class="text-lg font-semibold text-gray-900 mb-4" id="modalTitle">Tạo gói thành viên mới</h3>
                
                <form method="post" action="${pageContext.request.contextPath}/admin/tier-action" id="tierForm">
                    <input type="hidden" name="action" value="create" id="formAction">
                    <input type="hidden" name="tierId" id="tierId">
                    
                    <div class="mb-4">
                        <label for="tierName" class="block text-sm font-medium text-gray-700 mb-2">Tên gói</label>
                        <input type="text" id="tierName" name="tierName" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    
                    <div class="mb-4">
                        <label for="price" class="block text-sm font-medium text-gray-700 mb-2">Giá (VNĐ)</label>
                        <input type="number" id="price" name="price" min="0" step="1000" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    
                    <div class="mb-4">
                        <label for="priorityLevel" class="block text-sm font-medium text-gray-700 mb-2">Độ ưu tiên</label>
                        <select id="priorityLevel" name="priorityLevel" required 
                                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="1">1 - Cao nhất (VIP)</option>
                            <option value="2">2 - Cao (Premium)</option>
                            <option value="3">3 - Trung bình (Basic)</option>
                            <option value="99">99 - Thấp nhất (Free)</option>
                        </select>
                    </div>
                    
                    <div class="mb-6">
                        <label for="description" class="block text-sm font-medium text-gray-700 mb-2">Mô tả</label>
                        <textarea id="description" name="description" rows="3" 
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                    </div>
                    
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="closeTierModal()" 
                                class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition-colors">
                            Hủy
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors">
                            Lưu
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
                    Bạn có chắc chắn muốn xóa gói thành viên <span id="deleteName" class="font-semibold text-red-600"></span>?
                    <br>Hành động này không thể hoàn tác.
                </p>
                
                <div class="flex justify-center space-x-3">
                    <button type="button" onclick="closeDeleteModal()" 
                            class="px-6 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
                        Hủy
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/admin/tier-action" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="tierId" id="deleteId">
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
        let originalTiers = [];
        let filteredTiers = [];
        
        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Store original card data
            storeOriginalData();
            
            // Initialize filters from URL params
            initializeFiltersFromURL();
            
            // Add event listeners for real-time filtering
            setupEventListeners();
        });
        
        function storeOriginalData() {
            const tierCards = document.querySelectorAll('.grid .bg-white.rounded-xl.shadow-sm');
            originalTiers = [];
            
            tierCards.forEach(card => {
                if (card.querySelector('h3')) { // Skip quick actions card
                    const tier = {
                        element: card,
                        name: card.querySelector('h3').textContent.trim(),
                        description: card.querySelector('p.text-sm.text-gray-600') ? card.querySelector('p.text-sm.text-gray-600').textContent.trim() : '',
                        priority: getPriorityFromElement(card),
                        price: getPriceFromElement(card)
                    };
                    originalTiers.push(tier);
                }
            });
            filteredTiers = [...originalTiers];
        }
        
        function getPriorityFromElement(card) {
            const prioritySpan = card.querySelector('.px-3.py-1.text-xs');
            if (prioritySpan) {
                const text = prioritySpan.textContent.trim();
                const match = text.match(/Độ ưu tiên (\d+)/);
                return match ? match[1] : '';
            }
            return '';
        }
        
        function getPriceFromElement(card) {
            const priceElement = card.querySelector('.text-2xl.font-bold');
            return priceElement ? priceElement.textContent.trim() : '';
        }
        
        function setupEventListeners() {
            // Search input - real-time filtering
            document.getElementById('searchInput').addEventListener('input', debounce(applyFilters, 300));
            
            // Priority filter
            document.getElementById('priorityFilter').addEventListener('change', applyFilters);
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
            const priorityFilter = document.getElementById('priorityFilter').value;
            
            // Filter tiers
            filteredTiers = originalTiers.filter(tier => {
                // Search filter
                if (searchTerm && !matchesSearch(tier, searchTerm)) {
                    return false;
                }
                
                // Priority filter
                if (priorityFilter && tier.priority !== priorityFilter) {
                    return false;
                }
                
                return true;
            });
            
            // Update display
            updateDisplay();
            
            // Update URL (optional)
            updateURL(searchTerm, priorityFilter);
        }
        
        function matchesSearch(tier, searchTerm) {
            return (
                tier.name.toLowerCase().includes(searchTerm) ||
                tier.description.toLowerCase().includes(searchTerm) ||
                tier.price.toLowerCase().includes(searchTerm)
            );
        }
        
        function updateDisplay() {
            const gridContainer = document.querySelector('.grid.grid-cols-1.md\\:grid-cols-2.lg\\:grid-cols-3');
            
            // Hide all original cards
            originalTiers.forEach(tier => {
                tier.element.style.display = 'none';
            });
            
            // Show filtered cards
            if (filteredTiers.length > 0) {
                filteredTiers.forEach(tier => {
                    tier.element.style.display = '';
                });
                
                // Hide empty state if it exists
                const emptyState = gridContainer.querySelector('.empty-state');
                if (emptyState) {
                    emptyState.style.display = 'none';
                }
            } else {
                // Show empty state
                showEmptyState(gridContainer);
            }
            
            // Show filter info if filters are active
            showFilterInfo();
        }
        
        function showEmptyState(container) {
            // Remove existing empty state
            const existingEmpty = container.querySelector('.empty-state');
            if (existingEmpty) {
                existingEmpty.remove();
            }
            
            // Create new empty state
            const emptyDiv = document.createElement('div');
            emptyDiv.className = 'empty-state col-span-full flex flex-col items-center justify-center p-12 text-gray-500';
            emptyDiv.innerHTML = `
                <i class="fas fa-crown mb-3 text-4xl text-gray-400"></i>
                <p class="text-lg font-medium">Không tìm thấy gói thành viên nào</p>
                <p class="text-sm text-gray-400 mt-1">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
            `;
            container.appendChild(emptyDiv);
        }
        
        function showFilterInfo() {
            const existingInfo = document.querySelector('.filter-info');
            if (existingInfo) {
                existingInfo.remove();
            }
            
            const totalShowing = filteredTiers.length;
            if (totalShowing !== originalTiers.length) {
                const info = document.createElement('div');
                info.className = 'filter-info bg-blue-50 border border-blue-200 rounded-lg p-3 mb-4 text-blue-700';
                info.innerHTML = `
                    <i class="fas fa-info-circle mr-2"></i>
                    Đang hiển thị ${totalShowing} trong tổng số ${originalTiers.length} gói thành viên
                    <button onclick="clearFilters()" class="ml-4 text-blue-600 hover:text-blue-800 underline">
                        Xóa bộ lọc
                    </button>
                `;
                
                const gridContainer = document.querySelector('.grid.grid-cols-1.md\\:grid-cols-2.lg\\:grid-cols-3').parentNode;
                gridContainer.insertBefore(info, gridContainer.querySelector('.grid'));
            }
        }
        
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('priorityFilter').value = '';
            
            // Apply filters to show all
            applyFilters();
        }
        
        function updateURL(search, priority) {
            const url = new URL(window.location);
            
            if (search) url.searchParams.set('search', search);
            else url.searchParams.delete('search');
            
            if (priority) url.searchParams.set('priority', priority);
            else url.searchParams.delete('priority');
            
            // Update URL without reloading page
            window.history.replaceState({}, '', url);
        }
        
        function initializeFiltersFromURL() {
            const urlParams = new URLSearchParams(window.location.search);
            
            if (urlParams.has('search')) {
                document.getElementById('searchInput').value = urlParams.get('search');
            }
            
            if (urlParams.has('priority')) {
                document.getElementById('priorityFilter').value = urlParams.get('priority');
            }
            
            // Apply filters if any were set
            if (urlParams.toString()) {
                applyFilters();
            }
        }
        
        function openCreateModal() {
            document.getElementById('modalTitle').textContent = 'Tạo gói thành viên mới';
            document.getElementById('formAction').value = 'create';
            document.getElementById('tierForm').reset();
            document.getElementById('tierModal').classList.remove('hidden');
        }
        
        function openEditModal(tierId, tierName, description, price, priorityLevel) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa gói thành viên';
            document.getElementById('formAction').value = 'update';
            document.getElementById('tierId').value = tierId;
            document.getElementById('tierName').value = tierName;
            document.getElementById('description').value = description;
            document.getElementById('price').value = price;
            document.getElementById('priorityLevel').value = priorityLevel;
            document.getElementById('tierModal').classList.remove('hidden');
        }
        
        function closeTierModal() {
            document.getElementById('tierModal').classList.add('hidden');
        }
        
        function confirmDelete(tierId, tierName) {
            document.getElementById('deleteId').value = tierId;
            document.getElementById('deleteName').textContent = tierName;
            document.getElementById('deleteModal').classList.remove('hidden');
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.add('hidden');
        }
        
        // Close modals when clicking outside
        window.onclick = function(event) {
            const tierModal = document.getElementById('tierModal');
            const deleteModal = document.getElementById('deleteModal');
            
            if (event.target === tierModal) {
                closeTierModal();
            }
            if (event.target === deleteModal) {
                closeDeleteModal();
            }
        }
    </script>
</body>
</html>
