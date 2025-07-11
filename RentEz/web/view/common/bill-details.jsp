<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi Tiết Hóa Đơn - RentEz</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .bill-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 30px;
        }
        .bill-card {
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .status-paid {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        .status-unpaid {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        .status-overdue {
            background-color: #fff3cd;
            border-color: #ffeaa7;
            color: #856404;
        }
        .bill-amount {
            font-size: 2em;
            font-weight: bold;
        }
        .detail-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .detail-item:last-child {
            border-bottom: none;
        }
        .info-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .btn-back {
            border-radius: 20px;
            padding: 8px 20px;
        }
        .payment-btn {
            border-radius: 20px;
            padding: 10px 25px;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <!-- Include header -->
    <jsp:include page="header.jsp" />

    <div class="container mt-4">
        <!-- Back Button -->
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/payments" class="btn btn-outline-secondary btn-back">
                <i class="fas fa-arrow-left mr-2"></i>Quay Lại
            </a>
        </div>

        <!-- Bill Header -->
        <div class="bill-card">
            <div class="bill-header">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h2><i class="fas fa-file-invoice-dollar mr-2"></i>Chi Tiết Hóa Đơn #${bill.billId}</h2>
                        <p class="mb-2"><i class="fas fa-home mr-2"></i>${bill.property.title}</p>
                        <p class="mb-0"><i class="fas fa-calendar mr-2"></i>Kỳ thanh toán: ${bill.billingPeriod}</p>
                    </div>
                    <div class="col-md-4 text-right">
                        <div class="bill-amount">
                            <fmt:formatNumber value="${bill.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                        </div>
                        <c:choose>
                            <c:when test="${bill.status == 'Paid'}">
                                <span class="badge badge-success badge-lg mt-2">
                                    <i class="fas fa-check mr-1"></i>Đã Thanh Toán
                                </span>
                            </c:when>
                            <c:when test="${bill.status == 'Overdue'}">
                                <span class="badge badge-warning badge-lg mt-2">
                                    <i class="fas fa-exclamation-triangle mr-1"></i>Quá Hạn
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-danger badge-lg mt-2">
                                    <i class="fas fa-clock mr-1"></i>Chưa Thanh Toán
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Bill Information -->
            <div class="card-body">
                <div class="row">
                    <!-- Property Information -->
                    <div class="col-md-6">
                        <div class="info-card">
                            <h6><i class="fas fa-building mr-2"></i>Thông Tin Bất Động Sản</h6>
                            <hr>
                            <p><strong>Tên:</strong> ${bill.property.title}</p>
                            <p><strong>Địa chỉ:</strong> ${bill.property.address}</p>
                            <p><strong>Loại:</strong> ${bill.property.propertyType}</p>
                            <c:if test="${not empty landlord}">
                                <p><strong>Chủ nhà:</strong> ${landlord.fullName}</p>
                                <p><strong>Email:</strong> ${landlord.email}</p>
                                <p><strong>Điện thoại:</strong> ${landlord.phoneNumber}</p>
                            </c:if>
                        </div>
                    </div>

                    <!-- Bill Information -->
                    <div class="col-md-6">
                        <div class="info-card">
                            <h6><i class="fas fa-file-invoice mr-2"></i>Thông Tin Hóa Đơn</h6>
                            <hr>
                            <p><strong>Mã hóa đơn:</strong> #${bill.billId}</p>
                            <p><strong>Kỳ thanh toán:</strong> ${bill.billingPeriod}</p>
                            <p><strong>Hạn thanh toán:</strong> 
                                <fmt:formatDate value="${bill.dueDate}" pattern="dd/MM/yyyy"/>
                            </p>
                            <p><strong>Trạng thái:</strong> 
                                <c:choose>
                                    <c:when test="${bill.status == 'Paid'}">
                                        <span class="text-success">Đã thanh toán</span>
                                    </c:when>
                                    <c:when test="${bill.status == 'Overdue'}">
                                        <span class="text-warning">Quá hạn</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger">Chưa thanh toán</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <c:if test="${not empty renter}">
                                <p><strong>Người thuê:</strong> ${renter.fullName}</p>
                                <p><strong>Email:</strong> ${renter.email}</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Bill Details -->
                <div class="card">
                    <div class="card-header">
                        <h6><i class="fas fa-list mr-2"></i>Chi Tiết Các Khoản Phí</h6>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty bill.billDetails}">
                                <c:forEach var="detail" items="${bill.billDetails}">
                                    <div class="detail-item">
                                        <div class="row align-items-center">
                                            <div class="col-md-4">
                                                <strong>${detail.feeCategory.name}</strong>
                                                <br>
                                                <small class="text-muted">
                                                    Đơn giá: <fmt:formatNumber value="${detail.feeCategory.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>/${detail.feeCategory.unit}
                                                </small>
                                            </div>
                                            <div class="col-md-3 text-center">
                                                <span class="badge badge-info">
                                                    <fmt:formatNumber value="${detail.usageValue}" maxFractionDigits="2"/> ${detail.feeCategory.unit}
                                                </span>
                                            </div>
                                            <div class="col-md-3 text-center">
                                                <span class="text-muted">
                                                    <fmt:formatNumber value="${detail.feeCategory.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/> × 
                                                    <fmt:formatNumber value="${detail.usageValue}" maxFractionDigits="2"/>
                                                </span>
                                            </div>
                                            <div class="col-md-2 text-right">
                                                <strong class="text-primary">
                                                    <fmt:formatNumber value="${detail.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </strong>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <!-- Total -->
                                <div class="detail-item" style="background-color: #f8f9fa; border-top: 2px solid #dee2e6;">
                                    <div class="row align-items-center">
                                        <div class="col-md-9">
                                            <h6 class="mb-0"><strong>Tổng Cộng</strong></h6>
                                        </div>
                                        <div class="col-md-3 text-right">
                                            <h5 class="mb-0 text-primary">
                                                <strong>
                                                    <fmt:formatNumber value="${bill.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </strong>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-exclamation-circle text-muted" style="font-size: 2em;"></i>
                                    <p class="mt-2 text-muted">Không có chi tiết phí nào được tìm thấy</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Payment Action -->
                <c:if test="${bill.status != 'Paid' && currentUser.role == 'Renter' && bill.renterId == currentUser.userId}">
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-primary payment-btn" 
                                onclick="openPaymentModal(${bill.billId}, '${bill.property.title}', ${bill.totalAmount})">
                            <i class="fas fa-credit-card mr-2"></i>Thanh Toán Ngay
                        </button>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Payment Modal -->
    <div class="modal fade" id="paymentModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-credit-card mr-2"></i>Thanh Toán Hóa Đơn
                    </h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/payment-action" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="pay-bill">
                        <input type="hidden" name="billId" id="paymentBillId">
                        
                        <div class="alert alert-info">
                            <h6 id="paymentPropertyTitle"></h6>
                            <p class="mb-0">Số tiền: <strong id="paymentAmount"></strong></p>
                        </div>

                        <div class="form-group">
                            <label>Phương thức thanh toán:</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" value="wallet" id="walletPayment" checked>
                                <label class="form-check-label" for="walletPayment">
                                    <i class="fas fa-wallet mr-2"></i>Ví điện tử 
                                    <small class="text-muted">
                                        (Số dư hiện tại: <fmt:formatNumber value="${currentUser.wallet.balance}" type="currency" currencySymbol="₫" groupingUsed="true"/>)
                                    </small>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" value="bank_transfer" id="bankTransfer">
                                <label class="form-check-label" for="bankTransfer">
                                    <i class="fas fa-university mr-2"></i>Chuyển khoản ngân hàng
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" value="credit_card" id="creditCard">
                                <label class="form-check-label" for="creditCard">
                                    <i class="fas fa-credit-card mr-2"></i>Thẻ tín dụng
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-credit-card mr-1"></i>Thanh Toán
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Include footer -->
    <jsp:include page="footer.jsp" />

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function openPaymentModal(billId, propertyTitle, amount) {
            document.getElementById('paymentBillId').value = billId;
            document.getElementById('paymentPropertyTitle').textContent = propertyTitle;
            document.getElementById('paymentAmount').textContent = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(amount);
            
            $('#paymentModal').modal('show');
        }
        
        // Print functionality
        function printBill() {
            window.print();
        }
        
        // Add print styles
        const printStyles = `
            @media print {
                .btn, .modal, .navbar, footer { display: none !important; }
                .bill-card { box-shadow: none !important; border: 1px solid #ddd !important; }
                .bill-header { background: #f8f9fa !important; color: #333 !important; }
            }
        `;
        
        const styleSheet = document.createElement("style");
        styleSheet.type = "text/css";
        styleSheet.innerText = printStyles;
        document.head.appendChild(styleSheet);
    </script>
</body>
</html>
