<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin nhắn liên hệ - Admin RentEz</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            margin: 0.25rem 0;
        }
        
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255,255,255,0.1);
        }
        
        .main-content {
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        
        .card-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            border: none;
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .stats-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            margin-bottom: 1rem;
        }
        
        .btn-action {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            border-radius: 0.375rem;
        }
        
        .message-preview {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .subject-badge {
            font-size: 0.75rem;
            padding: 0.375rem 0.75rem;
            border-radius: 1rem;
        }
        
        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            margin: 2rem 0;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                min-height: auto;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar p-3">
                <div class="text-center mb-4">
                    <h4 class="text-white">RentEz Admin</h4>
                </div>
                
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users me-2"></i>Người dùng
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/properties">
                        <i class="fas fa-home me-2"></i>Bất động sản
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/contact-messages">
                        <i class="fas fa-envelope me-2"></i>Tin nhắn liên hệ
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                        <i class="fas fa-chart-bar me-2"></i>Báo cáo
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/settings">
                        <i class="fas fa-cog me-2"></i>Cài đặt
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/logout">
                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                    </a>
                </nav>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Quản lý tin nhắn liên hệ</h1>
                    <div>
                        <button class="btn btn-success me-2" onclick="exportMessages()">
                            <i class="fas fa-download me-2"></i>Xuất CSV
                        </button>
                        <button class="btn btn-danger" onclick="bulkDelete()" id="bulkDeleteBtn" style="display: none;">
                            <i class="fas fa-trash me-2"></i>Xóa đã chọn
                        </button>
                    </div>
                </div>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="stats-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <h3 class="mb-1">${totalMessages}</h3>
                            <p class="text-muted mb-0">Tổng tin nhắn</p>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="stats-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
                                <i class="fas fa-calendar-day"></i>
                            </div>
                            <h3 class="mb-1" id="todayMessages">0</h3>
                            <p class="text-muted mb-0">Tin nhắn hôm nay</p>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="stats-icon" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <h3 class="mb-1" id="complaintMessages">0</h3>
                            <p class="text-muted mb-0">Khiếu nại</p>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-3">
                        <div class="stats-card">
                            <div class="stats-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                <i class="fas fa-handshake"></i>
                            </div>
                            <h3 class="mb-1" id="businessMessages">0</h3>
                            <p class="text-muted mb-0">Hợp tác kinh doanh</p>
                        </div>
                    </div>
                </div>
                
                <!-- Charts Row -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Thống kê theo chủ đề</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="subjectChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Xu hướng tin nhắn</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="trendChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Filters -->
                <div class="filter-section">
                    <h5 class="mb-3">Bộ lọc</h5>
                    <form method="GET" id="filterForm">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label for="subject" class="form-label">Chủ đề</label>
                                <select class="form-select" id="subject" name="subject">
                                    <option value="all" ${subjectFilter == 'all' || empty subjectFilter ? 'selected' : ''}>Tất cả</option>
                                    <option value="general" ${subjectFilter == 'general' ? 'selected' : ''}>Thông tin chung</option>
                                    <option value="support" ${subjectFilter == 'support' ? 'selected' : ''}>Hỗ trợ kỹ thuật</option>
                                    <option value="business" ${subjectFilter == 'business' ? 'selected' : ''}>Hợp tác kinh doanh</option>
                                    <option value="complaint" ${subjectFilter == 'complaint' ? 'selected' : ''}>Khiếu nại</option>
                                    <option value="suggestion" ${subjectFilter == 'suggestion' ? 'selected' : ''}>Góp ý</option>
                                    <option value="other" ${subjectFilter == 'other' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="startDate" class="form-label">Từ ngày</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate}">
                            </div>
                            
                            <div class="col-md-3">
                                <label for="endDate" class="form-label">Đến ngày</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate}">
                            </div>
                            
                            <div class="col-md-3">
                                <label for="pageSize" class="form-label">Số bản ghi/trang</label>
                                <select class="form-select" id="pageSize" name="pageSize">
                                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                    <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                    <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                                    <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row mt-3">
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-filter me-2"></i>Lọc
                                </button>
                                <button type="button" class="btn btn-secondary" onclick="clearFilters()">
                                    <i class="fas fa-times me-2"></i>Xóa bộ lọc
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- Messages Table -->
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Danh sách tin nhắn</h5>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="selectAll">
                                <label class="form-check-label" for="selectAll">
                                    Chọn tất cả
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover" id="messagesTable">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>ID</th>
                                        <th>Người gửi</th>
                                        <th>Email</th>
                                        <th>Điện thoại</th>
                                        <th>Chủ đề</th>
                                        <th>Tin nhắn</th>
                                        <th>Ngày gửi</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="message" items="${messages}">
                                        <tr>
                                            <td>
                                                <input class="form-check-input message-checkbox" type="checkbox" 
                                                       value="${message.messageID}" onchange="toggleBulkDelete()">
                                            </td>
                                            <td>${message.messageID}</td>
                                            <td>${message.fullName}</td>
                                            <td>
                                                <a href="mailto:${message.email}" class="text-decoration-none">
                                                    ${message.email}
                                                </a>
                                            </td>
                                            <td>
                                                <c:if test="${not empty message.phone}">
                                                    <a href="tel:${message.phone}" class="text-decoration-none">
                                                        ${message.phone}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty message.phone}">
                                                    <span class="text-muted">Không có</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <span class="badge subject-badge 
                                                    ${message.subject == 'complaint' ? 'bg-danger' : 
                                                      message.subject == 'business' ? 'bg-success' :
                                                      message.subject == 'support' ? 'bg-warning' :
                                                      'bg-info'}">
                                                    ${message.subjectDisplayText}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="message-preview" title="${message.message}">
                                                    ${message.message}
                                                </div>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${message.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-sm btn-outline-primary btn-action" 
                                                            onclick="viewMessage(${message.messageID})" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-danger btn-action" 
                                                            onclick="deleteMessage(${message.messageID})" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&subject=${subjectFilter}&startDate=${startDate}&endDate=${endDate}&pageSize=${pageSize}">
                                                Trước
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach var="i" begin="${currentPage > 3 ? currentPage - 2 : 1}" 
                                               end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&subject=${subjectFilter}&startDate=${startDate}&endDate=${endDate}&pageSize=${pageSize}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&subject=${subjectFilter}&startDate=${startDate}&endDate=${endDate}&pageSize=${pageSize}">
                                                Sau
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Message Detail Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết tin nhắn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="messageModalBody">
                    <!-- Content will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        // Initialize DataTable
        $(document).ready(function() {
            // Calculate additional statistics
            calculateAdditionalStats();
            
            // Initialize charts
            initializeCharts();
        });
        
        // Calculate additional statistics
        function calculateAdditionalStats() {
            const today = new Date().toDateString();
            let todayCount = 0;
            let complaintCount = 0;
            let businessCount = 0;
            
            <c:forEach var="message" items="${messages}">
                const messageDate = new Date('${message.createdAt}').toDateString();
                if (messageDate === today) {
                    todayCount++;
                }
                
                <c:forEach var="stat" items="${stats}">
                    if ('${stat.subject}' === 'complaint') {
                        complaintCount = ${stat.messageCount};
                    }
                    if ('${stat.subject}' === 'business') {
                        businessCount = ${stat.messageCount};
                    }
                </c:forEach>
            </c:forEach>
            
            document.getElementById('todayMessages').textContent = todayCount;
            document.getElementById('complaintMessages').textContent = complaintCount;
            document.getElementById('businessMessages').textContent = businessCount;
        }
        
        // Initialize charts
        function initializeCharts() {
            // Subject distribution chart
            const subjectData = {
                labels: [],
                datasets: [{
                    data: [],
                    backgroundColor: [
                        '#4facfe', '#00f2fe', '#43e97b', '#38f9d7', 
                        '#fa709a', '#fee140', '#667eea', '#764ba2'
                    ]
                }]
            };
            
            <c:forEach var="stat" items="${stats}">
                subjectData.labels.push('${stat.subjectDisplayText}');
                subjectData.datasets[0].data.push(${stat.messageCount});
            </c:forEach>
            
            new Chart(document.getElementById('subjectChart'), {
                type: 'doughnut',
                data: subjectData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
            
            // Trend chart (placeholder - you would need to implement actual trend data)
            new Chart(document.getElementById('trendChart'), {
                type: 'line',
                data: {
                    labels: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
                    datasets: [{
                        label: 'Tin nhắn trong tuần',
                        data: [12, 19, 8, 15, 22, 13, 7],
                        borderColor: '#4facfe',
                        backgroundColor: 'rgba(79, 172, 254, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }
        
        // View message details
        function viewMessage(messageId) {
            fetch(`${pageContext.request.contextPath}/admin/contact-messages?action=view&id=` + messageId)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('messageModalBody').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('messageModal')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi tải chi tiết tin nhắn.');
                });
        }
        
        // Delete message
        function deleteMessage(messageId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin nhắn này?')) {
                fetch(`${pageContext.request.contextPath}/admin/contact-messages?action=delete&id=` + messageId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa tin nhắn.');
                });
            }
        }
        
        // Toggle bulk delete button
        function toggleBulkDelete() {
            const checkboxes = document.querySelectorAll('.message-checkbox:checked');
            const bulkDeleteBtn = document.getElementById('bulkDeleteBtn');
            
            if (checkboxes.length > 0) {
                bulkDeleteBtn.style.display = 'inline-block';
            } else {
                bulkDeleteBtn.style.display = 'none';
            }
        }
        
        // Select all functionality
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.message-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
            toggleBulkDelete();
        });
        
        // Bulk delete
        function bulkDelete() {
            const checkboxes = document.querySelectorAll('.message-checkbox:checked');
            if (checkboxes.length === 0) {
                alert('Vui lòng chọn ít nhất một tin nhắn để xóa.');
                return;
            }
            
            if (confirm(`Bạn có chắc chắn muốn xóa ${checkboxes.length} tin nhắn đã chọn?`)) {
                const messageIds = Array.from(checkboxes).map(cb => cb.value);
                
                const formData = new FormData();
                formData.append('action', 'bulk-delete');
                messageIds.forEach(id => formData.append('messageIds', id));
                
                fetch(`${pageContext.request.contextPath}/admin/contact-messages`, {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if (data.success) {
                        location.reload();
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa tin nhắn.');
                });
            }
        }
        
        // Export messages
        function exportMessages() {
            window.location.href = `${pageContext.request.contextPath}/admin/contact-messages?action=export`;
        }
        
        // Clear filters
        function clearFilters() {
            document.getElementById('subject').value = 'all';
            document.getElementById('startDate').value = '';
            document.getElementById('endDate').value = '';
            document.getElementById('pageSize').value = '20';
            document.getElementById('filterForm').submit();
        }
    </script>
</body>
</html>
