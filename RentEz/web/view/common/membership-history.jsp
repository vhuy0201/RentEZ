<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Lịch Sử Gói Thành Viên - RentEz</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-50 text-gray-800">

        <jsp:include page="header.jsp" />

        <div class="max-w-6xl mx-auto py-10 px-4">
            <!-- Header -->
            <div class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white rounded-2xl shadow-xl p-8 mb-10">
                <div class="flex justify-between items-center">
                    <div>
                        <h1 class="text-4xl font-bold mb-2">
                            <i class="fas fa-history mr-3"></i>Lịch Sử Gói Thành Viên
                        </h1>
                        <p class="opacity-90">Xem lại các gói bạn đã đăng ký và thanh toán</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/membership"
                       class="bg-white text-indigo-600 font-semibold px-5 py-2 rounded-lg shadow hover:bg-gray-100 transition">
                        <i class="fas fa-arrow-left mr-2"></i>Quay lại
                    </a>
                </div>
            </div>

            <!-- Thông báo -->
            <c:if test="${not empty param.success}">
                <div class="bg-green-100 border border-green-400 text-green-800 rounded-lg px-6 py-4 mb-6">
                    <i class="fas fa-check-circle mr-2"></i>${param.success}
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="bg-red-100 border border-red-400 text-red-800 rounded-lg px-6 py-4 mb-6">
                    <i class="fas fa-exclamation-circle mr-2"></i>${param.error}
                </div>
            </c:if>

            <!-- Nội dung chính -->
            <div class="grid md:grid-cols-2 gap-6">
                <!-- Lịch sử gói -->
                <div class="bg-white rounded-2xl shadow-lg p-6">
                    <h2 class="text-xl font-semibold text-indigo-600 mb-4"><i class="fas fa-crown mr-2"></i>Lịch Sử Gói</h2>
                    <c:choose>
                        <c:when test="${not empty tierHistory}">
                            <div class="space-y-5">
                                <c:forEach var="userTier" items="${tierHistory}">
                                    <div class="border rounded-xl p-4 flex justify-between items-center hover:shadow-md transition">
                                        <div class="flex items-center">
                                            <div class="w-12 h-12 rounded-full flex items-center justify-center mr-4 
                                                 ${userTier.status == 'Active' ? 'bg-green-500' : 'bg-rose-500'}">
                                                <i class="fas fa-crown text-white"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-bold">Tier ID: ${userTier.tierId}</h3>
                                                <p class="text-sm text-gray-600">
                                                    <fmt:formatDate value="${userTier.startDate}" pattern="dd/MM/yyyy" /> - 
                                                    <fmt:formatDate value="${userTier.endDate}" pattern="dd/MM/yyyy" />
                                                </p>
                                                <p class="text-xs text-gray-500 mt-1">
                                                    Thời gian: 
                                                    <c:set var="duration" value="${(userTier.endDate.time - userTier.startDate.time)/(1000*60*60*24)}" />
                                                    <fmt:formatNumber value="${duration}" maxFractionDigits="0" /> ngày
                                                </p>
                                            </div>
                                        </div>
                                        <span class="text-sm font-semibold px-3 py-1 rounded-full 
                                              ${userTier.status == 'Active' ? 'bg-green-100 text-green-700' : 'bg-rose-100 text-rose-700'}">
                                            ${userTier.status}
                                        </span>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center text-gray-500 py-8">Bạn chưa sử dụng gói thành viên nào.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Lịch sử thanh toán -->
                <div class="bg-white rounded-2xl shadow-lg p-6">
                    <h2 class="text-xl font-semibold text-indigo-600 mb-4"><i class="fas fa-credit-card mr-2"></i>Lịch Sử Thanh Toán</h2>
                    <c:choose>
                        <c:when test="${not empty tierPayments}">
                            <div class="space-y-5">
                                <c:forEach var="payment" items="${tierPayments}">
                                    <div class="border rounded-xl p-4 flex justify-between items-center hover:shadow-md transition">
                                        <div class="flex items-center">
                                            <div class="w-12 h-12 rounded-full flex items-center justify-center mr-4 
                                                 ${payment.status == 'Completed' ? 'bg-emerald-500' : 'bg-yellow-400'}">
                                                <i class="fas fa-dollar-sign text-white"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-bold text-lg">
                                                    <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </h3>
                                                <p class="text-sm text-gray-600">
                                                    <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm" />
                                                </p>
                                                <p class="text-xs text-gray-500 mt-1">Phương thức: ${payment.paymentMethod}</p>
                                                <c:if test="${not empty payment.transCode}">
                                                    <p class="text-xs text-gray-500">Mã GD: ${payment.transCode}</p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <span class="text-sm font-semibold px-3 py-1 rounded-full 
                                              ${payment.status == 'Completed' ? 'bg-green-100 text-green-700' : 
                                                payment.status == 'Pending' ? 'bg-yellow-100 text-yellow-700' : 
                                                'bg-rose-100 text-rose-700'}">
                                                  ${payment.status}
                                              </span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-gray-500 py-8">Bạn chưa có thanh toán nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Thống kê -->
                <div class="grid md:grid-cols-4 gap-6 mt-10">
                    <%
                        // Java backend có thể tính toán số liệu trước rồi set vào attribute nếu muốn tối ưu hóa
                    %>
                    <div class="text-center bg-white rounded-2xl shadow-xl p-6 hover:shadow-2xl transition">
                        <div class="w-14 h-14 mx-auto mb-3 rounded-full bg-gradient-to-br from-blue-500 to-cyan-500 flex items-center justify-center">
                            <i class="fas fa-crown text-white text-xl"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900">${not empty tierHistory ? tierHistory.size() : 0}</h3>
                        <p class="text-gray-500">Gói đã dùng</p>
                    </div>
                    <div class="text-center bg-white rounded-2xl shadow-xl p-6 hover:shadow-2xl transition">
                        <div class="w-14 h-14 mx-auto mb-3 rounded-full bg-gradient-to-br from-emerald-400 to-green-500 flex items-center justify-center">
                            <i class="fas fa-wallet text-white text-xl"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900">
                            <c:set var="totalSpent" value="0" />
                            <c:forEach var="payment" items="${tierPayments}">
                                <c:if test="${payment.status == 'Completed'}">
                                    <c:set var="totalSpent" value="${totalSpent + payment.amount}" />
                                </c:if>
                            </c:forEach>
                            <fmt:formatNumber value="${totalSpent}" type="currency" currencySymbol="₫" groupingUsed="true" />
                        </h3>
                        <p class="text-gray-500">Tổng chi tiêu</p>
                    </div>
                    <div class="text-center bg-white rounded-2xl shadow-xl p-6 hover:shadow-2xl transition">
                        <div class="w-14 h-14 mx-auto mb-3 rounded-full bg-gradient-to-br from-purple-400 to-purple-600 flex items-center justify-center">
                            <i class="fas fa-calendar text-white text-xl"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900">
                            <c:set var="totalDays" value="0" />
                            <c:forEach var="userTier" items="${tierHistory}">
                                <c:set var="duration" value="${(userTier.endDate.time - userTier.startDate.time)/(1000*60*60*24)}" />
                                <c:set var="totalDays" value="${totalDays + duration}" />
                            </c:forEach>
                            <fmt:formatNumber value="${totalDays}" maxFractionDigits="0" /> ngày
                        </h3>
                        <p class="text-gray-500">Tổng ngày sử dụng</p>
                    </div>
                    <div class="text-center bg-white rounded-2xl shadow-xl p-6 hover:shadow-2xl transition">
                        <div class="w-14 h-14 mx-auto mb-3 rounded-full bg-gradient-to-br from-orange-400 to-pink-500 flex items-center justify-center">
                            <i class="fas fa-star text-white text-xl"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900">
                            <c:set var="activeCount" value="0" />
                            <c:forEach var="userTier" items="${tierHistory}">
                                <c:if test="${userTier.status == 'Active'}">
                                    <c:set var="activeCount" value="${activeCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${activeCount}
                        </h3>
                        <p class="text-gray-500">Gói đang hoạt động</p>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />
        </body>
    </html>
