/**
 * RentEz Notification System
 * This script handles the real-time notification functionality for the application.
 */

// Global notification variables
let notificationCheckInterval = 30000; // Check for new notifications every 30 seconds
let notificationIntervalId = null;
let lastNotificationCount = 0;

/**
 * Initialize the notification system
 */
function initNotificationSystem() {
    // Only initialize if user is logged in (check for notification bell)
    const notificationBell = document.querySelector('.notification-bell');
    if (!notificationBell) return;
    
    // Start notification polling
    startNotificationPolling();
    
    // Add event listeners
    setupNotificationEvents();
}

/**
 * Start polling for new notifications
 */
function startNotificationPolling() {
    // Initial check immediately
    checkForNewNotifications();
    
    // Set interval for checking
    notificationIntervalId = setInterval(checkForNewNotifications, notificationCheckInterval);
}

/**
 * Stop notification polling
 */
function stopNotificationPolling() {
    if (notificationIntervalId) {
        clearInterval(notificationIntervalId);
        notificationIntervalId = null;
    }
}

/**
 * Check for new notifications
 */
function checkForNewNotifications() {
    fetch(`${window.contextPath}/notifications?action=getCount`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => {
        updateNotificationBadge(data.count);
        
        // If new notifications arrived, show notification
        if (lastNotificationCount > 0 && data.count > lastNotificationCount) {
            showNotificationToast();
        }
        
        lastNotificationCount = data.count;
    })
    .catch(error => console.error('Error checking notifications:', error));
}

/**
 * Update the notification badge count
 */
function updateNotificationBadge(count) {
    const badge = document.querySelector('.notification-badge');
    const menuBadge = document.querySelector('.user-menu .badge');
    
    // Update header icon badge
    if (count > 0) {
        if (badge) {
            badge.textContent = count;
        } else {
            // Create new badge if it doesn't exist
            const notificationIcon = document.querySelector('.notification-icon');
            if (notificationIcon) {
                const newBadge = document.createElement('span');
                newBadge.className = 'notification-badge';
                newBadge.textContent = count;
                notificationIcon.appendChild(newBadge);
            }
        }
    } else if (badge) {
        badge.remove();
    }
    
    // Update dropdown menu badge
    if (menuBadge) {
        if (count > 0) {
            menuBadge.textContent = count;
            menuBadge.style.display = 'inline';
        } else {
            menuBadge.style.display = 'none';
        }
    }
}

/**
 * Show a toast notification for new messages
 */
function showNotificationToast() {
    // Check if Bootstrap is available
    if (typeof bootstrap !== 'undefined' && bootstrap.Toast) {
        // Create toast element if it doesn't exist
        let toastContainer = document.getElementById('notification-toast-container');
        
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'notification-toast-container';
            toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
            document.body.appendChild(toastContainer);
        }
        
        // Create a new toast
        const toastEl = document.createElement('div');
        toastEl.className = 'toast';
        toastEl.setAttribute('role', 'alert');
        toastEl.setAttribute('aria-live', 'assertive');
        toastEl.setAttribute('aria-atomic', 'true');
        
        toastEl.innerHTML = `
            <div class="toast-header">
                <i class="fas fa-bell me-2 text-warning"></i>
                <strong class="me-auto">RentEz</strong>
                <small>Vừa mới</small>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                Bạn có thông báo mới. <a href="${window.contextPath}/notifications">Nhấn vào đây để xem</a>.
            </div>
        `;
        
        toastContainer.appendChild(toastEl);
        
        const toast = new bootstrap.Toast(toastEl, {
            autohide: true,
            delay: 5000
        });
        
        toast.show();
        
        // Remove the toast element after it's hidden
        toastEl.addEventListener('hidden.bs.toast', function() {
            toastEl.remove();
        });
    } else {
        // Simple notification if Bootstrap is not available
        const notificationSound = new Audio(`${window.contextPath}/view/guest/asset/sound/notification.mp3`);
        notificationSound.play().catch(error => console.log('Error playing notification sound'));
    }
}

/**
 * Set up event listeners for notifications
 */
function setupNotificationEvents() {
    // Mark as read when clicking on a notification
    document.addEventListener('click', function(e) {
        const markAsReadBtn = e.target.closest('button[title="Đánh dấu đã đọc"]');
        if (markAsReadBtn) {
            const form = markAsReadBtn.closest('form');
            if (form) {
                e.preventDefault();
                
                // Get notification ID
                const notificationId = form.querySelector('input[name="notificationId"]').value;
                
                // Send AJAX request to mark as read
                fetch(`${window.contextPath}/notifications`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: `action=markAsRead&notificationId=${notificationId}&isAjax=true`,
                    credentials: 'same-origin'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Update UI to reflect read status
                        const card = markAsReadBtn.closest('.notification-card');
                        if (card) {
                            card.classList.remove('unread');
                            markAsReadBtn.style.display = 'none';
                        }
                        
                        // Check for new count of unread notifications
                        checkForNewNotifications();
                    }
                })
                .catch(error => console.error('Error marking notification as read:', error));
            }
        }
    });
}

// Set the context path for API calls
window.contextPath = window.location.pathname.split('/')[1] === 'RentEz' ? '/RentEz' : '';

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', initNotificationSystem);
