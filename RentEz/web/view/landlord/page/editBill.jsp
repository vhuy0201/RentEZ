<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hóa đơn - RentEz</title>
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

        .form-container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
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

        .bill-detail-row {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 1px solid #e9ecef;
        }

        .info-box {
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            color: white;
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-paid {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-overdue {
            background-color: #fecaca;
            color: #991b1b;
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h1 class="h2 fw-bold text-dark mb-1">Chỉnh sửa hóa đơn</h1>
                        <p class="text-muted mb-0">Cập nhật thông tin hóa đơn hàng tháng</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/billManagement" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <!-- Bill Info Box -->
                <div class="info-box">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h5 class="mb-2">
                                <i class="fas fa-file-invoice me-2"></i>
                                Hóa đơn #${bill.billId}
                            </h5>
                            <p class="mb-1">
                                <i class="fas fa-home me-2"></i>
                                <strong>Bất động sản:</strong> ${bill.property.title}
                            </p>
                            <p class="mb-0">
                                <i class="fas fa-user me-2"></i>
                                <strong>Khách thuê:</strong> ${bill.renterName}
                            </p>
                        </div>
                        <div class="col-md-4 text-end">
                            <div class="status-badge 
                                <c:choose>
                                    <c:when test="${bill.status == 'Paid'}">status-paid</c:when>
                                    <c:when test="${bill.status == 'Pending'}">status-pending</c:when>
                                    <c:otherwise>status-overdue</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${bill.status == 'Paid'}">✅ Đã thanh toán</c:when>
                                    <c:when test="${bill.status == 'Pending'}">⏳ Chờ thanh toán</c:when>
                                    <c:otherwise>🚨 Quá hạn</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form -->
                <div class="form-container p-4">
                    <form method="post" action="${pageContext.request.contextPath}/billManagement" id="billForm">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="billId" value="${bill.billId}">
                        
                        <div class="row">
                            <!-- Basic Information -->
                            <div class="col-lg-8">
                                <h5 class="fw-bold mb-3">Thông tin cơ bản</h5>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="billingPeriod" class="form-label fw-semibold">Kỳ hóa đơn</label>
                                        <input type="month" class="form-control" id="billingPeriod" name="billingPeriod" 
                                               value="${bill.billingPeriod}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="dueDate" class="form-label fw-semibold">Hạn thanh toán</label>
                                        <input type="date" class="form-control" id="dueDate" name="dueDate" 
                                               value="<fmt:formatDate value='${bill.dueDate}' pattern='yyyy-MM-dd'/>" required>
                                    </div>
                                </div>

                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label for="status" class="form-label fw-semibold">Trạng thái</label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="Pending" ${bill.status == 'Pending' ? 'selected' : ''}>Chờ thanh toán</option>
                                            <option value="Paid" ${bill.status == 'Paid' ? 'selected' : ''}>Đã thanh toán</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Tiền thuê hàng tháng</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="monthlyRentDisplay"
                                                   value="<fmt:formatNumber value='${booking.monthlyRent}' type='number' groupingUsed='true'/>" readonly>
                                            <span class="input-group-text">VNĐ</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-4">
                                    <div class="col-md-12">
                                        <label class="form-label fw-semibold">Tổng tiền hiện tại</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" 
                                                   value="<fmt:formatNumber value='${bill.totalAmount}' type='number' groupingUsed='true'/>" readonly>
                                            <span class="input-group-text">VNĐ</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bill Details -->
                                <h5 class="fw-bold mb-3">Chi tiết hóa đơn</h5>
                                <div class="alert alert-info" role="alert">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <strong>Lưu ý:</strong> Tiền thuê hàng tháng (<fmt:formatNumber value='${booking.monthlyRent}' type='number' groupingUsed='true'/>đ) 
                                    sẽ được tự động tính vào tổng hóa đơn cùng với các khoản phí phụ bên dưới.
                                </div>
                                <div id="billDetails">
                                    <c:choose>
                                        <c:when test="${not empty bill.billDetails}">
                                            <c:forEach var="detail" items="${bill.billDetails}" varStatus="status">
                                                <div class="bill-detail-row" data-index="${status.index}">
                                                    <div class="row align-items-center">
                                                        <div class="col-md-4">
                                                            <label class="form-label fw-semibold">Danh mục phí</label>
                                                            <select class="form-select" name="categoryId" onchange="updateAmount(this)">
                                                                <option value="">-- Chọn danh mục --</option>
                                                                <c:forEach var="category" items="${feeCategories}">
                                                                    <option value="${category.categoryId}" 
                                                                            data-unit-price="${category.unitPrice}"
                                                                            data-unit="${category.unit}"
                                                                            ${category.categoryId == detail.categoryId ? 'selected' : ''}>
                                                                        ${category.name} (${category.unitPrice} VNĐ/${category.unit})
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <label class="form-label fw-semibold">Số lượng/Chỉ số</label>
                                                            <input type="number" step="0.01" class="form-control" name="usageValue" 
                                                                   value="${detail.usageValue}" placeholder="0" onchange="updateAmount(this)">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <label class="form-label fw-semibold">Thành tiền</label>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control amount-display" 
                                                                       value="<fmt:formatNumber value='${detail.amount}' type='number' groupingUsed='true'/>" readonly>
                                                                <span class="input-group-text">VNĐ</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <label class="form-label">&nbsp;</label>
                                                            <button type="button" class="btn btn-outline-danger d-block" onclick="removeDetailRow(this)">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="bill-detail-row" data-index="0">
                                                <div class="row align-items-center">
                                                    <div class="col-md-4">
                                                        <label class="form-label fw-semibold">Danh mục phí</label>
                                                        <select class="form-select" name="categoryId" onchange="updateAmount(this)">
                                                            <option value="">-- Chọn danh mục --</option>
                                                            <c:forEach var="category" items="${feeCategories}">
                                                                <option value="${category.categoryId}" 
                                                                        data-unit-price="${category.unitPrice}"
                                                                        data-unit="${category.unit}">
                                                                    ${category.name} (${category.unitPrice} VNĐ/${category.unit})
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="form-label fw-semibold">Số lượng/Chỉ số</label>
                                                        <input type="number" step="0.01" class="form-control" name="usageValue" 
                                                               placeholder="0" onchange="updateAmount(this)">
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="form-label fw-semibold">Thành tiền</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control amount-display" readonly>
                                                            <span class="input-group-text">VNĐ</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label class="form-label">&nbsp;</label>
                                                        <button type="button" class="btn btn-outline-danger d-block" onclick="removeDetailRow(this)">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-4">
                                    <button type="button" class="btn btn-outline-primary" onclick="addDetailRow()">
                                        <i class="fas fa-plus me-2"></i>Thêm khoản phí
                                    </button>
                                </div>
                                
                                <!-- Hidden template for new rows -->
                                <div id="rowTemplate" style="display: none;">
                                    <div class="bill-detail-row">
                                        <div class="row align-items-center">
                                            <div class="col-md-4">
                                                <label class="form-label fw-semibold">Danh mục phí</label>
                                                <select class="form-select" name="categoryId" onchange="updateAmount(this)">
                                                    <option value="">-- Chọn danh mục --</option>
                                                    <c:forEach var="category" items="${feeCategories}">
                                                        <option value="${category.categoryId}" 
                                                                data-unit-price="${category.unitPrice}"
                                                                data-unit="${category.unit}">
                                                            ${category.name} (${category.unitPrice} VNĐ/${category.unit})
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label fw-semibold">Số lượng/Chỉ số</label>
                                                <input type="number" step="0.01" class="form-control" name="usageValue" 
                                                       placeholder="0" onchange="updateAmount(this)">
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label fw-semibold">Thành tiền</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control amount-display" readonly>
                                                    <span class="input-group-text">VNĐ</span>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <label class="form-label">&nbsp;</label>
                                                <button type="button" class="btn btn-outline-danger d-block" onclick="removeDetailRow(this)">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Summary -->
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h6 class="fw-bold mb-0">Tóm tắt hóa đơn</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tiền thuê:</span>
                                            <span id="rentAmountSummary"><fmt:formatNumber value='${booking.monthlyRent}' type='number' groupingUsed='true'/>đ</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Các khoản phí:</span>
                                            <span id="feesAmountSummary">0đ</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between fw-bold">
                                            <span>Tổng cộng:</span>
                                            <span id="totalAmountSummary" class="text-primary">0đ</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <button type="submit" class="btn btn-main w-100">
                                        <i class="fas fa-save me-2"></i>Cập nhật hóa đơn
                                    </button>
                                </div>
                                
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/billManagement?action=view&id=${bill.billId}" 
                                       class="btn btn-outline-primary w-100">
                                        <i class="fas fa-eye me-2"></i>Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/bootstrap.bundle.min.js"></script>
    <script>
        let detailIndex = <c:choose><c:when test="${not empty bill.billDetails}">${bill.billDetails.size()}</c:when><c:otherwise>1</c:otherwise></c:choose>;
        let monthlyRent = <c:choose><c:when test="${not empty booking.monthlyRent}">${booking.monthlyRent}</c:when><c:otherwise>0</c:otherwise></c:choose>;

        function addDetailRow() {
            const container = document.getElementById('billDetails');
            const template = document.getElementById('rowTemplate');
            const newRow = template.cloneNode(true);
            
            newRow.style.display = 'block';
            newRow.id = '';
            newRow.setAttribute('data-index', detailIndex);
            
            container.appendChild(newRow);
            detailIndex++;
            updateSummary();
        }

        function removeDetailRow(button) {
            const row = button.closest('.bill-detail-row');
            row.remove();
            updateSummary();
        }

        function updateAmount(element) {
            const row = element.closest('.bill-detail-row');
            const categorySelect = row.querySelector('select[name="categoryId"]');
            const usageInput = row.querySelector('input[name="usageValue"]');
            const amountDisplay = row.querySelector('.amount-display');
            
            if (categorySelect.value && usageInput.value) {
                const unitPrice = parseFloat(categorySelect.selectedOptions[0].dataset.unitPrice) || 0;
                const usage = parseFloat(usageInput.value) || 0;
                const amount = unitPrice * usage;
                
                amountDisplay.value = formatNumber(amount);
            } else {
                amountDisplay.value = '';
            }
            
            updateSummary();
        }

        function updateSummary() {
            // Calculate fees total
            let feesTotal = 0;
            const amountDisplays = document.querySelectorAll('.amount-display');
            amountDisplays.forEach(display => {
                if (display.value) {
                    // Remove dots and parse the number
                    const value = display.value.replace(/\./g, '').replace(/,/g, '');
                    feesTotal += parseFloat(value) || 0;
                }
            });
            
            const total = monthlyRent + feesTotal;
            
            document.getElementById('rentAmountSummary').textContent = formatNumber(monthlyRent) + 'đ';
            document.getElementById('feesAmountSummary').textContent = formatNumber(feesTotal) + 'đ';
            document.getElementById('totalAmountSummary').textContent = formatNumber(total) + 'đ';
        }

        function formatNumber(num) {
            return Math.round(num).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        }

        // Initialize summary on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateSummary();
        });

        // Form validation
        document.getElementById('billForm').addEventListener('submit', function(e) {
            const status = document.getElementById('status').value;
            if (status === 'Paid') {
                if (!confirm('Bạn có chắc chắn muốn đánh dấu hóa đơn này là đã thanh toán?')) {
                    e.preventDefault();
                }
            }
        });
    </script>
</body>
</html>
