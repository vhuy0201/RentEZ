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
    <title>Chi tiết hóa đơn - RentEz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/landlord/common/navigation.css"/>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: #fafafa;
            font-family: 'Inter', Arial, sans-serif;
        }

        .dashboard-header {
            background: #fff;
            padding: 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
        }

        .bill-container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-paid {
            background: #d4edda;
            color: #155724;
        }

        .status-overdue {
            background: #f8d7da;
            color: #721c24;
        }

        .btn-main {
            background: linear-gradient(135deg, #e65100, #ff6d00);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(230, 81, 0, 0.3);
        }

        .btn-main:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(230, 81, 0, 0.4);
            color: white;
        }

        .bill-detail-table th {
            background: #f8f9fa;
            font-weight: 600;
            border: none;
            padding: 1rem;
        }

        .bill-detail-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
        }

        .total-section {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 8px;
            padding: 1.5rem;
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="container-fluid">
        <div class="row">
            <!-- Navigation -->
            <jsp:include page="../common/navigation.jsp" />
            
            <!-- Main content -->
            <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                <!-- Header -->
                <div class="dashboard-header d-flex justify-content-between align-items-center">
                    <div>
                        <h1 class="h2 fw-bold text-dark mb-1">Chi tiết hóa đơn</h1>
                        <p class="text-muted mb-0">Hóa đơn #HĐ-${bill.billId}</p>
                    </div>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/billManagement" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                        <a href="${pageContext.request.contextPath}/billManagement?action=edit&id=${bill.billId}" class="btn btn-outline-warning">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                        </a>
                        <button type="button" class="btn btn-main" onclick="window.print()">
                            <i class="fas fa-print me-2"></i>In hóa đơn
                        </button>
                    </div>
                </div>

                <c:if test="${not empty bill}">
                    <!-- Bill Information -->
                    <div class="bill-container p-4 mb-4">
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="mb-4">
                                    <h3 class="fw-bold mb-3">Thông tin hóa đơn</h3>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <td class="fw-semibold">Mã hóa đơn:</td>
                                                    <td>HĐ-${bill.billId}</td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-semibold">Kỳ hóa đơn:</td>
                                                    <td>${bill.billingPeriod}</td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-semibold">Hạn thanh toán:</td>
                                                    <td>
                                                        <fmt:formatDate value="${bill.dueDate}" pattern="dd/MM/yyyy"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-semibold">Trạng thái:</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${bill.status == 'Paid'}">
                                                                <span class="status-badge status-paid">Đã thanh toán</span>
                                                            </c:when>
                                                            <c:when test="${bill.status == 'Pending' && bill.dueDate.time < currentDate.time}">
                                                                <span class="status-badge status-overdue">Quá hạn</span>
                                                            </c:when>
                                                            <c:when test="${bill.status == 'Pending'}">
                                                                <span class="status-badge status-pending">Chờ thanh toán</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge status-pending">Chờ thanh toán</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-md-6">
                                            <h6 class="fw-bold mb-2">Thông tin bất động sản</h6>
                                            <div class="text-muted">
                                                <div class="fw-semibold">${bill.property.title}</div>
                                                <div class="small">
                                                    <i class="fas fa-map-marker-alt me-1"></i>
                                                    ${bill.property.address}
                                                </div>
                                                <div class="small mt-1">
                                                    <i class="fas fa-user me-1"></i>
                                                    <strong>Người thuê:</strong> ${bill.renterName}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bill Details -->
                                <div class="mb-4">
                                    <h5 class="fw-bold mb-3">Chi tiết các khoản phí</h5>
                                    <div class="table-responsive">
                                        <table class="table bill-detail-table">
                                            <thead>
                                                <tr>
                                                    <th>Danh mục</th>
                                                    <th>Đơn vị</th>
                                                    <th>Số lượng/Chỉ số</th>
                                                    <th>Đơn giá</th>
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
                                                                <td>
                                                                    <fmt:formatNumber value="${detail.usageValue}" type="number" groupingUsed="true"/>
                                                                </td>
                                                                <td>
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

                            <!-- Summary -->
                            <div class="col-lg-4">
                                <div class="total-section">
                                    <h5 class="fw-bold mb-3">Tóm tắt thanh toán</h5>
                                    
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
                                    
                                    <div class="d-flex justify-content-between mb-3">
                                        <span class="fw-bold fs-5">Tổng cộng:</span>
                                        <span class="fw-bold fs-4 text-primary">
                                            <fmt:formatNumber value="${bill.totalAmount}" type="number" groupingUsed="true"/>đ
                                        </span>
                                    </div>

                                    <c:if test="${bill.status == 'Pending'}">
                                        <div class="d-grid gap-2">
                                            <button type="button" class="btn btn-success" onclick="markAsPaid('${bill.billId}')">
                                                <i class="fas fa-check me-2"></i>Đánh dấu đã thanh toán
                                            </button>
                                            <button type="button" class="btn btn-outline-primary">
                                                <i class="fas fa-share me-2"></i>Gửi hóa đơn cho khách
                                            </button>
                                        </div>
                                    </c:if>

                                    <c:if test="${bill.status == 'Paid'}">
                                        <div class="alert alert-success mb-0">
                                            <i class="fas fa-check-circle me-2"></i>
                                            Hóa đơn đã được thanh toán
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty bill}">
                    <div class="text-center py-5">
                        <i class="fas fa-file-invoice text-muted" style="font-size: 4rem;"></i>
                        <h4 class="mt-3 text-muted">Không tìm thấy hóa đơn</h4>
                        <p class="text-muted">Hóa đơn bạn tìm kiếm không tồn tại hoặc đã bị xóa</p>
                        <a href="${pageContext.request.contextPath}/billManagement" class="btn btn-main">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
    <script>
        function markAsPaid(billId) {
            if (confirm('Bạn có chắc chắn hóa đơn này đã được thanh toán?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/billManagement';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'updateStatus';
                
                const billIdInput = document.createElement('input');
                billIdInput.type = 'hidden';
                billIdInput.name = 'billId';
                billIdInput.value = billId;
                
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = 'Paid';
                
                form.appendChild(actionInput);
                form.appendChild(billIdInput);
                form.appendChild(statusInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
