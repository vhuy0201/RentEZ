<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo hóa đơn mới - RentEz</title>
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
                        <h1 class="h2 fw-bold text-dark mb-1">Tạo hóa đơn mới</h1>
                        <p class="text-muted mb-0">Tạo hóa đơn hàng tháng cho khách thuê</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/billManagement" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <!-- Form -->
                <div class="form-container p-4">
                    <form method="post" action="${pageContext.request.contextPath}/billManagement" id="billForm">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <!-- Basic Information -->
                            <div class="col-lg-8">
                                <h5 class="fw-bold mb-3">Thông tin cơ bản</h5>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="bookingSelect" class="form-label fw-semibold">Chọn hợp đồng thuê</label>
                                        <select class="form-select" id="bookingSelect" name="bookingId" required onchange="updateBookingInfo()">
                                            <option value="">-- Chọn hợp đồng --</option>
                                            <c:forEach var="booking" items="${activeBookings}">
                                                <option value="${booking.bookingId}" 
                                                        data-property-id="${booking.propertyId}"
                                                        data-renter-id="${booking.renterId}"
                                                        data-monthly-rent="${booking.monthlyRent}">
                                                    BĐS ID: ${booking.propertyId} - Khách: ${booking.renterId} - ${booking.monthlyRent} VNĐ/tháng
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="billingPeriod" class="form-label fw-semibold">Kỳ hóa đơn</label>
                                        <input type="month" class="form-control" id="billingPeriod" name="billingPeriod" required>
                                    </div>
                                </div>

                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label for="dueDate" class="form-label fw-semibold">Hạn thanh toán</label>
                                        <input type="date" class="form-control" id="dueDate" name="dueDate" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold">Tiền thuê hàng tháng</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="monthlyRentDisplay" readonly>
                                            <span class="input-group-text">VNĐ</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bill Details -->
                                <h5 class="fw-bold mb-3">Chi tiết hóa đơn</h5>
                                <div id="billDetails">
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
                                </div>

                                <div class="mb-4">
                                    <button type="button" class="btn btn-outline-primary" onclick="addDetailRow()">
                                        <i class="fas fa-plus me-2"></i>Thêm khoản phí
                                    </button>
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
                                            <span id="rentAmountSummary">0đ</span>
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
                                        <i class="fas fa-save me-2"></i>Tạo hóa đơn
                                    </button>
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
        let detailIndex = 1;
        let monthlyRent = 0;

        function updateBookingInfo() {
            const select = document.getElementById('bookingSelect');
            const selectedOption = select.options[select.selectedIndex];
            
            if (selectedOption.value) {
                monthlyRent = parseFloat(selectedOption.dataset.monthlyRent) || 0;
                document.getElementById('monthlyRentDisplay').value = formatNumber(monthlyRent);
                updateSummary();
            } else {
                monthlyRent = 0;
                document.getElementById('monthlyRentDisplay').value = '';
                updateSummary();
            }
        }

        function addDetailRow() {
            const container = document.getElementById('billDetails');
            const newRow = document.createElement('div');
            newRow.className = 'bill-detail-row';
            newRow.setAttribute('data-index', detailIndex);
            
            newRow.innerHTML = `
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
            `;
            
            container.appendChild(newRow);
            detailIndex++;
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
                    feesTotal += parseFloat(display.value.replace(/\./g, '')) || 0;
                }
            });
            
            const total = monthlyRent + feesTotal;
            
            document.getElementById('rentAmountSummary').textContent = formatNumber(monthlyRent) + 'đ';
            document.getElementById('feesAmountSummary').textContent = formatNumber(feesTotal) + 'đ';
            document.getElementById('totalAmountSummary').textContent = formatNumber(total) + 'đ';
        }

        function formatNumber(num) {
            return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        }

        // Set default due date to next month 5th
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const nextMonth = new Date(today.getFullYear(), today.getMonth() + 1, 5);
            document.getElementById('dueDate').value = nextMonth.toISOString().split('T')[0];
            
            // Set default billing period to current month
            const currentMonth = today.toISOString().slice(0, 7);
            document.getElementById('billingPeriod').value = currentMonth;
        });
    </script>
</body>
</html>
