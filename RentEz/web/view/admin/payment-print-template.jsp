<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa Đơn #${payment.paymentId} - RentEz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .invoice-header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #f97316;
            padding-bottom: 20px;
        }
        
        .invoice-header h1 {
            color: #f97316;
            margin-bottom: 5px;
        }
        
        .invoice-header p {
            color: #666;
            margin: 5px 0;
        }
        
        .invoice-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        
        .invoice-info div {
            flex: 1;
        }
        
        .customer-info h3, .payment-info h3 {
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
            margin-bottom: 10px;
        }
        
        .amount {
            font-size: 24px;
            font-weight: bold;
            color: #f97316;
        }
        
        .payment-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            font-weight: bold;
            font-size: 14px;
            text-transform: uppercase;
        }
        
        .status-completed {
            background-color: #dcfce7;
            color: #15803d;
        }
        
        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
        }
        
        .status-failed {
            background-color: #fee2e2;
            color: #b91c1c;
        }
        
        .status-refunded {
            background-color: #e0f2fe;
            color: #0369a1;
        }
        
        .invoice-details {
            margin-top: 30px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        
        .invoice-details table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .invoice-details th {
            text-align: left;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            background-color: #f8f8f8;
        }
        
        .invoice-details td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .footer {
            margin-top: 50px;
            text-align: center;
            color: #666;
            font-size: 14px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        
        @media print {
            body {
                print-color-adjust: exact;
                -webkit-print-color-adjust: exact;
            }
            .no-print {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="invoice-header">
        <h1>RentEz</h1>
        <p>Hệ thống cho thuê bất động sản</p>
        <p>Hóa đơn thanh toán</p>
    </div>
    
    <div class="invoice-info">
        <div class="customer-info">
            <h3>Thông tin khách hàng</h3>
            <p><strong>Họ tên:</strong> ${not empty payer ? payer.name : 'User '.concat(payment.payerId)}</p>
            <p><strong>Email:</strong> ${not empty payer ? payer.email : 'N/A'}</p>
            <p><strong>Điện thoại:</strong> ${not empty payer ? payer.phoneNumber : 'N/A'}</p>
        </div>
        
        <div class="payment-info">
            <h3>Thông tin thanh toán</h3>
            <p><strong>Mã giao dịch:</strong> #${payment.paymentId}</p>
            <p><strong>Mã tham chiếu:</strong> ${payment.transCode}</p>
            <p><strong>Ngày thanh toán:</strong> <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
            <p><strong>Trạng thái:</strong> 
                <span class="payment-status 
                    ${payment.status == 'Completed' ? 'status-completed' : 
                      payment.status == 'Pending' ? 'status-pending' : 
                      payment.status == 'Refunded' ? 'status-refunded' : 'status-failed'}">
                    ${payment.status == 'Completed' ? 'Thành công' : 
                      payment.status == 'Pending' ? 'Đang xử lý' : 
                      payment.status == 'Refunded' ? 'Đã hoàn tiền' : 'Thất bại' }
                </span>
            </p>
        </div>
    </div>
    
    <div>
        <h3>Chi tiết thanh toán</h3>
        <p><strong>Phương thức thanh toán:</strong>
            ${payment.paymentMethod == 'vnpay' ? 'VNPay' : 
              payment.paymentMethod == 'momo' ? 'MoMo' : 
              payment.paymentMethod == 'bank_transfer' ? 'Chuyển khoản ngân hàng' : 'Tiền mặt'}
        </p>
        <p><strong>Số tiền:</strong> <span class="amount"><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></span></p>
        
        <c:if test="${not empty payment.description}">
            <p><strong>Mô tả:</strong> ${payment.description}</p>
        </c:if>
    </div>
    
    <c:if test="${not empty booking}">
        <div class="invoice-details">
            <h3>Chi tiết đặt thuê</h3>
            <table>
                <thead>
                    <tr>
                        <th>Mã đặt thuê</th>
                        <th>Bất động sản</th>
                        <th>Thời gian thuê</th>
                        <th>Giá thuê</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#${booking.bookingId}</td>
                        <td>${not empty property ? property.title : 'N/A'}</td>
                        <td>
                            <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy"/> - 
                            <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td><fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>/tháng</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </c:if>
    
    <c:if test="${not empty payment.notes}">
        <div style="margin-top: 20px; padding: 15px; background-color: #fffbeb; border: 1px solid #fef3c7; border-radius: 5px;">
            <h3 style="margin-top: 0;">Ghi chú</h3>
            <p>${payment.notes}</p>
        </div>
    </c:if>
    
    <div class="footer">
        <p>Cảm ơn quý khách đã sử dụng dịch vụ của RentEz!</p>
        <p>Địa chỉ: 123 Đường ABC, Quận XYZ, TP.HCM</p>
        <p>Email: support@rentez.com | Hotline: 1900-1234</p>
    </div>
    
    <div class="no-print" style="margin-top: 20px; text-align: center;">
        <button onclick="window.print();" style="padding: 10px 20px; background-color: #f97316; color: white; border: none; border-radius: 5px; cursor: pointer;">
            In hóa đơn
        </button>
        <button onclick="window.close();" style="padding: 10px 20px; background-color: #e5e7eb; color: #374151; border: none; border-radius: 5px; margin-left: 10px; cursor: pointer;">
            Đóng
        </button>
    </div>
</body>
</html>
