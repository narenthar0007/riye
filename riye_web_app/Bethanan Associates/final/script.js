// Bethanan Associates - Main JavaScript File

// Project Data with Real Images
const projects = [
    {
        title: "Luxury Residential Villa",
        category: "residential",
        image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=600&h=400&fit=crop",
        description: "A modern villa with sustainable design and smart home features in Coimbatore.",
        details: "3-story luxury villa with modern amenities, landscaped gardens, and eco-friendly features including solar panels, rainwater harvesting, and smart home automation.",
        area: "4,500 sq ft",
        location: "Coimbatore",
        duration: "8 months"
    },
    {
        title: "Corporate Office Complex",
        category: "commercial",
        image: "https://images.unsplash.com/photo-1507679799987-c73779587ccf?q=80&w=600&h=400&fit=crop",
        description: "Multi-story office building with modern workspaces in prime city location.",
        details: "15-floor commercial complex with modern office spaces, conference facilities, parking, and sustainable building features including energy-efficient HVAC systems.",
        area: "25,000 sq ft",
        location: "Coimbatore City Center",
        duration: "14 months"
    },
    {
        title: "Manufacturing Facility",
        category: "industrial",
        image: "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=600&h=400&fit=crop",
        description: "State-of-the-art factory for automotive components with high efficiency design.",
        details: "Industrial facility with specialized equipment housing, quality control systems, administrative offices, and modern safety infrastructure.",
        area: "15,000 sq ft",
        location: "SIPCOT Industrial Estate",
        duration: "10 months"
    },
    {
        title: "Premium Apartment Complex",
        category: "residential",
        image: "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=600&h=400&fit=crop",
        description: "Modern apartment complex with amenities and sustainable features.",
        details: "50-unit apartment complex with club house, swimming pool, landscaped gardens, children's play area, and underground parking.",
        area: "75,000 sq ft",
        location: "Peelamedu, Coimbatore",
        duration: "18 months"
    },
    {
        title: "Shopping Mall Complex",
        category: "commercial",
        image: "https://images.unsplash.com/photo-1555636222-cae831e670b3?q=80&w=600&h=400&fit=crop",
        description: "Multi-level retail complex with entertainment and dining facilities.",
        details: "3-level shopping mall with retail stores, food court, entertainment zone, multiplex cinema, and ample parking facilities.",
        area: "50,000 sq ft",
        location: "RS Puram, Coimbatore",
        duration: "20 months"
    },
    {
        title: "Warehouse & Distribution Center",
        category: "industrial",
        image: "https://images.unsplash.com/photo-1566228015668-4c45dbc4e2f5?q=80&w=600&h=400&fit=crop",
        description: "Large-scale warehouse facility with advanced logistics infrastructure.",
        details: "Modern warehouse with automated systems, loading docks, office spaces, temperature-controlled storage areas, and logistics management facilities.",
        area: "30,000 sq ft",
        location: "Kinathukadavu Industrial Zone",
        duration: "12 months"
    }
];

// Initialize Application
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

function initializeApp() {
    try {
        AOS.init({
            duration: 800,
            once: true,
            easing: 'ease-out-cubic',
            offset: 100
        });
    } catch (error) {
        console.log('AOS initialization failed, continuing without animations');
    }

    setupEventListeners();
    loadProjects();
    setupScrollAnimations();
    setupScrollToTop();
    // Removed particle system for professional appearance
    setupProgressBar();
    setupCounterAnimations();
    
    // Ultra Professional loading screen with advanced features
    const loadingScreen = document.getElementById('loading-screen');
    const progressFill = document.querySelector('.progress-fill');
    const progressGlow = document.querySelector('.progress-glow');
    const progressIndicator = document.querySelector('.progress-indicator');
    const percentageDisplay = document.querySelector('.progress-percent');
    const progressText = document.querySelector('.progress-text');
    const stages = document.querySelectorAll('.stage');
    
    if (loadingScreen && progressFill && percentageDisplay) {
        let progress = 0;
        let currentStage = 0;
        
        const loadingStages = [
            { text: 'Loading Assets', min: 0, max: 35 },
            { text: 'Preparing Interface', min: 35, max: 75 },
            { text: 'Ready to Explore', min: 75, max: 100 }
        ];
        
        const progressInterval = setInterval(() => {
            // Random increment with different speeds for each stage
            let increment = Math.random() * 8 + 3;
            if (progress > 60) increment = Math.random() * 4 + 2; // Slow down near end
            
            progress += increment;
            
            if (progress >= 100) {
                progress = 100;
                clearInterval(progressInterval);
                
                // Update final display
                progressFill.style.width = '100%';
                progressGlow.style.width = '100%';
                progressIndicator.style.left = '100%';
                percentageDisplay.textContent = '100%';
                progressText.textContent = 'Complete!';
                
                // Activate final stage
                stages.forEach((stage, index) => {
                    if (index === loadingStages.length - 1) {
                        stage.classList.add('active');
                    }
                });
                
                // Complete loading and hide screen with premium animation
                setTimeout(() => {
                    loadingScreen.style.opacity = '0';
                    loadingScreen.style.transform = 'scale(1.1)';
                    loadingScreen.style.filter = 'blur(5px)';
                    setTimeout(() => {
                        loadingScreen.style.display = 'none';
                    }, 1000);
                }, 800);
                return;
            }
            
            // Update progress visuals
            progressFill.style.width = `${progress}%`;
            progressGlow.style.width = `${progress}%`;
            progressIndicator.style.left = `${progress}%`;
            percentageDisplay.textContent = `${Math.floor(progress)}%`;
            
            // Update stage based on progress
            const newStage = loadingStages.findIndex(stage => 
                progress >= stage.min && progress < stage.max
            );
            
            if (newStage !== -1 && newStage !== currentStage) {
                // Remove active from all stages
                stages.forEach(stage => stage.classList.remove('active'));
                
                // Add active to current stage
                if (stages[newStage]) {
                    stages[newStage].classList.add('active');
                    progressText.textContent = loadingStages[newStage].text;
                }
                
                currentStage = newStage;
            }
            
        }, 120); // Slightly faster updates for smoother animation
        
        // Initialize first stage
        if (stages[0]) {
            stages[0].classList.add('active');
            progressText.textContent = loadingStages[0].text;
        }
        
    } else {
        // Fallback for older loading screen
        setTimeout(() => {
            if (loadingScreen) {
                loadingScreen.style.opacity = '0';
                setTimeout(() => {
                    loadingScreen.style.display = 'none';
                }, 500);
            }
        }, 3000);
    }
}

