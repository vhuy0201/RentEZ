<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="p-4">
    <div class="border-b pb-4 mb-4">
        <div class="flex justify-between">
            <span class="text-gray-500">Mã giao dịch:</span>
            <span class="font-semibold">#${payment.paymentId}</span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Mã giao dịch:</span>
            <span class="font-semibold">${payment.transCode}</span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Trạng thái:</span>
            <span class="font-semibold 
                ${payment.status == 'completed' ? 'text-green-600' : 
                payment.status == 'pending' ? 'text-yellow-600' : 
                payment.status == 'failed' ? 'text-red-600' : 
                'text-purple-600'}">
                ${payment.status == 'completed' ? 'Thành công' : 
                payment.status == 'pending' ? 'Đang xử lý' : 
                payment.status == 'failed' ? 'Thất bại' : 'Đã hoàn tiền'}
            </span>
        </div>
    </div>
    
    <div class="border-b pb-4 mb-4">
        <h4 class="font-semibold mb-3">Thông tin thanh toán</h4>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Người thanh toán:</span>
            <span class="font-semibold">${payer.name}</span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Email:</span>
            <span>${payer.email}</span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Số điện thoại:</span>
            <span>${payer.phone}</span>
        </div>
        
        <c:if test="${not empty payee}">
            <div class="mt-4 pt-2 border-t">
                <div class="flex justify-between mt-2">
                    <span class="text-gray-500">Người nhận:</span>
                    <span class="font-semibold">${payee.name}</span>
                </div>
                <div class="flex justify-between mt-2">
                    <span class="text-gray-500">Email:</span>
                    <span>${payee.email}</span>
                </div>
            </div>
        </c:if>
    </div>
    
    <div class="border-b pb-4 mb-4">
        <h4 class="font-semibold mb-3">Chi tiết thanh toán</h4>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Số tiền:</span>
            <span class="text-xl font-bold text-green-600">
                <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
            </span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Phương thức:</span>
            <span>${payment.paymentMethod == 'vnpay' ? 'VNPay' : 
                  payment.paymentMethod == 'momo' ? 'MoMo' : 
                  payment.paymentMethod == 'Bank Transfer' ? 'Chuyển khoản' : 'Tiền mặt'}</span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Thời gian:</span>
            <span><fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/></span>
        </div>
        <div class="flex justify-between mt-2">
            <span class="text-gray-500">Loại giao dịch:</span>
            <span>${payment.referenceType}</span>
        </div>
    </div>
    
    <div class="flex justify-center mt-6 space-x-4">
        <c:if test="${payment.status == 'completed' && !payment.isRefunded}">
            <form method="post" action="${pageContext.request.contextPath}/admin/payment-action">
                <input type="hidden" name="action" value="refund">
                <input type="hidden" name="paymentId" value="${payment.paymentId}">
                <button type="submit" class="px-4 py-2 bg-yellow-500 text-white rounded-lg hover:bg-yellow-600 transition-colors">
                    <i class="fas fa-undo mr-2"></i> Hoàn tiền
                </button>
            </form>
        </c:if>
        <button onclick="closePaymentDetailModal()" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">
            <i class="fas fa-times mr-2"></i> Đóng
        </button>
    </div>
</div>
