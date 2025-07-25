<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tài chính - RentEz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
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
                        'orange-lighter': '#ffb74d',
                        'orange-lightest': '#ffe0b2'
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

        .sidebar {
            background: linear-gradient(135deg, #e65100 0%, #ff6d00 50%, #ff9800 100%);
            color: #fff;
            min-height: 100vh;
            border-radius: 0 2rem 2rem 0;
            box-shadow: 0 8px 32px rgba(230, 81, 0, 0.2);
            position: relative;
            overflow: hidden;
        }

        .sidebar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="20" cy="60" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="30" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>') repeat;
            opacity: 0.3;
            pointer-events: none;
        }

        .user-info {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
            z-index: 1;
        }

        .account-avatar {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: bold;
            color: #fff;
            backdrop-filter: blur(10px);
        }

        .user-points {
            background: rgba(255, 255, 255, 0.15);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            padding: 0.75rem 1.5rem;
            margin: 0.25rem 0;
            border-radius: 12px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link:hover,
        .nav-link.active {
            background: rgba(255, 255, 255, 0.15) !important;
            color: #fff !important;
            transform: translateX(8px);
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .nav-link:hover::before {
            opacity: 1;
        }

        .nav-link i {
            width: 20px;
            margin-right: 12px;
            font-size: 1.1rem;
        }

        .logout-section {
            margin-top: auto;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .dashboard-header {
            background: #fff;
            padding: 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
        }

        .dashboard-section-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
            background: linear-gradient(135deg, #e65100, #ff6d00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .dashboard-section-subtitle {
            color: #718096;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }

        .btn-main {
            background: linear-gradient(135deg, #e65100, #ff6d00);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            box-shadow: 0 4px 15px rgba(230, 81, 0, 0.3);
        }

        .btn-main:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(230, 81, 0, 0.4);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
            color: white;
        }

        .dashboard-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        .balance-card {
            background: linear-gradient(135deg, #e65100, #ff6d00);
            color: white;
            padding: 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 30px rgba(230, 81, 0, 0.3);
        }

        .balance-amount {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .balance-label {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .transaction-section {
            background: #fff;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
            margin-bottom: 2rem;
        }

        .transaction-form {
            display: flex;
            gap: 1rem;
            align-items: end;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        .form-control {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #ff6d00;
            box-shadow: 0 0 0 0.2rem rgba(255, 109, 0, 0.25);
        }

        .transaction-table {
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #f0f0f0;
        }

        .table th {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border: none;
            font-weight: 600;
            color: #495057;
            padding: 1rem;
            border-bottom: 2px solid #dee2e6;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f8f9fa;
        }

        .transaction-type {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .type-deposit {
            background: #d4edda;
            color: #155724;
        }

        .type-withdraw {
            background: #f8d7da;
            color: #721c24;
        }

        .amount-positive {
            color: #28a745;
            font-weight: 600;
        }

        .amount-negative {
            color: #dc3545;
            font-weight: 600;
        }

        .success-message {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            border: 1px solid #c3e6cb;
            display: flex;
            align-items: center;
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .success-message.show {
            opacity: 1;
            transform: translateY(0);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #718096;
        }

        .empty-icon {
            font-size: 4rem;
            color: #e2e8f0;
            margin-bottom: 1rem;
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
                        <div class="dashboard-section-subtitle mb-2">Quản lý tài khoản</div>
                        <div class="dashboard-section-title">Ví điện tử & Giao dịch</div>
                    </div>
                </div>
                
                <!-- Success message -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="success-message" id="successMessage">
                        <i class="fas fa-check-circle me-2"></i>
                        ${sessionScope.successMessage}
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                
                <!-- Error message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        ${error}
                    </div>
                </c:if>
                
                <!-- Balance Card -->
                <div class="balance-card">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <div class="balance-label">Số dư hiện tại</div>
                            <div class="balance-amount">
                                <fmt:formatNumber value="${wallet.balance}" type="number" groupingUsed="true"/> VNĐ
                            </div>
                            <div class="text-white-50">
                                Cập nhật lần cuối: <fmt:formatDate value="${wallet.lastUpdated}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <i class="fas fa-wallet" style="font-size: 4rem; opacity: 0.3;"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Transaction Forms -->
                <div class="row g-4 mb-4">
                    <!-- Deposit Form -->
                    <div class="col-md-6">
                        <div class="transaction-section">
                            <h5 class="mb-3">
                                <i class="fas fa-plus-circle text-success me-2"></i>
                                Nạp tiền
                            </h5>
                            <form method="post" action="financialManagement">
                                <input type="hidden" name="action" value="deposit">
                                <div class="mb-3">
                                    <label for="depositAmount" class="form-label">Số tiền nạp (VNĐ)</label>
                                    <input type="number" class="form-control" id="depositAmount" name="amount" 
                                           placeholder="Nhập số tiền" min="1000" step="1000" required>
                                    <div class="form-text">Số tiền tối thiểu: 1,000 VNĐ</div>
                                </div>
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="fas fa-plus me-2"></i>Nạp tiền
                                </button>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Withdraw Form -->
                    <div class="col-md-6">
                        <div class="transaction-section">
                            <h5 class="mb-3">
                                <i class="fas fa-minus-circle text-danger me-2"></i>
                                Rút tiền
                            </h5>
                            <form method="post" action="financialManagement">
                                <input type="hidden" name="action" value="withdraw">
                                <div class="mb-3">
                                    <label for="withdrawAmount" class="form-label">Số tiền rút (VNĐ)</label>
                                    <input type="number" class="form-control" id="withdrawAmount" name="amount" 
                                           placeholder="Nhập số tiền" min="1000" step="1000" 
                                           max="${wallet.balance}" required>
                                    <div class="form-text">Số dư khả dụng: <fmt:formatNumber value="${wallet.balance}" type="number" groupingUsed="true"/> VNĐ</div>
                                </div>
                                <button type="submit" class="btn btn-danger w-100">
                                    <i class="fas fa-minus me-2"></i>Rút tiền
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- Transaction History -->
                <div class="transaction-table">
                    <div class="p-3 border-bottom">
                        <h5 class="mb-0">
                            <i class="fas fa-history me-2"></i>
                            Lịch sử giao dịch
                        </h5>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty transactions}">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>Mã giao dịch</th>
                                            <th>Nội dung</th>
                                            <th>Loại</th>
                                            <th>Số tiền</th>
                                            <th>Thời gian</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="transaction" items="${transactions}">
                                            <tr>
                                                <td>
                                                    <div class="fw-bold text-primary">${transaction.transCode}</div>
                                                    <div class="small text-muted">ID: ${transaction.walletTransferID}</div>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">${transaction.content}</div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${transaction.amount > 0}">
                                                            <span class="transaction-type type-deposit">
                                                                <i class="fas fa-plus"></i>
                                                                Nạp tiền
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="transaction-type type-withdraw">
                                                                <i class="fas fa-minus"></i>
                                                                Rút tiền
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${transaction.amount > 0}">
                                                            <div class="amount-positive">
                                                                +<fmt:formatNumber value="${transaction.amount}" type="number" groupingUsed="true"/> VNĐ
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="amount-negative">
                                                                <fmt:formatNumber value="${transaction.amount}" type="number" groupingUsed="true"/> VNĐ
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">
                                                        ${transaction.timeCode}
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${transaction.isRefunded}">
                                                            <span class="transaction-type type-withdraw">
                                                                <i class="fas fa-undo"></i>
                                                                Đã hoàn trả
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="transaction-type type-deposit">
                                                                <i class="fas fa-check"></i>
                                                                Thành công
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-receipt"></i>
                                </div>
                                <h4>Chưa có giao dịch nào</h4>
                                <p class="text-muted">Bạn chưa thực hiện giao dịch nào. Hãy nạp tiền để bắt đầu sử dụng dịch vụ!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <jsp:include page="/view/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
    <script>
        // Function to show and hide success message
        document.addEventListener('DOMContentLoaded', function () {
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                successMessage.classList.add('show');
                setTimeout(function () {
                    successMessage.style.opacity = '0';
                    setTimeout(function () {
                        successMessage.remove();
                    }, 500);
                }, 5000);
            }
        });
        
        // Confirm logout function
        function confirmLogout() {
            if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                window.location.href = '${pageContext.request.contextPath}/logout';
            }
        }
        
        // Update withdraw max amount based on balance
        document.getElementById('withdrawAmount').addEventListener('input', function() {
            const walletBalance = parseFloat('${wallet.balance}') || 0;
            const amount = parseFloat(this.value) || 0;
            
            if (amount > walletBalance) {
                this.setCustomValidity('Số tiền rút không được vượt quá số dư hiện tại');
            } else if (amount < 1000 && amount > 0) {
                this.setCustomValidity('Số tiền rút tối thiểu là 1,000 VNĐ');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>
