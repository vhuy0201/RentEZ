<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>JSP Page</title>
        <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#fff7ed',
                            100: '#ffedd5',
                            200: '#fed7aa',
                            300: '#fdba74',
                            400: '#fb923c',
                            500: '#f97316',
                            600: '#ea580c',
                            700: '#c2410c',
                            800: '#9a3412',
                            900: '#7c2d12',
                        }
                    }
                }
            }
        }
    </script>
    </head>
    <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
        <div class="flex">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />

            <!-- Main Content -->
            <div class="ml-64 flex-1">
                <!-- Top Header -->
                <header class="bg-white shadow-sm border-b border-gray-200">
                    <div class="px-6 py-4">
                        <div class="flex items-center justify-between">
                            <h2 class="text-2xl font-bold text-gray-800">Báo cáo người dùng</h2>
                            <div class="flex items-center space-x-4">
                                <div class="text-sm text-gray-600">
                                    <fmt:formatDate value="<%= new java.util.Date()%>" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                                <button class="p-2 rounded-lg bg-primary-50 text-primary-600 hover:bg-primary-100 transition-colors">
                                    <i class="fas fa-bell"></i>
                                </button>
                                <button class="p-2 rounded-lg bg-primary-50 text-primary-600 hover:bg-primary-100 transition-colors">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </header>

                <!-- Dashboard Content -->
                <main class="p-6">
                    <!-- Filter Section -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-6">
                        <div class="flex flex-col lg:flex-row gap-4 items-end">
                            <!-- Status Filter -->
                            <div class="flex-1">
                                <label for="statusFilter" class="block text-sm font-medium text-gray-700 mb-2">Trạng thái</label>
                                <select id="statusFilter" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="pending">Chờ xử lý</option>
                                    <option value="approved">Đã xử lý</option>
                                </select>
                            </div>
                            
                            <!-- Date Filter -->
                            <div class="flex-1">
                                <label for="dateFilter" class="block text-sm font-medium text-gray-700 mb-2">Ngày báo cáo</label>
                                <input type="date" id="dateFilter" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                            </div>
                            
                            <!-- Search Filter -->
                            <div class="flex-1">
                                <label for="searchFilter" class="block text-sm font-medium text-gray-700 mb-2">Tìm kiếm</label>
                                <input type="text" id="searchFilter" placeholder="Tìm theo tên người dùng hoặc nội dung..." class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-primary-500">
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="flex gap-2">
                                <button onclick="applyFilters()" class="px-4 py-2 bg-primary-600 text-white rounded-md hover:bg-primary-700 transition-colors flex items-center gap-2">
                                    <i class="fas fa-filter"></i>
                                    Lọc
                                </button>
                                <button onclick="clearFilters()" class="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-600 transition-colors flex items-center gap-2">
                                    <i class="fas fa-times"></i>
                                    Xóa
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reports Summary -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm text-gray-600">Tổng báo cáo</p>
                                    <p class="text-2xl font-bold text-gray-800" id="totalReports">${reports.size()}</p>
                                </div>
                                <div class="p-3 bg-blue-100 rounded-full">
                                    <i class="fas fa-file-alt text-blue-600 text-xl"></i>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm text-gray-600">Chờ xử lý</p>
                                    <p class="text-2xl font-bold text-yellow-600" id="pendingReports">
                                        <c:set var="pendingCount" value="0"/>
                                        <c:forEach var="report" items="${reports}">
                                            <c:if test="${!report.isApproved}">
                                                <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${pendingCount}
                                    </p>
                                </div>
                                <div class="p-3 bg-yellow-100 rounded-full">
                                    <i class="fas fa-clock text-yellow-600 text-xl"></i>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm text-gray-600">Đã xử lý</p>
                                    <p class="text-2xl font-bold text-green-600" id="approvedReports">
                                        <c:set var="approvedCount" value="0"/>
                                        <c:forEach var="report" items="${reports}">
                                            <c:if test="${report.isApproved}">
                                                <c:set var="approvedCount" value="${approvedCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        ${approvedCount}
                                    </p>
                                </div>
                                <div class="p-3 bg-green-100 rounded-full">
                                    <i class="fas fa-check-circle text-green-600 text-xl"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reports List -->
                    <div id="reportsContainer">
                        <c:if test="${empty reports}">
                            <div class="text-center text-gray-500 mt-12 bg-white rounded-lg p-8">
                                <i class="fas fa-file-alt text-4xl text-gray-300 mb-4"></i>
                                <p class="text-lg font-medium">Không có báo cáo nào.</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty reports}">
                            <div class="grid grid-cols-1 gap-4" id="reportsList">
                            <c:forEach var="report" items="${reports}">
                                <div class="report-item block bg-white rounded-lg shadow hover:shadow-lg transition p-4 flex items-start gap-4 group" 
                                     data-status="${report.isApproved ? 'approved' : 'pending'}" 
                                     data-user="${users[report.userId].name}" 
                                     data-content="${report.content}"
                                     data-date="<fmt:formatDate value='${report.time}' pattern='yyyy-MM-dd'/>">
                                    <a href="ReportServlet?action=getReportDetail&id=${report.reportID}" class="flex items-start gap-4 w-full">
                                        <img src="${users[report.userId].avatar != null && !users[report.userId].avatar.isEmpty() ? users[report.userId].avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" alt="Avatar" class="w-14 h-14 rounded-full object-cover border-2 border-primary-200 group-hover:border-primary-500">
                                        <div class="flex-1">
                                            <div class="flex items-center gap-2 mb-1">
                                                <span class="font-semibold text-gray-800">${users[report.userId].name}</span>
                                                <c:if test="${report.isApproved}">
                                                    <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                        <i class="fas fa-check mr-1"></i>
                                                        Đã xử lý
                                                    </span>
                                                </c:if>
                                                <c:if test="${!report.isApproved}">
                                                    <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                                        <i class="fas fa-clock mr-1"></i>
                                                        Chờ xử lý
                                                    </span>
                                                </c:if>
                                                <span class="text-xs text-gray-400 ml-2">
                                                    <fmt:formatDate value="${report.time}" pattern="dd/MM/yyyy HH:mm"/>
                                                </span>
                                            </div>
                                            <div class="text-gray-700 line-clamp-2">${report.content}</div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </main>
            </div>
        </div>

        <!-- JavaScript for Filtering -->
        <script>
            // Store original reports data
            const allReports = document.querySelectorAll('.report-item');
            
            function applyFilters() {
                const statusFilter = document.getElementById('statusFilter').value;
                const dateFilter = document.getElementById('dateFilter').value;
                const searchFilter = document.getElementById('searchFilter').value.toLowerCase();
                
                let visibleCount = 0;
                let pendingCount = 0;
                let approvedCount = 0;
                
                allReports.forEach(report => {
                    const reportStatus = report.dataset.status;
                    const reportUser = report.dataset.user.toLowerCase();
                    const reportContent = report.dataset.content.toLowerCase();
                    const reportDate = report.dataset.date;
                    
                    let showReport = true;
                    
                    // Status filter
                    if (statusFilter && statusFilter !== reportStatus) {
                        showReport = false;
                    }
                    
                    // Date filter
                    if (dateFilter && dateFilter !== reportDate) {
                        showReport = false;
                    }
                    
                    // Search filter
                    if (searchFilter && !reportUser.includes(searchFilter) && !reportContent.includes(searchFilter)) {
                        showReport = false;
                    }
                    
                    if (showReport) {
                        report.style.display = 'block';
                        visibleCount++;
                        if (reportStatus === 'pending') pendingCount++;
                        else approvedCount++;
                    } else {
                        report.style.display = 'none';
                    }
                });
                
                // Update counters
                document.getElementById('totalReports').textContent = visibleCount;
                document.getElementById('pendingReports').textContent = pendingCount;
                document.getElementById('approvedReports').textContent = approvedCount;
                
                // Show no results message if needed
                const noResults = document.getElementById('noResultsMessage');
                if (visibleCount === 0) {
                    if (!noResults) {
                        const message = document.createElement('div');
                        message.id = 'noResultsMessage';
                        message.className = 'text-center text-gray-500 mt-8 bg-white rounded-lg p-8';
                        message.innerHTML = `
                            <i class="fas fa-search text-4xl text-gray-300 mb-4"></i>
                            <p class="text-lg font-medium">Không tìm thấy báo cáo nào phù hợp.</p>
                            <p class="text-sm text-gray-400 mt-2">Thử thay đổi bộ lọc để xem thêm kết quả.</p>
                        `;
                        document.getElementById('reportsList').appendChild(message);
                    }
                } else if (noResults) {
                    noResults.remove();
                }
            }
            
            function clearFilters() {
                document.getElementById('statusFilter').value = '';
                document.getElementById('dateFilter').value = '';
                document.getElementById('searchFilter').value = '';
                
                // Show all reports
                allReports.forEach(report => {
                    report.style.display = 'block';
                });
                
                // Reset counters to original values
                document.getElementById('totalReports').textContent = '${reports.size()}';
                document.getElementById('pendingReports').textContent = '${pendingCount}';
                document.getElementById('approvedReports').textContent = '${approvedCount}';
                
                // Remove no results message if exists
                const noResults = document.getElementById('noResultsMessage');
                if (noResults) {
                    noResults.remove();
                }
            }
            
            // Real-time search
            document.getElementById('searchFilter').addEventListener('input', function() {
                applyFilters();
            });
            
            // Apply filters on status/date change
            document.getElementById('statusFilter').addEventListener('change', applyFilters);
            document.getElementById('dateFilter').addEventListener('change', applyFilters);
        </script>
