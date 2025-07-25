<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Kết Quả Thanh Toán - RentEz</title>
        <!-- Tailwind CSS CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body class="bg-gradient-to-br from-orange-50 via-orange-100 to-orange-50 min-h-screen font-sans">
        <jsp:include page="../common/header.jsp" />

        <div class="container mx-auto px-6 mt-8">
            <div class="max-w-2xl mx-auto">
                <div class="bg-white rounded-lg shadow-lg p-8">
                    
                    <c:choose>
                        <c:when test="${param.vnp_ResponseCode == '00'}">
                            <!-- Success -->
                            <div class="text-center">
                                <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <i class="fas fa-check text-4xl text-green-600"></i>
                                </div>
                                <h2 class="text-3xl font-bold text-green-600 mb-4">Thanh Toán Thành Công!</h2>
                                <p class="text-gray-600 mb-6">Giao dịch nạp tiền của bạn đã được xử lý thành công.</p>
                                
                                <div class="bg-green-50 border border-green-200 rounded-lg p-6 mb-6">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <span class="font-semibold text-gray-700">Mã giao dịch:</span>
                                            <span class="text-green-600">${param.vnp_TxnRef}</span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Số tiền:</span>
                                            <span class="text-green-600 font-bold">
                                                <fmt:formatNumber value="${param.vnp_Amount / 100}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                            </span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Ngân hàng:</span>
                                            <span class="text-green-600">${param.vnp_BankCode}</span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Mã GD VNPay:</span>
                                            <span class="text-green-600">${param.vnp_TransactionNo}</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="space-x-4">
                                    <a href="${pageContext.request.contextPath}/view-payments" 
                                       class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded-lg hover:from-orange-500 hover:to-orange-600 transition">
                                        <i class="fas fa-wallet mr-2"></i> Xem Ví Của Tôi
                                    </a>
                                    <a href="${pageContext.request.contextPath}/dashboard" 
                                       class="inline-flex items-center px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition">
                                        <i class="fas fa-home mr-2"></i> Về Trang Chủ
                                    </a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Error -->
                            <div class="text-center">
                                <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <i class="fas fa-times text-4xl text-red-600"></i>
                                </div>
                                <h2 class="text-3xl font-bold text-red-600 mb-4">Thanh Toán Thất Bại!</h2>
                                <p class="text-gray-600 mb-6">Giao dịch của bạn không thể được xử lý.</p>
                                
                                <div class="bg-red-50 border border-red-200 rounded-lg p-6 mb-6">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <span class="font-semibold text-gray-700">Mã giao dịch:</span>
                                            <span class="text-red-600">${param.vnp_TxnRef}</span>
                                        </div>
                                        <div>
                                            <span class="font-semibold text-gray-700">Mã lỗi:</span>
                                            <span class="text-red-600">${param.vnp_ResponseCode}</span>
                                        </div>
                                        <div class="md:col-span-2">
                                            <span class="font-semibold text-gray-700">Lý do:</span>
                                            <span class="text-red-600">
                                                <c:choose>
                                                    <c:when test="${param.vnp_ResponseCode == '01'}">Giao dịch chưa hoàn tất</c:when>
                                                    <c:when test="${param.vnp_ResponseCode == '02'}">Giao dịch bị lỗi</c:when>
                                                    <c:when test="${param.vnp_ResponseCode == '04'}">Giao dịch đảo (Khách hàng đã bị trừ tiền tại Ngân hàng nhưng GD chưa thành công ở VNPAY)</c:when>
                                                    <c:when test="${param.vnp_ResponseCode == '05'}">VNPAY đang xử lý giao dịch này (GD hoàn tiền)</c:when>
                                                    <c:when test="${param.vnp_ResponseCode == '06'}">VNPAY đã gửi yêu cầu hoàn tiền sang Ngân hàng (GD hoàn tiền)</c:when>
                                                    <c:when test="${param.vnp_ResponseCode == '07'}">Giao dịch bị nghi ngờ</c:when>
                                                    <c:when test="${param.vnp_ResponseCode == '09'}">GD Hoàn trả bị từ chối</c:when>
                                                    <c:otherwise>Lỗi không xác định</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="space-x-4">
                                    <a href="${pageContext.request.contextPath}/view-payments" 
                                       class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded-lg hover:from-orange-500 hover:to-orange-600 transition">
                                        <i class="fas fa-redo mr-2"></i> Thử Lại
                                    </a>
                                    <a href="${pageContext.request.contextPath}/dashboard" 
                                       class="inline-flex items-center px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition">
                                        <i class="fas fa-home mr-2"></i> Về Trang Chủ
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <jsp:include page="../common/footer.jsp" />
        
        <c:if test="${param.vnp_ResponseCode == '00'}">
            <script>
                // Auto redirect after 10 seconds for successful payment
                setTimeout(function() {
                    window.location.href = '${pageContext.request.contextPath}/view-payments';
                }, 10000);
            </script>
        </c:if>
    </body>
</html>
