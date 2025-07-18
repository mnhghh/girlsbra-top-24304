// GirlsBra Top - Main JavaScript File

// Mobile Menu Toggle
function toggleMobileMenu() {
    const navMenu = document.querySelector('.nav-menu');
    navMenu.classList.toggle('active');
}

// Close mobile menu when clicking outside
document.addEventListener('click', function(event) {
    const navMenu = document.querySelector('.nav-menu');
    const mobileToggle = document.querySelector('.mobile-menu-toggle');
    
    if (!navMenu.contains(event.target) && !mobileToggle.contains(event.target)) {
        navMenu.classList.remove('active');
    }
});

// Smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Bra Size Calculator Functions
function calculateBraSize() {
    const bandSize = parseFloat(document.getElementById('bandSize').value);
    const bustSize = parseFloat(document.getElementById('bustSize').value);
    const unit = document.getElementById('unit').value;
    
    if (!bandSize || !bustSize) {
        alert('Please enter both measurements');
        return;
    }
    
    if (bustSize <= bandSize) {
        alert('Bust measurement should be larger than band measurement');
        return;
    }
    
    // Convert to inches if needed
    let bandInches = unit === 'cm' ? bandSize / 2.54 : bandSize;
    let bustInches = unit === 'cm' ? bustSize / 2.54 : bustSize;
    
    // Calculate band size (round to nearest even number)
    let calculatedBand = Math.round(bandInches / 2) * 2;
    if (calculatedBand % 2 !== 0) {
        calculatedBand += 1;
    }
    
    // Adjust if band measurement is odd
    if (Math.round(bandInches) % 2 !== 0) {
        calculatedBand += 4;
    }
    
    // Calculate cup size
    const difference = bustInches - calculatedBand;
    const cupSizes = ['AA', 'A', 'B', 'C', 'D', 'DD', 'DDD', 'F', 'G', 'H', 'I', 'J'];
    let cupIndex = Math.round(difference);
    
    if (cupIndex < 0) cupIndex = 0;
    if (cupIndex >= cupSizes.length) cupIndex = cupSizes.length - 1;
    
    const cupSize = cupSizes[cupIndex];
    const finalSize = `${calculatedBand}${cupSize}`;
    
    // Display result
    document.getElementById('resultSize').textContent = finalSize;
    document.getElementById('resultBox').style.display = 'block';
    
    // Add some helpful text
    const resultText = document.getElementById('resultText');
    if (resultText) {
        resultText.textContent = `Your calculated bra size is ${finalSize}. Remember, this is a starting point - different brands may fit differently!`;
    }
}

// Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    const inputs = form.querySelectorAll('input[required], textarea[required]');
    let isValid = true;
    
    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.style.borderColor = '#f44336';
            isValid = false;
        } else {
            input.style.borderColor = '#e0e0e0';
        }
    });
    
    return isValid;
}

// Contact form submission
function submitContactForm(event) {
    event.preventDefault();
    
    if (!validateForm('contactForm')) {
        alert('Please fill in all required fields');
        return;
    }
    
    // Simulate form submission
    alert('Thank you for your message! We\'ll get back to you soon.');
    document.getElementById('contactForm').reset();
}

// Add loading animation to buttons
function addLoadingToButton(button) {
    const originalText = button.textContent;
    button.textContent = 'Loading...';
    button.disabled = true;
    
    setTimeout(() => {
        button.textContent = originalText;
        button.disabled = false;
    }, 2000);
}

// Intersection Observer for animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Initialize animations when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Add fade-in animation to cards
    const cards = document.querySelectorAll('.card, .product-box');
    cards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });
    
    // Add click tracking for affiliate links
    const affiliateLinks = document.querySelectorAll('a[href*="amazon.com"], a[href*="aliexpress.com"]');
    affiliateLinks.forEach(link => {
        link.addEventListener('click', function() {
            // Track affiliate link clicks (placeholder for analytics)
            console.log('Affiliate link clicked:', this.href);
        });
    });
    
    // Add hover effects to product boxes
    const productBoxes = document.querySelectorAll('.product-box');
    productBoxes.forEach(box => {
        box.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        box.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
});

// Utility function to format currency
function formatCurrency(amount, currency = 'USD') {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: currency
    }).format(amount);
}

// Utility function to truncate text
function truncateText(text, maxLength) {
    if (text.length <= maxLength) return text;
    return text.substr(0, maxLength) + '...';
}

// Search functionality (placeholder)
function searchSite(query) {
    // This would typically connect to a search API or filter content
    console.log('Searching for:', query);
    // Placeholder implementation
    alert(`Search functionality coming soon! You searched for: "${query}"`);
}

// Newsletter signup (placeholder)
function subscribeNewsletter(email) {
    if (!email || !email.includes('@')) {
        alert('Please enter a valid email address');
        return;
    }
    
    // Placeholder for newsletter signup
    alert('Thank you for subscribing! You\'ll receive our latest bra guides and tips.');
}

// Cookie consent (basic implementation)
function showCookieConsent() {
    if (!localStorage.getItem('cookieConsent')) {
        const consent = confirm('This website uses cookies to improve your experience. Do you accept?');
        if (consent) {
            localStorage.setItem('cookieConsent', 'accepted');
        }
    }
}

// Initialize cookie consent check
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(showCookieConsent, 2000);
});

// Performance optimization: Lazy loading for images
function lazyLoadImages() {
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                imageObserver.unobserve(img);
            }
        });
    });
    
    images.forEach(img => imageObserver.observe(img));
}

// Initialize lazy loading
document.addEventListener('DOMContentLoaded', lazyLoadImages);

