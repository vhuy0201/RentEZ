<%@page contentType='text/html' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt' %>
<!DOCTYPE html>
<html lang='vi'>
    <head>
        <meta charset='UTF-8'>
        <title>Quản Lý Gói Thành Viên - RentEz</title>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <link href='https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css' rel='stylesheet'>
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css'>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f5f7ff;
                color: #1f2a44;
            }
            .card-hover:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08);
            }
            .gradient-text {
                background: linear-gradient(90deg, #4f46e5, #ec4899);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .gradient-bg {
                background: linear-gradient(135deg, #4f46e5, #ec4899);
            }
            .btn-gradient {
                background: linear-gradient(90deg, #4f46e5, #ec4899);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .btn-gradient:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 16px rgba(79, 70, 229, 0.4);
            }
            .modal-content {
                animation: slideIn 0.3s ease-out;
            }
            @keyframes slideIn {
                from {
                    transform: translateY(20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body class='bg-gray-50 text-gray-900'>

        <jsp:include page='header.jsp' />

        <!-- Banner -->
        <div class='bg-gradient-to-r from-indigo-600 to-pink-500 text-white rounded-b-3xl px-6 py-12 mb-12 shadow-2xl'>
            <div class='max-w-7xl mx-auto flex flex-wrap md:flex-nowrap justify-between items-center'>
                <div class="mb-6 md:mb-0">
                    <h1 class='text-4xl font-extrabold tracking-tight'><i class='fas fa-crown text-yellow-400 mr-3'></i>Quản Lý Gói Thành Viên</h1>
                    <p class='text-indigo-100 mt-3 font-medium text-lg'>Khám phá các gói thành viên để nâng tầm trải nghiệm của bạn!</p>
                </div>
                <div class='bg-white/10 backdrop-blur-lg p-5 rounded-2xl shadow-lg'>
                    <p class='text-sm text-indigo-100'>Số dư ví:</p>
                    <p class='text-2xl font-bold text-white mt-1'>
                        <fmt:formatNumber value='${userWallet.balance}' type='currency' currencySymbol='₫' groupingUsed='true' />
                    </p>
                    <a href='${pageContext.request.contextPath}/payments' class='inline-block mt-3 text-sm bg-white/20 px-4 py-2 rounded-full text-white hover:bg-white/30 transition'>
                        <i class='fas fa-wallet mr-2'></i>Quản lý ví
                    </a>
                </div>
            </div>
        </div>

        <!-- Thông báo -->
        <div class='max-w-7xl mx-auto px-4'>
            <c:if test='${not empty param.success}'>
                <div class='bg-green-50 text-green-800 border-l-4 border-green-500 rounded-xl px-5 py-4 mb-8 shadow-md'>
                    <div class="flex items-center">
                        <i class='fas fa-check-circle text-green-600 text-2xl mr-4'></i>
                        <p class="font-semibold">${param.success}</p>
                    </div>
                </div>
            </c:if>
            <c:if test='${not empty param.error}'>
                <div class='bg-red-50 text-red-800 border-l-4 border-red-500 rounded-xl px-5 py-4 mb-8 shadow-md'>
                    <div class="flex items-center">
                        <i class='fas fa-exclamation-circle text-red-600 text-2xl mr-4'></i>
                        <p class="font-semibold">${param.error}</p>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Trạng thái gói hiện tại -->
        <div class='max-w-7xl mx-auto px-4 mb-16'>
            <div class='bg-white shadow-2xl rounded-3xl p-10 border border-gray-100'>
                <h2 class='gradient-text text-3xl font-extrabold mb-8'><i class='fas fa-user-crown mr-3'></i>Gói hiện tại</h2>
                <c:choose>
                    <c:when test='${not empty currentUserTier && not empty currentTier}'>
                        <div class='flex flex-col md:flex-row justify-between items-center'>
                            <div class='flex items-center mb-6 md:mb-0'>
                                <div class='w-24 h-24 rounded-full bg-gradient-to-br from-indigo-500 to-pink-500 flex items-center justify-center mr-6 shadow-xl'>
                                    <i class='fas fa-crown text-white text-4xl'></i>
                                </div>
                                <div>
                                    <h3 class='text-2xl font-bold text-gray-900'>${currentTier.tierName}</h3>
                                    <p class='text-gray-600 my-2 current-tier-description' data-description='${currentTier.description}'></p>
                                    <div class="inline-flex items-center bg-yellow-50 text-yellow-800 text-sm px-4 py-2 rounded-full mt-2 shadow-sm">
                                        <i class='fas fa-clock mr-2'></i>
                                        Hết hạn: <fmt:formatDate value='${currentUserTier.endDate}' pattern='dd/MM/yyyy'/>
                                    </div>
                                </div>
                            </div>
                            <div class='text-center md:text-right'>
                                <div class="flex items-center justify-center md:justify-end mb-4">
                                    <span class="gradient-bg text-white px-4 py-2 rounded-lg font-bold inline-flex items-center shadow-md">
                                        <i class='fas fa-star text-yellow-300 mr-2'></i>
                                        Ưu tiên: ${currentTier.priorityLevel}
                                    </span>
                                </div>
                                <a href='${pageContext.request.contextPath}/membership?action=history' 
                                   class='inline-block px-5 py-3 bg-gray-100 text-gray-800 rounded-lg hover:bg-gray-200 transition'>
                                    <i class='fas fa-history mr-2'></i>Xem lịch sử
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class='text-center py-16 px-8'>
                            <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6 shadow-md">
                                <i class='fas fa-user text-gray-400 text-4xl'></i>
                            </div>
                            <h3 class='text-3xl font-bold text-gray-800 mb-3'>Chưa có gói thành viên</h3>
                            <p class='text-gray-500 max-w-lg mx-auto text-lg'>Chọn một gói bên dưới để mở khóa các tính năng độc quyền và ưu đãi hấp dẫn!</p>
                            <div class="mt-8 animate-bounce">
                                <i class="fas fa-arrow-down text-indigo-600 text-2xl"></i>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Các gói thành viên -->
        <div class='max-w-7xl mx-auto px-4 mb-20'>
            <h2 class='text-4xl font-extrabold mb-10 text-center'>
                <span class="gradient-text"><i class='fas fa-star mr-3 text-yellow-400'></i>Chọn gói thành viên</span>
            </h2>
            <div class='grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10'>
                <c:forEach var='tier' items='${availableTiers}'>
                    <div class='bg-white rounded-3xl shadow-lg p-10 transition duration-300 card-hover border border-gray-100 relative <c:if test='${not empty currentTier && tier.tierId == currentTier.tierId}'>ring-4 ring-indigo-500</c:if>'>
                            <!-- Icon -->
                        <c:if test='${not empty currentTier && tier.tierId == currentTier.tierId}'>
                            <div class="absolute -top-4 -right-4">
                                <span class="gradient-bg text-white text-sm px-4 py-2 rounded-full font-semibold shadow-lg">
                                    <i class="fas fa-check mr-2"></i>Đang dùng
                                </span>
                            </div>
                        </c:if>

                        <div class='w-24 h-24 mx-auto rounded-full mb-8 flex items-center justify-center shadow-xl
                             <c:choose>
                                 <c:when test='${tier.priorityLevel == 1}'>bg-gradient-to-br from-yellow-400 to-orange-500</c:when>
                                 <c:when test='${tier.priorityLevel == 2}'>bg-gradient-to-br from-indigo-600 to-blue-500</c:when>
                                 <c:when test='${tier.priorityLevel == 3}'>bg-gradient-to-br from-teal-500 to-green-500</c:when>
                                 <c:otherwise>bg-gradient-to-br from-gray-400 to-gray-600</c:otherwise>
                             </c:choose>'>
                            <i class='fas fa-crown text-white text-4xl'></i>
                        </div>

                        <h3 class='text-center text-2xl font-bold text-gray-900 mb-3'>${tier.tierName}</h3>
                        <p class='text-center text-gray-500 mb-8 px-4 tier-description' data-description='${tier.description}'></p>

                        <div class='text-center mb-8 py-4 px-6 rounded-2xl bg-gray-50'>
                            <p class='text-4xl font-extrabold 
                               <c:choose>
                                   <c:when test='${tier.priorityLevel == 1}'>text-orange-500</c:when>
                                   <c:when test='${tier.priorityLevel == 2}'>text-indigo-600</c:when>
                                   <c:when test='${tier.priorityLevel == 3}'>text-teal-600</c:when>
                                   <c:otherwise>text-gray-600</c:otherwise>
                               </c:choose>'>
                                <fmt:formatNumber value='${tier.price}' type='currency' currencySymbol='₫' groupingUsed='true'/>
                            </p>
                            <p class='text-sm text-gray-400 font-medium mt-2'>/tháng</p>
                        </div>

                        <div class="border-t border-b border-gray-100 py-6 mb-8">
                            <ul class='text-gray-600 space-y-4'>
                                <li class="flex items-start">
                                    <span class="
                                          <c:choose>
                                              <c:when test='${tier.priorityLevel == 1}'>text-orange-500</c:when>
                                              <c:when test='${tier.priorityLevel == 2}'>text-indigo-600</c:when>
                                              <c:when test='${tier.priorityLevel == 3}'>text-teal-600</c:when>
                                              <c:otherwise>text-gray-600</c:otherwise>
                                          </c:choose> mr-3 mt-1">
                                        <i class='fas fa-check-circle text-lg'></i>
                                    </span>
                                    <span>
                                        <c:choose>
                                            <c:when test='${tier.priorityLevel == 1}'>🔥 Ưu tiên cao nhất - Hot nhất</c:when>
                                            <c:when test='${tier.priorityLevel == 2}'>⭐ Ưu tiên trung bình - Mới nhất</c:when>
                                            <c:when test='${tier.priorityLevel == 3}'>📌 Ưu tiên cơ bản - Thường</c:when>
                                            <c:otherwise>Ưu tiên mức <b>${tier.priorityLevel}</b></c:otherwise>
                                        </c:choose>
                                    </span>
                                </li>
                                <c:if test='${tier.priorityLevel <= 2}'>
                                    <li class="flex items-start">
                                        <span class="
                                              <c:choose>
                                                  <c:when test='${tier.priorityLevel == 1}'>text-orange-500</c:when>
                                                  <c:when test='${tier.priorityLevel == 2}'>text-indigo-600</c:when>
                                              </c:choose> mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Hỗ trợ khách hàng ưu tiên 24/7</span>
                                    </li>
                                </c:if>
                                <c:if test='${tier.priorityLevel == 1}'>
                                    <li class="flex items-start">
                                        <span class="text-orange-500 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Tất cả tính năng cao cấp</span>
                                    </li>
                                    <li class="flex items-start">
                                        <span class="text-orange-500 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Không giới hạn đăng tin</span>
                                    </li>
                                    <li class="flex items-start">
                                        <span class="text-orange-500 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Đặc quyền Diamond VIP</span>
                                    </li>
                                </c:if>
                                <c:if test='${tier.priorityLevel == 2}'>
                                    <li class="flex items-start">
                                        <span class="text-indigo-600 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Tính năng nâng cao</span>
                                    </li>
                                    <li class="flex items-start">
                                        <span class="text-indigo-600 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Đăng tin ưu tiên</span>
                                    </li>
                                </c:if>
                                <c:if test='${tier.priorityLevel == 3}'>
                                    <li class="flex items-start">
                                        <span class="text-teal-600 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Tính năng cơ bản</span>
                                    </li>
                                    <li class="flex items-start">
                                        <span class="text-teal-600 mr-3 mt-1">
                                            <i class='fas fa-check-circle text-lg'></i>
                                        </span>
                                        <span>Đăng tin thường</span>
                                    </li>
                                </c:if>
                            </ul>
                        </div>

                        <!-- Nút hành động -->
                        <div class='text-center'>
                            <c:choose>
                                <c:when test='${not empty currentTier && tier.tierId == currentTier.tierId}'>
                                    <span class='block gradient-bg text-white py-4 px-8 rounded-2xl font-semibold shadow-lg'>
                                        <i class='fas fa-check-circle mr-3'></i>Đang sử dụng
                                    </span>
                                </c:when>
                                <c:when test='${not empty currentTier && tier.priorityLevel < currentTier.priorityLevel}'>
                                    <button onclick='openUpgradeModal("${tier.tierId}", "${tier.tierName}", "${tier.price}")' 
                                            class='w-full py-4 px-8 btn-gradient text-white rounded-2xl font-semibold transition flex items-center justify-center'>
                                        <i class='fas fa-arrow-circle-up mr-3'></i>Nâng cấp ngay
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button 
                                        onclick='openPurchaseModal("${tier.tierId}", "${tier.tierName}", "${tier.price}")'
                                        class="w-full py-4 px-8 btn-gradient text-white font-semibold rounded-2xl shadow-lg transition flex items-center justify-center space-x-3">
                                        <i class="fas fa-shopping-cart text-xl"></i>
                                        <span class="text-lg">Mua ngay</span>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <jsp:include page='footer.jsp' />

        <!-- JavaScript xử lý modal -->
        <script>
            let currentTierPrice = 0;
            
            // Function to format descriptions with line breaks at periods
            function formatDescription(text) {
                if (!text) return '';
                
                // Split by periods and filter out empty strings
                const sentences = text.split('.').filter(sentence => sentence.trim().length > 0);
                
                // Join sentences with periods and line breaks
                return sentences.map(sentence => sentence.trim()).join('.<br>') + (sentences.length > 0 ? '.' : '');
            }
            
            // Initialize descriptions when page loads
            document.addEventListener('DOMContentLoaded', function() {
                // Format tier descriptions in cards
                const tierDescriptions = document.querySelectorAll('.tier-description');
                tierDescriptions.forEach(element => {
                    const description = element.getAttribute('data-description');
                    element.innerHTML = formatDescription(description);
                });
                
                // Format current tier description
                const currentTierDescription = document.querySelector('.current-tier-description');
                if (currentTierDescription) {
                    const description = currentTierDescription.getAttribute('data-description');
                    currentTierDescription.innerHTML = formatDescription(description);
                }
            });
            
            function openPurchaseModal(tierId, tierName, price) {
                document.getElementById('purchaseTierId').value = tierId;
                document.getElementById('purchaseTierName').textContent = tierName;
                currentTierPrice = parseFloat(price);
                updateTotalPrice();
                document.getElementById('purchaseModal').classList.remove('hidden');
            }
            function closePurchaseModal() {
                document.getElementById('purchaseModal').classList.add('hidden');
            }
            function openUpgradeModal(tierId, tierName, price) {
                document.getElementById('upgradeTierId').value = tierId;
                document.getElementById('upgradeTierName').textContent = tierName;
                document.getElementById('upgradeModal').classList.remove('hidden');
            }
            function closeUpgradeModal() {
                document.getElementById('upgradeModal').classList.add('hidden');
            }
            function updateTotalPrice() {
                const duration = parseInt(document.getElementById('duration').value);
                let discount = 0;
                if (duration === 3)
                    discount = 0.05;
                if (duration === 6)
                    discount = 0.10;
                if (duration === 12)
                    discount = 0.15;
                const total = currentTierPrice * duration * (1 - discount);
                document.getElementById('totalPrice').textContent = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(total);
            }
        </script>

        <!-- Modal cho mua gói -->
        <div id="purchaseModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center hidden backdrop-blur-lg">
            <div class="bg-white rounded-3xl shadow-2xl p-10 max-w-lg w-full mx-4 modal-content">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-3xl font-extrabold gradient-text">Mua Gói Thành Viên</h3>
                    <button type="button" onclick="closePurchaseModal()" class="text-gray-500 hover:text-gray-700 transition">
                        <i class="fas fa-times text-2xl"></i>
                    </button>
                </div>

                <form action="${pageContext.request.contextPath}/membership-action" method="post">
                    <input type="hidden" name="action" value="purchase">
                    <input type="hidden" name="tierId" id="purchaseTierId">

                    <div class="mb-6">
                        <div class="flex items-center justify-center bg-indigo-50 rounded-2xl p-6 mb-6">
                            <div class="w-20 h-20 bg-gradient-to-br from-indigo-600 to-pink-500 rounded-full flex items-center justify-center mr-4 shadow-md">
                                <i class="fas fa-crown text-white text-3xl"></i>
                            </div>
                            <div>
                                <p class="text-gray-500 text-sm">Bạn đang mua gói</p>
                                <h4 class="text-2xl font-bold text-gray-900" id="purchaseTierName">-</h4>
                            </div>
                        </div>
                    </div>

                    <div class="mb-6">
                        <label class="block text-gray-700 font-semibold mb-3">Chọn thời hạn</label>
                        <select id="duration" name="duration" onchange="updateTotalPrice()" class="w-full p-3 border border-gray-200 rounded-xl text-gray-700 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                            <option value="1">1 tháng</option>
                            <option value="3">3 tháng (Giảm 5%)</option>
                            <option value="6">6 tháng (Giảm 10%)</option>
                            <option value="12">12 tháng (Giảm 15%)</option>
                        </select>
                    </div>

                    <div class="mb-6">
                        <label class="block text-gray-700 font-semibold mb-3">Phương thức thanh toán</label>
                        <div class="grid grid-cols-1 gap-3">
                            <label class="flex items-center p-4 border border-gray-200 rounded-xl cursor-pointer bg-gray-50 hover:bg-gray-100 transition">
                                <input type="radio" name="paymentMethod" value="wallet" checked class="h-5 w-5 text-indigo-600">
                                <div class="ml-3">
                                    <span class="text-gray-800 font-semibold">Ví RentEz</span>
                                    <p class="text-sm text-gray-500">Thanh toán qua số dư ví</p>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="flex justify-between items-center p-5 rounded-2xl bg-gray-50 mb-6">
                        <span class="text-gray-700 font-semibold">Tổng cộng:</span>
                        <span class="text-2xl font-bold text-indigo-600" id="totalPrice">-</span>
                    </div>

                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="closePurchaseModal()" 
                                class="px-6 py-3 bg-gray-200 text-gray-700 rounded-xl hover:bg-gray-300 transition-all">
                            Hủy
                        </button>
                        <button type="submit" 
                                class="px-8 py-3 btn-gradient text-white font-semibold rounded-xl shadow-lg transition-all">
                            <i class="fas fa-shopping-cart mr-2"></i>Xác nhận mua
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal cho nâng cấp gói -->
        <div id="upgradeModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex items-center justify-center hidden backdrop-blur-lg">
            <div class="bg-white rounded-3xl shadow-xl p-10 max-w-lg w-full mx-4 modal-content">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-3xl font-extrabold gradient-text">Nâng cấp Gói Thành Viên</h3>
                    <button type="button" onclick="closeUpgradeModal()" class="text-gray-500 hover:text-gray-700 transition">
                        <i class="fas fa-times text-2xl"></i>
                    </button>
                </div>

                <form action="${pageContext.request.contextPath}/membership-action" method="post">
                    <input type="hidden" name="action" value="upgrade">
                    <input type="hidden" name="tierId" id="upgradeTierId">

                    <div class="mb-6">
                        <div class="flex items-center mb-4">
                            <div class="w-14 h-14 rounded-lg bg-gray-200 flex items-center justify-center">
                                <i class="fas fa-crown text-gray-400 text-xl"></i>
                            </div>
                            <div class="mx-4 text-gray-400">
                                <i class="fas fa-arrow-right text-2xl"></i>
                            </div>
                            <div class="w-16 h-16 rounded-xl bg-gradient-to-br from-indigo-600 to-pink-500 flex items-center justify-center">
                                <i class="fas fa-crown text-white text-2xl"></i>
                            </div>
                        </div>

                        <div class="bg-indigo-50 rounded-2xl p-5">
                            <p class="text-gray-600 mb-2">Bạn đang nâng cấp lên:</p>
                            <h4 class="text-2xl font-bold text-gray-900" id="upgradeTierName">-</h4>
                            <p class="text-sm text-indigo-500 mt-3"><i class="fas fa-info-circle mr-2"></i>Hệ thống sẽ tính phí nâng cấp dựa trên thời gian còn lại của gói hiện tại</p>
                        </div>
                    </div>

                    <div class="mb-6">
                        <label class="block text-gray-700 font-semibold mb-3">Phương thức thanh toán</label>
                        <div class="grid grid-cols-1 gap-3">
                            <label class="flex items-center p-4 border border-gray-200 rounded-xl cursor-pointer bg-gray-50 hover:bg-gray-100 transition">
                                <input type="radio" name="paymentMethod" value="wallet" checked class="h-5 w-5 text-indigo-600">
                                <div class="ml-3">
                                    <span class="text-gray-800 font-semibold">Ví RentEz</span>
                                    <p class="text-sm text-gray-500">Thanh toán qua số dư</p>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-3">
                        <button type="button" onclick="closeUpgradeModal()" 
                                class="px-6 py-3 bg-gray-200 text-gray-700 rounded-xl hover:bg-gray-300 transition">
                            Hủy
                        </button>
                        <button type="submit" 
                                class="px-8 py-3 btn-gradient text-white font-semibold rounded-xl shadow-md transition">
                            <i class="fas fa-arrow-up mr-2"></i>Xác nhận nâng cấp
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </body>
</html>