function setupEventListeners() {
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    const navbar = document.getElementById('navbar');
    
    if (mobileMenuBtn && mobileMenu) {
        // Handle both click and touch events for mobile compatibility
        mobileMenuBtn.addEventListener('click', handleMobileMenuToggle);
        mobileMenuBtn.addEventListener('touchstart', handleMobileMenuToggle);
        
        function handleMobileMenuToggle(e) {
            e.preventDefault();
            e.stopPropagation();
            
            const isActive = mobileMenu.classList.contains('active');
            
            if (isActive) {
                mobileMenu.classList.remove('active');
                mobileMenuBtn.classList.remove('active');
            } else {
                mobileMenu.classList.add('active');
                mobileMenuBtn.classList.add('active');
            }
            
            mobileMenuBtn.setAttribute('aria-expanded', (!isActive).toString());
        }
        
        // Close mobile menu when clicking on links
        const mobileLinks = mobileMenu.querySelectorAll('.navbar-mobile-link');
        
        mobileLinks.forEach(link => {
            link.addEventListener('click', () => {
                mobileMenu.classList.remove('active');
                mobileMenuBtn.classList.remove('active');
                mobileMenuBtn.setAttribute('aria-expanded', 'false');
            });
        });
    }

    // Handle navbar scroll effect
    let lastScrollTop = 0;
    window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset || document.documentElement.scrollTop;
        
        if (navbar) {
            if (currentScroll > 100) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        }
        
        // Update active navigation links
        updateActiveNavLink();
        
        lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
    });

    // Setup smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('.navbar-link, .navbar-mobile-link');
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href');
            if (targetId && targetId.startsWith('#')) {
                scrollToSection(targetId.substring(1));
            }
        });
    });

    // Update active nav link based on scroll position
    function updateActiveNavLink() {
        const sections = ['home', 'about', 'services', 'projects', 'why-choose', 'contact'];
        const navLinks = document.querySelectorAll('.navbar-link');
        
        let currentSection = 'home';
        
        sections.forEach(sectionId => {
            const section = document.getElementById(sectionId);
            if (section) {
                const rect = section.getBoundingClientRect();
                if (rect.top <= 100 && rect.bottom >= 100) {
                    currentSection = sectionId;
                }
            }
        });
        
        navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href === `#${currentSection}`) {
                link.classList.add('active');
            } else {
                link.classList.remove('active');
            }
        });
    }

    // Close mobile menu when clicking outside
    document.addEventListener('click', (e) => {
        if (mobileMenuBtn && mobileMenu && 
            !mobileMenuBtn.contains(e.target) && 
            !mobileMenu.contains(e.target)) {
            
            mobileMenu.classList.remove('show');
            setTimeout(() => mobileMenu.classList.add('hidden'), 300);
            
            const icon = mobileMenuBtn.querySelector('i');
            if (icon) {
                icon.classList.remove('bi-x');
                icon.classList.add('bi-list');
            }
            mobileMenuBtn.setAttribute('aria-expanded', 'false');
        }
    });

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const target = document.querySelector(targetId);
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                
                // Close mobile menu if open
                if (mobileMenu && mobileMenuBtn) {
                    mobileMenu.classList.remove('show');
                    setTimeout(() => mobileMenu.classList.add('hidden'), 300);
                    
                    const icon = mobileMenuBtn.querySelector('i');
                    if (icon) {
                        icon.classList.remove('bi-x');
                        icon.classList.add('bi-list');
                    }
                    mobileMenuBtn.setAttribute('aria-expanded', 'false');
                }
            }
        });
    });

    // Project filter functionality
    document.querySelectorAll('.project-filter').forEach(button => {
        button.addEventListener('click', function() {
            // Remove active state from all buttons
            document.querySelectorAll('.project-filter').forEach(btn => {
                btn.classList.remove('active', 'bg-accent-500', 'text-white');
                btn.classList.add('bg-gray-200', 'text-gray-700');
                btn.setAttribute('aria-selected', 'false');
            });
            
            // Add active state to clicked button
            this.classList.add('active', 'bg-accent-500', 'text-white');
            this.classList.remove('bg-gray-200', 'text-gray-700');
            this.setAttribute('aria-selected', 'true');
            
            const filter = this.getAttribute('data-filter');
            filterProjects(filter);
        });
    });

    // Form submissions
    const quoteForm = document.getElementById('quote-form');
    if (quoteForm) {
        quoteForm.addEventListener('submit', function(e) {
            e.preventDefault();
            showNotification('Quote request submitted successfully! We will contact you soon.', 'success');
            this.reset();
            closeQuoteModal();
        });
    }

    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            showNotification('Message sent successfully! Thank you for contacting us.', 'success');
            this.reset();
        });
    }

    // Modal close on background click
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                this.style.display = 'none';
                document.body.style.overflow = 'auto';
            }
        });
    });

    // ESC key to close modals
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            document.querySelectorAll('.modal').forEach(modal => {
                if (modal.style.display === 'block') {
                    modal.style.display = 'none';
                    document.body.style.overflow = 'auto';
                }
            });
        }
    });
}

