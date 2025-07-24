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
</head>
<body class="bg-gray-50">
    <!-- Header -->
    <nav class="bg-white shadow-sm border-b">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="text-2xl font-bold text-blue-600">
                        RentEz Admin
                    </a>
                </div>
                <div class="flex items-center space-x-4">
                    <a href="${pageContext.request.contextPath}/admin/tiers" class="text-gray-600 hover:text-blue-600">
                        <i class="fas fa-crown mr-2"></i>Quản lý gói
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="text-gray-600 hover:text-blue-600">
                        <i class="fas fa-users mr-2"></i>Người dùng
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="text-gray-600 hover:text-blue-600">
                        <i class="fas fa-home mr-2"></i>Trang chủ
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
        <!-- Page Header -->
        <div class="md:flex md:items-center md:justify-between mb-8">
            <div class="flex-1 min-w-0">
                <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
                    <i class="fas fa-crown text-yellow-500 mr-3"></i>
                    Quản lý gói thành viên
                </h2>
                <p class="mt-1 text-sm text-gray-500">
                    Quản lý các gói thành viên và theo dõi người dùng đăng ký
                </p>
            </div>
            <div class="mt-4 flex md:mt-0 md:ml-4 space-x-3">
                <button onclick="openCreateModal()" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700">
                    <i class="fas fa-plus mr-2"></i>
                    Tạo gói mới
                </button>
                <form method="post" action="${pageContext.request.contextPath}/admin/tier-action" class="inline">
                    <input type="hidden" name="action" value="expire-memberships">
                    <button type="submit" class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                        <i class="fas fa-sync mr-2"></i>
                        Cập nhật hết hạn
                    </button>
                </form>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${param.success != null}">
            <div class="mb-4 bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-md">
                <div class="flex">
                    <i class="fas fa-check-circle mr-3 mt-0.5"></i>
                    <span>${param.success}</span>
                </div>
            </div>
        </c:if>
        
        <c:if test="${param.error != null}">
            <div class="mb-4 bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-md">
                <div class="flex">
                    <i class="fas fa-exclamation-circle mr-3 mt-0.5"></i>
                    <span>${param.error}</span>
                </div>
            </div>
        </c:if>

        <!-- Tier Management Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
            <c:forEach var="tier" items="${tiers}">
                <div class="bg-white rounded-lg shadow-sm border hover:shadow-md transition-shadow">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-lg font-semibold text-gray-900">${tier.tierName}</h3>
                            <div class="flex items-center space-x-2">
                                <span class="px-2 py-1 text-xs font-medium rounded-full 
                                    ${tier.priorityLevel == 1 ? 'bg-purple-100 text-purple-800' : 
                                      tier.priorityLevel == 2 ? 'bg-blue-100 text-blue-800' : 
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
                            <a href="${pageContext.request.contextPath}/admin/tiers?action=edit&id=${tier.tierId}" 
                               class="flex-1 bg-blue-50 text-blue-700 text-center py-2 px-3 rounded-md text-sm font-medium hover:bg-blue-100 transition-colors">
                                <i class="fas fa-edit mr-1"></i>Chỉnh sửa
                            </a>
                            <c:if test="${tier.price > 0}">
                                <button onclick="confirmDelete(${tier.tierId}, '${tier.tierName}')" 
                                        class="bg-red-50 text-red-700 py-2 px-3 rounded-md text-sm font-medium hover:bg-red-100 transition-colors">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Quick Actions -->
        <div class="bg-white rounded-lg shadow-sm border p-6">
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
    <div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <div class="mt-3 text-center">
                <i class="fas fa-exclamation-triangle text-red-500 text-4xl mb-4"></i>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Xác nhận xóa</h3>
                <p class="text-sm text-gray-600 mb-6">
                    Bạn có chắc chắn muốn xóa gói <span id="deleteTierName" class="font-semibold"></span>?
                    Hành động này không thể hoàn tác.
                </p>
                
                <div class="flex justify-center space-x-3">
                    <button type="button" onclick="closeDeleteModal()" 
                            class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md hover:bg-gray-400 transition-colors">
                        Hủy
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/admin/tier-action" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="tierId" id="deleteTierId">
                        <button type="submit" 
                                class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition-colors">
                            Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openCreateModal() {
            document.getElementById('modalTitle').textContent = 'Tạo gói thành viên mới';
            document.getElementById('formAction').value = 'create';
            document.getElementById('tierForm').reset();
            document.getElementById('tierModal').classList.remove('hidden');
        }
        
        function closeTierModal() {
            document.getElementById('tierModal').classList.add('hidden');
        }
        
        function confirmDelete(tierId, tierName) {
            document.getElementById('deleteTierId').value = tierId;
            document.getElementById('deleteTierName').textContent = tierName;
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
