<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="payment-detail">
    <!-- Payment Info Header -->
    <div class="bg-gradient-to-r from-primary-500 to-primary-600 text-white rounded-lg p-4 mb-6">
        <div class="flex justify-between items-center">
            <div>
                <h3 class="text-xl font-bold">Giao dịch #${payment.paymentId}</h3>
                <p class="text-primary-100">${payment.transCode}</p>
            </div>
            <div class="text-right">
                <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                    ${payment.status == 'Completed' ? 'bg-green-100 text-green-800' : 
                      payment.status == 'Pending' ? 'bg-yellow-100 text-yellow-800' : 
                      payment.status == 'Paid' ? 'bg-blue-100 text-blue-800' : 
                      'bg-red-100 text-red-800'}">
                    ${payment.status == 'Completed' ? 'Thành công' : 
                      payment.status == 'Pending' ? 'Đang xử lý' : 
                      payment.status == 'Paid' ? 'Đã thanh toán' : 'Thất bại' }
                </span>
                <p class="mt-2 text-sm text-primary-100">
                    <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                </p>
            </div>
        </div>
    </div>
    
    <!-- Payment Information -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
        <!-- Left Column -->
        <div class="space-y-4">
            <div>
                <h4 class="text-sm font-medium text-gray-500">Người thanh toán</h4>
                <div class="flex items-center mt-1">
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-blue-600 rounded-full flex items-center justify-center text-white font-semibold">
                        ${not empty payer ? payer.name.charAt(0) : 'U'}
                    </div>
                    <div class="ml-3">
                        <p class="text-base font-medium text-gray-900">${not empty payer ? payer.name : 'User '.concat(payment.payerId)}</p>
                        <p class="text-sm text-gray-500">${not empty payer ? payer.email : ''}</p>
                    </div>
                </div>
            </div>
            
            <div>
                <h4 class="text-sm font-medium text-gray-500">Phương thức thanh toán</h4>
                <div class="flex items-center mt-1">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center bg-gray-100 mr-2">
                        <i class="${payment.paymentMethod == 'vnpay' ? 'fas fa-credit-card text-blue-500' : 
                                   payment.paymentMethod == 'momo' ? 'fas fa-wallet text-pink-500' : 
                                   payment.paymentMethod == 'bank_transfer' ? 'fas fa-university text-green-500' : 
                                   'fas fa-money-bill text-green-600'}"></i>
                    </div>
                    <div>
                        <p class="text-base font-medium text-gray-900">
                            ${payment.paymentMethod == 'vnpay' ? 'VNPay' : 
                              payment.paymentMethod == 'momo' ? 'MoMo' : 
                              payment.paymentMethod == 'bank_transfer' ? 'Chuyển khoản ngân hàng' : 
                              'Tiền mặt'}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Right Column -->
        <div class="space-y-4">
            <div>
                <h4 class="text-sm font-medium text-gray-500">Mã đặt thuê liên quan</h4>
                <c:if test="${not empty booking}">
                    <div class="flex items-center mt-1">
                        <div class="w-8 h-8 rounded-full flex items-center justify-center bg-primary-100 text-primary-600 mr-2">
                            <i class="fas fa-home"></i>
                        </div>
                        <div>
                            <p class="text-base font-medium text-gray-900">Booking #${booking.bookingId}</p>
                            <p class="text-sm text-gray-500">
                                <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy"/> - 
                                <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy"/>
                            </p>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty booking}">
                    <p class="text-gray-500 mt-1">Không có thông tin đặt thuê liên quan</p>
                </c:if>
            </div>
            
            <div>
                <h4 class="text-sm font-medium text-gray-500">Số tiền</h4>
                <p class="text-2xl font-bold text-green-600 mt-1">
                    <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                </p>
            </div>
        </div>
    </div>

    <!-- Transaction Details -->
    <div class="mb-6">
        <h4 class="text-sm font-medium text-gray-500 mb-3">Chi tiết giao dịch</h4>
        <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <p class="text-sm font-medium text-gray-500">ID Giao dịch</p>
                    <p class="text-base text-gray-900">${payment.transCode}</p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500">Thời gian tạo</p>
                    <p class="text-base text-gray-900">
                        <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-500">Mô tả</p>
                    <p class="text-base text-gray-900">${not empty payment.description ? payment.description : 'Không có mô tả'}</p>
                </div>
                <c:if test="${not empty payment.completedDate}">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Thời gian hoàn thành</p>
                        <p class="text-base text-gray-900">
                            <fmt:formatDate value="${payment.completedDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </p>
                    </div>
                </c:if>
                <c:if test="${payment.status == 'Refunded'}">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Thời gian hoàn tiền</p>
                        <p class="text-base text-gray-900">
                            <fmt:formatDate value="${payment.refundDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Payment Notes -->
    <c:if test="${not empty payment.notes}">
        <div class="mb-6">
            <h4 class="text-sm font-medium text-gray-500 mb-3">Ghi chú</h4>
            <div class="bg-yellow-50 rounded-lg p-4 border border-yellow-200">
                <p class="text-gray-800">${payment.notes}</p>
            </div>
        </div>
    </c:if>
</div>