function loadProjects() {
    const projectsGrid = document.getElementById('projects-grid');
    if (!projectsGrid) return;
    
    const projectsHTML = projects.map((project, index) => `
        <div class="project-card group cursor-pointer" data-category="${project.category}" data-aos="fade-up" data-aos-delay="${index * 150}" role="article" aria-label="${project.title}">
            <div class="relative overflow-hidden rounded-xl bg-white shadow-lg">
                <div class="project-image-container relative overflow-hidden">
                    <img src="${project.image}" alt="${project.title}" 
                         class="w-full h-64 object-cover transition-transform duration-700">
                    <div class="project-overlay absolute inset-0 flex items-center justify-center">
                        <div class="project-content text-center text-white p-6">
                            <h3 class="font-inter text-xl font-bold mb-3 text-shadow">${project.title}</h3>
                            <p class="text-sm mb-6 opacity-90 leading-relaxed">${project.description}</p>
                            <div class="flex flex-col sm:flex-row gap-3 justify-center">
                                <button onclick="openProjectModal('${index}')" class="btn-premium inline-flex items-center justify-center gap-2">
                                    <i class="bi bi-eye"></i>
                                    View Details
                                </button>
                                <button onclick="scrollToSection('contact')" class="btn-premium inline-flex items-center justify-center gap-2">
                                    <i class="bi bi-telephone"></i>
                                    Get Quote
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="project-info">
                    <div class="flex justify-between items-start mb-3">
                        <span class="project-category inline-flex items-center gap-1">
                            <i class="bi bi-${project.category === 'residential' ? 'house' : project.category === 'commercial' ? 'building' : 'gear'}"></i>
                            ${project.category}
                        </span>
                        <span class="project-area">${project.area}</span>
                    </div>
                    <h4 class="project-title">${project.title}</h4>
                    <div class="project-details">
                        <i class="bi bi-geo-alt text-blue-500"></i>
                        <span>${project.location}</span>
                        <span class="text-gray-400">•</span>
                        <i class="bi bi-clock text-green-500"></i>
                        <span>${project.duration}</span>
                    </div>
                    <div class="mt-3 pt-3 border-t border-gray-100">
                        <div class="flex items-center justify-between text-xs text-gray-500">
                            <span class="flex items-center gap-1">
                                <i class="bi bi-award text-yellow-500"></i>
                                Premium Quality
                            </span>
                            <span class="flex items-center gap-1">
                                <i class="bi bi-check-circle text-green-500"></i>
                                Completed
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `).join('');
    
    projectsGrid.innerHTML = projectsHTML;
    
    // Add staggered animation to project cards
    setTimeout(() => {
        const projectCards = document.querySelectorAll('.project-card');
        projectCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    }, 100);
}

function filterProjects(category) {
    const projectCards = document.querySelectorAll('.project-card');
    const projectsGrid = document.getElementById('projects-grid');
    
    // Add loading animation
    projectsGrid.style.position = 'relative';
    
    projectCards.forEach((card, index) => {
        if (category === 'all' || card.dataset.category === category) {
            // Show cards with staggered animation
            card.style.display = 'block';
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px) scale(0.9)';
            
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0) scale(1)';
            }, index * 80 + 100);
        } else {
            // Hide cards with smooth animation
            card.style.opacity = '0';
            card.style.transform = 'translateY(-20px) scale(0.95)';
            
            setTimeout(() => {
                card.style.display = 'none';
            }, 400);
        }
    });
    
    // Add pulse animation to visible cards after filter
    setTimeout(() => {
        const visibleCards = document.querySelectorAll('.project-card[style*="opacity: 1"]');
        visibleCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.animation = 'pulse-glow 0.6s ease-out';
                setTimeout(() => {
                    card.style.animation = '';
                }, 600);
            }, index * 50);
        });
    }, 800);
}

function setupScrollAnimations() {
    const navbar = document.getElementById('navbar');
    if (!navbar) return;
    
    let lastScrollY = window.scrollY;
    
    window.addEventListener('scroll', () => {
        const currentScrollY = window.scrollY;
        
        if (currentScrollY > 100) {
            navbar.classList.add('header-scrolled');
        } else {
            navbar.classList.remove('header-scrolled');
        }
        
        lastScrollY = currentScrollY;
    });
}

function setupScrollToTop() {
    const scrollTopBtn = document.getElementById('scroll-top');
    if (!scrollTopBtn) return;
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            scrollTopBtn.classList.remove('opacity-0', 'invisible');
            scrollTopBtn.classList.add('opacity-100', 'visible');
        } else {
            scrollTopBtn.classList.add('opacity-0', 'invisible');
            scrollTopBtn.classList.remove('opacity-100', 'visible');
        }
    });

    scrollTopBtn.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
}

function setupProgressBar() {
    const progressBar = document.getElementById('progress-bar');
    if (!progressBar) return;
    
    window.addEventListener('scroll', () => {
        const scrollTop = window.scrollY;
        const docHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrollPercent = (scrollTop / docHeight) * 100;
        progressBar.style.width = Math.max(0, Math.min(100, scrollPercent)) + '%';
    });
}

function setupCounterAnimations() {
    const counters = document.querySelectorAll('.counter');
    
    if ('IntersectionObserver' in window) {
        const counterObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counter = entry.target;
                    const target = parseInt(counter.dataset.target);
                    animateCounter(counter, target);
                    counterObserver.unobserve(counter);
                }
            });
        });

        counters.forEach(counter => counterObserver.observe(counter));
    }
}

function animateCounter(element, target) {
    let current = 0;
    const increment = target / 100;
    const duration = 2000;
    const stepTime = duration / 100;

    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target + (target === 100 ? '%' : '+');
            clearInterval(timer);
        } else {
            element.textContent = Math.floor(current) + (target === 100 ? '%' : '+');
        }
    }, stepTime);
}

// Modal Functions
function openAboutModal() {
    const modal = document.getElementById('about-modal');
    if (modal) {
        modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
        modal.classList.add('animate-zoom');
    }
}

