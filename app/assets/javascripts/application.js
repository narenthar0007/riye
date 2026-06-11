// Riye Construction Management System - Main JavaScript
// Simple version for asset pipeline compatibility

// Basic functionality without complex imports
document.addEventListener('DOMContentLoaded', function () {
    initializeNavigation();
    initializeFlashMessages();
    initializeFormEnhancements();
});

// Navigation functionality
function initializeNavigation() {
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');

    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function () {
            navMenu.classList.toggle('active');

            const icon = navToggle.querySelector('i');
            if (navMenu.classList.contains('active')) {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            } else {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });

        document.addEventListener('click', function (event) {
            if (!navToggle.contains(event.target) && !navMenu.contains(event.target)) {
                navMenu.classList.remove('active');
                const icon = navToggle.querySelector('i');
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });
    }
}

// Flash messages
function initializeFlashMessages() {
    const flashMessages = document.querySelectorAll('[data-flash]');

    flashMessages.forEach(flash => {
        setTimeout(() => {
            hideFlashMessage(flash);
        }, 5000);

        const closeButton = flash.querySelector('[data-flash-close]');
        if (closeButton) {
            closeButton.addEventListener('click', () => {
                hideFlashMessage(flash);
            });
        }
    });
}

function hideFlashMessage(flashElement) {
    flashElement.style.transform = 'translateY(-100%)';
    flashElement.style.opacity = '0';

    setTimeout(() => {
        if (flashElement.parentNode) {
            flashElement.parentNode.removeChild(flashElement);
        }
    }, 300);
}

// Form enhancements
function initializeFormEnhancements() {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function (e) {
            const submitButton = form.querySelector('input[type="submit"], button[type="submit"]');
            if (submitButton) {
                const originalText = submitButton.innerHTML || submitButton.value;

                if (submitButton.tagName === 'INPUT') {
                    submitButton.value = 'Processing...';
                } else {
                    submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                }

                submitButton.disabled = true;

                setTimeout(() => {
                    if (submitButton.tagName === 'INPUT') {
                        submitButton.value = originalText;
                    } else {
                        submitButton.innerHTML = originalText;
                    }
                    submitButton.disabled = false;
                }, 10000);
            }
        });
    });
}

// Search functionality for tables
if (document.getElementById('searchWorkers')) {
    const searchInput = document.getElementById('searchWorkers');
    const tableRows = document.querySelectorAll('tbody tr');

    searchInput.addEventListener('input', function () {
        const searchTerm = this.value.toLowerCase();

        tableRows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm) || searchTerm === '') {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
}
