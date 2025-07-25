<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>RentEz - Chi tiết hợp đồng #${booking.bookingId}</title>

        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png" />

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />

        <!-- Google Fonts for Vietnamese support -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'orange': {
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
                        },
                        fontFamily: {
                            'sans': ['Inter', 'Roboto', 'system-ui', 'sans-serif'],
                        }
                    }
                }
            }
        </script>
        
        <style>
            .contract-document {
                font-family: 'Times New Roman', serif;
                line-height: 1.8;
            }

            .contract-document h1 {
                font-weight: bold;
                text-align: center;
                margin-bottom: 1rem;
            }

            .contract-document h3 {
                font-weight: bold;
                margin-top: 1.5rem;
                margin-bottom: 0.75rem;
            }

            .contract-buttons {
                display: flex;
                gap: 0.5rem;
                margin-bottom: 1rem;
                padding: 1rem;
                background-color: #f9fafb;
                border-radius: 0.5rem;
            }

            .contract-buttons button {
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.15s ease-in-out;
                border: none;
                cursor: pointer;
            }

            .btn-print {
                background-color: #059669;
                color: white;
            }

            .btn-print:hover {
                background-color: #047857;
            }

            .btn-download {
                background-color: #dc2626;
                color: white;
            }

            .btn-download:hover {
                background-color: #b91c1c;
            }

            .btn-back {
                background-color: #6b7280;
                color: white;
            }

            .btn-back:hover {
                background-color: #4b5563;
            }

            @media print {
                .contract-buttons {
                    display: none;
                }

                .contract-document {
                    font-size: 12pt;
                    line-height: 1.5;
                }

                .contract-document h1 {
                    font-size: 16pt;
                }

                .contract-document h3 {
                    font-size: 14pt;
                }
            }

            .status-badge {
                font-size: 0.75rem;
                font-weight: 500;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
            }

            .status-pending {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-confirmed {
                background-color: #d1fae5;
                color: #065f46;
            }

            .status-completed {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .status-cancelled {
                background-color: #fee2e2;
                color: #991b1b;
            }
        </style>
    </head>
    <body class="bg-gray-50 font-sans">
        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Main Container -->
        <div class="min-h-screen bg-gray-50 py-8">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                
                <!-- Action Buttons -->
                <div class="contract-buttons">
                    <button onclick="history.back()" class="btn-back">
                        <i class="bi bi-arrow-left mr-1"></i>
                        Quay lại
                    </button>
                    <button onclick="printContract()" class="btn-print">
                        <i class="bi bi-printer mr-1"></i>
                        In hợp đồng
                    </button>
                    <button onclick="downloadContract()" class="btn-download">
                        <i class="bi bi-download mr-1"></i>
                        Tải xuống PDF
                    </button>
                </div>
                
                <!-- Contract Document -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden">
                    <div class="contract-document p-8">
                        <!-- Contract Header -->
                        <div class="text-center mb-8">
                            <h1 class="text-3xl font-bold mb-4">HỢP ĐỒNG THUÊ NHÀ NGUYÊN CĂN</h1>
                            <p class="italic mb-2">Căn cứ vào khả năng, nhu cầu của hai bên:</p>
                            <p>Hôm nay, ngày <fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy" />, chúng tôi gồm có:</p>
                        </div>

                        <!-- Party A - Landlord -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">BÊN CHO THUÊ NHÀ (Gọi tắt là Bên A):</h3>
                            <div class="ml-4 space-y-2">
                                <div class="flex">
                                    <span class="w-24 font-medium">Ông/Bà:</span>
                                    <span class="flex-1 border-b border-dotted border-gray-400 px-2">${landlord.name}</span>
                                </div>
                                <div class="flex">
                                    <span class="w-24 font-medium">Email:</span>
                                    <span class="flex-1 border-b border-dotted border-gray-400 px-2">${landlord.email}</span>
                                </div>
                                <div class="flex">
                                    <span class="w-24 font-medium">Số điện thoại:</span>
                                    <span class="flex-1 border-b border-dotted border-gray-400 px-2">
                                        <c:choose>
                                            <c:when test="${not empty landlord.phone}">
                                                ${landlord.phone}
                                            </c:when>
                                            <c:otherwise>
                                                .......................................................................................................
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Party B - Renter -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">BÊN THUÊ NHÀ (Gọi tắt là Bên B):</h3>
                            <div class="ml-4 space-y-2">
                                <div class="flex">
                                    <span class="w-24 font-medium">Ông/Bà:</span>
                                    <span class="flex-1 border-b border-dotted border-gray-400 px-2">${renter.name}</span>
                                </div>
                                <div class="flex">
                                    <span class="w-24 font-medium">Email:</span>
                                    <span class="flex-1 border-b border-dotted border-gray-400 px-2">${renter.email}</span>
                                </div>
                                <div class="flex">
                                    <span class="w-24 font-medium">Số điện thoại:</span>
                                    <span class="flex-1 border-b border-dotted border-gray-400 px-2">
                                        <c:choose>
                                            <c:when test="${not empty renter.phone}">
                                                ${renter.phone}
                                            </c:when>
                                            <c:otherwise>
                                                .......................................................................................................
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <p class="mb-6 text-justify">
                            Sau khi thỏa thuận, hai bên đồng ý tham gia và ký kết hợp đồng thuê nhà với các điều khoản sau đây:
                        </p>

                        <!-- Article 1 -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">ĐIỀU 1: DIỆN TÍCH VÀ THỜI GIAN THUÊ</h3>
                            <div class="ml-4 space-y-3">
                                <p class="text-justify">1.1 Bên A đồng ý cho Bên B thuê toàn bộ ngôi nhà <strong>"${property.title}"</strong> 
                                tọa lạc tại địa chỉ: <strong>${location.address}, ${location.city}, ${location.stateProvince}</strong> 
                                với các đặc điểm sau:</p>
                                <div class="ml-8 space-y-1">
                                    <p>- Diện tích: <strong>${property.size} m²</strong></p>
                                    <p>- Loại hình: <strong>${propertyType.typeName}</strong></p>
                                    <p>- Số phòng ngủ: <strong>${property.numberOfBedrooms}</strong></p>
                                    <p>- Số phòng tắm: <strong>${property.numberOfBathrooms}</strong></p>
                                    <p>- Kết cấu: Nhà nguyên căn đầy đủ tiện nghi</p>
                                </div>
                                <p class="text-justify">1.2 Mục đích thuê: <strong>Để ở</strong></p>
                                <p class="text-justify">1.3 Bên thuê được quyền sử dụng toàn bộ ngôi nhà cùng tất cả trang thiết bị, không gian, tài sản của Bên cho thuê.</p>
                                <p class="text-justify">1.4 Bên B không được chuyển nhượng, cầm cố, thế chấp, hoặc cho bên thứ ba thuê lại căn nhà.</p>
                                <p class="text-justify">1.5 Thời gian cho thuê: Bắt đầu từ ngày: <strong><fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /></strong> 
                                và sẽ chấm dứt vào ngày: <strong><fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" /></strong></p>
                            </div>
                        </div>

                        <!-- Article 2 -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">ĐIỀU 2: GIÁ THUÊ VÀ PHƯƠNG THỨC THANH TOÁN</h3>
                            <div class="ml-4 space-y-3">
                                <p class="text-justify">2.1 Giá thuê toàn bộ căn nhà trên mỗi tháng là: 
                                <strong><fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" /></strong>, 
                                giá thuê này chưa bao gồm các chi phí điện, nước, internet.</p>
                                <p class="text-justify">2.2 Tiền thuê nhà phải được thanh toán vào đầu mỗi tháng, chậm nhất là ngày 05 của tháng đó.</p>
                                <p class="text-justify">2.3 Tiền đặt cọc nhằm đảm bảo cho hợp đồng thuê là: 
                                <strong><fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" /></strong>, 
                                được thanh toán một lần khi hai bên ký hợp đồng thuê nhà.</p>
                                <p class="text-justify">2.4 Số tiền đặt cọc sẽ được Bên A hoàn lại toàn bộ cho Bên B khi hết hạn hợp đồng và Bên B đã hoàn trả nhà ở tình trạng ban đầu.</p>
                                <p class="text-justify">2.5 Tổng giá trị hợp đồng: 
                                <strong><fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" /></strong></p>
                            </div>
                        </div>

                        <!-- Article 3 -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">ĐIỀU 3: QUYỀN VÀ NGHĨA VỤ CỦA CÁC BÊN</h3>
                            <div class="ml-4 space-y-2">
                                <p><strong>3.1 Quyền và nghĩa vụ của Bên A (Chủ nhà):</strong></p>
                                <div class="ml-4 space-y-1">
                                    <p>- Được nhận tiền thuê nhà đúng hạn theo thỏa thuận</p>
                                    <p>- Được kiểm tra tình trạng nhà ở định kỳ với sự thống nhất của Bên B</p>
                                    <p>- Phải đảm bảo quyền sử dụng nhà ở của Bên B trong thời gian hợp đồng</p>
                                    <p>- Phải sửa chữa các hư hỏng do thiên tai, hỏa hoạn (không do lỗi của Bên B)</p>
                                    <p>- Không được tự ý tăng giá thuê trong thời gian hợp đồng</p>
                                </div>
                                <p><strong>3.2 Quyền và nghĩa vụ của Bên B (Người thuê):</strong></p>
                                <div class="ml-4 space-y-1">
                                    <p>- Được sử dụng nhà ở theo đúng mục đích và thời hạn đã thỏa thuận</p>
                                    <p>- Được yêu cầu Bên A sửa chữa những hư hỏng không do lỗi của mình</p>
                                    <p>- Phải thanh toán tiền thuê nhà đúng hạn theo thỏa thuận</p>
                                    <p>- Phải bảo quản tài sản, trang thiết bị của Bên A</p>
                                    <p>- Phải hoàn trả nhà đúng tình trạng ban đầu khi hết hạn hợp đồng</p>
                                    <p>- Phải chịu trách nhiệm về các hư hỏng do lỗi của mình gây ra</p>
                                </div>
                            </div>
                        </div>

                        <!-- Article 4 -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">ĐIỀU 4: ĐIỀU KHOẢN CHUNG</h3>
                            <div class="ml-4 space-y-2">
                                <p class="text-justify">4.1 Hai bên cam kết thực hiện đúng và đầy đủ các điều khoản đã thỏa thuận.</p>
                                <p class="text-justify">4.2 Trong quá trình thực hiện nếu có vướng mắc, hai bên sẽ cùng nhau thỏa thuận giải quyết trên tinh thần hợp tác.</p>
                                <p class="text-justify">4.3 Hợp đồng này có hiệu lực kể từ ngày ký và chấm dứt vào ngày hết hạn.</p>
                                <p class="text-justify">4.4 Hợp đồng được lập thành 02 bản có giá trị pháp lý như nhau, mỗi bên giữ 01 bản.</p>
                            </div>
                        </div>

                        <!-- Article 5 -->
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-3">ĐIỀU 5: ĐIỀU KHOẢN VÀ ĐIỀU KIỆN ĐẶC BIỆT</h3>
                            <div class="ml-4 space-y-3">
                                <c:if test="${not empty booking.termsAndConditions}">
                                    <div>
                                        <p class="font-semibold mb-2">5.1 Điều khoản và điều kiện:</p>
                                        <div class="ml-4 p-4 bg-gray-50 rounded-lg border-l-4 border-blue-500">
                                            <p class="text-justify whitespace-pre-line">${booking.termsAndConditions}</p>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty booking.penaltyClause}">
                                    <div>
                                        <p class="font-semibold mb-2">5.2 Điều khoản phạt và vi phạm:</p>
                                        <div class="ml-4 p-4 bg-red-50 rounded-lg border-l-4 border-red-500">
                                            <p class="text-justify whitespace-pre-line">${booking.penaltyClause}</p>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <c:if test="${empty booking.termsAndConditions and empty booking.penaltyClause}">
                                    <div class="ml-4 p-4 bg-gray-100 rounded-lg">
                                        <p class="text-gray-600 italic">Không có điều khoản đặc biệt nào được quy định trong hợp đồng này.</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Contract Info Section -->
                        <div class="mt-8 p-6 bg-gray-50 rounded-lg">
                            <h4 class="font-bold text-xl mb-4 text-gray-800">Thông tin hợp đồng #${booking.bookingId}</h4>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div class="space-y-2">
                                    <p><span class="font-medium">Ngày tạo hợp đồng:</span> <fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm" /></p>
                                    <p><span class="font-medium">Trạng thái:</span> 
                                        <span class="status-badge status-${booking.status.toLowerCase()}">${booking.status}</span>
                                    </p>
                                    <p><span class="font-medium">Thời gian thuê:</span> 
                                        <fmt:formatDate value="${booking.startDate}" pattern="dd/MM/yyyy" /> - 
                                        <fmt:formatDate value="${booking.endDate}" pattern="dd/MM/yyyy" />
                                    </p>
                                    <p><span class="font-medium">Trạng thái ký:</span></p>
                                    <div class="ml-4 space-y-1">
                                        <p class="text-sm ${booking.signedByLandlord ? 'text-green-600' : 'text-gray-500'}">
                                            <i class="bi ${booking.signedByLandlord ? 'bi-check-circle-fill' : 'bi-clock'} mr-1"></i>
                                            Chủ nhà: ${booking.signedByLandlord ? 'Đã ký' : 'Chưa ký'}
                                        </p>
                                        <p class="text-sm ${booking.signedByRenter ? 'text-green-600' : 'text-gray-500'}">
                                            <i class="bi ${booking.signedByRenter ? 'bi-check-circle-fill' : 'bi-clock'} mr-1"></i>
                                            Người thuê: ${booking.signedByRenter ? 'Đã ký' : 'Chưa ký'}
                                        </p>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <p><span class="font-medium">Tiền thuê hàng tháng:</span> 
                                        <fmt:formatNumber value="${booking.monthlyRent}" type="currency" currencySymbol="₫" />
                                    </p>
                                    <p><span class="font-medium">Tiền đặt cọc:</span> 
                                        <fmt:formatNumber value="${booking.depositAmount}" type="currency" currencySymbol="₫" />
                                    </p>
                                    <p><span class="font-medium">Tổng giá trị:</span> 
                                        <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₫" />
                                    </p>
                                    <p><span class="font-medium">Diện tích:</span> ${property.size} m²</p>
                                    <p><span class="font-medium">Loại hình:</span> ${propertyType.typeName}</p>
                                </div>
                            </div>
                        </div>

                        <!-- Signature Section -->
                        <div class="mt-12 grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div class="text-center">
                                <p class="font-bold mb-16 text-lg">BÊN CHO THUÊ NHÀ</p>
                                <p class="italic mb-2">(Ký và ghi rõ họ tên)</p>
                                <div class="mt-8 pt-2 border-t border-gray-300">
                                    <p class="font-medium text-lg">${landlord.name}</p>
                                </div>
                            </div>
                            <div class="text-center">
                                <p class="font-bold mb-16 text-lg">BÊN THUÊ NHÀ</p>
                                <p class="italic mb-2">(Ký và ghi rõ họ tên)</p>
                                <div class="mt-8 pt-2 border-t border-gray-300">
                                    <p class="font-medium text-lg">${renter.name}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Print contract
            function printContract() {
                window.print();
            }

            // Download contract as PDF (placeholder)
            function downloadContract() {
                alert('Tính năng tải xuống PDF đang được phát triển. Hiện tại bạn có thể sử dụng chức năng in để lưu thành PDF.');
            }
        </script>
    </body>
</html>