function closeAboutModal() {
    const modal = document.getElementById('about-modal');
    if (modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
    }
}

function openProjectModal(projectIndex) {
    const project = typeof projectIndex === 'string' ? projects[parseInt(projectIndex)] : getProjectByCategory(projectIndex);
    const modal = document.getElementById('project-modal');
    
    if (!modal) return;
    
    if (project) {
        document.getElementById('project-modal-title').textContent = project.title;
        document.getElementById('project-modal-image').src = project.image;
        document.getElementById('project-modal-description').textContent = project.details;
        document.getElementById('project-modal-area').textContent = project.area;
        document.getElementById('project-modal-location').textContent = project.location;
        document.getElementById('project-modal-duration').textContent = project.duration;
    } else {
        // Default project info for service categories
        const serviceInfo = getServiceInfo(projectIndex);
        document.getElementById('project-modal-title').textContent = serviceInfo.title;
        document.getElementById('project-modal-image').src = serviceInfo.image;
        document.getElementById('project-modal-description').textContent = serviceInfo.description;
        document.getElementById('project-modal-area').textContent = serviceInfo.area;
        document.getElementById('project-modal-location').textContent = serviceInfo.location;
        document.getElementById('project-modal-duration').textContent = serviceInfo.duration;
    }
    
    modal.style.display = 'block';
    document.body.style.overflow = 'hidden';
    modal.classList.add('animate-zoom');
}

function closeProjectModal() {
    const modal = document.getElementById('project-modal');
    if (modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
    }
}

// Contact and Quote Functions

function getProjectByCategory(category) {
    return projects.find(project => project.category === category);
}

function getServiceInfo(service) {
    const serviceData = {
        'residential': {
            title: 'Residential Construction Services',
            image: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=600&h=400&fit=crop',
            description: 'We specialize in luxury residential projects including villas, apartments, and custom homes with modern amenities, sustainable design features, and smart home integration.',
            area: 'Various Sizes Available',
            location: 'Coimbatore & Surrounding Areas',
            duration: '6-18 Months'
        },
        'commercial': {
            title: 'Commercial Construction Projects',
            image: 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?q=80&w=600&h=400&fit=crop',
            description: 'Our commercial expertise includes office buildings, retail spaces, shopping complexes, and mixed-use developments designed for optimal functionality and modern aesthetics.',
            area: '5,000 - 100,000+ sq ft',
            location: 'Commercial Districts',
            duration: '12-24 Months'
        },
        'consulting': {
            title: 'Engineering Consulting Services',
            image: 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?q=80&w=600&h=400&fit=crop',
            description: 'Comprehensive engineering consultation including structural design, project management, feasibility studies, technical advisory services, and quality assurance.',
            area: 'All Project Scales',
            location: 'Pan-India Services',
            duration: 'As Per Project Requirements'
        },
        'industrial': {
            title: 'Industrial Construction Solutions',
            image: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=600&h=400&fit=crop',
            description: 'Specialized industrial construction including manufacturing facilities, warehouses, factories, and logistics centers with advanced infrastructure and safety systems.',
            area: '10,000 - 50,000+ sq ft',
            location: 'Industrial Zones',
            duration: '8-20 Months'
        },
        'renovation': {
            title: 'Renovation & Remodeling Services',
            image: 'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?q=80&w=600&h=400&fit=crop',
            description: 'Complete renovation and remodeling services for residential and commercial properties, including modernization, space optimization, and sustainable upgrades.',
            area: 'Existing Structures',
            location: 'Coimbatore Region',
            duration: '3-12 Months'
        }
    };
    return serviceData[service] || serviceData['residential'];
}

// Contact Functions
// Form Validation System
const FormValidator = {
    // Validation rules
    rules: {
        name: {
            required: true,
            minLength: 2,
            pattern: /^[a-zA-Z\s]+$/,
            message: 'Please enter a valid name (minimum 2 characters, letters only)'
        },
        phone: {
            required: true,
            pattern: /^[+]?[0-9\s\-\(\)]{10,15}$/,
            message: 'Please enter a valid phone number (10-15 digits)'
        },
        email: {
            required: true,
            pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            message: 'Please enter a valid email address'
        },
        details: {
            required: false,
            minLength: 0,
            message: 'Project details are optional'
        }
    },

    // Initialize validation
    init() {
        const form = document.getElementById('contact-form');
        if (!form) return;

        // Add event listeners for real-time validation
        Object.keys(this.rules).forEach(fieldName => {
            const field = document.getElementById(fieldName);
            if (field) {
                field.addEventListener('blur', () => this.validateField(fieldName));
                field.addEventListener('input', () => this.clearValidation(fieldName));
            }
        });
    },

    // Validate individual field
    validateField(fieldName) {
        const field = document.getElementById(fieldName);
        const rule = this.rules[fieldName];
        if (!field || !rule) return true;

        const value = field.value.trim();
        let isValid = true;
        let message = '';

        // Check required
        if (rule.required && !value) {
            isValid = false;
            message = `${this.getFieldLabel(fieldName)} is required`;
        }
        // Check minimum length
        else if (rule.minLength && value.length < rule.minLength) {
            isValid = false;
            message = rule.message;
        }
        // Check pattern
        else if (rule.pattern && !rule.pattern.test(value)) {
            isValid = false;
            message = rule.message;
        }

        this.showValidation(fieldName, isValid, message);
        return isValid;
    },

    // Validate entire form
    validateForm() {
        let isValid = true;
        Object.keys(this.rules).forEach(fieldName => {
            if (!this.validateField(fieldName)) {
                isValid = false;
            }
        });
        return isValid;
    },

    // Show validation feedback
    showValidation(fieldName, isValid, message) {
        const field = document.getElementById(fieldName);
        const formGroup = field.closest('.form-group');
        
        // Remove existing validation
        this.clearValidation(fieldName);

        if (isValid) {
            field.classList.add('success');
            field.classList.remove('error');
            
            // Don't show success message for optional project details field
            if (fieldName !== 'details') {
                const successMsg = document.createElement('div');
                successMsg.className = 'success-message';
                successMsg.innerHTML = '<i class="bi bi-check-circle-fill"></i>Looks good!';
                formGroup.appendChild(successMsg);
            }
        } else {
            field.classList.add('error');
            field.classList.remove('success');
            
            const errorMsg = document.createElement('div');
            errorMsg.className = 'error-message';
            errorMsg.innerHTML = `<i class="bi bi-exclamation-circle-fill"></i>${message}`;
            formGroup.appendChild(errorMsg);
        }
    },

    // Clear validation feedback
    clearValidation(fieldName) {
        const field = document.getElementById(fieldName);
        const formGroup = field.closest('.form-group');
        
        field.classList.remove('error', 'success');
        
        const existingMessages = formGroup.querySelectorAll('.error-message, .success-message');
        existingMessages.forEach(msg => msg.remove());
    },

    // Get field label for error messages
    getFieldLabel(fieldName) {
        const labels = {
            name: 'Full Name',
            phone: 'Phone Number',
            email: 'Email Address',
            details: 'Project Details'
        };
        return labels[fieldName] || fieldName;
    },

    // Clear all validation
    clearAllValidation() {
        Object.keys(this.rules).forEach(fieldName => {
            this.clearValidation(fieldName);
        });
    }
};

