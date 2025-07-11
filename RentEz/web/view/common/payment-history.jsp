<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lịch Sử Thanh Toán - RentEz</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .history-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 30px;
        }
        .history-card {
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .transaction-item {
            padding: 20px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s;
        }
        .transaction-item:hover {
            background-color: #f8f9fa;
        }
        .transaction-item:last-child {
            border-bottom: none;
        }
        .transaction-amount {
            font-size: 1.2em;
            font-weight: bold;
        }
        .transaction-date {
            color: #6c757d;
            font-size: 0.9em;
        }
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-failed {
            background-color: #f8d7da;
            color: #721c24;
        }
        .filter-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .btn-back {
            border-radius: 20px;
            padding: 8px 20px;
        }
        .summary-stats {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .stat-item {
            text-align: center;
        }
        .stat-value {
            font-size: 1.5em;
            font-weight: bold;
        }
        .payment-method-badge {
            border-radius: 15px;
            padding: 5px 10px;
            font-size: 0.8em;
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

        <!-- Page Header -->
        <div class="history-card">
            <div class="history-header">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h2><i class="fas fa-history mr-2"></i>Lịch Sử Thanh Toán</h2>
                        <p class="mb-0">Xem tất cả các giao dịch và lịch sử thanh toán của bạn</p>
                    </div>
                    <div class="col-md-4 text-right">
                        <button class="btn btn-light" onclick="exportToCSV()">
                            <i class="fas fa-download mr-1"></i>Xuất Excel
                        </button>
                    </div>
                </div>
            </div>

            <!-- Summary Statistics -->
            <div class="card-body">
                <div class="summary-stats">
                    <div class="row">
                        <div class="col-md-3 stat-item">
                            <div class="stat-value">${payments.size()}</div>
                            <div>Tổng Giao Dịch</div>
                        </div>
                        <div class="col-md-3 stat-item">
                            <div class="stat-value">
                                <c:set var="totalCompleted" value="0"/>
                                <c:forEach var="payment" items="${payments}">
                                    <c:if test="${payment.status == 'Completed'}">
                                        <c:set var="totalCompleted" value="${totalCompleted + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${totalCompleted}
                            </div>
                            <div>Thành Công</div>
                        </div>
                        <div class="col-md-3 stat-item">
                            <div class="stat-value">
                                <c:set var="totalPending" value="0"/>
                                <c:forEach var="payment" items="${payments}">
                                    <c:if test="${payment.status == 'Pending'}">
                                        <c:set var="totalPending" value="${totalPending + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${totalPending}
                            </div>
                            <div>Đang Xử Lý</div>
                        </div>
                        <div class="col-md-3 stat-item">
                            <div class="stat-value">
                                <c:set var="totalAmount" value="0"/>
                                <c:forEach var="payment" items="${payments}">
                                    <c:if test="${payment.status == 'Completed'}">
                                        <c:set var="totalAmount" value="${totalAmount + payment.amount}"/>
                                    </c:if>
                                </c:forEach>
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                            </div>
                            <div>Tổng Đã Thanh Toán</div>
                        </div>
                    </div>
                </div>

                <!-- Filter Section -->
                <div class="filter-section">
                    <form method="GET" action="${pageContext.request.contextPath}/payments">
                        <input type="hidden" name="action" value="payment-history">
                        <div class="row">
                            <div class="col-md-3">
                                <label for="fromDate">Từ ngày:</label>
                                <input type="date" class="form-control" name="fromDate" id="fromDate" value="${param.fromDate}">
                            </div>
                            <div class="col-md-3">
                                <label for="toDate">Đến ngày:</label>
                                <input type="date" class="form-control" name="toDate" id="toDate" value="${param.toDate}">
                            </div>
                            <div class="col-md-3">
                                <label for="status">Trạng thái:</label>
                                <select class="form-control" name="status" id="status">
                                    <option value="">Tất cả</option>
                                    <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                                    <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="Failed" ${param.status == 'Failed' ? 'selected' : ''}>Thất bại</option>
                                </select>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary mr-2">
                                    <i class="fas fa-search mr-1"></i>Lọc
                                </button>
                                <a href="${pageContext.request.contextPath}/payments?action=payment-history" class="btn btn-outline-secondary">
                                    <i class="fas fa-redo mr-1"></i>Đặt lại
                                </a>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Payment History List -->
                <c:choose>
                    <c:when test="${empty payments}">
                        <div class="text-center py-5">
                            <i class="fas fa-history text-muted" style="font-size: 3em;"></i>
                            <h5 class="mt-3">Chưa có giao dịch nào</h5>
                            <p class="text-muted">Lịch sử giao dịch sẽ hiển thị tại đây khi bạn thực hiện thanh toán</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-header">
                                <h6><i class="fas fa-list mr-2"></i>Danh Sách Giao Dịch</h6>
                            </div>
                            <div class="card-body p-0">
                                <c:forEach var="payment" items="${payments}">
                                    <div class="transaction-item">
                                        <div class="row align-items-center">
                                            <div class="col-md-1 text-center">
                                                <c:choose>
                                                    <c:when test="${payment.referenceType == 'Bill'}">
                                                        <i class="fas fa-file-invoice-dollar text-primary" style="font-size: 1.5em;"></i>
                                                    </c:when>
                                                    <c:when test="${payment.referenceType == 'Deposit'}">
                                                        <i class="fas fa-plus text-success" style="font-size: 1.5em;"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-exchange-alt text-info" style="font-size: 1.5em;"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-md-4">
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${payment.referenceType == 'Bill'}">
                                                            Thanh toán hóa đơn #${payment.referenceId}
                                                        </c:when>
                                                        <c:when test="${payment.referenceType == 'Deposit'}">
                                                            Nạp tiền vào ví
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${payment.referenceType}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </strong>
                                                <br>
                                                <div class="transaction-date">
                                                    <i class="fas fa-clock mr-1"></i>
                                                    <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </div>
                                                <small class="text-muted">Mã GD: ${payment.transCode}</small>
                                            </div>
                                            <div class="col-md-2 text-center">
                                                <span class="payment-method-badge badge badge-secondary">
                                                    <c:choose>
                                                        <c:when test="${payment.paymentMethod == 'Wallet'}">
                                                            <i class="fas fa-wallet mr-1"></i>Ví điện tử
                                                        </c:when>
                                                        <c:when test="${payment.paymentMethod == 'bank_transfer'}">
                                                            <i class="fas fa-university mr-1"></i>Chuyển khoản
                                                        </c:when>
                                                        <c:when test="${payment.paymentMethod == 'credit_card'}">
                                                            <i class="fas fa-credit-card mr-1"></i>Thẻ tín dụng
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${payment.paymentMethod}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="col-md-2 text-center">
                                                <c:choose>
                                                    <c:when test="${payment.status == 'Completed'}">
                                                        <span class="badge badge-success status-completed">
                                                            <i class="fas fa-check mr-1"></i>Hoàn thành
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${payment.status == 'Pending'}">
                                                        <span class="badge badge-warning status-pending">
                                                            <i class="fas fa-clock mr-1"></i>Đang xử lý
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger status-failed">
                                                            <i class="fas fa-times mr-1"></i>${payment.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-md-3 text-right">
                                                <div class="transaction-amount">
                                                    <c:choose>
                                                        <c:when test="${payment.payerId == currentUser.userId}">
                                                            <span class="text-danger">
                                                                -<fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-success">
                                                                +<fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <c:if test="${payment.isRefunded}">
                                                    <small class="text-muted">
                                                        <i class="fas fa-undo mr-1"></i>Đã hoàn tiền
                                                    </small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <nav class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Wallet Transfer History -->
        <c:if test="${not empty walletTransfers}">
            <div class="history-card">
                <div class="card-header bg-info text-white">
                    <h6><i class="fas fa-wallet mr-2"></i>Lịch Sử Giao Dịch Ví</h6>
                </div>
                <div class="card-body p-0">
                    <c:forEach var="transfer" items="${walletTransfers}">
                        <div class="transaction-item">
                            <div class="row align-items-center">
                                <div class="col-md-1 text-center">
                                    <i class="fas fa-wallet text-info" style="font-size: 1.5em;"></i>
                                </div>
                                <div class="col-md-6">
                                    <strong>${transfer.content}</strong>
                                    <br>
                                    <div class="transaction-date">
                                        <i class="fas fa-clock mr-1"></i>${transfer.timeCode}
                                    </div>
                                    <small class="text-muted">Mã GD: ${transfer.transCode}</small>
                                </div>
                                <div class="col-md-2 text-center">
                                    <c:choose>
                                        <c:when test="${transfer.isRefunded}">
                                            <span class="badge badge-warning">
                                                <i class="fas fa-undo mr-1"></i>Đã hoàn
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-success">
                                                <i class="fas fa-check mr-1"></i>Hoàn thành
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-md-3 text-right">
                                    <div class="transaction-amount text-info">
                                        <fmt:formatNumber value="${transfer.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Include footer -->
    <jsp:include page="footer.jsp" />

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function exportToCSV() {
            // Create CSV content
            let csvContent = "data:text/csv;charset=utf-8,";
            csvContent += "Ngày,Loại,Phương thức,Số tiền,Trạng thái,Mã giao dịch\n";
            
            // Add payment data
            <c:forEach var="payment" items="${payments}">
                csvContent += '"<fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm"/>",';
                csvContent += '"<c:choose><c:when test="${payment.referenceType == 'Bill'}">Thanh toán hóa đơn</c:when><c:otherwise>${payment.referenceType}</c:otherwise></c:choose>",';
                csvContent += '"${payment.paymentMethod}",';
                csvContent += '"<fmt:formatNumber value="${payment.amount}" pattern="#,##0"/>",';
                csvContent += '"${payment.status}",';
                csvContent += '"${payment.transCode}"\n';
            </c:forEach>
            
            // Create and download file
            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "payment_history.csv");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
        
        // Auto-set date range to current month if not specified
        window.onload = function() {
            const fromDate = document.getElementById('fromDate');
            const toDate = document.getElementById('toDate');
            
            if (!fromDate.value && !toDate.value) {
                const now = new Date();
                const firstDay = new Date(now.getFullYear(), now.getMonth(), 1);
                const lastDay = new Date(now.getFullYear(), now.getMonth() + 1, 0);
                
                fromDate.value = firstDay.toISOString().split('T')[0];
                toDate.value = lastDay.toISOString().split('T')[0];
            }
        };
    </script>
</body>
</html>
