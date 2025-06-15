
document.addEventListener('DOMContentLoaded', function () {
    // Handle success message display
    const successMessage = document.getElementById('successMessage');
    if (successMessage) {
        successMessage.classList.add('show');
        setTimeout(function () {
            successMessage.classList.remove('show');
            setTimeout(function () {
                successMessage.remove();
            }, 500);
        }, 3000);
        fetch('${pageContext.request.contextPath}/cleanupSession', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'attribute=successMessage'
        }).catch(error => console.error('Error cleaning session:', error));
    }
});
