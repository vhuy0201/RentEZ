// Add Font Awesome if not already included
if (!document.getElementById('fontawesome-css')) {
    var fontAwesome = document.createElement('link');
    fontAwesome.id = 'fontawesome-css';
    fontAwesome.rel = 'stylesheet';
    fontAwesome.href = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css';
    document.head.appendChild(fontAwesome);
}    // Enhanced dropdown behavior 
document.addEventListener('DOMContentLoaded', function () {
    var userDropdown = document.querySelector('.user-dropdown');
    var dropdownMenu = document.querySelector('.user-dropdown__menu');
    var dropdownToggle = document.querySelector('.user-dropdown__toggle');
    if (userDropdown && dropdownMenu) {
// For touchscreen devices - support tap
        if (dropdownToggle) {
            dropdownToggle.addEventListener('click', function (e) {
                if ('ontouchstart' in window || window.innerWidth < 992) {
                    if (dropdownMenu.style.visibility === 'visible') {
                        dropdownMenu.style.visibility = 'hidden';
                        dropdownMenu.style.opacity = '0';
                    } else {
                        dropdownMenu.style.visibility = 'visible';
                        dropdownMenu.style.opacity = '1';
                        dropdownMenu.style.display = 'block';
                    }
                    e.stopPropagation();
                }
            });
        }

// Close the dropdown when clicking outside
        document.addEventListener('click', function (e) {
            if (!e.target.closest('.user-dropdown')) {
                dropdownMenu.style.visibility = 'hidden';
                dropdownMenu.style.opacity = '0';
            }
        });
    }
});
