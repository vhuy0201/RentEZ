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
        <title>Quản lý hóa đơn - RentEz</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/landlord/common/navigation.css"/>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'orange-dark': '#e65100',
                            'orange-primary': '#ff6d00',
                            'orange-light': '#ff9800',
                        }
                    }
                }
            }
        </script>
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
            }

            .stats-card {
                background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
                border-radius: 16px;
                padding: 1.5rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                border: 1px solid #f0f0f0;
                transition: all 0.3s ease;
            }

            .stats-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            }

            .bill-card {
                background: #fff;
                border-radius: 12px;
                border: 1px solid #e9ecef;
                transition: all 0.3s ease;
            }

            .bill-card:hover {
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
                transform: translateY(-2px);
            }

            .status-badge {
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-size: 0.85rem;
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
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center">
                        <div>
                            <div class="text-muted mb-2">Quản lý hóa đơn hàng tháng</div>
                            <h1 class="h2 fw-bold text-dark mb-0">Hóa đơn thuê nhà</h1>
                        </div>
                        <div class="d-flex gap-3">
                            <a href="${pageContext.request.contextPath}/billManagement?action=create" 
                               class="btn btn-main">
                                <i class="fas fa-plus me-2"></i>Tạo hóa đơn mới
                            </a>
                        </div>
                    </div>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Statistics Cards -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary text-white rounded-circle p-3 me-3">
                                        <i class="fas fa-file-invoice"></i>
                                    </div>
                                    <div>
                                        <div class="h4 mb-0 fw-bold">${totalBills}</div>
                                        <div class="text-muted small">Tổng hóa đơn</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <div class="bg-success text-white rounded-circle p-3 me-3">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <div>
                                        <div class="h4 mb-0 fw-bold">${paidBills}</div>
                                        <div class="text-muted small">Đã thanh toán</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning text-white rounded-circle p-3 me-3">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="h4 mb-0 fw-bold">${pendingBills}</div>
                                        <div class="text-muted small">Chờ thanh toán</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <div class="bg-danger text-white rounded-circle p-3 me-3">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                    <div>
                                        <div class="h4 mb-0 fw-bold">${overdueBillsCount}</div>
                                        <div class="text-muted small">Quá hạn</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bills List -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3 class="h5 mb-0 fw-bold">Danh sách hóa đơn</h3>
                            <div class="d-flex gap-2">
                                <select class="form-select form-select-sm" id="statusFilter">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="Pending">Chờ thanh toán</option>
                                    <option value="Paid">Đã thanh toán</option>
                                    <option value="Overdue">Quá hạn</option>
                                </select>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${not empty bills}">
                                <div class="row g-4">
                                    <c:forEach var="bill" items="${bills}">
                                        <c:set var="displayStatus" value="${bill.status}" />
                                        <c:if test="${bill.status == 'Pending' && bill.dueDate.time < currentDate.time}">
                                            <c:set var="displayStatus" value="Overdue" />
                                        </c:if>
                                        <div class="col-md-6 col-lg-4" data-status="${displayStatus}">
                                            <div class="bill-card p-4">
                                                <div class="d-flex justify-content-between align-items-start mb-3">
                                                    <div>
                                                        <h6 class="fw-bold mb-1">HĐ-${bill.billId}</h6>
                                                        <div class="text-muted small">${bill.billingPeriod}</div>
                                                    </div>
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
                                                </div>

                                                <div class="mb-3">
                                                    <div class="fw-semibold text-truncate" title="${bill.property.title}">
                                                        ${bill.property.title}
                                                    </div>
                                                    <div class="text-muted small text-truncate" title="${bill.property.address}">
                                                        <i class="fas fa-map-marker-alt me-1"></i>
                                                        ${bill.property.address}
                                                    </div>
                                                    <div class="text-muted small text-truncate">
                                                        <i class="fas fa-user me-1"></i>
                                                        ${bill.renterName}
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="text-muted small">Số tiền:</span>
                                                        <span class="fw-bold text-primary">
                                                            <fmt:formatNumber value="${bill.totalAmount}" type="number" groupingUsed="true"/>đ
                                                        </span>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="text-muted small">Hạn thanh toán:</span>
                                                        <span class="fw-semibold">
                                                            <fmt:formatDate value="${bill.dueDate}" pattern="dd/MM/yyyy"/>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="d-flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/billManagement?action=view&id=${bill.billId}" 
                                                       class="btn btn-outline-primary btn-sm flex-fill">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/billManagement?action=edit&id=${bill.billId}" 
                                                       class="btn btn-outline-warning btn-sm flex-fill">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-file-invoice text-muted" style="font-size: 4rem;"></i>
                                    <h4 class="mt-3 text-muted">Chưa có hóa đơn nào</h4>
                                    <p class="text-muted">Bắt đầu tạo hóa đơn cho khách thuê của bạn</p>
                                    <a href="${pageContext.request.contextPath}/billManagement?action=create" class="btn btn-main">
                                        <i class="fas fa-plus me-2"></i>Tạo hóa đơn đầu tiên
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
        <script>
            // Status filter
            document.getElementById('statusFilter').addEventListener('change', function () {
                const filterValue = this.value.toLowerCase();
                const billCards = document.querySelectorAll('[data-status]');

                billCards.forEach(card => {
                    const cardStatus = card.getAttribute('data-status').toLowerCase();
                    if (!filterValue || cardStatus === filterValue) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });

            // Update bill status
            function updateStatus(billId, status) {
                if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái hóa đơn này?')) {
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
                    statusInput.value = status;

                    form.appendChild(actionInput);
                    form.appendChild(billIdInput);
                    form.appendChild(statusInput);

                    document.body.appendChild(form);
                    form.submit();
                }
            }

            // Delete bill
            function deleteBill(billId) {
                if (confirm('Bạn có chắc chắn muốn xóa hóa đơn này? Hành động này không thể hoàn tác.')) {
                    window.location.href = '${pageContext.request.contextPath}/billManagement?action=delete&id=' + billId;
                }
            }
        </script>
    </body>
</html>
