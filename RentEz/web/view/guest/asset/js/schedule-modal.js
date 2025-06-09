/**
 * Schedule Viewing Modal Functionality
 */
document.addEventListener('DOMContentLoaded', function() {
    console.log("Schedule modal script loaded");
    
    // Give bootstrap a moment to fully load (especially if loaded from CDN)
    setTimeout(function() {
        initializeScheduleModal();
    }, 500);
});

function initializeScheduleModal() {
    try {
        // Initialize the modal
        const modalElement = document.getElementById('scheduleViewingModal');
        if (!modalElement) {
            console.error("Modal element not found");
            return;
        }
        
        console.log("Found modal element:", modalElement);
        
        // Make sure Bootstrap is loaded
        if (typeof bootstrap === 'undefined') {
            console.error("Bootstrap is not loaded. Loading from CDN...");
            loadBootstrapFromCDN(initializeScheduleModal);
            return;
        }
        
        // Create modal instance
        try {
            window.scheduleModal = new bootstrap.Modal(modalElement);
            console.log("Modal initialized successfully");
        } catch (error) {
            console.error("Error initializing Bootstrap modal:", error);
            return;
        }
        
        // Initialize date picker min date
        const scheduleDateInput = document.getElementById('scheduleDate');
        if (scheduleDateInput) {
            const today = new Date();
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0'); // Months are 0-based
            const dd = String(today.getDate()).padStart(2, '0');
            scheduleDateInput.min = `${yyyy}-${mm}-${dd}`;
            console.log("Set min date:", scheduleDateInput.min);
        }
        
        // Set up the button click handler
        const openModalBtn = document.getElementById('openScheduleModalBtn');
        if (openModalBtn) {
            openModalBtn.addEventListener('click', function(event) {
                event.preventDefault();
                event.stopPropagation();
                console.log("Button clicked, showing modal");
                window.scheduleModal.show();
            });
            console.log("Added click handler to button");
        } else {
            console.error("Modal open button not found");
        }
        
        // Set up form validation
        setupFormValidation(scheduleDateInput);
        
        // Handle messages from server after form submission
        handleServerMessages();
        
    } catch (error) {
        console.error("Error in initializeScheduleModal:", error);
    }
}

function setupFormValidation(scheduleDateInput) {
    const scheduleForm = document.querySelector('#scheduleViewingModal form');
    const submitBtn = document.getElementById('scheduleSubmitBtn');
    const submitSpinner = document.getElementById('scheduleSpinner');
    const submitBtnText = document.getElementById('submitBtnText');
    const scheduleTimeInput = document.getElementById('scheduleTime');
    
    if (scheduleForm) {
        scheduleForm.addEventListener('submit', function(event) {
            let isValid = true;
            
            // Validate the date input
            if (scheduleDateInput) {
                const dateValue = scheduleDateInput.value;
                if (!dateValue || dateValue === '') {
                    event.preventDefault();
                    scheduleDateInput.classList.add('is-invalid');
                    isValid = false;
                } else {
                    scheduleDateInput.classList.remove('is-invalid');
                    
                    const selectedDate = new Date(dateValue);
                    const currentDate = new Date();
                    currentDate.setHours(0, 0, 0, 0); // Reset time part for date comparison
                    
                    if (selectedDate < currentDate) {
                        event.preventDefault();
                        scheduleDateInput.classList.add('is-invalid');
                        showToast('Không thể chọn ngày trong quá khứ');
                        isValid = false;
                    }
                }
            }
            
            // Validate time input
            if (scheduleTimeInput) {
                const timeValue = scheduleTimeInput.value;
                if (!timeValue || timeValue === '') {
                    event.preventDefault();
                    scheduleTimeInput.classList.add('is-invalid');
                    isValid = false;
                } else {
                    scheduleTimeInput.classList.remove('is-invalid');
                    
                    // Check if the selected time is within business hours (8:00 AM to 8:00 PM)
                    const [hours, minutes] = timeValue.split(':').map(Number);
                    if (hours < 8 || hours > 20 || (hours === 20 && minutes > 0)) {
                        event.preventDefault();
                        scheduleTimeInput.classList.add('is-invalid');
                        showToast('Vui lòng chọn thời gian từ 8:00 sáng đến 8:00 tối');
                        isValid = false;
                    }
                    
                    // If today is selected, make sure the time is in the future
                    if (scheduleDateInput && scheduleDateInput.value) {
                        const selectedDate = new Date(scheduleDateInput.value);
                        const currentDate = new Date();
                        if (selectedDate.getDate() === currentDate.getDate() && 
                            selectedDate.getMonth() === currentDate.getMonth() && 
                            selectedDate.getFullYear() === currentDate.getFullYear()) {
                            
                            const currentHour = currentDate.getHours();
                            const currentMinute = currentDate.getMinutes();
                            
                            if (hours < currentHour || (hours === currentHour && minutes <= currentMinute)) {
                                event.preventDefault();
                                scheduleTimeInput.classList.add('is-invalid');
                                showToast('Vui lòng chọn thời gian trong tương lai');
                                isValid = false;
                            }
                        }
                    }
                }
            }
            
            if (!isValid) {
                return false;
            }
            
            // Show loading spinner and disable button during submission
            if (submitBtn && submitSpinner && submitBtnText) {
                submitBtn.disabled = true;
                submitSpinner.classList.remove('d-none');
                submitBtnText.textContent = 'Đang xử lý...';
            }
            
            // Form is valid, allow submission
            return true;
        });
    }
      // Reset form when modal is hidden
    const scheduleModal = document.getElementById('scheduleViewingModal');
    if (scheduleModal) {
        scheduleModal.addEventListener('hidden.bs.modal', function() {
            if (scheduleForm) scheduleForm.reset();
            if (scheduleDateInput) scheduleDateInput.classList.remove('is-invalid');
            if (scheduleTimeInput) scheduleTimeInput.classList.remove('is-invalid');
            if (submitBtn) submitBtn.disabled = false;
            if (submitSpinner) submitSpinner.classList.add('d-none');
            if (submitBtnText) submitBtnText.textContent = 'Xác nhận';
        });
    }
}

