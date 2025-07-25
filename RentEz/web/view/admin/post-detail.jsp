<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết bài đăng - RentEz Admin</title>
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
                <div class="flex items-center justify-between">
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/posts" 
                           class="text-primary-600 hover:text-primary-700 mb-2 inline-flex items-center">
                            <i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách
                        </a>
                        <h1 class="text-3xl font-bold text-gray-900 mb-2">Chi tiết bài đăng</h1>
                    </div>
                    
                    <div class="flex items-center gap-3">
                        <c:choose>
                            <c:when test="${property.publicStatus}">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                                    <i class="fas fa-check-circle mr-2"></i>
                                    Đã duyệt
                                </span>
                                <button onclick="rejectProperty('${property.propertyId}')" 
                                        class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors">
                                    <i class="fas fa-times mr-2"></i>Từ chối
                                </button>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-yellow-100 text-yellow-800">
                                    <i class="fas fa-clock mr-2"></i>
                                    Chờ duyệt
                                </span>
                                <button onclick="approveProperty('${property.propertyId}')" 
                                        class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors">
                                    <i class="fas fa-check mr-2"></i>Duyệt bài đăng
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Property Details -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- Property Image -->
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <div class="aspect-w-16 aspect-h-9">
                            <img src="${property.avatar != null ? property.avatar : '/api/placeholder/800/400'}" 
                                 alt="Property Image" 
                                 class="w-full h-96 object-cover">
                        </div>
                    </div>

                    <!-- Basic Information -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Thông tin cơ bản</h2>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề</label>
                                <p class="text-gray-900">${property.title}</p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Loại bất động sản</label>
                                <p class="text-gray-900">${propertyType.typeName}</p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Giá thuê</label>
                                <p class="text-gray-900 text-lg font-semibold text-primary-600">
                                    <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Diện tích</label>
                                <p class="text-gray-900">${property.size} m²</p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Số phòng ngủ</label>
                                <p class="text-gray-900">${property.numberOfBedrooms} phòng</p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Số phòng tắm</label>
                                <p class="text-gray-900">${property.numberOfBathrooms} phòng</p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Trạng thái</label>
                                <p class="text-gray-900">${property.availabilityStatus}</p>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Mức độ ưu tiên</label>
                                <p class="text-gray-900">
                                    <c:choose>
                                        <c:when test="${property.priorityLevel == 1}">Thường</c:when>
                                        <c:when test="${property.priorityLevel == 2}">Ưu tiên</c:when>
                                        <c:when test="${property.priorityLevel == 3}">Cao cấp</c:when>
                                        <c:otherwise>Không xác định</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Mô tả chi tiết</h2>
                        <div class="prose max-w-none">
                            <p class="text-gray-700 whitespace-pre-line">${property.description}</p>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Vị trí</h2>
                        <div class="flex items-start">
                            <i class="fas fa-map-marker-alt text-primary-600 mt-1 mr-3"></i>
                            <p class="text-gray-700">${property.address}</p>
                        </div>
                    </div>
                </div>

                <!-- Sidebar Information -->
                <div class="space-y-6">
                    <!-- Landlord Information -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Thông tin chủ sở hữu</h2>
                        
                        <div class="flex items-center mb-4">
                            <div class="w-12 h-12 bg-primary-100 rounded-full flex items-center justify-center mr-4">
                                <i class="fas fa-user text-primary-600 text-lg"></i>
                            </div>
                            <div>
                                <p class="font-medium text-gray-900">${landlord.name}</p>
                                <p class="text-sm text-gray-500">${landlord.role}</p>
                            </div>
                        </div>
                        
                        <div class="space-y-3">
                            <div class="flex items-center">
                                <i class="fas fa-envelope text-gray-400 mr-3 w-4"></i>
                                <span class="text-sm text-gray-700">${landlord.email}</span>
                            </div>
                            
                            <c:if test="${not empty landlord.phone}">
                                <div class="flex items-center">
                                    <i class="fas fa-phone text-gray-400 mr-3 w-4"></i>
                                    <span class="text-sm text-gray-700">${landlord.phone}</span>
                                </div>
                            </c:if>
                            
                            <div class="flex items-center">
                                <i class="fas fa-calendar text-gray-400 mr-3 w-4"></i>
                                <span class="text-sm text-gray-700">
                                    Tham gia: <fmt:formatDate value="${landlord.createdAt}" pattern="dd/MM/yyyy"/>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Property Stats -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Thống kê</h2>
                        
                        <div class="space-y-4">
                            <div class="flex items-center justify-between">
                                <span class="text-sm text-gray-600">ID bài đăng</span>
                                <span class="text-sm font-medium text-gray-900">#${property.propertyId}</span>
                            </div>
                            
                            <div class="flex items-center justify-between">
                                <span class="text-sm text-gray-600">Loại bài đăng</span>
                                <span class="text-sm font-medium text-gray-900">
                                    <c:choose>
                                        <c:when test="${property.priorityLevel == 3}">
                                            <span class="text-yellow-600">
                                                <i class="fas fa-crown mr-1"></i>Cao cấp
                                            </span>
                                        </c:when>
                                        <c:when test="${property.priorityLevel == 2}">
                                            <span class="text-blue-600">
                                                <i class="fas fa-star mr-1"></i>Ưu tiên
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-gray-600">
                                                <i class="fas fa-home mr-1"></i>Thường
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div class="flex items-center justify-between">
                                <span class="text-sm text-gray-600">Trạng thái duyệt</span>
                                <span class="text-sm font-medium">
                                    <c:choose>
                                        <c:when test="${property.publicStatus}">
                                            <span class="text-green-600">
                                                <i class="fas fa-check-circle mr-1"></i>Đã duyệt
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-yellow-600">
                                                <i class="fas fa-clock mr-1"></i>Chờ duyệt
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Thao tác nhanh</h2>
                        
                        <div class="space-y-3">
                            <c:choose>
                                <c:when test="${property.publicStatus}">
                                    <button onclick="rejectProperty('${property.propertyId}')" 
                                            class="w-full px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors">
                                        <i class="fas fa-times mr-2"></i>Từ chối bài đăng
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button onclick="approveProperty('${property.propertyId}')" 
                                            class="w-full px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors">
                                        <i class="fas fa-check mr-2"></i>Duyệt bài đăng
                                    </button>
                                </c:otherwise>
                            </c:choose>
                            
                            <a href="mailto:${landlord.email}" 
                               class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors text-center inline-block">
                                <i class="fas fa-envelope mr-2"></i>Liên hệ chủ sở hữu
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
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
    </script>
</body>
</html>
