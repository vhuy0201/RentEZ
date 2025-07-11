<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - RentEz Admin</title>
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
                        <h2 class="text-2xl font-bold text-gray-800">Quản lý người dùng</h2>
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
                                <input type="text" id="searchInput" placeholder="Tên, email, số điện thoại..."
                                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Vai trò</label>
                            <select id="roleFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="">Tất cả vai trò</option>
                                <option value="1">Admin</option>
                                <option value="2">Chủ nhà</option>
                                <option value="3">Người thuê</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                            <select id="statusFilter" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="">Tất cả trạng thái</option>
                                <option value="active">Hoạt động</option>
                                <option value="inactive">Không hoạt động</option>
                                <option value="blocked">Đã khóa</option>
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

                <!-- Users Table -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gradient-to-r from-primary-500 to-primary-600">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Người dùng
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        Vai trò
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
                                <c:forEach var="user" items="${users}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="w-10 h-10 bg-gradient-to-br from-primary-400 to-primary-600 rounded-full flex items-center justify-center text-white font-semibold">
                                                    ${user.name.substring(0,1).toUpperCase()}
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-gray-900">${user.name}</div>
                                                    <div class="text-sm text-gray-500">${user.email}</div>
                                                    <div class="text-sm text-gray-500">${user.phone}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                                ${user.role == 'Admin' ? 'bg-red-100 text-red-800' : 
                                                  user.role == 'Landlord' ? 'bg-blue-100 text-blue-800' : 
                                                  'bg-green-100 text-green-800'}">
                                                ${user.role == 'Admin' ? 'Admin' : user.role == 'Landlord' ? 'Chủ nhà' : 'Người thuê'}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                                ${user.status == 'true' ? 'bg-green-100 text-green-800' : 
                                                  user.status == 'false' ? 'bg-yellow-100 text-yellow-800' : 
                                                  'bg-red-100 text-red-800'}">
                                                ${user.status == 'true' ? 'Hoạt động' : 
                                                  user.status == 'false' ? 'Không hoạt động' : 'Đã khóa'}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex space-x-2">
                                                <button onclick="openEditModal('${user.userId}')" 
                                                        class="bg-blue-50 text-blue-600 px-3 py-1.5 rounded-lg hover:bg-blue-100 transition-colors">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button onclick="confirmDelete('${user.userId}', '${user.name}')" 
                                                        class="bg-red-50 text-red-600 px-3 py-1.5 rounded-lg hover:bg-red-100 transition-colors">
                                                    <i class="fas fa-ban"></i>
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
                        Hiển thị <span class="font-medium">1</span> đến <span class="font-medium">10</span> 
                        của <span class="font-medium">${totalUsers}</span> kết quả
                    </div>
                    <div class="flex space-x-2">
                        <button class="px-3 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-50">
                            Trước
                        </button>
                        <button class="px-3 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium">
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

    <!-- Create/Edit User Modal -->
    <div id="userModal" class="fixed inset-0 bg-black bg-opacity-50 hidden overflow-y-auto h-full w-full z-50">
        <div class="relative top-20 mx-auto p-5 border w-[500px] shadow-lg rounded-xl bg-white">
            <div class="mt-3">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-semibold text-gray-900" id="modalTitle">Tạo người dùng mới</h3>
                    <button onclick="closeUserModal()" class="text-gray-400 hover:text-gray-600">
                        <i class="fas fa-times text-xl"></i>
                    </button>
                </div>
                
                <form method="post" action="${pageContext.request.contextPath}/admin/user-action" id="userForm">
                    <input type="hidden" name="action" value="create" id="formAction">
                    <input type="hidden" name="userId" id="userId">
                    
                    <div class="grid grid-cols-2 gap-4 mb-4">
                        <div>
                            <label for="name" class="block text-sm font-medium text-gray-700 mb-2">Họ và tên</label>
                            <input type="text" id="name" name="fullname" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                        </div>
                        <div>
                            <label for="phoneNumber" class="block text-sm font-medium text-gray-700 mb-2">Số điện thoại</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" required 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                        <input type="email" id="email" name="email" required 
                               class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4 mb-4">
                        <div>
                            <label for="role" class="block text-sm font-medium text-gray-700 mb-2">Vai trò</label>
                            <select id="role" name="roleId" required 
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="Admin">Admin</option>
                                <option value="Landlord">Chủ nhà</option>
                                <option value="Renter" selected>Người thuê</option>
                            </select>
                        </div>
                        <div>
                            <label for="status" class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                            <select id="status" name="status" required 
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                                <option value="true" selected>Hoạt động</option>
                                <option value="false">Không hoạt động</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="address" class="block text-sm font-medium text-gray-700 mb-2">Địa chỉ</label>
                        <input type="text" id="address" name="address" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                    </div>
                    
                    <div class="mb-6" id="passwordSection">
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-2">Mật khẩu</label>
                        <input type="password" id="password" name="password" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500">
                        <p class="text-xs text-gray-500 mt-1">Để trống nếu không muốn thay đổi mật khẩu</p>
                    </div>
                    
                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="closeUserModal()" 
                                class="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
                            Hủy
                        </button>
                        <button type="submit" 
                                class="px-4 py-2 bg-gradient-to-r from-primary-500 to-primary-600 text-white rounded-lg hover:from-primary-600 hover:to-primary-700 transition-all">
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
                    Bạn có chắc chắn muốn xóa người dùng <span id="deleteName" class="font-semibold text-red-600"></span>?
                    <br>Hành động này không thể hoàn tác.
                </p>
                
                <div class="flex justify-center space-x-3">
                    <button type="button" onclick="closeDeleteModal()" 
                            class="px-6 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
                        Hủy
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/admin/user-action" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteId">
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
        function openCreateModal() {
            document.getElementById('modalTitle').textContent = 'Tạo người dùng mới';
            document.getElementById('formAction').value = 'create';
            document.getElementById('userForm').reset();
            document.getElementById('passwordSection').style.display = 'block';
            document.getElementById('password').required = true;
            document.getElementById('userModal').classList.remove('hidden');
        }
        
        function openEditModal(userId) {
            // Fetch user data and populate form
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa người dùng';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('userId').value = userId;
            document.getElementById('password').required = false;
            document.getElementById('passwordSection').style.display = 'block';
            
            // Hiển thị loading indicator
            const formInputs = document.querySelectorAll('#userForm input:not([type="hidden"]), #userForm select');
            formInputs.forEach(input => {
                input.disabled = true;
                if (input.tagName === 'SELECT') {
                    input.style.backgroundColor = '#f3f4f6';
                } else {
                    input.value = 'Đang tải...';
                }
            });
            
            // Hiển thị modal trước khi fetch data
            document.getElementById('userModal').classList.remove('hidden');
            
            // Fetch user data từ server
            fetch('${pageContext.request.contextPath}/admin/users?action=get&userId=' + userId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(userData => {
                    // Điền thông tin vào form
                    document.getElementById('name').value = userData.name;
                    document.getElementById('email').value = userData.email;
                    document.getElementById('phoneNumber').value = userData.phone;
                    document.getElementById('address').value = userData.address;
                    document.getElementById('role').value = userData.role;
                    document.getElementById('status').value = userData.status.toString();
                    document.getElementById('password').value = '';
                    
                    // Enable các field input
                    formInputs.forEach(input => {
                        input.disabled = false;
                        if (input.tagName === 'SELECT') {
                            input.style.backgroundColor = '';
                        }
                    });
                })
                .catch(error => {
                    console.error('Error fetching user data:', error);
                    alert('Có lỗi khi tải thông tin người dùng. Vui lòng thử lại.');
                    closeUserModal();
                });
        }
        
        function closeUserModal() {
            document.getElementById('userModal').classList.add('hidden');
        }
        
        function confirmDelete(userId, userName) {
            document.getElementById('deleteId').value = userId;
            document.getElementById('deleteName').textContent = userName;
            document.getElementById('deleteModal').classList.remove('hidden');
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.add('hidden');
        }
        
        function toggleStatus(userId) {
            // Toggle user status
            console.log('Toggle status for user:', userId);
        }
        
        function applyFilters() {
            // Apply search and filter logic
            console.log('Applying filters...');
        }
        
        // Close modals when clicking outside
        window.onclick = function(event) {
            const userModal = document.getElementById('userModal');
            const deleteModal = document.getElementById('deleteModal');
            
            if (event.target === userModal) {
                closeUserModal();
            }
            if (event.target === deleteModal) {
                closeDeleteModal();
            }
        }
    </script>
</body>
</html>
