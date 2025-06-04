<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - RentEz</title>
     <link
      rel="shortcut icon"
      href="https://cityscape.wowtheme7.com/assets/images/logo/favicon.png"
    />
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/bootstrap.min.css" />
    <!-- Font awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/fontawesome-all.min.css" />
    <!-- Line awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/line-awesome.min.css" />
    <!-- Main stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/guest/asset/css/index-CUmDp7cY.css" />
    
    <style>
        .profile-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 0 15px;
        }
        
        .profile-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .profile-header {
            background: var(--gradient-one);
            padding: 30px;
            color: #000;
            text-align: center;
            position: relative;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid #fff;
            margin: 0 auto 15px;
            overflow: hidden;
            background: #fff;
        }
        
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-tabs {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        
        .profile-tabs .nav-link {
            color: #495057;
            border: none;
            border-bottom: 3px solid transparent;
            border-radius: 0;
            padding: 15px 25px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .profile-tabs .nav-link.active {
            color: #212529;
            border-bottom-color: var(--primary-color);
            background-color: transparent;
        }
        
        .profile-content {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: 500;
        }
        
        .btn-action {
            padding: 10px 20px;
            font-weight: 500;
        }
        
        .password-requirements {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .requirements-list {
            margin-top: 5px;
            padding-left: 20px;
        }
        
        .requirements-list li {
            margin-bottom: 3px;
        }
        
        .label-with-icon {
            display: flex;
            align-items: center;
        }
        
        .label-with-icon i {
            margin-right: 8px;
            color: var(--primary-color);
        }
        
        .text-success {
            color: #28a745;
        }
        
        .text-danger {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div id="root">
        <main class="body-bg">
            <jsp:include page="/view/common/header.jsp" />
            
            <div class="container profile-container">
                <div class="profile-card">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <img src="${pageContext.request.contextPath}/view/guest/asset/img/default-avatar.png" alt="${sessionScope.user.name}" />
                        </div>
                        <h3>${sessionScope.user.name}</h3>
                        <p>${sessionScope.user.email}</p>
                    </div>
                    
                    <ul class="nav nav-tabs profile-tabs" id="profileTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="edit-profile-tab" data-bs-toggle="tab" data-bs-target="#edit-profile" type="button" role="tab">
                                <i class="fas fa-user-edit me-2"></i>Edit Profile
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="change-password-tab" data-bs-toggle="tab" data-bs-target="#change-password" type="button" role="tab">
                                <i class="fas fa-key me-2"></i>Change Password
                            </button>
                        </li>
                    </ul>
                    
                    <div class="tab-content profile-content" id="profileTabsContent">
                        <!-- Edit Profile Tab -->
                        <div class="tab-pane fade show active" id="edit-profile" role="tabpanel" aria-labelledby="edit-profile-tab">
                            <c:if test="${not empty profileMessage}">
                                <div class="alert alert-${profileMessageType} alert-dismissible fade show" role="alert">
                                    ${profileMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/profile" method="post">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="name" class="form-label label-with-icon">
                                                <i class="fas fa-user"></i>Full Name
                                            </label>
                                            <input type="text" class="form-control" id="name" name="name" value="${sessionScope.user.name}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="email" class="form-label label-with-icon">
                                                <i class="fas fa-envelope"></i>Email Address
                                            </label>
                                            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" readonly>
                                            <small class="form-text text-muted">Email cannot be changed for security reasons.</small>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="phone" class="form-label label-with-icon">
                                                <i class="fas fa-phone"></i>Phone Number
                                            </label>
                                            <input type="tel" class="form-control" id="phone" name="phone" value="${sessionScope.user.phone}" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="role" class="form-label label-with-icon">
                                                <i class="fas fa-user-tag"></i>Role
                                            </label>
                                            <input type="text" class="form-control" id="role" value="${sessionScope.user.role}" readonly>
                                            <small class="form-text text-muted">Contact support to change your role.</small>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="address" class="form-label label-with-icon">
                                                <i class="fas fa-map-marker-alt"></i>Address
                                            </label>
                                            <textarea class="form-control" id="address" name="address" rows="3" required>${sessionScope.user.address}</textarea>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-primary btn-action">
                                        <i class="fas fa-save me-2"></i>Save Changes
                                    </button>
                                </div>
                                
                                <input type="hidden" name="action" value="updateProfile">
                            </form>
                        </div>
                        
                        <!-- Change Password Tab -->
                        <div class="tab-pane fade" id="change-password" role="tabpanel" aria-labelledby="change-password-tab">
                            <c:if test="${not empty passwordMessage}">
                                <div class="alert alert-${passwordMessageType} alert-dismissible fade show" role="alert">
                                    ${passwordMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/profile" method="post" id="changePasswordForm">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="currentPassword" class="form-label label-with-icon">
                                                <i class="fas fa-lock"></i>Current Password
                                            </label>
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="newPassword" class="form-label label-with-icon">
                                                <i class="fas fa-key"></i>New Password
                                            </label>
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                            <div class="password-requirements">
                                                Password must contain:
                                                <ul class="requirements-list">
                                                    <li id="length">At least 8 characters</li>
                                                    <li id="uppercase">At least one uppercase letter</li>
                                                    <li id="lowercase">At least one lowercase letter</li>
                                                    <li id="number">At least one number</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="confirmPassword" class="form-label label-with-icon">
                                                <i class="fas fa-check-double"></i>Confirm New Password
                                            </label>
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                            <div id="passwordMatch" class="form-text"></div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-primary btn-action">
                                        <i class="fas fa-key me-2"></i>Change Password
                                    </button>
                                </div>
                                
                                <input type="hidden" name="action" value="changePassword">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <jsp:include page="/view/common/footer.jsp" />
        </main>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Password validation
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const lengthReq = document.getElementById('length');
            const uppercaseReq = document.getElementById('uppercase');
            const lowercaseReq = document.getElementById('lowercase');
            const numberReq = document.getElementById('number');
            const passwordMatch = document.getElementById('passwordMatch');
            
            function validatePassword() {
                const password = newPassword.value;
                
                // Check length
                if (password.length >= 8) {
                    lengthReq.classList.add('text-success');
                    lengthReq.classList.remove('text-danger');
                } else {
                    lengthReq.classList.add('text-danger');
                    lengthReq.classList.remove('text-success');
                }
                
                // Check uppercase
                if (/[A-Z]/.test(password)) {
                    uppercaseReq.classList.add('text-success');
                    uppercaseReq.classList.remove('text-danger');
                } else {
                    uppercaseReq.classList.add('text-danger');
                    uppercaseReq.classList.remove('text-success');
                }
                
                // Check lowercase
                if (/[a-z]/.test(password)) {
                    lowercaseReq.classList.add('text-success');
                    lowercaseReq.classList.remove('text-danger');
                } else {
                    lowercaseReq.classList.add('text-danger');
                    lowercaseReq.classList.remove('text-success');
                }
                
                // Check number
                if (/\d/.test(password)) {
                    numberReq.classList.add('text-success');
                    numberReq.classList.remove('text-danger');
                } else {
                    numberReq.classList.add('text-danger');
                    numberReq.classList.remove('text-success');
                }
            }
            
            function checkPasswordMatch() {
                if (confirmPassword.value === newPassword.value) {
                    passwordMatch.textContent = "Passwords match";
                    passwordMatch.className = "form-text text-success";
                } else {
                    passwordMatch.textContent = "Passwords do not match";
                    passwordMatch.className = "form-text text-danger";
                }
            }
            
            if (newPassword) {
                newPassword.addEventListener('keyup', validatePassword);
                newPassword.addEventListener('keyup', checkPasswordMatch);
            }
            
            if (confirmPassword) {
                confirmPassword.addEventListener('keyup', checkPasswordMatch);
            }
            
            // Form validation
            const changePasswordForm = document.getElementById('changePasswordForm');
            if (changePasswordForm) {
                changePasswordForm.addEventListener('submit', function(event) {
                    const password = newPassword.value;
                    const confirmPwd = confirmPassword.value;
                    
                    // Validate password criteria
                    if (password.length < 8 || !/[A-Z]/.test(password) || !/[a-z]/.test(password) || !/\d/.test(password)) {
                        alert('Please ensure your password meets all the requirements');
                        event.preventDefault();
                        return;
                    }
                    
                    // Check passwords match
                    if (password !== confirmPwd) {
                        alert('Passwords do not match');
                        event.preventDefault();
                        return;
                    }
                });
            }
            
            // Handle tab activation based on URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const tab = urlParams.get('tab');
            
            if (tab === 'changePassword') {
                const passwordTab = document.getElementById('change-password-tab');
                if (passwordTab) {
                    passwordTab.click();
                }
            }
        });
    </script>
</body>
</html>
