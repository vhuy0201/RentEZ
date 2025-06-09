<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng tin mới - RentEz</title>
        <link rel="shortcut icon" href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css"/>
        <style>
            body {
                background: #f5f7fa;
                font-family: 'Inter', Arial, sans-serif;
            }
            .sidebar {
                background: linear-gradient(135deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                min-height: 100vh;
                border-radius: 0 2rem 2rem 0;
                box-shadow: 0 0 2rem #0001;
            }
            .sidebar a {
                color: #fff;
                font-weight: 500;
                border-radius: 0.5rem;
                margin-bottom: 0.25rem;
                transition: background 0.2s;
            }
            .sidebar .active, .sidebar a:hover {
                background: rgba(255,255,255,0.12);
            }
            .account-avatar {
                width: 64px;
                height: 64px;
                background: linear-gradient(135deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                font-weight: bold;
                box-shadow: 0 2px 8px #0002;
            }
            .header {
                background: #fff;
                color: #1a1f2a;
                border-radius: 1rem;
                box-shadow: 0 2px 12px #0001;
            }
            .card {
                border-radius: 1rem;
                border: none;
                box-shadow: 0 2px 12px #0001;
                background: #fff;
            }
            .btn-main {
                background: linear-gradient(90deg, #8556f0 0%, #439beb 100%);
                color: #fff;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                transition: background 0.2s;
            }
            .btn-main:hover {
                background: linear-gradient(90deg, #439beb 0%, #8556f0 100%);
            }
            .section-heading__title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #1a1f2a;
            }
            .section-heading__subtitle {
                font-size: 1rem;
                color: #8556f0;
                font-weight: 600;
            }
            .nav-link {
                padding: 0.75rem 1rem;
            }
            .error {
                color: red;
                margin-bottom: 10px;
            }
            .success {
                color: green;
                margin-bottom: 10px;
            }
            .location-form label {
                margin-top: 8px;
            }
            .location-form input {
                margin-bottom: 8px;
            }
            .location-form {
                padding: 10px;
                border: 1px dashed #999;
                margin-top: 10px;
                background-color: #f9f9f9;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <aside class="col-md-2 d-none d-md-block sidebar py-4">
                    <div class="text-center mb-4">
                        <div class="account-avatar mx-auto mb-2">T</div>
                        <div><strong>Dũng Trần</strong></div>
                        <div class="small">0 điểm</div>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/HomeServlet"><i class="fas fa-home me-2"></i>Trang chủ</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/landLordHomeServlet"><i class="fas fa-tachometer-alt me-2"></i>Tổng quan</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="${pageContext.request.contextPath}/viewProperties"><i class="fas fa-list me-2"></i>Quản lý tin đăng</a></li>
                        <li class="nav-item w-100"><a class="nav-link active" href="${pageContext.request.contextPath}/addProperty"><i class="fas fa-plus me-2"></i>Đăng tin</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-user-friends me-2"></i>Khách hàng</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-gem me-2"></i>Gói hội viên</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-wallet me-2"></i>Quản lý tài chính</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-cog me-2"></i>Cài đặt tài khoản</a></li>
                        <li class="nav-item w-100"><a class="nav-link" href="#"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                    </ul>
                </aside>

                <!-- Main content -->
                <main class="col-md-10 ms-sm-auto px-md-4">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="card p-4 mb-4">
                                <h4 class="mb-4">Thông tin bất động sản</h4>
                                <c:if test="${not empty error}">
                                    <div class="error">${error}</div>
                                </c:if>
                                <c:if test="${not empty message}">
                                    <div class="success">${message}</div>
                                </c:if>
                                <form action="addProperty" method="post" enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Title:</label>
                                        <input type="text" id="title" name="title" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description:</label>
                                        <textarea id="description" name="description" rows="4" class="form-control" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="typeId" class="form-label">Type of property:</label>
                                        <select id="typeId" name="typeId" class="form-select" required>
                                            <option value="">-- Select Type --</option>
                                            <option value="1">Apartment</option>
                                            <option value="2">House</option>
                                            <option value="3">Condo</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="location">Location:</label>
                                        <div class="mb-3 location-form">
                                            <label for="address" class="form-label">Address:</label>
                                            <input type="text" id="address" name="address" class="form-control" required>
                                            <label for="city" class="form-label">City:</label>
                                            <input type="text" id="city" name="city" class="form-control" required>
                                            <label for="stateProvince" class="form-label">State Province:</label>
                                            <input type="text" id="stateProvince" name="stateProvince" class="form-control" required>
                                            <label for="country" class="form-label">Country:</label>
                                            <input type="text" id="country" name="country" class="form-control" required>
                                            <label for="ZipCode" class="form-label">ZipCode:</label>
                                            <input type="text" id="ZipCode" name="ZipCode" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price: (VNĐ)</label>
                                        <input type="number" id="price" name="price" step="0.01" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="size" class="form-label">Size (m²):</label>
                                        <input type="number" id="size" name="size" step="0.01" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="numberOfBedrooms" class="form-label">Number of Bedrooms:</label>
                                        <input type="number" id="numberOfBedrooms" name="numberOfBedrooms" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="numberOfBathrooms" class="form-label">Number of Bathrooms:</label>
                                        <input type="number" id="numberOfBathrooms" name="numberOfBathrooms" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="availabilityStatus" class="form-label">Availability Status:</label>
                                        <select id="availabilityStatus" name="availabilityStatus" class="form-select" required>
                                            <option value="Available">Available</option>
                                            <option value="Rented">Rented</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="priorityLevel" class="form-label">Priority Level:</label>
                                        <input type="number" id="priorityLevel" name="priorityLevel" class="form-control" required>
                                    </div>
                                    <div class="mb-3 text-end">
                                        <input type="submit" value="Add Property" class="btn btn-main px-4">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <jsp:include page="/view/common/footer.jsp" />
        <script src="${pageContext.request.contextPath}/view/guest/asset/js/boostrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/view/landlord/asset/js/fontAwesome.js"></script>
    </body>
</html>