<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Hóa đơn - RentEz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
    
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Inter', Arial, sans-serif;
        }

        .page-header {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: 1px solid #e9ecef;
        }

        .card {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }

        .card-header {
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            font-weight: 600;
            padding: 1.25rem;
        }

        .property-info {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .table th {
            background: #f8f9fa;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
            padding: 1rem;
        }

        .table td {
            padding: 1rem;
            border-bottom: 1px solid #e9ecef;
        }

        .summary-box {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .btn-primary {
            background: #007bff;
            border: 1px solid #007bff;
            border-radius: 6px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
        }

        .btn-outline-secondary {
            border: 1px solid #6c757d;
            border-radius: 6px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
        }

        .btn-success {
            background: #28a745;
            border: 1px solid #28a745;
            border-radius: 6px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
        }

        .badge {
            font-size: 0.875rem;
            padding: 0.5rem 0.75rem;
            border-radius: 4px;
        }

        .payment-modal .modal-header {
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }

        .wallet-info {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .amount-highlight {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 1rem;
            }
            .table-responsive {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <div class="container my-4">
        <!-- Header -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h1 class="h3 mb-1">Chi tiết</h1>
                    <p class="text-muted mb-0">Mã hóa đơn: <strong>HĐ-${bill.billId}</strong></p>
                </div>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/payments" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button type="button" class="btn btn-primary" onclick="window.print()">
                        <i class="fas fa-print me-1"></i>In hóa đơn
                    </button>
                </div>
            </div>
        </div>

        <c:if test="${not empty bill}">
            <div class="row">
                <!-- Left Column - Bill Details -->
                <div class="col-lg-8">
                    <!-- Property Information -->
                    <div class="property-info">
                        <h5 class="fw-bold mb-3"><i class="fas fa-home me-2"></i>Thông tin bất động sản</h5>
                        <div class="row">
                            <div class="col-md-8">
                                <h6 class="fw-bold text-primary">${bill.property.title}</h6>
                                <p class="text-muted mb-2">
                                    <i class="fas fa-map-marker-alt me-1"></i>
                                    ${bill.property.address}
                                </p>
                                <p class="mb-0">
                                    <i class="fas fa-user me-1"></i>
                                    <strong>Người thuê:</strong> ${bill.renterName}
                                </p>
                            </div>
                            <div class="col-md-4">
                                <div class="text-end">
                                    <div class="small text-muted">Kỳ hóa đơn</div>
                                    <div class="fw-bold">${bill.billingPeriod}</div>
                                    <div class="small text-muted mt-2">Hạn thanh toán</div>
                                    <div class="fw-bold">
                                        <fmt:formatDate value="${bill.dueDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Status -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Trạng thái hóa đơn</h5>
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center gap-3">
                                        <div>
                                            <strong>Trạng thái:</strong>
                                            <c:choose>
                                                <c:when test="${bill.status == 'Paid'}">
                                                    <span class="badge bg-success ms-2">Đã thanh toán</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'Pending' && bill.dueDate.time < currentDate.time}">
                                                    <span class="badge bg-danger ms-2">Quá hạn</span>
                                                </c:when>
                                                <c:when test="${bill.status == 'Pending'}">
                                                    <span class="badge bg-warning ms-2">Chờ thanh toán</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning ms-2">Chờ thanh toán</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Details -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Chi tiết các khoản phí</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>Danh mục</th>
                                            <th>Đơn vị</th>
                                            <th class="text-center">Số lượng</th>
                                            <th class="text-end">Đơn giá</th>
                                            <th class="text-end">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty bill.billDetails}">
                                                <c:forEach var="detail" items="${bill.billDetails}">
                                                    <tr>
                                                        <td class="fw-semibold">${detail.feeCategory.name}</td>
                                                        <td>${detail.feeCategory.unit}</td>
                                                        <td class="text-center">
                                                            <fmt:formatNumber value="${detail.usageValue}" type="number" groupingUsed="true"/>
                                                        </td>
                                                        <td class="text-end">
                                                            <fmt:formatNumber value="${detail.feeCategory.unitPrice}" type="number" groupingUsed="true"/>đ
                                                        </td>
                                                        <td class="text-end fw-bold">
                                                            <fmt:formatNumber value="${detail.amount}" type="number" groupingUsed="true"/>đ
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted py-4">
                                                        <i class="fas fa-receipt me-2"></i>
                                                        Chưa có chi tiết phí nào
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column - Payment Summary -->
                <div class="col-lg-4">
                    <div class="summary-box">
                        <h5 class="fw-bold mb-3"><i class="fas fa-calculator me-2"></i>Tóm tắt thanh toán</h5>

                        <c:set var="totalDetails" value="0" />
                        <c:if test="${not empty bill.billDetails}">
                            <c:forEach var="detail" items="${bill.billDetails}">
                                <c:set var="totalDetails" value="${totalDetails + detail.amount}" />
                            </c:forEach>
                        </c:if>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tổng các khoản phí:</span>
                            <span class="fw-semibold">
                                <fmt:formatNumber value="${totalDetails}" type="number" groupingUsed="true"/>đ
                            </span>
                        </div>
                        
                        <hr>
                        
                        <div class="d-flex justify-content-between mb-4">
                            <span class="fw-bold fs-5">Tổng cộng:</span>
                            <span class="amount-highlight">
                                <fmt:formatNumber value="${bill.totalAmount}" type="number" groupingUsed="true"/>đ
                            </span>
                        </div>

                        <!-- Payment Actions -->
                        <c:choose>
                            <c:when test="${bill.status == 'Paid'}">
                                <div class="alert alert-success text-center mb-0">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <strong>Đã thanh toán</strong>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="d-grid gap-2">
                                    <form action="${pageContext.request.contextPath}/payment-action" method="POST">
                                        <input type="hidden" name="action" value="pay-bill" />
                                        <input type="hidden" name="billId" value="${bill.billId}" />
                                        <input type="hidden" name="amount" value="${bill.totalAmount}" />
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-credit-card me-2"></i>Thanh toán ngay
                                        </button>
                                    </form>
                                    <c:if test="${bill.dueDate.time < currentDate.time}">
                                        <div class="alert alert-warning text-center mb-0 mt-2">
                                            <i class="fas fa-exclamation-triangle me-1"></i>
                                            <small>Hóa đơn đã quá hạn thanh toán</small>
                                        </div>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Wallet Information -->
                    <c:if test="${bill.status != 'Paid' && not empty userWallet}">
                        <div class="wallet-info">
                            <h6 class="fw-bold mb-2"><i class="fas fa-wallet me-2"></i>Ví của bạn</h6>
                            <div class="d-flex justify-content-between">
                                <span>Số dư hiện tại:</span>
                                <span class="fw-bold text-primary">
                                    <fmt:formatNumber value="${userWallet.balance}" type="number" groupingUsed="true"/>đ
                                </span>
                            </div>
                            <c:if test="${userWallet.balance < bill.totalAmount}">
                                <div class="alert alert-warning mt-2 mb-0">
                                    <small>
                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                        Số dư không đủ để thanh toán hóa đơn này
                                    </small>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <c:if test="${empty bill}">
            <div class="text-center py-5">
                <i class="fas fa-file-invoice text-muted" style="font-size: 4rem;"></i>
                <h4 class="mt-3 text-muted">Không tìm thấy hóa đơn</h4>
                <p class="text-muted">Hóa đơn bạn tìm kiếm không tồn tại hoặc bạn không có quyền xem</p>
                <a href="${pageContext.request.contextPath}/payments" class="btn btn-primary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                </a>
            </div>
        </c:if>
    </div>

    <!-- Print functionality -->
    <script>
        function printBill() {
            window.print();
        }
    </script>
</body>
</html>
