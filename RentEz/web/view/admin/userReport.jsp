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
                    <c:if test="${empty reports}">
                        <div class="text-center text-gray-500 mt-12">Không có báo cáo nào.</div>
                    </c:if>
                    <c:if test="${not empty reports}">
                        <div class="grid grid-cols-1 gap-4">
                            <c:forEach var="report" items="${reports}">
                                <a href="ReportServlet?action=getReportDetail&id=${report.reportID}" class="block bg-white rounded-lg shadow hover:shadow-lg transition p-4 flex items-start gap-4 group">
                                    <img src="${users[report.userId].avatar != null && !users[report.userId].avatar.isEmpty() ? users[report.userId].avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" alt="Avatar" class="w-14 h-14 rounded-full object-cover border-2 border-primary-200 group-hover:border-primary-500">
                                    <div class="flex-1">
                                        <div class="flex items-center gap-2 mb-1">
                                            <span class="font-semibold text-gray-800">${users[report.userId].name}</span>
                                            <span class="text-xs text-gray-400 ml-2">
                                                <fmt:formatDate value="${report.time}" pattern="dd/MM/yyyy HH:mm"/>
                                            </span>
                                        </div>
                                        <div class="text-gray-700 line-clamp-2">${report.content}</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>
                </main>
            </div>
        </div>
    </body>
</html>
