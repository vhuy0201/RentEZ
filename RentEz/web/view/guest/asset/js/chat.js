/**
 * Simple Chat System for RentEz
 * This file handles the client-side functionality of the chat system
 */

// Global variables
let currentConversation = {
    userId: null,
    propertyId: null
};

// Message polling interval (in milliseconds)
const MESSAGE_POLL_INTERVAL = 5000;
let messagePollingTimer = null;

// DOM ready function
document.addEventListener('DOMContentLoaded', function () {
    // Initialize chat
    initChat();
    
    // Set polling interval if not already set
    if (!window.MESSAGE_POLL_INTERVAL) {
        window.MESSAGE_POLL_INTERVAL = 5000; // Default to 5 seconds
    }
});

/**
 * Initialize the chat system
 */
function initChat() {
    // Get parameters from URL
    const urlParams = new URLSearchParams(window.location.search);
    const userId = urlParams.get('userId');
    const propertyId = urlParams.get('propertyId');
    
    // Set up event handlers
    setupEventHandlers();
    
    // Load conversation list
    loadConversationList();
    
    // If userId and propertyId are provided, load that conversation
    if (userId && propertyId) {
        loadConversation(userId, propertyId);
    }
}

/**
 * Set up event handlers for chat elements
 */
function setupEventHandlers() {
    // Send message form
    const messageForm = document.getElementById('message-form');
    if (messageForm) {
        messageForm.addEventListener('submit', function(e) {
            e.preventDefault();
            sendMessage();
        });
    }
    
    // Message input - enter to send, shift+enter for new line
    const messageInput = document.getElementById('message-input');
    if (messageInput) {
        messageInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    }
}

/**
 * Load the list of conversations for the current user
 */
function loadConversationList() {
    fetch(`${window.contextPath}/messages?action=getConversations`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                displayConversationList(data.conversations);
            } else {
                console.error('Error loading conversations:', data.error);
            }
        })
        .catch(error => {
            console.error('Failed to load conversations:', error);
        });
}

/**
 * Display the list of conversations
 */