// Initialize form validation when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    FormValidator.init();
    QuoteValidator.init();
});

function sendWhatsApp() {
    const form = document.getElementById('contact-form');
    if (!form) return;
    
    // Validate form before sending
    if (!FormValidator.validateForm()) {
        showNotification('❌ Please fix the validation errors before sending!', 'error');
        return;
    }
    
    const formData = new FormData(form);
    
    const name = formData.get('name').trim();
    const phone = formData.get('phone').trim();
    const email = formData.get('email').trim();
    const projectType = formData.get('projectType');
    const details = formData.get('details').trim();

    const message = `*New Project Inquiry - Bethanan Associates*

🏗️ *Construction Consultation Request*

👤 *Name:* ${name}
📞 *Phone:* ${phone}
📧 *Email:* ${email}
🏠 *Project Type:* ${projectType || 'Not specified'}

📝 *Project Details:*
${details}

Thank you for choosing Bethanan Associates Engineers & Builders. We will contact you within 24 hours for a detailed consultation!

🌟 *35+ Years of Excellence in Construction*`;
    
    const whatsappUrl = `https://wa.me/919942223010?text=${encodeURIComponent(message)}`;
    window.open(whatsappUrl, '_blank');
    showNotification('✅ Redirecting to WhatsApp...', 'success');
    
    // Clear form and validation after successful submission
    form.reset();
    FormValidator.clearAllValidation();
}