function handleServerMessages() {
    const urlParams = new URLSearchParams(window.location.search);
    const scheduleMessage = urlParams.get('scheduleMessage');
    
    if (scheduleMessage) {
        // Display a toast notification
        showToast(decodeURIComponent(scheduleMessage));
        
        // Clean the URL - remove scheduleMessage parameter
        const url = new URL(window.location.href);
        url.searchParams.delete('scheduleMessage');
        window.history.replaceState({}, document.title, url.toString());
    }
}

function loadBootstrapFromCDN(callback) {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js';
    script.integrity = 'sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4';
    script.crossOrigin = 'anonymous';
    script.onload = callback;
    document.head.appendChild(script);
}

function showToast(message) {
    // Remove any existing toasts
    const existingToasts = document.querySelectorAll('.toast-container');
    existingToasts.forEach(t => {
        if (document.body.contains(t)) {
            document.body.removeChild(t);
        }
    });
    
    // Create toast container
    const toastContainer = document.createElement('div');
    toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
    toastContainer.style.zIndex = '5';
    
    // Create toast HTML
    const isSuccess = message.toLowerCase().includes('thành công') || 
                     (!message.toLowerCase().includes('thất bại') && 
                     !message.toLowerCase().includes('lỗi') && 
                     !message.toLowerCase().includes('không'));
    
    const borderColor = isSuccess ? 'success' : 'danger';
    const iconType = isSuccess ? 'check-circle-fill' : 'exclamation-triangle-fill';
    
    const toastContent = `
        <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header border-${borderColor} border-bottom">
                <i class="bi bi-${iconType} me-2 text-${borderColor}"></i>
                <strong class="me-auto">Thông báo</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        </div>
    `;
    
    toastContainer.innerHTML = toastContent;
    document.body.appendChild(toastContainer);
    
    // Initialize Bootstrap toast if available
    const toastElement = toastContainer.querySelector('.toast');
    if (toastElement) {
        try {
            if (typeof bootstrap !== 'undefined') {
                const bsToast = new bootstrap.Toast(toastElement, {
                    autohide: true,
                    delay: 5000
                });
            }
        } catch (error) {
            console.error("Error initializing toast:", error);
        }
        
        // Remove from DOM after 5 seconds anyway
        setTimeout(() => {
            if (document.body.contains(toastContainer)) {
                document.body.removeChild(toastContainer);
            }
        }, 5000);
        
        // Handle close button
        const closeButton = toastElement.querySelector('.btn-close');
        if (closeButton) {
            closeButton.addEventListener('click', () => {
                if (document.body.contains(toastContainer)) {
                    document.body.removeChild(toastContainer);
                }
            });
        }
    }
}

// Function to manually open the modal from outside
function openScheduleModal() {
    console.log("Manual open modal function called");
    if (window.scheduleModal) {
        window.scheduleModal.show();
    } else {
        console.error("Modal not initialized yet. Initializing...");
        initializeScheduleModal();
        setTimeout(() => {
            if (window.scheduleModal) {
                window.scheduleModal.show();
            } else {
                alert("Không thể mở form đặt lịch. Vui lòng thử lại sau.");
            }
        }, 500);
    }
}
