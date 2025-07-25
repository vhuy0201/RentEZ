<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý hợp đồng - RentEz</title>
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

            .dashboard-header {
                border-radius: 1.5rem;
                border: none;
                box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
                background: linear-gradient(135deg, #fff 0%, #fff8f0 100%);
                padding: 2rem 2.5rem;
                margin-bottom: 2rem;
                border-left: 6px solid #e65100;
            }

            .dashboard-section-title {
                font-size: 1.875rem;
                font-weight: 700;
                color: #1a1a1a;
                margin-bottom: 0.5rem;
            }

            .dashboard-section-subtitle {
                font-size: 0.95rem;
                color: #e65100;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .contracts-card {
                border-radius: 1.5rem;
                border: none;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
                background: #fff;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .contracts-card:hover {
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            }

            .contracts-header {
                background: linear-gradient(135deg, #fff8f0 0%, #fff 100%);
                padding: 1.5rem 2rem;
                border-bottom: 2px solid #ffe0b2;
            }

            .contracts-body {
                padding: 2rem;
            }

            .filter-section {
                background: #f8f9fa;
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            .btn-main {
                background: linear-gradient(135deg, #e65100 0%, #ff6d00 50%, #ff9800 100%);
                color: #fff;
                border: none;
                border-radius: 0.75rem;
                font-weight: 600;
                padding: 0.875rem 1.75rem;
                transition: all 0.3s ease;
                box-shadow: 0 4px 20px rgba(230, 81, 0, 0.3);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.875rem;
            }

            .btn-main:hover {
                background: linear-gradient(135deg, #bf360c 0%, #e65100 50%, #ff6d00 100%);
                transform: translateY(-3px);
                box-shadow: 0 8px 30px rgba(230, 81, 0, 0.4);
                color: #fff;
            }

            .btn-approve {
                background: linear-gradient(135deg, #4caf50 0%, #66bb6a 100%);
                color: #fff;
                border: none;
                border-radius: 0.5rem;
                padding: 0.5rem 1rem;
                font-weight: 600;
                font-size: 0.875rem;
                transition: all 0.3s ease;
            }

            .btn-approve:hover {
                background: linear-gradient(135deg, #388e3c 0%, #4caf50 100%);
                transform: translateY(-2px);
                color: #fff;
            }

            .btn-reject {
                background: linear-gradient(135deg, #f44336 0%, #e57373 100%);
                color: #fff;
                border: none;
                border-radius: 0.5rem;
                padding: 0.5rem 1rem;
                font-weight: 600;
                font-size: 0.875rem;
                transition: all 0.3s ease;
            }

            .btn-reject:hover {
                background: linear-gradient(135deg, #d32f2f 0%, #f44336 100%);
                transform: translateY(-2px);
                color: #fff;
            }

            .btn-view {
                background: linear-gradient(135deg, #2196f3 0%, #64b5f6 100%);
                color: #fff;
                border: none;
                border-radius: 0.5rem;
                padding: 0.5rem 1rem;
                font-weight: 600;
                font-size: 0.875rem;
                transition: all 0.3s ease;
            }

            .btn-view:hover {
                background: linear-gradient(135deg, #1976d2 0%, #2196f3 100%);
                transform: translateY(-2px);
                color: #fff;
            }

            .status-badge {
                font-size: 0.75rem;
                font-weight: 600;
                padding: 0.5rem 1rem;
                border-radius: 50px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-pending {
                background: linear-gradient(135deg, #ffc107 0%, #ffeb3b 100%);
                color: #8f6000;
            }

            .status-confirmed {
                background: linear-gradient(135deg, #4caf50 0%, #8bc34a 100%);
                color: #1b5e20;
            }

            .status-rejected {
                background: linear-gradient(135deg, #f44336 0%, #e57373 100%);
                color: #b71c1c;
            }

            .status-completed {
                background: linear-gradient(135deg, #2196f3 0%, #64b5f6 100%);
                color: #0d47a1;
            }

            .contract-item {
                background: #fff;
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 1rem;
                border: 1px solid #f0f0f0;
                transition: all 0.3s ease;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .contract-item:hover {
                border-color: #ffe0b2;
                box-shadow: 0 4px 20px rgba(255, 224, 178, 0.3);
                transform: translateY(-2px);
            }

            .contract-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }

            .contract-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #1a1a1a;
                margin-bottom: 0.25rem;
            }

            .contract-subtitle {
                color: #666;
                font-size: 0.9rem;
            }

            .contract-details {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .detail-item {
                display: flex;
                flex-direction: column;
            }

            .detail-label {
                font-size: 0.875rem;
                color: #666;
                margin-bottom: 0.25rem;
            }

            .detail-value {
                font-weight: 600;
                color: #1a1a1a;
            }

            .contract-actions {
                display: flex;
                gap: 0.75rem;
                justify-content: flex-end;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
                color: #666;
            }

            .empty-state i {
                font-size: 4rem;
                color: #ddd;
                margin-bottom: 1rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: #fff;
                border-radius: 1rem;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #666;
                font-size: 0.9rem;
            }

            .stat-pending .stat-number { color: #ffc107; }
            .stat-confirmed .stat-number { color: #4caf50; }
            .stat-rejected .stat-number { color: #f44336; }
            .stat-completed .stat-number { color: #2196f3; }

            @media (max-width: 768px) {
                .contracts-body {
                    padding: 1rem;
                }
                
                .contract-actions {
                    flex-direction: column;
                }
                
                .contract-details {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Navigation -->
                <jsp:include page="../common/navigation.jsp" />

                <!-- Main content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <!-- Header -->
                    <div class="dashboard-header d-flex flex-wrap justify-content-between align-items-center mb-4">
                        <div>
                            <div class="dashboard-section-subtitle mb-2">Quản lý hợp đồng thuê nhà</div>
                            <div class="dashboard-section-title">Danh sách hợp đồng</div>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted">Xin chào, <strong class="text-dark">Dũng Trần</strong></span>
                        </div>
                    </div>

                    <!-- Statistics -->
                    <div class="stats-grid">
                        <div class="stat-card stat-pending">
                            <div class="stat-number">${stats.Pending != null ? stats.Pending : 0}</div>
                            <div class="stat-label">Chờ duyệt</div>
                        </div>
                        <div class="stat-card stat-confirmed">
                            <div class="stat-number">${stats.Confirmed != null ? stats.Confirmed : 0}</div>
                            <div class="stat-label">Đã duyệt</div>
                        </div>
                        <div class="stat-card stat-rejected">
                            <div class="stat-number">${stats.Rejected != null ? stats.Rejected : 0}</div>
                            <div class="stat-label">Đã từ chối</div>
                        </div>
                        <div class="stat-card stat-completed">
                            <div class="stat-number">${stats.Completed != null ? stats.Completed : 0}</div>
                            <div class="stat-label">Hoàn thành</div>
                        </div>
                    </div>

                    <!-- Contracts Management Card -->
                    <div class="contracts-card mb-4">
                        <div class="contracts-header">
                            <h4 class="mb-0 d-flex align-items-center">
                                <i class="fas fa-file-contract me-3" style="color: #e65100;"></i>
                                Quản lý hợp đồng thuê nhà
                            </h4>
                        </div>
                        <div class="contracts-body">
                            <!-- Filter Section -->
                            <div class="filter-section">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <label for="statusFilter" class="form-label">Trạng thái</label>
                                        <select id="statusFilter" class="form-select" onchange="filterContracts()">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="Pending">Chờ duyệt</option>
                                            <option value="Confirmed">Đã duyệt</option>
                                            <option value="Rejected">Đã từ chối</option>
                                            <option value="Completed">Hoàn thành</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="dateFilter" class="form-label">Ngày tạo</label>
                                        <input type="date" id="dateFilter" class="form-control" onchange="filterContracts()">
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="searchFilter" class="form-label">Tìm kiếm</label>
                                        <input type="text" id="searchFilter" class="form-control" placeholder="Tìm theo tên khách hàng..." onkeyup="filterContracts()">
                                    </div>
                                    <div class="col-md-2 mb-3 d-flex align-items-end">
                                        <button type="button" class="btn btn-main w-100" onclick="resetFilters()">
                                            <i class="fas fa-sync-alt me-2"></i>Reset
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Contracts List -->
                            <div id="contractsList">
                                <c:choose>
                                    <c:when test="${not empty contracts}">
                                        <c:forEach var="contract" items="${contracts}">
                                            <div class="contract-item" data-status="${contract.booking.status}" 
                                                 data-date="<fmt:formatDate value='${contract.booking.createdAt}' pattern='yyyy-MM-dd' />" 
                                                 data-search="${contract.renter.name}">
                                                <div class="contract-info">
                                                    <div>
                                                        <div class="contract-title">Hợp đồng #${contract.booking.bookingId}</div>
                                                        <div class="contract-subtitle">Khách hàng: ${contract.renter.name} </div>
                                                    </div>
                                                    <span class="status-badge status-${fn:toLowerCase(contract.status)}">
                                                        <c:choose>
                                                            <c:when test="${contract.booking.status == 'Pending'}">Chờ duyệt</c:when>
                                                            <c:when test="${contract.booking.status == 'Confirmed'}">Đã duyệt</c:when>
                                                            <c:when test="${contract.booking.status == 'Rejected'}">Đã từ chối</c:when>
                                                            <c:when test="${contract.booking.status == 'Completed'}">Hoàn thành</c:when>
                                                            <c:otherwise>${contract.booking.status}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="contract-details">
                                                    <div class="detail-item">
                                                        <span class="detail-label">Bất động sản</span>
                                                        <span class="detail-value">Property ID: ${contract.booking.propertyId}</span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-label">Tiền thuê/tháng</span>
                                                        <span class="detail-value"><fmt:formatNumber value="${contract.booking.monthlyRent}" type="currency" currencySymbol="" /> VNĐ</span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-label">Tiền đặt cọc</span>
                                                        <span class="detail-value"><fmt:formatNumber value="${contract.booking.depositAmount}" type="currency" currencySymbol="" /> VNĐ</span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-label">Tổng giá trị</span>
                                                        <span class="detail-value"><fmt:formatNumber value="${contract.booking.totalPrice}" type="currency" currencySymbol="" /> VNĐ</span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-label">Ngày tạo</span>
                                                        <span class="detail-value"><fmt:formatDate value="${contract.booking.createdAt}" pattern="dd/MM/yyyy" /></span>
                                                    </div>
                                                    <div class="detail-item">
                                                        <span class="detail-label">Trạng thái ký</span>
                                                        <span class="detail-value">
                                                            <c:choose>
                                                                <c:when test="${contract.booking.signedByRenter and contract.booking.signedByLandlord}">
                                                                    <span class="text-success">Hoàn tất</span>
                                                                </c:when>
                                                                <c:when test="${contract.booking.signedByRenter}">
                                                                    <span class="text-success">Khách đã ký</span>
                                                                </c:when>
                                                                <c:when test="${contract.booking.signedByLandlord}">
                                                                    <span class="text-success">Chủ nhà đã ký</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-warning">Chưa ký</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="contract-actions">
                                                    <button type="button" class="btn btn-view" onclick="viewContract('${contract.booking.bookingId}')">
                                                        <i class="fas fa-eye me-1"></i>Xem chi tiết
                                                    </button>
                                                    <c:if test="${contract.booking.status == 'Pending'}">
                                                        <button type="button" class="btn btn-approve" onclick="approveContract('${contract.booking.bookingId}')">
                                                            <i class="fas fa-check me-1"></i>Duyệt
                                                        </button>
                                                        <button type="button" class="btn btn-reject" onclick="rejectContract('${contract.booking.bookingId}')">
                                                            <i class="fas fa-times me-1"></i>Từ chối
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-state">
                                            <i class="fas fa-file-contract"></i>
                                            <h5>Chưa có hợp đồng nào</h5>
                                            <p>Hiện tại chưa có hợp đồng thuê nhà nào cho bất động sản của bạn</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Empty state (hidden by default) -->
                            <div id="emptyState" class="empty-state" style="display: none;">
                                <i class="fas fa-file-contract"></i>
                                <h5>Không tìm thấy hợp đồng nào</h5>
                                <p>Thử thay đổi bộ lọc hoặc tạo hợp đồng mới</p>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <jsp:include page="/view/common/footer.jsp" />
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        <script>
            // Filter contracts function
            function filterContracts() {
                const statusFilter = document.getElementById('statusFilter').value;
                const dateFilter = document.getElementById('dateFilter').value;
                const searchFilter = document.getElementById('searchFilter').value.toLowerCase();
                
                const contracts = document.querySelectorAll('.contract-item');
                let visibleCount = 0;
                
                contracts.forEach(contract => {
                    const contractStatus = contract.getAttribute('data-status');
                    const contractDate = contract.getAttribute('data-date');
                    const contractSearch = contract.getAttribute('data-search').toLowerCase();
                    
                    let showContract = true;
                    
                    // Filter by status
                    if (statusFilter && contractStatus !== statusFilter) {
                        showContract = false;
                    }
                    
                    // Filter by date
                    if (dateFilter && contractDate !== dateFilter) {
                        showContract = false;
                    }
                    
                    // Filter by search term
                    if (searchFilter && !contractSearch.includes(searchFilter)) {
                        showContract = false;
                    }
                    
                    if (showContract) {
                        contract.style.display = 'block';
                        visibleCount++;
                    } else {
                        contract.style.display = 'none';
                    }
                });
                
                // Show/hide empty state
                const emptyState = document.getElementById('emptyState');
                const contractsList = document.getElementById('contractsList');
                
                if (visibleCount === 0) {
                    contractsList.style.display = 'none';
                    emptyState.style.display = 'block';
                } else {
                    contractsList.style.display = 'block';
                    emptyState.style.display = 'none';
                }
            }
            
            // Reset filters function
            function resetFilters() {
                document.getElementById('statusFilter').value = '';
                document.getElementById('dateFilter').value = '';
                document.getElementById('searchFilter').value = '';
                filterContracts();
            }
            
            // View contract function
            function viewContract(contractId) {
                // Redirect to contract detail page
                window.location.href = `${pageContext.request.contextPath}/contract-detail?id=${contractId}`;
            }
            
            // Approve contract function
            function approveContract(contractId) {
                if (confirm('Bạn có chắc chắn muốn duyệt hợp đồng này?')) {
                    // Make AJAX call to approve contract
                    fetch(`${pageContext.request.contextPath}/approveContract`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            contractId: parseInt(contractId),
                            action: 'approve'
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Hợp đồng đã được duyệt thành công!');
                            location.reload(); // Reload to update the UI
                        } else {
                            alert('Có lỗi xảy ra: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi duyệt hợp đồng!');
                    });
                }
            }
            
            // Reject contract function
            function rejectContract(contractId) {
                const reason = prompt('Vui lòng nhập lý do từ chối hợp đồng:');
                if (reason && reason.trim() !== '') {
                    // Make AJAX call to reject contract
                    fetch(`${pageContext.request.contextPath}/rejectContract`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            contractId: parseInt(contractId),
                            action: 'reject',
                            reason: reason
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Hợp đồng đã được từ chối!');
                            location.reload(); // Reload to update the UI
                        } else {
                            alert('Có lỗi xảy ra: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi từ chối hợp đồng!');
                    });
                }
            }
            
            // Confirm logout function
            function confirmLogout() {
                if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                    window.location.href = '${pageContext.request.contextPath}/logout';
                }
            }
        </script>
    </body>
</html>