function sendEmail() {
    const form = document.getElementById('contact-form');
    if (!form) return;
    
    const formData = new FormData(form);
    
    // Validate form before sending
    if (!FormValidator.validateForm()) {
        showNotification('❌ Please fix the validation errors before sending!', 'error');
        return;
    }
    
    const name = formData.get('name').trim();
    const phone = formData.get('phone').trim();
    const email = formData.get('email').trim();
    const projectType = formData.get('projectType');
    const details = formData.get('details').trim();
    
    const subject = `Project Consultation Request from ${name} - Bethanan Associates`;
    const body = `Dear Bethanan Associates Team,

I am interested in your construction services and would like to request a consultation. Please find my project details below:

CONTACT INFORMATION:
Name: ${name}
Phone: ${phone}
Email: ${email}
Project Type: ${projectType || 'Not specified'}

PROJECT DETAILS:
${details}

I would appreciate a consultation at your earliest convenience to discuss my project requirements in detail.

Thank you for your time and expertise.

Best regards,
${name}

---
This inquiry was sent through your website contact form.
Bethanan Associates Engineers & Builders
Phone: +91 9942223010
Email: Bethananassociates@gmail.com`;
    
    const mailtoUrl = `mailto:Bethananassociates@gmail.com?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    window.location.href = mailtoUrl;
    showNotification('✅ Opening email client...', 'success');
    
    // Clear form and validation after successful submission
    form.reset();
    FormValidator.clearAllValidation();
}

// Quote Modal Functions
function openQuoteModal() {
    const modal = document.getElementById('quote-modal');
    if (modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        
        // Focus on first input after animation
        setTimeout(() => {
            const firstInput = document.getElementById('quote-name');
            if (firstInput) firstInput.focus();
        }, 300);
    }
}

function closeQuoteModal() {
    const modal = document.getElementById('quote-modal');
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
        
        // Clear form and validation
        const form = document.getElementById('quote-form');
        if (form) {
            form.reset();
            QuoteValidator.clearAllValidation();
        }
    }
}

// Quote Form Validation System
const QuoteValidator = {
    rules: {
        'quote-name': {
            required: true,
            minLength: 2,
            pattern: /^[a-zA-Z\s]+$/,
            message: 'Please enter a valid name (minimum 2 characters, letters only)'
        },
        'quote-phone': {
            required: true,
            pattern: /^[+]?[0-9\s\-\(\)]{10,15}$/,
            message: 'Please enter a valid phone number (10-15 digits)'
        },
        'quote-email': {
            required: true,
            pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            message: 'Please enter a valid email address'
        },
        'quote-project-type': {
            required: true,
            message: 'Please select a project type'
        },
        'quote-location': {
            required: true,
            minLength: 3,
            message: 'Please enter the project location (minimum 3 characters)'
        }
    },

    init() {
        // Add event listeners for real-time validation
        Object.keys(this.rules).forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (field) {
                field.addEventListener('blur', () => this.validateField(fieldId));
                field.addEventListener('input', () => this.clearValidation(fieldId));
                field.addEventListener('change', () => this.validateField(fieldId));
            }
        });
    },

    validateField(fieldId) {
        const field = document.getElementById(fieldId);
        const rule = this.rules[fieldId];
        if (!field || !rule) return true;

        const value = field.value.trim();
        let isValid = true;
        let message = '';

        // Check required
        if (rule.required && !value) {
            isValid = false;
            message = `${this.getFieldLabel(fieldId)} is required`;
        }
        // Check minimum length
        else if (rule.minLength && value.length < rule.minLength) {
            isValid = false;
            message = rule.message;
        }
        // Check pattern
        else if (rule.pattern && value && !rule.pattern.test(value)) {
            isValid = false;
            message = rule.message;
        }

        this.showValidation(fieldId, isValid, message);
        return isValid;
    },

    validateForm() {
        let isValid = true;
        Object.keys(this.rules).forEach(fieldId => {
            if (!this.validateField(fieldId)) {
                isValid = false;
            }
        });
        return isValid;
    },

    showValidation(fieldId, isValid, message) {
        const field = document.getElementById(fieldId);
        const formGroup = field.closest('.form-group');
        
        // Remove existing validation
        this.clearValidation(fieldId);

        if (isValid && field.value.trim()) {
            field.classList.add('valid');
            field.classList.remove('invalid');
            
            const successMsg = document.createElement('div');
            successMsg.className = 'quote-validation-success';
            successMsg.innerHTML = '<i class="bi bi-check-circle-fill"></i>Looks good!';
            formGroup.appendChild(successMsg);
        } else if (!isValid) {
            field.classList.add('invalid');
            field.classList.remove('valid');
            
            const errorMsg = document.createElement('div');
            errorMsg.className = 'quote-validation-error';
            errorMsg.innerHTML = `<i class="bi bi-exclamation-circle-fill"></i>${message}`;
            formGroup.appendChild(errorMsg);
        }
    },

    clearValidation(fieldId) {
        const field = document.getElementById(fieldId);
        const formGroup = field.closest('.form-group');
        
        field.classList.remove('invalid', 'valid');
        
        const existingMessages = formGroup.querySelectorAll('.quote-validation-error, .quote-validation-success');
        existingMessages.forEach(msg => msg.remove());
    },

    getFieldLabel(fieldId) {
        const labels = {
            'quote-name': 'Full Name',
            'quote-phone': 'Phone Number',
            'quote-email': 'Email Address',
            'quote-project-type': 'Project Type',
            'quote-location': 'Project Location'
        };
        return labels[fieldId] || fieldId;
    },

    clearAllValidation() {
        Object.keys(this.rules).forEach(fieldId => {
            this.clearValidation(fieldId);
        });
    }
};

function submitQuoteRequest() {
    const form = document.getElementById('quote-form');
    if (!form) return;
    
    // Validate form before proceeding
    if (!QuoteValidator.validateForm()) {
        showNotification('❌ Please fix the validation errors before submitting!', 'error');
        return;
    }
    
    const formData = new FormData(form);
    
    const name = formData.get('name')?.trim();
    const phone = formData.get('phone')?.trim();
    const email = formData.get('email')?.trim();
    const projectType = formData.get('projectType');
    const location = formData.get('location')?.trim();
    const budget = formData.get('budget') || 'Not specified';
    const timeline = formData.get('timeline') || 'Not specified';
    const details = formData.get('details')?.trim() || 'No additional details provided';

    // Create comprehensive email content
    const emailSubject = `Quote Request from ${name} - ${projectType} Project`;
    const emailBody = `Dear Bethanan Associates Team,

I would like to request a detailed quote for my construction project. Please find the complete project information below:

═══════════════════════════════════════
CLIENT INFORMATION
═══════════════════════════════════════
Name: ${name}
Phone: ${phone}
Email: ${email}
Project Location: ${location}

═══════════════════════════════════════
PROJECT SPECIFICATIONS
═══════════════════════════════════════
Project Type: ${projectType}
Estimated Budget Range: ${budget}
Expected Timeline: ${timeline}

═══════════════════════════════════════
PROJECT DETAILS
═══════════════════════════════════════
${details}

═══════════════════════════════════════
REQUEST DETAILS
═══════════════════════════════════════
Submission Date: ${new Date().toLocaleDateString('en-IN')}
Submission Time: ${new Date().toLocaleTimeString('en-IN')}
Request Source: Website Quote Form

I would appreciate a comprehensive quote including:
• Detailed cost breakdown
• Project timeline estimation
• Material specifications
• Terms and conditions

Please contact me at your earliest convenience to discuss this project further.

Thank you for your time and expertise.

Best regards,
${name}
${phone}
${email}

---
This quote request was submitted through the Bethanan Associates website.
Bethanan Associates Engineers & Builders
📞 Phone: +91 9942223010
📧 Email: Bethananassociates@gmail.com
📍 Address: Vilankurichi, Coimbatore, Tamil Nadu

🏗️ 35+ Years of Excellence in Construction`;

    // Send via email directly
    const mailtoUrl = `mailto:Bethananassociates@gmail.com?subject=${encodeURIComponent(emailSubject)}&body=${encodeURIComponent(emailBody)}`;
    
    try {
        window.location.href = mailtoUrl;
        showNotification('✅ Opening email client with your quote request...', 'success');
        
        // Clear form and close modal after successful submission
        setTimeout(() => {
            form.reset();
            QuoteValidator.clearAllValidation();
            closeQuoteModal();
        }, 1000);
        
    } catch (error) {
        showNotification('❌ Error opening email client. Please try again.', 'error');
        console.error('Email submission error:', error);
    }
}

// Close modal when clicking outside
document.addEventListener('click', function(event) {
    const modal = document.getElementById('quote-modal');
    if (modal && event.target === modal) {
        closeQuoteModal();
    }
});

// Close modal with Escape key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeQuoteModal();
    }
});

// Utility Functions
function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        const navbar = document.getElementById('navbar');
        const navbarHeight = navbar ? navbar.offsetHeight : 60;
        const offset = navbarHeight + 20; // Add 20px extra padding
        
        const sectionTop = section.offsetTop - offset;
        
        window.scrollTo({
            top: sectionTop,
            behavior: 'smooth'
        });
    }
}

function showNotification(message, type = 'success') {
    const notification = document.getElementById('notification');
    const messageElement = document.getElementById('notification-message');
    if (!notification || !messageElement) return;
    
    const icon = notification.querySelector('i');
    
    messageElement.textContent = message;
    
    // Reset classes
    notification.className = 'notification';
    
    if (type === 'error') {
        notification.classList.add('error');
        if (icon) icon.className = 'bi bi-exclamation-triangle mr-2 text-lg';
    } else if (type === 'info') {
        notification.style.background = 'linear-gradient(135deg, #3b82f6, #1d4ed8)';
        notification.style.boxShadow = '0 10px 25px rgba(59, 130, 246, 0.3)';
        if (icon) icon.className = 'bi bi-info-circle mr-2 text-lg';
    } else {
        if (icon) icon.className = 'bi bi-check-circle mr-2 text-lg';
    }
    
    // Force a reflow to ensure the initial state is applied
    notification.offsetHeight;
    
    // Show notification
    notification.classList.add('show');
    
    // Auto-hide after 3 seconds
    setTimeout(() => {
        notification.classList.remove('show');
        
        // Reset styles for next use after animation completes
        setTimeout(() => {
            if (type === 'info') {
                notification.style.background = '';
                notification.style.boxShadow = '';
            }
        }, 400);
    }, 3000);
}

// Performance optimization for scroll events
let ticking = false;
function requestTick() {
    if (!ticking) {
        requestAnimationFrame(updateElements);
        ticking = true;
    }
}

function updateElements() {
    ticking = false;
}

window.addEventListener('scroll', requestTick);

// Enhanced keyboard navigation
document.addEventListener('keydown', function(e) {
    // Quick actions with keyboard shortcuts
    if (e.ctrlKey || e.metaKey) {
        switch(e.key) {
            case 'k':
                e.preventDefault();
                openQuoteModal();
                break;
            case 'm':
                e.preventDefault();
                openAIGenerator();
                break;
        }
    }
});

// Enhanced form validation
function validateForm(form) {
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    
    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            field.classList.add('border-red-500');
            isValid = false;
        } else {
            field.classList.remove('border-red-500');
        }
    });
    
    return isValid;
}

// Add form validation to contact form
document.addEventListener('DOMContentLoaded', function() {
    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        const inputs = contactForm.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.hasAttribute('required') && !this.value.trim()) {
                    this.classList.add('border-red-500');
                    this.classList.remove('border-gray-200');
                } else {
                    this.classList.remove('border-red-500');
                    this.classList.add('border-gray-200');
                }
            });
        });
    }
});

// Error handling for missing elements
window.addEventListener('error', function(e) {
    console.log('Error caught:', e.error);
    // Graceful degradation - don't show errors to users
});

// Console branding and info
console.log('%c🏗️ Bethanan Associates Engineers & Builders', 'color: #d97706; font-size: 24px; font-weight: bold; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);');
console.log('%c✨ Building Excellence Since 2012', 'color: #059669; font-size: 16px; font-weight: 600;');
console.log('%c📞 Contact: +91 9942223010 | 📧 Bethananassociates@gmail.com', 'color: #1e293b; font-size: 12px;');
console.log('%c🎯 Professional Website with AI-Powered Features', 'color: #8b5cf6; font-size: 12px;');

// Advanced smooth scrolling with offset for fixed header
function smoothScrollTo(element) {
    const headerHeight = document.getElementById('navbar').offsetHeight;
    const elementPosition = element.offsetTop - headerHeight - 20;
    
    window.scrollTo({
        top: elementPosition,
        behavior: 'smooth'
    });
}

// Enhanced project filtering with animation
function filterProjectsEnhanced(category) {
    const projectCards = document.querySelectorAll('.project-card');
    const delay = 100;
    
    projectCards.forEach((card, index) => {
        if (category === 'all' || card.dataset.category === category) {
            setTimeout(() => {
                card.style.display = 'block';
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px) scale(0.9)';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0) scale(1)';
                }, 50);
            }, index * delay);
        } else {
            card.style.opacity = '0';
            card.style.transform = 'translateY(-30px) scale(0.9)';
            setTimeout(() => {
                card.style.display = 'none';
            }, 300);
        }
    });
}

// Professional loading simulation for better UX
function simulateLoading() {
    const steps = [
        { message: 'Loading Assets...', progress: 20 },
        { message: 'Initializing Components...', progress: 40 },
        { message: 'Loading Images...', progress: 60 },
        { message: 'Setting up Animations...', progress: 80 },
        { message: 'Ready!', progress: 100 }
    ];
    
    let currentStep = 0;
    const loadingText = document.querySelector('.loading-screen h2');
    
    const loadingInterval = setInterval(() => {
        if (currentStep < steps.length && loadingText) {
            loadingText.textContent = steps[currentStep].message;
            currentStep++;
        } else {
            clearInterval(loadingInterval);
        }
    }, 600);
}

// Start loading simulation
simulateLoading();

// Add professional touch with subtle animations
document.addEventListener('DOMContentLoaded', function() {
    // Animate elements on page load
    const animateElements = document.querySelectorAll('.premium-card, .service-card, .testimonial-card');
    
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-fade-in-up');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);
    
    animateElements.forEach(el => observer.observe(el));
});

// ========================================
// PROFESSIONAL MOBILE OPTIMIZATIONS
// ========================================

// Mobile Device Detection
function isMobileDevice() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

// Touch Device Detection
function isTouchDevice() {
    return 'ontouchstart' in window || navigator.maxTouchPoints > 0 || navigator.msMaxTouchPoints > 0;
}

// Mobile-Specific Optimizations
document.addEventListener('DOMContentLoaded', function() {
    if (isMobileDevice() || isTouchDevice()) {
        // Add mobile class to body
        document.body.classList.add('mobile-device');
        
        // Optimize viewport for mobile
        optimizeViewport();
        
        // Add touch event handlers
        addTouchEventHandlers();
        
        // Optimize scroll performance
        optimizeScrollPerformance();
        
        // Handle mobile keyboard
        handleMobileKeyboard();
        
        // Optimize modals for mobile
        optimizeMobileModals();
    }
});

// Optimize Viewport for Mobile
function optimizeViewport() {
    // Prevent zoom on input focus for iOS
    const viewportMeta = document.querySelector('meta[name="viewport"]');
    if (viewportMeta) {
        viewportMeta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
    }
    
    // Handle orientation change
    window.addEventListener('orientationchange', function() {
        setTimeout(() => {
            // Force viewport recalculation
            document.documentElement.style.height = window.innerHeight + 'px';
            setTimeout(() => {
                document.documentElement.style.height = '';
            }, 100);
        }, 100);
    });
}

// Add Touch Event Handlers
function addTouchEventHandlers() {
    // Add touch feedback to buttons
    const touchElements = document.querySelectorAll('.btn, .navbar-mobile-link, .floating-btn, .premium-card, .service-card, .project-card');
    
    touchElements.forEach(element => {
        element.addEventListener('touchstart', function() {
            this.style.transform = 'scale(0.98)';
            this.style.transition = 'transform 0.1s ease';
        });
        
        element.addEventListener('touchend', function() {
            setTimeout(() => {
                this.style.transform = '';
                this.style.transition = '';
            }, 100);
        });
        
        element.addEventListener('touchcancel', function() {
            this.style.transform = '';
            this.style.transition = '';
        });
    });
}

// Optimize Scroll Performance
function optimizeScrollPerformance() {
    let ticking = false;
    
    function updateScrollElements() {
        // Update navbar on scroll
        const navbar = document.getElementById('navbar');
        if (navbar) {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        }
        
        ticking = false;
    }
    
    window.addEventListener('scroll', function() {
        if (!ticking) {
            requestAnimationFrame(updateScrollElements);
            ticking = true;
        }
    }, { passive: true });
}

// Handle Mobile Keyboard
function handleMobileKeyboard() {
    const inputs = document.querySelectorAll('input, textarea, select');
    
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            // Scroll to input on mobile to prevent keyboard overlap
            if (window.innerWidth <= 768) {
                setTimeout(() => {
                    this.scrollIntoView({ 
                        behavior: 'smooth', 
                        block: 'center' 
                    });
                }, 300);
            }
        });
        
        // Prevent zoom on focus for number inputs
        if (input.type === 'number' || input.type === 'tel') {
            input.addEventListener('focus', function() {
                this.setAttribute('readonly', 'readonly');
                this.setAttribute('inputmode', 'numeric');
                setTimeout(() => {
                    this.removeAttribute('readonly');
                }, 100);
            });
        }
    });
}

// Optimize Modals for Mobile
function optimizeMobileModals() {
    const modals = document.querySelectorAll('.modal, .quote-modal-overlay');
    
    modals.forEach(modal => {
        modal.addEventListener('touchmove', function(e) {
            // Prevent background scroll when modal is open
            if (this.classList.contains('active') || this.style.display === 'flex') {
                const modalContent = this.querySelector('.modal-content, .quote-modal-container');
                if (modalContent && !modalContent.contains(e.target)) {
                    e.preventDefault();
                }
            }
        }, { passive: false });
    });
}

// Smooth Scroll Polyfill for Mobile
function smoothScrollTo(element) {
    if (element) {
        const offsetTop = element.offsetTop - 80; // Account for navbar
        window.scrollTo({
            top: offsetTop,
            behavior: 'smooth'
        });
    }
}

// Enhanced Mobile Navigation
document.addEventListener('DOMContentLoaded', function() {
    const mobileNavLinks = document.querySelectorAll('.navbar-mobile-link[href^="#"]');
    
    mobileNavLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            // Close mobile menu
            const mobileMenu = document.getElementById('mobile-menu');
            const mobileMenuBtn = document.getElementById('mobile-menu-btn');
            if (mobileMenu && mobileMenuBtn) {
                mobileMenu.classList.remove('active');
                mobileMenuBtn.classList.remove('active');
            }
            
            // Smooth scroll to target
            setTimeout(() => {
                smoothScrollTo(targetElement);
            }, 300);
        });
    });
});

// Mobile Performance Monitoring
if (isMobileDevice()) {
    // Monitor performance on mobile
    window.addEventListener('load', function() {
        setTimeout(() => {
            if ('performance' in window) {
                const loadTime = performance.timing.loadEventEnd - performance.timing.navigationStart;
                if (loadTime > 3000) {
                    console.log('Mobile load time optimization needed:', loadTime + 'ms');
                }
            }
        }, 1000);
    });
}

// Mobile Swipe Gestures (for future enhancements)
function addSwipeGestures() {
    let startX, startY, distX, distY;
    const threshold = 150;
    const allowedTime = 300;
    let startTime;
    
    document.addEventListener('touchstart', function(e) {
        const touchobj = e.changedTouches[0];
        startX = touchobj.pageX;
        startY = touchobj.pageY;
        startTime = new Date().getTime();
    }, { passive: true });
    
    document.addEventListener('touchend', function(e) {
        const touchobj = e.changedTouches[0];
        distX = touchobj.pageX - startX;
        distY = touchobj.pageY - startY;
        const elapsedTime = new Date().getTime() - startTime;
        
        if (elapsedTime <= allowedTime && Math.abs(distX) >= threshold && Math.abs(distY) <= 100) {
            // Swipe detected - can be used for future enhancements
            if (distX > 0) {
                // Right swipe
            } else {
                // Left swipe
            }
        }
    }, { passive: true });
}