function displayConversationList(conversations) {
    const conversationListElement = document.getElementById('conversation-list');
    if (!conversationListElement) return;
    
    // Clear the list
    conversationListElement.innerHTML = '';
    
    if (conversations.length === 0) {
        // Display empty state
        const emptyState = document.createElement('div');
        emptyState.className = 'empty-state';
        emptyState.innerHTML = `
            <div class="text-center p-4">
                <i class="fas fa-comments fa-3x text-muted"></i>
                <p class="mt-2">Bạn chưa có cuộc trò chuyện nào</p>
                <p class="small text-muted">Hãy liên hệ với chủ nhà để bắt đầu trò chuyện</p>
            </div>
        `;
        conversationListElement.appendChild(emptyState);
        return;
    }
    
    // Add each conversation to the list
    conversations.forEach(conversation => {
        const isSelected = currentConversation.userId == conversation.userId && 
                          currentConversation.propertyId == conversation.propertyId;
        
        const avatarSrc = conversation.avatar || `${window.contextPath}/view/guest/asset/img/default-avatar.png`;
        const propertyThumb = conversation.propertyThumbnail || `${window.contextPath}/view/guest/asset/img/property-placeholder.jpg`;
        
        const conversationItem = document.createElement('div');
        conversationItem.className = `conversation-item ${isSelected ? 'active' : ''} ${!conversation.isRead && !conversation.isSentByMe ? 'unread' : ''}`;
        conversationItem.setAttribute('data-user-id', conversation.userId);
        conversationItem.setAttribute('data-property-id', conversation.propertyId);
        
        const lastMessageTime = new Date(conversation.lastMessageTime);
        const timeString = formatTime(lastMessageTime);
        
        conversationItem.innerHTML = `
            <div class="conversation-avatar">
                <img src="${avatarSrc}" alt="${conversation.name}" onerror="this.src='${window.contextPath}/view/guest/asset/img/default-avatar.png'">
            </div>
            <div class="conversation-info">
                <div class="conversation-name">${conversation.name}</div>
                <div class="property-title">${conversation.propertyTitle}</div>
                <div class="conversation-last-message">
                    ${conversation.isSentByMe ? '<span class="sent-by-me">Bạn: </span>' : ''}
                    ${conversation.lastMessage}
                </div>
            </div>
            <div class="conversation-meta">
                <div class="conversation-time">${timeString}</div>
                ${!conversation.isRead && !conversation.isSentByMe ? '<div class="unread-indicator"></div>' : ''}
            </div>
        `;
          // Add click event to load conversation
        conversationItem.addEventListener('click', () => {
            // Remove active class from all conversation items
            document.querySelectorAll('.conversation-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Add active class to selected conversation
            conversationItem.classList.add('active');
            
            // Remove unread indicator
            conversationItem.classList.remove('unread');
            conversationItem.querySelector('.unread-indicator')?.remove();
            
            // Load the conversation
            loadConversation(conversation.userId, conversation.propertyId);
        });
        
        conversationListElement.appendChild(conversationItem);
    });
}

/**
 * Load conversation between current user and the specified user for a property
 */
function loadConversation(userId, propertyId) {
    // Update the current conversation
    currentConversation.userId = userId;
    currentConversation.propertyId = propertyId;
    
    // Show loading state
    const chatMessagesElement = document.getElementById('chat-messages');
    if (chatMessagesElement) {
        chatMessagesElement.innerHTML = '<div class="text-center p-4"><div class="spinner-border text-primary" role="status"></div></div>';
    }
    
    // Show chat area if hidden
    const chatAreaElement = document.getElementById('chat-area');
    if (chatAreaElement) {
        chatAreaElement.classList.remove('d-none');
    }
    
    // Update the form's hidden fields
    document.getElementById('receiver-id').value = userId;
    document.getElementById('property-id').value = propertyId;
    
    // Fetch the conversation
    fetch(`${window.contextPath}/messages?action=getConversation&userId=${userId}&propertyId=${propertyId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Update the UI with the conversation
                displayConversation(data);
                
                // Set up polling for new messages
                setupMessagePolling();
            } else {
                console.error('Error loading conversation:', data.error);
            }
        })
        .catch(error => {
            console.error('Failed to load conversation:', error);
        });
}

/**
 * Display the conversation messages
 */
function displayConversation(data) {
    const chatMessagesElement = document.getElementById('chat-messages');
    const chatHeaderElement = document.getElementById('chat-header');
    
    if (!chatMessagesElement || !chatHeaderElement) return;
    
    // Update the chat header with user and property info
    if (data.user && data.property) {
        const avatarSrc = data.user.avatar || `${window.contextPath}/view/guest/asset/img/default-avatar.png`;
        const propertyThumb = data.property.thumbnail || `${window.contextPath}/view/guest/asset/img/property-placeholder.jpg`;
        
        chatHeaderElement.innerHTML = `
            <div class="chat-header-user">
                <img src="${avatarSrc}" alt="${data.user.name}" class="chat-header-avatar"
                     onerror="this.src='${window.contextPath}/view/guest/asset/img/default-avatar.png'">
                <div>
                    <div class="chat-header-name">${data.user.name}</div>
                    <div class="chat-header-property">
                        <img src="${propertyThumb}" class="property-thumbnail">
                        <span>${data.property.title}</span>
                    </div>
                </div>
            </div>
        `;
    }
    
    // Clear the chat messages
    chatMessagesElement.innerHTML = '';
    
    // If no messages, show empty state
    if (!data.messages || data.messages.length === 0) {
        chatMessagesElement.innerHTML = `
            <div class="empty-chat">
                <i class="fas fa-comments fa-3x"></i>
                <p>Chưa có tin nhắn nào</p>
                <p class="hint">Bắt đầu cuộc trò chuyện ngay bây giờ</p>
            </div>
        `;
        return;
    }
    
    // Group messages by date
    let currentDate = null;
    
    // Add each message to the chat
    data.messages.forEach((message, index) => {
        const isSentByMe = message.isSentByMe;
        const messageDate = new Date(message.sendDate);
        
        // Add date separator if this is a new date
        if (!currentDate || !isSameDay(currentDate, messageDate)) {
            currentDate = messageDate;
            const dateSeparator = document.createElement('div');
            dateSeparator.className = 'date-separator';
            dateSeparator.innerText = formatDate(messageDate);
            chatMessagesElement.appendChild(dateSeparator);
        }
        
        // Create message element
        const messageElement = document.createElement('div');
        messageElement.className = `message ${isSentByMe ? 'sent' : 'received'}`;
        messageElement.setAttribute('data-message-id', message.messageId);
        
        // Format the time
        const timeString = messageDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        
        messageElement.innerHTML = `
            <div class="message-content">
                ${message.content}
                <span class="message-time">${timeString}</span>
                ${isSentByMe ? `<i class="status-icon ${message.isRead ? 'fas fa-check-double' : 'fas fa-check'}"></i>` : ''}
            </div>
        `;
        
        chatMessagesElement.appendChild(messageElement);
    });
    
    // Scroll to bottom
    scrollToBottom();
}

/**
 * Send a new message
 */
function sendMessage() {
    const messageInput = document.getElementById('message-input');
    const receiverId = document.getElementById('receiver-id').value;
    const propertyId = document.getElementById('property-id').value;
    const messageContent = messageInput.value.trim();
    
    // Don't send empty messages
    if (!messageContent || !receiverId || !propertyId) {
        return;
    }
    
    // Clear input
    messageInput.value = '';
    
    // Create form data
    const formData = new FormData();
    formData.append('action', 'sendMessage');
    formData.append('receiverId', receiverId);
    formData.append('propertyId', propertyId);
    formData.append('content', messageContent);
    formData.append('isNegotiation', 'false');
    formData.append('isAjax', 'true');
    
    // Optimistically add message to UI
    const chatMessagesElement = document.getElementById('chat-messages');
    const tempId = 'temp-' + Date.now();
    const messageDate = new Date();
    const timeString = messageDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    
    // Check if we need to add a date separator
    const lastDateSeparator = chatMessagesElement.querySelector('.date-separator:last-of-type');
    let needsDateSeparator = true;
    
    if (lastDateSeparator) {
        const separatorText = lastDateSeparator.innerText;
        const separatorDate = parseDateString(separatorText);
        if (isSameDay(separatorDate, messageDate)) {
            needsDateSeparator = false;
        }
    }
    
    if (needsDateSeparator) {
        const dateSeparator = document.createElement('div');
        dateSeparator.className = 'date-separator';
        dateSeparator.innerText = formatDate(messageDate);
        chatMessagesElement.appendChild(dateSeparator);
    }
    
    const tempMessage = document.createElement('div');
    tempMessage.className = 'message sent sending';
    tempMessage.id = tempId;
    tempMessage.innerHTML = `
        <div class="message-content">
            ${messageContent}
            <span class="message-time">${timeString}</span>
            <i class="status-icon fas fa-clock"></i>
        </div>
    `;
    
    chatMessagesElement.appendChild(tempMessage);
    scrollToBottom();
    
    // Send the message to the server
    fetch(`${window.contextPath}/messages`, {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Update the temporary message with the real ID
                const tempElement = document.getElementById(tempId);
                if (tempElement) {
                    tempElement.id = '';
                    tempElement.classList.remove('sending');
                    tempElement.setAttribute('data-message-id', data.messageId);
                    tempElement.querySelector('.status-icon').className = 'status-icon fas fa-check';
                }
                
                // Refresh conversation list to show this as the most recent
                loadConversationList();
            } else {
                // Show error for the message
                const tempElement = document.getElementById(tempId);
                if (tempElement) {
                    tempElement.classList.add('error');
                    tempElement.querySelector('.status-icon').className = 'status-icon fas fa-exclamation-circle';
                    
                    // Add retry button
                    const retryButton = document.createElement('button');
                    retryButton.className = 'btn-retry';
                    retryButton.innerHTML = '<i class="fas fa-redo"></i>';
                    retryButton.addEventListener('click', function() {
                        tempElement.remove();
                        // Re-add the message to the input and focus it
                        messageInput.value = messageContent;
                        messageInput.focus();
                    });
                    
                    tempElement.querySelector('.message-content').appendChild(retryButton);
                }
                
                console.error('Error sending message:', data.error);
            }
        })
        .catch(error => {
            // Show error for the message
            const tempElement = document.getElementById(tempId);
            if (tempElement) {
                tempElement.classList.add('error');
                tempElement.querySelector('.status-icon').className = 'status-icon fas fa-exclamation-circle';
            }
            console.error('Failed to send message:', error);
        });
}

/**
 * Mark a message as read
 */
function markAsRead(messageId) {
    const formData = new FormData();
    formData.append('action', 'markAsRead');
    formData.append('messageId', messageId);
    formData.append('isAjax', 'true');
    
    fetch(`${window.contextPath}/messages`, {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (!data.success) {
                console.error('Error marking message as read:', data.error);
            }
        })
        .catch(error => {
            console.error('Failed to mark message as read:', error);
        });
}

/**
 * Set up polling for new messages
 */
function setupMessagePolling() {
    // Clear existing timer
    if (messagePollingTimer) {
        clearInterval(messagePollingTimer);
    }
    
    // Only set up polling if we have a current conversation
    if (!currentConversation.userId || !currentConversation.propertyId) {
        return;
    }
    
    // Set up new timer
    messagePollingTimer = setInterval(() => {
        // Only poll if the conversation is still active
        if (currentConversation.userId && currentConversation.propertyId) {
            pollForNewMessages();
        } else {
            clearInterval(messagePollingTimer);
        }
    }, MESSAGE_POLL_INTERVAL);
}

/**
 * Poll for new messages in the current conversation
 */
function pollForNewMessages() {
    // Get the most recent message ID in the current conversation
    const messages = document.querySelectorAll('.message[data-message-id]');
    let mostRecentMessageId = 0;
    
    messages.forEach(message => {
        const messageId = parseInt(message.getAttribute('data-message-id'));
        if (messageId > mostRecentMessageId) {
            mostRecentMessageId = messageId;
        }
    });
    
    // Fetch new messages
    fetch(`${window.contextPath}/messages?action=getConversation&userId=${currentConversation.userId}&propertyId=${currentConversation.propertyId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success && data.messages) {
                // Check if there are new messages
                let hasNewMessages = false;
                
                data.messages.forEach(message => {
                    if (message.messageId > mostRecentMessageId) {
                        hasNewMessages = true;
                    }
                });
                
                // If there are new messages, update the conversation
                if (hasNewMessages) {
                    displayConversation(data);
                    
                    // Also refresh the conversation list
                    loadConversationList();
                }
            }
        })
        .catch(error => {
            console.error('Failed to poll for new messages:', error);
        });
}

