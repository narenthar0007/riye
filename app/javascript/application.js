// Riye Construction Management System - Main JavaScript
// Modern interactive features and animations

// Import Turbo and Stimulus
import "@hotwired/turbo-rails"
import "controllers"

// =================== DOCUMENT READY =================== //
document.addEventListener('DOMContentLoaded', function () {
    initializeNavigation();
    initializeFlashMessages();
    initializeFormEnhancements();
    initializeLoadingStates();
    initializeAnimations();
    initializeInteractiveElements();
});

// =================== NAVIGATION FUNCTIONALITY =================== //
function initializeNavigation() {
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');

    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function () {
            navMenu.classList.toggle('active');

            // Animate hamburger icon
            const icon = navToggle.querySelector('i');
            if (navMenu.classList.contains('active')) {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            } else {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });

        // Close menu when clicking outside
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

// =================== FLASH MESSAGES =================== //
function initializeFlashMessages() {
    const flashMessages = document.querySelectorAll('[data-flash]');

    flashMessages.forEach(flash => {
        // Auto-hide after 5 seconds
        setTimeout(() => {
            hideFlashMessage(flash);
        }, 5000);

        // Manual close button
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

// Show new flash message programmatically
function showFlashMessage(message, type = 'notice') {
    const flash = document.createElement('div');
    flash.className = `flash flash-${type}`;
    flash.setAttribute('data-flash', '');

    flash.innerHTML = `
        <div class="flash-content">
            <i class="fas fa-${type === 'notice' ? 'check-circle' : 'exclamation-triangle'}"></i>
            <span>${message}</span>
            <button class="flash-close" data-flash-close>
                <i class="fas fa-times"></i>
            </button>
        </div>
    `;

    const container = document.querySelector('.content-container');
    if (container) {
        container.insertBefore(flash, container.firstChild);

        // Initialize close functionality for new flash
        const closeButton = flash.querySelector('[data-flash-close]');
        closeButton.addEventListener('click', () => {
            hideFlashMessage(flash);
        });

        // Auto-hide after 5 seconds
        setTimeout(() => {
            hideFlashMessage(flash);
        }, 5000);
    }
}

// =================== FORM ENHANCEMENTS =================== //
function initializeFormEnhancements() {
    // Add loading states to forms
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

                // Re-enable after 10 seconds as fallback
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

    // Enhanced input interactions
    const inputs = document.querySelectorAll('input, textarea, select');
    inputs.forEach(input => {
        // Add floating label effect
        input.addEventListener('focus', function () {
            this.parentElement.classList.add('input-focused');
        });

        input.addEventListener('blur', function () {
            this.parentElement.classList.remove('input-focused');
            if (this.value) {
                this.parentElement.classList.add('input-has-value');
            } else {
                this.parentElement.classList.remove('input-has-value');
            }
        });

        // Check initial value
        if (input.value) {
            input.parentElement.classList.add('input-has-value');
        }
    });
}

// =================== LOADING STATES =================== //
function initializeLoadingStates() {
    const loadingOverlay = document.getElementById('loadingOverlay');

    // Show loading on Turbo navigation
    document.addEventListener('turbo:visit', () => {
        showLoading();
    });

    document.addEventListener('turbo:load', () => {
        hideLoading();
    });
}

function showLoading() {
    const loadingOverlay = document.getElementById('loadingOverlay');
    if (loadingOverlay) {
        loadingOverlay.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
}

function hideLoading() {
    const loadingOverlay = document.getElementById('loadingOverlay');
    if (loadingOverlay) {
        loadingOverlay.style.display = 'none';
        document.body.style.overflow = '';
    }
}

// =================== ANIMATIONS =================== //
function initializeAnimations() {
    // Intersection Observer for scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-slide-in-up');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Observe cards and tables
    const elementsToAnimate = document.querySelectorAll('.card, .table-container, .btn');
    elementsToAnimate.forEach(el => {
        observer.observe(el);
    });
}

// =================== INTERACTIVE ELEMENTS =================== //
function initializeInteractiveElements() {
    // Button click effects
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('click', function (e) {
            // Ripple effect
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.cssText = `
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: scale(0);
                animation: ripple 0.6s linear;
                left: ${x}px;
                top: ${y}px;
                width: ${size}px;
                height: ${size}px;
            `;

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });

    // Table row hover effects
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach(row => {
        row.addEventListener('mouseenter', function () {
            this.style.transform = 'scale(1.01)';
            this.style.zIndex = '1';
        });

        row.addEventListener('mouseleave', function () {
            this.style.transform = 'scale(1)';
            this.style.zIndex = '';
        });
    });

    // Smooth scroll for anchor links
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    anchorLinks.forEach(link => {
        link.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);

            if (targetElement) {
                e.preventDefault();
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// =================== UTILITY FUNCTIONS =================== //
function debounce(func, wait, immediate) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            timeout = null;
            if (!immediate) func(...args);
        };
        const callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func(...args);
    };
}

function throttle(func, limit) {
    let inThrottle;
    return function () {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// =================== SEARCH FUNCTIONALITY =================== //
function initializeSearch() {
    const searchInputs = document.querySelectorAll('[data-search]');

    searchInputs.forEach(input => {
        const targetSelector = input.getAttribute('data-search');
        const targetElements = document.querySelectorAll(targetSelector);

        const debouncedSearch = debounce((query) => {
            targetElements.forEach(element => {
                const text = element.textContent.toLowerCase();
                if (text.includes(query.toLowerCase()) || query === '') {
                    element.style.display = '';
                } else {
                    element.style.display = 'none';
                }
            });
        }, 300);

        input.addEventListener('input', function () {
            debouncedSearch(this.value);
        });
    });
}

// =================== DATA TABLE ENHANCEMENTS =================== //
function initializeDataTables() {
    const tables = document.querySelectorAll('.data-table');

    tables.forEach(table => {
        // Add sorting functionality
        const headers = table.querySelectorAll('th[data-sort]');
        headers.forEach(header => {
            header.style.cursor = 'pointer';
            header.innerHTML += ' <i class="fas fa-sort"></i>';

            header.addEventListener('click', function () {
                const sortKey = this.getAttribute('data-sort');
                const tbody = table.querySelector('tbody');
                const rows = Array.from(tbody.querySelectorAll('tr'));

                const isAscending = !this.classList.contains('sort-desc');

                // Remove sort classes from all headers
                headers.forEach(h => {
                    h.classList.remove('sort-asc', 'sort-desc');
                    const icon = h.querySelector('i');
                    icon.className = 'fas fa-sort';
                });

                // Add appropriate class to current header
                this.classList.add(isAscending ? 'sort-asc' : 'sort-desc');
                const icon = this.querySelector('i');
                icon.className = `fas fa-sort-${isAscending ? 'up' : 'down'}`;

                // Sort rows
                rows.sort((a, b) => {
                    const aValue = a.querySelector(`td:nth-child(${Array.from(this.parentNode.children).indexOf(this) + 1})`).textContent.trim();
                    const bValue = b.querySelector(`td:nth-child(${Array.from(this.parentNode.children).indexOf(this) + 1})`).textContent.trim();

                    if (isAscending) {
                        return aValue.localeCompare(bValue, undefined, { numeric: true });
                    } else {
                        return bValue.localeCompare(aValue, undefined, { numeric: true });
                    }
                });

                // Re-append sorted rows
                rows.forEach(row => tbody.appendChild(row));
            });
        });
    });
}

// =================== GLOBAL ERROR HANDLING =================== //
window.addEventListener('error', function (e) {
    console.error('JavaScript Error:', e.error);
    // You could send this to a logging service
});

// =================== EXPORT FUNCTIONS FOR GLOBAL USE =================== //
window.RiyeApp = {
    showFlashMessage,
    showLoading,
    hideLoading,
    debounce,
    throttle
};

// Add custom CSS for animations
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(2);
            opacity: 0;
        }
    }
    
    .input-focused label {
        color: var(--primary-color);
    }
    
    .sort-asc, .sort-desc {
        background-color: rgba(37, 99, 235, 0.1);
    }
`;
document.head.appendChild(style);