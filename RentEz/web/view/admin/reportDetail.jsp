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
                            900: '#7c2d12'
                        }
                    }
                }
            }
        };
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
                    <div class="max-w-2xl mx-auto bg-white rounded-lg shadow p-8">
                        <h3 class="text-xl font-bold mb-6 text-primary-700">Chi tiết tố cáo</h3>
                        <div class="flex flex-col md:flex-row gap-8 mb-8">
                            <!-- Người tố cáo -->
                            <div class="flex-1 flex flex-col items-center bg-primary-50 rounded-lg p-4">
                                <img src="${renter.avatar != null && !renter.avatar.isEmpty() ? renter.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" class="w-20 h-20 rounded-full object-cover border-2 border-primary-300 mb-2" alt="Avatar renter">
                                <div class="font-semibold text-gray-800">${renter.name}</div>
                                <div class="text-sm text-gray-500 mb-1">${renter.email}</div>
                                <span class="text-xs text-primary-600 font-medium">Người tố cáo</span>
                            </div>
                            <!-- Landlord bị tố cáo -->
                            <div class="flex-1 flex flex-col items-center bg-orange-50 rounded-lg p-4">
                                <img src="${landLord.avatar != null && !landLord.avatar.isEmpty() ? landLord.avatar : pageContext.request.contextPath.concat('/view/guest/asset/img/default-avatar.png')}" class="w-20 h-20 rounded-full object-cover border-2 border-orange-300 mb-2" alt="Avatar landlord">
                                <div class="font-semibold text-gray-800">${landLord.name}</div>
                                <div class="text-sm text-gray-500 mb-1">${landLord.email}</div>
                                <span class="text-xs text-orange-600 font-medium">Chủ nhà bị tố cáo</span>
                            </div>
                        </div>
                        <div class="mb-6">
                            <div class="font-semibold text-gray-700 mb-2">Nội dung tố cáo:</div>
                            <div class="bg-gray-50 border rounded p-4 text-gray-800 whitespace-pre-line">${report.content}</div>
                        </div>
                        <div class="flex gap-4 justify-end">
                            <form action="ReportServlet" method="post">
                                <input type="hidden" name="action" value="approve" />
                                <input type="hidden" name="reportID" value="${report.reportID}" />
                                <button type="submit" class="px-5 py-2 rounded bg-green-600 text-white font-semibold hover:bg-green-700 transition">Phê duyệt tố cáo</button>
                            </form>
                            <form action="ReportServlet" method="post" onsubmit="return confirm('Bạn chắc chắn muốn xóa tố cáo này?');">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="reportID" value="${param.id}" />
                                <button type="submit" class="px-5 py-2 rounded bg-red-600 text-white font-semibold hover:bg-red-700 transition">Xóa tố cáo</button>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>