/**
 * Helper function to scroll the chat messages to the bottom
 */
function scrollToBottom() {
    const chatMessagesElement = document.getElementById('chat-messages');
    if (chatMessagesElement) {
        chatMessagesElement.scrollTop = chatMessagesElement.scrollHeight;
    }
}

/**
 * Format a date to display in the chat
 */
function formatDate(date) {
    const today = new Date();
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    
    if (isSameDay(date, today)) {
        return "Hôm nay";
    } else if (isSameDay(date, yesterday)) {
        return "Hôm qua";
    } else {
        return date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' });
    }
}

/**
 * Format a time to display in the chat
 */
function formatTime(date) {
    const today = new Date();
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    
    if (isSameDay(date, today)) {
        return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    } else if (isSameDay(date, yesterday)) {
        return "Hôm qua";
    } else {
        return date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit' });
    }
}

/**
 * Check if two dates are the same day
 */
function isSameDay(date1, date2) {
    return date1.getDate() === date2.getDate() &&
           date1.getMonth() === date2.getMonth() &&
           date1.getFullYear() === date2.getFullYear();
}

/**
 * Parse a date string from the format returned by formatDate
 */
function parseDateString(dateStr) {
    const today = new Date();
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    
    if (dateStr === "Hôm nay") {
        return today;
    } else if (dateStr === "Hôm qua") {
        return yesterday;
    } else {
        // Parse Vietnamese format DD/MM/YYYY
        const parts = dateStr.split('/');
        return new Date(parts[2], parts[1] - 1, parts[0]);
    }
}
