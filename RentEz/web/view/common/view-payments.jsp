<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Quản lý Thanh Toán</title>
        <!-- Tailwind CSS CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gradient-to-br from-orange-50 via-orange-100 to-orange-50 min-h-screen font-sans">
        <jsp:include page="header.jsp" />

        <div class="container mx-auto px-6 mt-8">

            <!-- Page Header -->
            <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-8">
                <div class="md:w-2/3">
                    <h2 class="text-3xl font-bold text-orange-600 flex items-center mb-1">
                        <i class="fas fa-credit-card mr-3"></i> Quản Lý Thanh Toán
                    </h2>
                    <p class="text-gray-600">Xem và quản lý các khoản thanh toán, hóa đơn của bạn</p>
                </div>        <div class="md:w-1/3 text-right mt-4 md:mt-0">
                    <div class="space-x-3">
                        <button type="button"
                                class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded shadow-sm text-orange-600 hover:bg-orange-50 transition"
                                data-modal-toggle="addFundsModal">
                            <i class="fas fa-plus mr-2"></i> Nạp Tiền
                        </button>
                        <button type="button"
                                class="inline-flex items-center px-4 py-2 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded shadow-sm hover:from-orange-500 hover:to-orange-600 transition"
                                data-modal-toggle="withdrawModal">
                            <i class="fas fa-minus mr-2"></i> Rút Tiền
                        </button>
                    </div>
                </div>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty param.success}">
                <div
                    class="flex items-center bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6 relative"
                    role="alert">
                    <i class="fas fa-check-circle mr-2"></i>
                    <span>${param.success}</span>
                    <button type="button"
                            class="absolute top-1 right-2 text-green-700 hover:text-green-900 focus:outline-none"
                            onclick="this.parentElement.style.display = 'none';">
                        &times;
                    </button>
                </div>
            </c:if>

            <c:if test="${not empty param.error}">
                <div
                    class="flex items-center bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 relative"
                    role="alert">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span>${param.error}</span>
                    <button type="button"
                            class="absolute top-1 right-2 text-red-700 hover:text-red-900 focus:outline-none"
                            onclick="this.parentElement.style.display = 'none';">
                        &times;
                    </button>
                </div>
            </c:if>

            <c:if test="${not empty param.info}">
                <div
                    class="flex items-center bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded mb-6 relative"
                    role="alert">
                    <i class="fas fa-info-circle mr-2"></i>
                    <span>${param.info}</span>
                    <button type="button"
                            class="absolute top-1 right-2 text-blue-700 hover:text-blue-900 focus:outline-none"
                            onclick="this.parentElement.style.display = 'none';">
                        &times;
                    </button>
                </div>
            </c:if>

            <div class="flex flex-wrap -mx-3 mt-6">
                <!-- Wallet Balance -->
                <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                    <div
                        class="bg-white shadow rounded-lg p-6 border border-orange-200 hover:shadow-lg transition cursor-default">
                        <h5 class="text-xl font-semibold text-orange-600 flex items-center mb-3">
                            <i class="fas fa-wallet mr-3"></i> Số Dư Ví
                        </h5>
                        <h2 class="text-3xl font-bold text-gray-800 mb-1">
                            <fmt:formatNumber value="${userWallet.balance}" type="currency" currencySymbol="₫" groupingUsed="true" />
                        </h2>
                        <small class="text-gray-500">
                            Cập nhật lần cuối: 
                            <fmt:formatDate value="${userWallet.lastUpdated}" pattern="dd/MM/yyyy HH:mm" />
                        </small>
                    </div>
                </div>

                <!-- Summary Cards -->
                <div class="w-full md:w-2/3 px-3">
                    <div class="flex flex-wrap -mx-3">
                        <div class="w-1/3 px-3">
                            <div
                                class="bg-white border border-red-200 rounded-lg shadow p-5 flex flex-col items-center hover:shadow-lg transition cursor-default">
                                <div class="text-red-500 mb-2 text-3xl">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                                <h6 class="font-semibold mb-1">Chưa Thanh Toán</h6>
                                <h4 class="text-red-600 font-bold mb-1">${unpaidBills.size()}</h4>
                                <small class="text-red-400">
                                    <fmt:formatNumber value="${totalUnpaid}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                </small>
                            </div>
                        </div>
                        <div class="w-1/3 px-3">
                            <div
                                class="bg-white border border-green-200 rounded-lg shadow p-5 flex flex-col items-center hover:shadow-lg transition cursor-default">
                                <div class="text-green-500 mb-2 text-3xl">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <h6 class="font-semibold mb-1">Đã Thanh Toán</h6>
                                <h4 class="text-green-600 font-bold mb-1">${paidBills.size()}</h4>
                                <small class="text-green-400">Hóa đơn trong tháng</small>
                            </div>
                        </div>
                        <div class="w-1/3 px-3">
                            <div
                                class="bg-white border border-blue-200 rounded-lg shadow p-5 flex flex-col items-center hover:shadow-lg transition cursor-default">
                                <div class="text-blue-500 mb-2 text-3xl">
                                    <i class="fas fa-history"></i>
                                </div>
                                <h6 class="font-semibold mb-1">Giao Dịch Gần Đây</h6>
                                <h4 class="text-blue-600 font-bold mb-1">${recentPayments.size()}</h4>
                                <small class="text-blue-400">Trong 30 ngày qua</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Navigation Tabs -->
            <div class="mt-8 border-b border-orange-300">
                <nav class="flex space-x-6 text-orange-600 font-semibold" aria-label="Tabs" id="paymentTabs">
                    <button id="unpaid-tab" aria-controls="unpaid" aria-selected="true" role="tab"
                            class="pb-3 border-b-4 border-orange-500 focus:outline-none" 
                            onclick="switchTab(event, 'unpaid')">
                        <i class="fas fa-exclamation-triangle mr-1"></i> Chưa Thanh Toán (${unpaidBills.size()})
                    </button>
                    <button id="paid-tab" aria-controls="paid" aria-selected="false" role="tab"
                            class="pb-3 border-b-4 border-transparent hover:border-orange-400 focus:outline-none"
                            onclick="switchTab(event, 'paid')">
                        <i class="fas fa-check-circle mr-1"></i> Đã Thanh Toán (${paidBills.size()})
                    </button>
                    <button id="history-tab" aria-controls="history" aria-selected="false" role="tab"
                            class="pb-3 border-b-4 border-transparent hover:border-orange-400 focus:outline-none"
                            onclick="switchTab(event, 'history')">
                        <i class="fas fa-history mr-1"></i> Lịch Sử Giao Dịch
                    </button>
                </nav>
            </div>

            <!-- Tab Content -->
            <div class="mt-6">
                <!-- Unpaid Bills Tab -->
                <div id="unpaid" role="tabpanel" aria-labelledby="unpaid-tab" class="tab-panel block">
                    <div class="bg-white rounded-lg shadow p-6">
                        <c:choose>
                            <c:when test="${empty unpaidBills}">
                                <div class="text-center py-10 text-green-600">
                                    <i class="fas fa-smile text-6xl mb-5"></i>
                                    <h5 class="text-xl font-semibold">Tuyệt vời! Bạn không có hóa đơn nào chưa thanh toán</h5>
                                    <p class="text-gray-500 mt-1">Tất cả các khoản thanh toán của bạn đều đã được xử lý</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="bill" items="${unpaidBills}">
                                    <div class="mb-4 rounded-lg border border-orange-300 p-4 hover:shadow-lg transition
                                         ${bill.status == 'Overdue' ? 'bg-red-50 border-red-400' : 'bg-orange-50'}">
                                        <div class="flex flex-wrap md:flex-nowrap items-center">
                                            <div class="md:w-1/2 mb-3 md:mb-0">
                                                <h6 class="text-lg font-semibold flex items-center">
                                                    <i class="fas fa-home mr-2 text-orange-500"></i> ${bill.property.title}
                                                </h6>
                                                <p class="text-gray-600 text-sm mb-1 flex items-center">
                                                    <i class="fas fa-calendar mr-1"></i> Kỳ thanh toán: ${bill.billingPeriod}
                                                </p>
                                                <p class="text-gray-600 text-sm mb-1 flex items-center">
                                                    <i class="fas fa-clock mr-1"></i> Hạn thanh toán:
                                                    <fmt:formatDate value="${bill.dueDate}" pattern="dd/MM/yyyy" />
                                                </p>
                                                <c:if test="${bill.status == 'Overdue'}">
                                                    <span
                                                        class="inline-block bg-red-400 text-white text-xs font-semibold px-3 py-1 rounded mt-1">
                                                        <i class="fas fa-exclamation-triangle mr-1"></i> Quá hạn
                                                    </span>
                                                </c:if>
                                            </div>
                                            <div class="md:w-1/4 text-center text-red-600 text-xl font-bold mb-3 md:mb-0">
                                                <fmt:formatNumber value="${bill.totalAmount}" type="currency" currencySymbol="₫"
                                                                  groupingUsed="true" />
                                            </div>
                                            <div class="md:w-1/4 flex flex-col items-end space-y-2">
                                                <button type="button"
                                                        class="px-4 py-2 text-orange-600 border border-orange-400 rounded hover:bg-orange-50 transition text-sm"
                                                        onclick="viewBillDetails(${bill.billId})">
                                                    <i class="fas fa-eye mr-1"></i> Chi Tiết
                                                </button>
                                                <button type="button"
                                                        class="px-4 py-2 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded shadow hover:from-orange-500 hover:to-orange-600 transition text-sm"
                                                        onclick="openPaymentModal(${bill.billId}, '${bill.property.title}', ${bill.totalAmount})">
                                                    <i class="fas fa-credit-card mr-1"></i> Thanh Toán
                                                </button>
                                            </div>
                                        </div>

                                        <!-- Bill Details Preview -->
                                        <c:if test="${not empty bill.billDetails}">
                                            <div class="mt-4 text-sm text-gray-600">
                                                <small>Chi tiết hóa đơn:</small>
                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mt-2">
                                                    <c:forEach var="detail" items="${bill.billDetails}">
                                                        <div>
                                                            • ${detail.feeCategory.name}: 
                                                            <strong>
                                                                <fmt:formatNumber value="${detail.amount}" type="currency"
                                                                                  currencySymbol="₫" groupingUsed="true" />
                                                            </strong>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Paid Bills Tab -->
                <div id="paid" role="tabpanel" aria-labelledby="paid-tab" class="tab-panel hidden">
                    <div class="bg-white rounded-lg shadow p-6">
                        <c:choose>
                            <c:when test="${empty paidBills}">
                                <div class="text-center py-10 text-gray-400">
                                    <i class="fas fa-receipt text-6xl mb-5"></i>
                                    <h5 class="text-xl font-semibold">Chưa có hóa đơn nào được thanh toán</h5>
                                    <p class="text-gray-500 mt-1">Lịch sử thanh toán sẽ hiển thị tại đây</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="bill" items="${paidBills}">
                                    <div
                                        class="mb-4 rounded-lg border border-green-300 bg-green-50 p-4 hover:shadow-lg transition cursor-default">
                                        <div class="flex flex-wrap md:flex-nowrap items-center">
                                            <div class="md:w-7/12 mb-3 md:mb-0">
                                                <h6 class="text-lg font-semibold flex items-center">
                                                    <i class="fas fa-home mr-2 text-green-600"></i> ${bill.property.title}
                                                </h6>
                                                <p class="text-gray-600 text-sm mb-1 flex items-center">
                                                    <i class="fas fa-calendar mr-1"></i> Kỳ thanh toán: ${bill.billingPeriod}
                                                </p>
                                                <p class="text-gray-600 text-sm mb-1 flex items-center">
                                                    <i class="fas fa-clock mr-1"></i> Đã thanh toán: 
                                                    <fmt:formatDate value="${bill.dueDate}" pattern="dd/MM/yyyy" />
                                                </p>
                                                <span
                                                    class="inline-block bg-green-500 text-white text-xs font-semibold px-3 py-1 rounded mt-1">
                                                    <i class="fas fa-check mr-1"></i> Đã thanh toán
                                                </span>
                                            </div>
                                            <div class="md:w-3/12 text-center text-green-600 text-xl font-bold mb-3 md:mb-0">
                                                <fmt:formatNumber value="${bill.totalAmount}" type="currency" currencySymbol="₫"
                                                                  groupingUsed="true" />
                                            </div>
                                            <div class="md:w-2/12 flex justify-end">
                                                <button type="button"
                                                        class="px-4 py-2 text-green-600 border border-green-400 rounded hover:bg-green-50 transition text-sm"
                                                        onclick="viewBillDetails(${bill.billId})">
                                                    <i class="fas fa-eye mr-1"></i> Chi Tiết
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Payment History Tab -->
                <div id="history" role="tabpanel" aria-labelledby="history-tab" class="tab-panel hidden">
                    <div class="bg-white rounded-lg shadow p-6">
                        <div class="flex justify-between items-center mb-4">
                            <h6 class="text-lg font-semibold flex items-center text-orange-600">
                                <i class="fas fa-history mr-2"></i> Lịch Sử Giao Dịch
                            </h6>
                            <a href="${pageContext.request.contextPath}/payments?action=payment-history"
                               class="inline-flex items-center px-3 py-1 border border-orange-400 text-orange-600 rounded hover:bg-orange-50 transition text-sm">
                                <i class="fas fa-external-link-alt mr-1"></i> Xem Tất Cả
                            </a>
                        </div>
                        <c:choose>
                            <c:when test="${empty recentPayments}">
                                <div class="text-center py-10 text-gray-400">
                                    <i class="fas fa-history text-6xl mb-5"></i>
                                    <h5 class="text-xl font-semibold">Chưa có giao dịch nào</h5>
                                    <p class="text-gray-500 mt-1">Lịch sử giao dịch sẽ hiển thị tại đây</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="overflow-x-auto">
                                    <table class="min-w-full table-auto border-collapse border border-gray-200">
                                        <thead class="bg-orange-200 text-orange-700 font-semibold">
                                            <tr>
                                                <th class="border border-gray-300 px-4 py-2 text-left">Ngày</th>
                                                <th class="border border-gray-300 px-4 py-2 text-left">Loại</th>
                                                <th class="border border-gray-300 px-4 py-2 text-left">Phương thức</th>
                                                <th class="border border-gray-300 px-4 py-2 text-right">Số tiền</th>
                                                <th class="border border-gray-300 px-4 py-2 text-left">Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="payment" items="${recentPayments}" varStatus="status" end="9">
                                                <tr class="hover:bg-orange-50 transition">
                                                    <td class="border border-gray-300 px-4 py-2 whitespace-nowrap">
                                                        <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td class="border border-gray-300 px-4 py-2 whitespace-nowrap">
                                                        <c:choose>
                                                            <c:when test="${payment.referenceType == 'Bill'}">
                                                                <i class="fas fa-file-invoice-dollar text-orange-600 mr-1"></i>
                                                                Thanh toán hóa đơn
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-exchange-alt text-blue-600 mr-1"></i>
                                                                ${payment.referenceType}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="border border-gray-300 px-4 py-2 whitespace-nowrap">
                                                        <span class="inline-block bg-gray-300 text-gray-700 rounded px-2 py-0.5 text-xs font-semibold">
                                                            ${payment.paymentMethod}
                                                        </span>
                                                    </td>
                                                    <td class="border border-gray-300 px-4 py-2 whitespace-nowrap text-right font-semibold text-orange-600">
                                                        <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                                    </td>
                                                    <td class="border border-gray-300 px-4 py-2 whitespace-nowrap">
                                                        <c:choose>
                                                            <c:when test="${payment.status == 'Completed'}">
                                                                <span
                                                                    class="inline-block bg-green-500 text-white px-2 py-1 rounded text-xs font-semibold">
                                                                    Hoàn thành
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${payment.status == 'Pending'}">
                                                                <span
                                                                    class="inline-block bg-yellow-400 text-gray-800 px-2 py-1 rounded text-xs font-semibold">
                                                                    Đang xử lý
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="inline-block bg-red-500 text-white px-2 py-1 rounded text-xs font-semibold">
                                                                    ${payment.status}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Modal -->
        <div id="paymentModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
            <div class="bg-white rounded-lg shadow-lg max-w-md w-full mx-4">
                <div class="flex justify-between items-center border-b border-orange-300 px-6 py-4">
                    <h5 class="text-xl font-semibold text-orange-600 flex items-center">
                        <i class="fas fa-credit-card mr-2"></i> Thanh Toán Hóa Đơn
                    </h5>
                    <button type="button" class="text-orange-600 hover:text-orange-800 focus:outline-none" onclick="closePaymentModal()">&times;</button>
                </div>
                <form action="${pageContext.request.contextPath}/payment-action" method="POST" class="px-6 py-4">
                    <input type="hidden" name="action" value="pay-bill" />
                    <input type="hidden" name="billId" id="paymentBillId" />

                    <div class="bg-orange-50 rounded p-4 mb-4">
                        <h6 id="paymentPropertyTitle" class="font-semibold text-orange-700"></h6>
                        <p class="mb-0">Số tiền: <strong id="paymentAmount"></strong></p>
                    </div>

                    <div class="mb-4">
                        <label class="block font-semibold mb-2">Phương thức thanh toán:</label>
                        <div class="space-y-2">
                            <label class="inline-flex items-center">
                                <input type="radio" name="paymentMethod" value="wallet" id="walletPayment" checked class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-wallet mr-2"></i>Ví điện tử
                                    <small class="text-gray-500">(Số dư:
                                        <fmt:formatNumber value="${userWallet.balance}" type="currency" currencySymbol="₫" groupingUsed="true" />
                                        )</small>
                                </span>
                            </label>
                            <label class="inline-flex items-center">
                                <input type="radio" name="paymentMethod" value="bank_transfer" id="bankTransfer" class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-university mr-2"></i>Chuyển khoản ngân hàng</span>
                            </label>
                            <label class="inline-flex items-center">
                                <input type="radio" name="paymentMethod" value="credit_card" id="creditCard" class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-credit-card mr-2"></i>Thẻ tín dụng</span>
                            </label>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-3">
                        <button type="button" class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 transition"
                                onclick="closePaymentModal()">Hủy</button>
                        <button type="submit" class="px-4 py-2 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded hover:from-orange-500 hover:to-orange-600 transition">
                            <i class="fas fa-credit-card mr-2"></i> Thanh Toán
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Add Funds Modal -->
        <div id="addFundsModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
            <div class="bg-white rounded-lg shadow-lg max-w-md w-full mx-4">
                <div class="flex justify-between items-center border-b border-orange-300 px-6 py-4">
                    <h5 class="text-xl font-semibold text-orange-600 flex items-center">
                        <i class="fas fa-plus mr-2"></i> Nạp Tiền Vào Ví
                    </h5>
                    <button type="button" class="text-orange-600 hover:text-orange-800 focus:outline-none" onclick="closeAddFundsModal()">&times;</button>
                </div>
                <form id="addFundsForm" action="${pageContext.request.contextPath}/payment-action" method="POST" class="px-6 py-4">
                    <input type="hidden" name="action" value="add-funds" />
                    <input type="hidden" name="paymentMethod" value="wallet" />
                    <input type="hidden" name="description" value="Nap tien vao tai khoan" />

                    <div class="mb-4">
                        <label for="amount" class="block font-semibold mb-2">Số tiền cần nạp (VND):</label>
                        <input type="number" id="amount" name="amount" min="10000" step="1000" required
                               placeholder="Nhập số tiền"
                               class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400" />
                        <small class="text-gray-500">Số tiền tối thiểu: 10,000 VND</small>
                    </div>

                    <div class="mb-4">
                        <label class="block font-semibold mb-2">Phương thức nạp tiền:</label>
                        <div class="space-y-2">
                            <label class="inline-flex items-center">
                                <input type="radio" name="method" value="bank_transfer" id="addFundsBankTransfer" checked
                                       class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-university mr-2"></i>Chuyển khoản ngân hàng</span>
                            </label>
                            <label class="inline-flex items-center">
                                <input type="radio" name="method" value="credit_card" id="addFundsCreditCard"
                                       class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-credit-card mr-2"></i>Thẻ tín dụng</span>
                            </label>
                            <label class="inline-flex items-center">
                                <input type="radio" name="method" value="vnpay" id="addFundsVNPay" class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-wallet mr-2"></i>Ví VNPay</span>
                            </label>
                            <label class="inline-flex items-center">
                                <input type="radio" name="method" value="momo" id="addFundsMomo" class="form-radio text-orange-500" />
                                <span class="ml-2 cursor-pointer"><i class="fas fa-mobile-alt mr-2"></i>Ví MoMo</span>
                            </label>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-3">
                        <button type="button" class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 transition"
                                onclick="closeAddFundsModal()">Hủy</button>
                        <button type="button" id="addFundsSubmitBtn" class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 transition">
                            <i class="fas fa-plus mr-2"></i> Nạp Tiền
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Withdraw Modal -->
        <div id="withdrawModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
            <div class="bg-white rounded-lg shadow-lg max-w-md w-full mx-4">
                <div class="flex justify-between items-center border-b border-orange-300 px-6 py-4">
                    <h5 class="text-xl font-semibold text-orange-600 flex items-center">
                        <i class="fas fa-minus mr-2"></i> Rút Tiền Từ Ví
                    </h5>
                    <button type="button" class="text-orange-600 hover:text-orange-800 focus:outline-none" onclick="closeWithdrawModal()">&times;</button>
                </div>
                <form action="${pageContext.request.contextPath}/payment-action" method="POST" class="px-6 py-4">
                    <input type="hidden" name="action" value="withdraw-funds" />

                    <div class="mb-4">
                        <label for="withdrawAmount" class="block font-semibold mb-2">Số tiền cần rút (VND):</label>
                        <input type="number" id="withdrawAmount" name="amount" min="10000" step="1000" 
                               max="${userWallet.balance}" required
                               placeholder="Nhập số tiền"
                               class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400" />
                        <small class="text-gray-500">
                            Số dư hiện tại: <fmt:formatNumber value="${userWallet.balance}" type="currency" currencySymbol="₫" groupingUsed="true" />
                        </small>
                    </div>

                    <div class="mb-4">
                        <label for="bankAccount" class="block font-semibold mb-2">Số tài khoản ngân hàng:</label>
                        <input type="text" id="bankAccount" name="bankAccount" required
                               placeholder="Nhập số tài khoản"
                               class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400" />
                    </div>

                    <div class="mb-4">
                        <label for="bankName" class="block font-semibold mb-2">Tên ngân hàng:</label>
                        <select id="bankName" name="bankName" required
                                class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400">
                            <option value="">Chọn ngân hàng</option>
                            <option value="Vietcombank">Vietcombank</option>
                            <option value="VietinBank">VietinBank</option>
                            <option value="BIDV">BIDV</option>
                            <option value="Agribank">Agribank</option>
                            <option value="ACB">ACB</option>
                            <option value="Techcombank">Techcombank</option>
                            <option value="Sacombank">Sacombank</option>
                            <option value="VPBank">VPBank</option>
                            <option value="TPBank">TPBank</option>
                            <option value="MBBank">MBBank</option>
                            <option value="SHB">SHB</option>
                            <option value="HDBank">HDBank</option>
                            <option value="OCB">OCB</option>
                            <option value="SeABank">SeABank</option>
                            <option value="VIB">VIB</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="block font-semibold mb-2">Ghi chú (tùy chọn):</label>
                        <textarea id="description" name="description" rows="3"
                                  placeholder="Nhập ghi chú cho giao dịch..."
                                  class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-400"></textarea>
                    </div>

                    <div class="flex justify-end space-x-3">
                        <button type="button" class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100 transition"
                                onclick="closeWithdrawModal()">Hủy</button>
                        <button type="submit" class="px-4 py-2 bg-gradient-to-r from-orange-400 to-orange-500 text-white rounded hover:from-orange-500 hover:to-orange-600 transition">
                            <i class="fas fa-minus mr-2"></i> Rút Tiền
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            // Tab switching function
            function switchTab(event, tabId) {
                event.preventDefault();
                const tabs = document.querySelectorAll('[role="tab"]');
                const panels = document.querySelectorAll('.tab-panel');

                tabs.forEach(tab => {
                    tab.classList.remove('border-orange-500', 'font-bold');
                    tab.classList.add('border-transparent');
                    tab.setAttribute('aria-selected', 'false');
                });

                panels.forEach(panel => {
                    panel.classList.add('hidden');
                    panel.classList.remove('block');
                });

                event.currentTarget.classList.add('border-orange-500', 'font-bold');
                event.currentTarget.classList.remove('border-transparent');
                event.currentTarget.setAttribute('aria-selected', 'true');

                document.getElementById(tabId).classList.remove('hidden');
                document.getElementById(tabId).classList.add('block');
            }

            // Modal open/close helpers
            function openPaymentModal(billId, propertyTitle, amount) {
                document.getElementById('paymentBillId').value = billId;
                document.getElementById('paymentPropertyTitle').textContent = propertyTitle;
                document.getElementById('paymentAmount').textContent = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
                document.getElementById('paymentModal').classList.remove('hidden');
            }

            function closePaymentModal() {
                document.getElementById('paymentModal').classList.add('hidden');
            }
            function closeAddFundsModal() {
                document.getElementById('addFundsModal').classList.add('hidden');
            }

            function closeWithdrawModal() {
                document.getElementById('withdrawModal').classList.add('hidden');
            }

            // Handle Nạp Tiền button modal toggle
            document.querySelector('[data-modal-toggle="addFundsModal"]').addEventListener('click', () => {
                document.getElementById('addFundsModal').classList.remove('hidden');
            });

            // Handle Rút Tiền button modal toggle
            document.querySelector('[data-modal-toggle="withdrawModal"]').addEventListener('click', () => {
                document.getElementById('withdrawModal').classList.remove('hidden');
            });

            // Handle Add Funds form submit
            document.getElementById('addFundsSubmitBtn').addEventListener('click', function(e) {
                e.preventDefault();
                
                const form = document.getElementById('addFundsForm');
                const formData = new FormData(form);
                const amount = formData.get('amount');
                const method = formData.get('method');
                
                // Validate amount
                if (!amount || amount < 10000) {
                    alert('Vui lòng nhập số tiền hợp lệ (tối thiểu 10,000 VND)');
                    return;
                }
                
                if (method === 'vnpay') {
                    // Handle VNPay payment
                    handleVNPayPayment(amount);
                } else {
                    // Handle other payment methods (existing logic)
                    form.submit();
                }
            });

            function handleVNPayPayment(amount) {
                // Show loading state
                const submitBtn = document.getElementById('addFundsSubmitBtn');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Đang xử lý...';
                submitBtn.disabled = true;
                
                // Make AJAX request to Deposit servlet which will route to VNPay
                fetch('${pageContext.request.contextPath}/deposit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'amount=' + encodeURIComponent(amount) + '&method=vnpay'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.code === '00') {
                        // Redirect to VNPay payment page
                        window.location.href = data.data;
                    } else {
                        alert('Lỗi: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi tạo liên kết thanh toán');
                })
                .finally(() => {
                    // Restore button state
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                });
            }
        </script>

    </body>
</html>
