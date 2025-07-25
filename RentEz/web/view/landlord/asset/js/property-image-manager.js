/**
 * Property Image Management JavaScript
 * Handles multiple image upload, preview, and management for properties
 */

class PropertyImageManager {
    constructor() {
        this.maxImages = 10; // Maximum number of images allowed
        this.maxFileSize = 10 * 1024 * 1024; // 10MB per file
        this.allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
        this.imageCounter = 0;
        this.selectedFiles = [];
        
        this.initializeEventListeners();
    }

    initializeEventListeners() {
        // Avatar upload
        const avatarInput = document.getElementById('propertyAvatar');
        if (avatarInput) {
            avatarInput.addEventListener('change', (e) => this.handleAvatarUpload(e));
        }

        // Multiple images upload
        const imagesInput = document.getElementById('propertyImages');
        if (imagesInput) {
            imagesInput.addEventListener('change', (e) => this.handleMultipleImageUpload(e));
        }

        // Drag and drop
        const dropZone = document.getElementById('imageDropZone');
        if (dropZone) {
            dropZone.addEventListener('dragover', (e) => this.handleDragOver(e));
            dropZone.addEventListener('dragleave', (e) => this.handleDragLeave(e));
            dropZone.addEventListener('drop', (e) => this.handleDrop(e));
        }
    }

    /**
     * Handle avatar image upload (single image)
     */
    handleAvatarUpload(event) {
        const file = event.target.files[0];
        if (!file) return;

        if (!this.validateFile(file)) {
            event.target.value = '';
            return;
        }

        this.showAvatarPreview(file);
    }

    /**
     * Handle multiple images upload
     */
    handleMultipleImageUpload(event) {
        const files = Array.from(event.target.files);
        this.processMultipleFiles(files);
    }

    /**
     * Process multiple files for upload
     */
    processMultipleFiles(files) {
        const container = document.getElementById('imagePreviewContainer');
        if (!container) return;

        // Check total number of images
        const currentImages = container.querySelectorAll('.image-preview-item').length;
        if (currentImages + files.length > this.maxImages) {
            this.showMessage(`Chỉ được phép tải lên tối đa ${this.maxImages} ảnh`, 'error');
            return;
        }

        files.forEach(file => {
            if (this.validateFile(file)) {
                this.selectedFiles.push(file);
                this.createImagePreview(file);
            }
        });

        this.updateImageCounter();
    }

    /**
     * Validate file type and size
     */
    validateFile(file) {
        // Check file type
        if (!this.allowedTypes.includes(file.type)) {
            this.showMessage('Chỉ chấp nhận file ảnh (JPEG, PNG, GIF, WebP)', 'error');
            return false;
        }

        // Check file size
        if (file.size > this.maxFileSize) {
            this.showMessage(`File quá lớn. Kích thước tối đa: ${this.maxFileSize / (1024 * 1024)}MB`, 'error');
            return false;
        }

        return true;
    }

    /**
     * Show avatar preview
     */
    showAvatarPreview(file) {
        const previewContainer = document.getElementById('avatarPreviewContainer');
        if (!previewContainer) return;

        const reader = new FileReader();
        reader.onload = (e) => {
            previewContainer.innerHTML = `
                <div class="avatar-preview">
                    <img src="${e.target.result}" alt="Avatar Preview" class="img-fluid rounded">
                    <div class="avatar-preview-overlay">
                        <button type="button" class="btn btn-danger btn-sm" onclick="propertyImageManager.removeAvatarPreview()">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            `;
        };
        reader.readAsDataURL(file);
    }

    /**
     * Create image preview for multiple images
     */
    createImagePreview(file) {
        const container = document.getElementById('imagePreviewContainer');
        if (!container) return;

        const reader = new FileReader();
        reader.onload = (e) => {
            const imageId = `image_${this.imageCounter++}`;
            const imageItem = document.createElement('div');
            imageItem.className = 'image-preview-item';
            imageItem.setAttribute('data-image-id', imageId);
            
            imageItem.innerHTML = `
                <div class="image-preview">
                    <img src="${e.target.result}" alt="Preview" class="img-fluid">
                    <div class="image-preview-overlay">
                        <button type="button" class="btn btn-danger btn-sm" onclick="propertyImageManager.removeImage('${imageId}')">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                    <div class="image-info">
                        <small class="text-muted">${file.name}</small>
                        <br>
                        <small class="text-muted">${this.formatFileSize(file.size)}</small>
                    </div>
                </div>
            `;

            container.appendChild(imageItem);
        };
        reader.readAsDataURL(file);
    }

