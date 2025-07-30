<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Danh Sách Yêu Thích - RentEz</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gradient-to-br from-orange-50 via-orange-100 to-orange-50 min-h-screen font-sans">
    <jsp:include page="header.jsp" />

    <div class="container mx-auto px-6 mt-8">
        <!-- Page Header -->
        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-8">
            <div class="md:w-2/3">
                <h2 class="text-3xl font-bold text-orange-600 flex items-center mb-1">
                    <i class="fas fa-heart mr-3"></i> Danh Sách Yêu Thích
                </h2>
                <p class="text-gray-600">Quản lý các bất động sản bạn quan tâm</p>
            </div>
            <div class="md:w-1/3 text-right mt-4 md:mt-0">
                <span class="inline-flex items-center px-4 py-2 bg-white border border-orange-300 rounded shadow-sm text-orange-600">
                    <i class="fas fa-list mr-2"></i> ${totalFavorites} bất động sản
                </span>
            </div>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty param.success}">
            <div class="flex items-center bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6 relative" role="alert">
                <i class="fas fa-check-circle mr-2"></i>
                <span>${param.success}</span>
                <button type="button" class="absolute top-1 right-2 text-green-700 hover:text-green-900 focus:outline-none"
                    onclick="this.parentElement.style.display='none';">
                    &times;
                </button>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="flex items-center bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 relative" role="alert">
                <i class="fas fa-exclamation-circle mr-2"></i>
                <span>${param.error}</span>
                <button type="button" class="absolute top-1 right-2 text-red-700 hover:text-red-900 focus:outline-none"
                    onclick="this.parentElement.style.display='none';">
                    &times;
                </button>
            </div>
        </c:if>

        <c:if test="${not empty param.info}">
            <div class="flex items-center bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded mb-6 relative" role="alert">
                <i class="fas fa-info-circle mr-2"></i>
                <span>${param.info}</span>
                <button type="button" class="absolute top-1 right-2 text-blue-700 hover:text-blue-900 focus:outline-none"
                    onclick="this.parentElement.style.display='none';">
                    &times;
                </button>
            </div>
        </c:if>

        <!-- Favorites Content -->
        <div class="bg-white rounded-lg shadow-lg">
            <c:choose>
                <c:when test="${empty favoriteProperties}">
                    <!-- Empty State -->
                    <div class="text-center py-16">
                        <div class="text-gray-400 mb-4">
                            <i class="fas fa-heart text-6xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-700 mb-2">Chưa có bất động sản yêu thích</h3>
                        <p class="text-gray-500 mb-6">Hãy thêm những bất động sản bạn quan tâm vào danh sách yêu thích</p>
                        <a href="${pageContext.request.contextPath}/search" 
                           class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded-lg hover:from-orange-500 hover:to-orange-600 transition">
                            <i class="fas fa-search mr-2"></i> Tìm kiếm bất động sản
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Favorites Grid -->
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <c:forEach var="property" items="${favoriteProperties}">
                                <div class="bg-white border border-gray-200 rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200">
                                    <!-- Property Image -->
                                    <div class="relative">
                                        <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}">
                                            <c:choose>
                                                <c:when test="${not empty property.avatar}">
                                                    <img src="${property.avatar}" 
                                                         alt="${property.title}" 
                                                         class="w-full h-48 object-cover rounded-t-lg" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/view/guest/asset/img/property-1-D5t-zcgy.png" 
                                                         alt="Hình ảnh mặc định" 
                                                         class="w-full h-48 object-cover rounded-t-lg" />
                                                </c:otherwise>
                                            </c:choose>
                                        </a>                                        <!-- Favorite Button -->
                                        <button onclick="removeFavorite('${property.propertyId}')" 
                                                class="absolute top-3 right-3 bg-red-500 text-white rounded-full p-2 hover:bg-red-600 transition-colors duration-200">
                                            <i class="fas fa-heart text-sm"></i>
                                        </button>
                                    </div>

                                    <!-- Property Content -->
                                    <div class="p-4">
                                        <!-- Price -->
                                        <div class="text-xl font-bold text-orange-600 mb-2">
                                            <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="₫" maxFractionDigits="0" groupingUsed="true"/><span class="text-sm text-gray-500">/tháng</span>
                                        </div>

                                        <!-- Title -->
                                        <h3 class="font-semibold text-gray-800 mb-2 line-clamp-2">
                                            <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                               class="hover:text-orange-600 transition-colors">
                                                ${property.title}
                                            </a>
                                        </h3>

                                        <!-- Location -->
                                        <p class="text-gray-600 text-sm mb-3 flex items-center">
                                            <i class="fas fa-map-marker-alt mr-1 text-gray-400"></i>
                                            <c:set var="location" value="${locations[property.locationId]}" />
                                            <c:if test="${not empty location}">
                                                ${location.address}, ${location.city}
                                            </c:if>
                                        </p>

                                        <!-- Property Details -->
                                        <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
                                            <span class="flex items-center">
                                                <i class="fas fa-expand mr-1"></i>
                                                ${property.size}m²
                                            </span>
                                            <span class="flex items-center">
                                                <i class="fas fa-bed mr-1"></i>
                                                ${property.numberOfBedrooms} PN
                                            </span>
                                            <span class="flex items-center">
                                                <i class="fas fa-bath mr-1"></i>
                                                ${property.numberOfBathrooms} PT
                                            </span>
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="flex space-x-2">
                                            <a href="${pageContext.request.contextPath}/property-detail?id=${property.propertyId}" 
                                               class="flex-1 bg-gradient-to-r from-orange-400 to-orange-500 text-white text-center py-2 px-4 rounded hover:from-orange-500 hover:to-orange-600 transition text-sm">
                                                <i class="fas fa-eye mr-1"></i> Xem chi tiết
                                            </a>                                            <button onclick="removeFavorite('${property.propertyId}')" 
                                                    class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition text-sm">
                                                <i class="fas fa-trash mr-1"></i> Xóa
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Back to Search -->
        <div class="text-center mt-8">
            <a href="${pageContext.request.contextPath}/search" 
               class="inline-flex items-center px-6 py-3 bg-white border border-orange-300 text-orange-600 rounded-lg hover:bg-orange-50 transition">
                <i class="fas fa-search mr-2"></i> Tiếp tục tìm kiếm
            </a>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        function removeFavorite(propertyId) {
            if (confirm('Bạn có chắc chắn muốn xóa bất động sản này khỏi danh sách yêu thích?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/favorite-action';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'remove';
                
                const propertyInput = document.createElement('input');
                propertyInput.type = 'hidden';
                propertyInput.name = 'propertyId';
                propertyInput.value = propertyId;
                
                const redirectInput = document.createElement('input');
                redirectInput.type = 'hidden';
                redirectInput.name = 'redirectUrl';
                redirectInput.value = '${pageContext.request.contextPath}/favorites';
                
                form.appendChild(actionInput);
                form.appendChild(propertyInput);
                form.appendChild(redirectInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
