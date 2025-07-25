<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <h6 class="text-muted mb-2">Thông tin người gửi</h6>
            <div class="card border-0 bg-light">
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <strong>Họ tên:</strong><br>
                            <span>${message.fullName}</span>
                        </div>
                        <div class="col-6">
                            <strong>Email:</strong><br>
                            <a href="mailto:${message.email}" class="text-decoration-none">${message.email}</a>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-6">
                            <strong>Điện thoại:</strong><br>
                            <c:if test="${not empty message.phone}">
                                <a href="tel:${message.phone}" class="text-decoration-none">${message.phone}</a>
                            </c:if>
                            <c:if test="${empty message.phone}">
                                <span class="text-muted">Không có</span>
                            </c:if>
                        </div>
                        <div class="col-6">
                            <strong>Ngày gửi:</strong><br>
                            <fmt:formatDate value="${message.createdAt}" pattern="dd/MM/yyyy 'lúc' HH:mm"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <h6 class="text-muted mb-2">Thông tin tin nhắn</h6>
            <div class="card border-0 bg-light">
                <div class="card-body">
                    <div class="mb-3">
                        <strong>Chủ đề:</strong><br>
                        <span class="badge 
                            ${message.subject == 'complaint' ? 'bg-danger' : 
                              message.subject == 'business' ? 'bg-success' :
                              message.subject == 'support' ? 'bg-warning text-dark' :
                              'bg-info'} fs-6">
                            ${message.subjectDisplayText}
                        </span>
                    </div>
                    <div>
                        <strong>Đồng ý chính sách bảo mật:</strong><br>
                        <c:if test="${message.privacyPolicyAccepted}">
                            <span class="badge bg-success"><i class="fas fa-check me-1"></i>Đã đồng ý</span>
                        </c:if>
                        <c:if test="${!message.privacyPolicyAccepted}">
                            <span class="badge bg-danger"><i class="fas fa-times me-1"></i>Chưa đồng ý</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-12">
            <h6 class="text-muted mb-2">Nội dung tin nhắn</h6>
            <div class="card border-0 bg-light">
                <div class="card-body">
                    <div class="message-content">
                        ${message.message}
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-12">
            <h6 class="text-muted mb-2">Thao tác</h6>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary" onclick="replyToMessage('${message.email}', '${message.fullName}', '${message.subjectDisplayText}')">
                    <i class="fas fa-reply me-2"></i>Trả lời qua Email
                </button>
                <c:if test="${not empty message.phone}">
                    <button type="button" class="btn btn-success" onclick="callContact('${message.phone}')">
                        <i class="fas fa-phone me-2"></i>Gọi điện
                    </button>
                </c:if>
                <button type="button" class="btn btn-danger" onclick="deleteFromModal(${message.messageID})">
                    <i class="fas fa-trash me-2"></i>Xóa tin nhắn
                </button>
            </div>
        </div>
    </div>
</div>

<style>
.message-content {
    white-space: pre-wrap;
    word-wrap: break-word;
    line-height: 1.6;
    max-height: 300px;
    overflow-y: auto;
    padding: 1rem;
    background: white;
    border-radius: 8px;
    border: 1px solid #e9ecef;
}
</style>

<script>
function replyToMessage(email, fullName, subject) {
    const mailtoLink = `mailto:${email}?subject=Re: ${subject} - RentEz&body=Chào ${fullName},%0D%0A%0D%0AChúng tôi đã nhận được tin nhắn của bạn về "${subject}".%0D%0A%0D%0AXin cảm ơn bạn đã liên hệ với RentEz.%0D%0A%0D%0ATrân trọng,%0D%0AĐội ngũ hỗ trợ RentEz`;
    window.open(mailtoLink, '_blank');
}

function callContact(phone) {
    window.open(`tel:${phone}`, '_self');
}

function deleteFromModal(messageId) {
    if (confirm('Bạn có chắc chắn muốn xóa tin nhắn này?')) {
        fetch(`${window.location.origin}/RentEz/admin/contact-messages?action=delete&id=` + messageId, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
            if (data.success) {
                // Close modal and reload page
                bootstrap.Modal.getInstance(document.getElementById('messageModal')).hide();
                location.reload();
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Có lỗi xảy ra khi xóa tin nhắn.');
        });
    }
}
</script>