    /**
     * Remove avatar preview
     */
    removeAvatarPreview() {
        const previewContainer = document.getElementById('avatarPreviewContainer');
        const avatarInput = document.getElementById('propertyAvatar');
        
        if (previewContainer) {
            previewContainer.innerHTML = '';
        }
        
        if (avatarInput) {
            avatarInput.value = '';
        }
    }

    /**
     * Remove image from preview
     */
    removeImage(imageId) {
        const imageItem = document.querySelector(`[data-image-id="${imageId}"]`);
        if (imageItem) {
            // Find and remove the file from selectedFiles array
            const fileName = imageItem.querySelector('.image-info small').textContent;
            this.selectedFiles = this.selectedFiles.filter(file => file.name !== fileName);
            
            imageItem.remove();
            this.updateImageCounter();
        }
    }

    /**
     * Remove existing property image (for edit mode)
     */
    removeExistingImage(imageId) {
        if (!confirm('Bạn có chắc chắn muốn xóa ảnh này?')) {
            return;
        }

        fetch('/RentEz/propertyImage?action=delete&imageId=' + imageId, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const imageItem = document.querySelector(`[data-existing-id="${imageId}"]`);
                if (imageItem) {
                    imageItem.remove();
                }
                this.showMessage('Xóa ảnh thành công', 'success');
            } else {
                this.showMessage('Lỗi xóa ảnh: ' + data.message, 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            this.showMessage('Lỗi kết nối khi xóa ảnh', 'error');
        });
    }

    /**
     * Handle drag over event
     */
    handleDragOver(event) {
        event.preventDefault();
        event.currentTarget.classList.add('drag-over');
    }

    /**
     * Handle drag leave event
     */
    handleDragLeave(event) {
        event.preventDefault();
        event.currentTarget.classList.remove('drag-over');
    }

    /**
     * Handle drop event
     */
    handleDrop(event) {
        event.preventDefault();
        event.currentTarget.classList.remove('drag-over');
        
        const files = Array.from(event.dataTransfer.files);
        this.processMultipleFiles(files);
    }

    /**
     * Update image counter display
     */
    updateImageCounter() {
        const counter = document.getElementById('imageCounter');
        if (counter) {
            const currentCount = this.selectedFiles.length;
            counter.textContent = `${currentCount}/${this.maxImages} ảnh`;
            
            if (currentCount >= this.maxImages) {
                counter.classList.add('text-warning');
            } else {
                counter.classList.remove('text-warning');
            }
        }
    }

    /**
     * Format file size for display
     */
    formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    /**
     * Show message to user
     */
    showMessage(message, type = 'info') {
        // Create or update message container
        let messageContainer = document.getElementById('messageContainer');
        if (!messageContainer) {
            messageContainer = document.createElement('div');
            messageContainer.id = 'messageContainer';
            messageContainer.style.position = 'fixed';
            messageContainer.style.top = '20px';
            messageContainer.style.right = '20px';
            messageContainer.style.zIndex = '9999';
            document.body.appendChild(messageContainer);
        }

        const alertClass = type === 'error' ? 'alert-danger' : 
                          type === 'success' ? 'alert-success' : 'alert-info';

        const messageDiv = document.createElement('div');
        messageDiv.className = `alert ${alertClass} alert-dismissible fade show`;
        messageDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;

        messageContainer.appendChild(messageDiv);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (messageDiv.parentNode) {
                messageDiv.remove();
            }
        }, 5000);
    }

    /**
     * Load existing property images (for edit mode)
     */
    loadExistingImages(propertyId) {
        fetch(`/RentEz/propertyImage?action=view&propertyId=${propertyId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                this.displayExistingImages(data.images);
            }
        })
        .catch(error => {
            console.error('Error loading existing images:', error);
        });
    }

    /**
     * Display existing property images
     */
    displayExistingImages(images) {
        const container = document.getElementById('existingImagesContainer');
        if (!container) return;

        container.innerHTML = '';

        images.forEach(image => {
            const imageItem = document.createElement('div');
            imageItem.className = 'existing-image-item';
            imageItem.setAttribute('data-existing-id', image.imageId);
            
            imageItem.innerHTML = `
                <div class="image-preview">
                    <img src="${image.imageURL}" alt="Property Image" class="img-fluid">
                    <div class="image-preview-overlay">
                        <button type="button" class="btn btn-danger btn-sm" onclick="propertyImageManager.removeExistingImage(${image.imageId})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            `;

            container.appendChild(imageItem);
        });
    }
}

// Initialize the property image manager when the page loads
let propertyImageManager;
document.addEventListener('DOMContentLoaded', function() {
    propertyImageManager = new PropertyImageManager();
    
    // Load existing images if in edit mode
    const propertyId = document.querySelector('input[name="propertyId"]');
    if (propertyId && propertyId.value) {
        propertyImageManager.loadExistingImages(propertyId.value);
    }
});
