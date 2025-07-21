#!/bin/bash

# Configuration
WEBSITE_ROOT="/mnt/d/girlsbra shell Script" # Adjust this path if your website is in a different location
ARTICLE_TEMPLATE="${WEBSITE_ROOT}/blog/article_template.html"
BLOG_ARTICLES_DIR="${WEBSITE_ROOT}/blog"

# Function to convert title to a URL-friendly filename
slugify() {
  echo "$1" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-*|-*$//g' | tr A-Z a-z
}

# Check if article title is provided
if [ -z "$1" ]; then
  echo "Usage: $0 \"Your Article Title\""
  exit 1
fi

ARTICLE_TITLE="$1"
FILENAME=$(slugify "${ARTICLE_TITLE}")".html"
ARTICLE_PATH="${BLOG_ARTICLES_DIR}/${FILENAME}"
CURRENT_DATE=$(date +"%Y-%m-%d")

# Create the article template if it doesn't exist
if [ ! -f "${ARTICLE_TEMPLATE}" ]; then
  echo "Creating article template: ${ARTICLE_TEMPLATE}"
  cat <<EOF > "${ARTICLE_TEMPLATE}"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{TITLE}} | GirlsBra Top</title>
    <meta name="description" content="{{DESCRIPTION}}">
    <meta name="keywords" content="{{KEYWORDS}}">
    <meta name="author" content="GirlsBra Top">
    <link rel="canonical" href="https://girlsbra.top/blog/{{FILENAME}}">
    <link rel="stylesheet" href="../css/style.css">
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "Article",
        "headline": "{{TITLE}}",
        "description": "{{DESCRIPTION}}",
        "author": {
            "@type": "Organization",
            "name": "GirlsBra Top"
        },
        "publisher": {
            "@type": "Organization",
            "name": "GirlsBra Top",
            "logo": {
                "@type": "ImageObject",
                "url": "https://girlsbra.top/images/logo.png"
            }
        },
        "datePublished": "{{DATE}}",
        "dateModified": "{{DATE}}",
        "mainEntityOfPage": {
            "@type": "WebPage",
            "@id": "https://girlsbra.top/blog/{{FILENAME}}"
        }
    }
    </script>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <nav class="navbar container">
            <div class="logo">
                <a href="../index.html">GirlsBra Top</a>
            </div>
            <ul class="nav-menu">
                <li><a href="../index.html" class="nav-link">Home</a></li>
                <li><a href="../calculator.html" class="nav-link">Bra Size Calculator</a></li>
                <li><a href="../blog.html" class="nav-link">Blog</a></li>
                <li><a href="../about.html" class="nav-link">About</a></li>
                <li><a href="../contact.html" class="nav-link">Contact</a></li>
            </ul>
            <button class="mobile-menu-toggle" onclick="toggleMobileMenu()">☰</button>
        </nav>
    </header>

    <!-- Article Header -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col col-8">
                    <nav style="margin-bottom: 1rem; color: var(--text-light); font-size: 0.9rem;">
                        <a href="../index.html" style="color: var(--text-light);">Home</a> > 
                        <a href="../blog.html" style="color: var(--text-light);">Blog</a> > 
                        <span>{{TITLE}}</span>
                    </nav>
                    
                    <span style="color: var(--primary-color); font-size: 0.9rem; font-weight: 500;">ARTICLE CATEGORY</span>
                    <h1>{{TITLE}}</h1>
                    <div style="margin-bottom: 2rem; color: var(--text-light); font-size: 0.9rem;">
                        <span>Published {{DATE}}</span> • <span>5 min read</span> • <span>By GirlsBra Top</span>
                    </div>
                    
                    <img src="../images/blog-placeholder.jpg" alt="{{TITLE}}" style="width: 100%; border-radius: 8px; margin-bottom: 2rem;">
                </div>
            </div>
        </div>
    </section>

    <!-- Article Content -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col col-8">
                    <article>
                        <p>Start writing your article content here. Replace this placeholder text with your actual article.</p>
                        <p>Remember to use HTML tags for formatting, such as &lt;h2&gt; for subheadings, &lt;p&gt; for paragraphs, &lt;ul&gt; for unordered lists, and &lt;ol&gt; for ordered lists.</p>
                        <p>You can also add images using &lt;img src="../images/your-image.jpg" alt="Image description"&gt; and links using &lt;a href="your-link.html"&gt;Link Text&lt;/a&gt;.</p>
                    </article>
                </div>
                
                <div class="col col-4">
                    <div class="card">
                        <div class="card-content">
                            <h3>Related Articles</h3>
                            <div style="margin-bottom: 1rem;">
                                <a href="wireless-nursing-bra-review.html" style="color: var(--text-primary); text-decoration: none;">
                                    <h4 style="font-size: 1rem; margin-bottom: 0.5rem;">Wireless Nursing Bra Review</h4>
                                    <p style="font-size: 0.9rem; color: var(--text-secondary);">Top picks for comfortable nursing bras</p>
                                </a>
                            </div>
                            <div style="margin-bottom: 1rem;">
                                <a href="how-to-measure-bra-size.html" style="color: var(--text-primary); text-decoration: none;">
                                    <h4 style="font-size: 1rem; margin-bottom: 0.5rem;">How to Measure Bra Size</h4>
                                    <p style="font-size: 0.9rem; color: var(--text-secondary);">Step-by-step measurement guide</p>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="card mt-3">
                        <div class="card-content">
                            <h3>Quick Tools</h3>
                            <a href="../calculator.html" class="btn btn-primary mb-2" style="width: 100%;">Bra Size Calculator</a>
                            <a href="../contact.html" class="btn btn-outline" style="width: 100%;">Ask a Question</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>GirlsBra Top</h3>
                    <p>Empowering every woman to find her perfect fit. Your trusted source for bra guides, reviews, and expert advice.</p>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="../calculator.html">Bra Size Calculator</a></li>
                        <li><a href="../blog.html">Blog</a></li>
                        <li><a href="../about.html">About Us</a></li>
                        <li><a href="../contact.html">Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Categories</h3>
                    <ul class="footer-links">
                        <li><a href="category/bra-size-guide.html">Bra Size Guide</a></li>
                        <li><a href="category/best-bras-by-use.html">Best Bras by Use</a></li>
                        <li><a href="category/bra-reviews.html">Bra Reviews</a></li>
                        <li><a href="category/maternity-bras.html">Maternity Bras</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Legal</h3>
                    <ul class="footer-links">
                        <li><a href="../privacy.html">Privacy Policy</a></li>
                        <li><a href="../disclaimer.html">Affiliate Disclaimer</a></li>
                        <li><a href="../terms.html">Terms of Service</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2025 GirlsBra Top. All rights reserved. | Empowering Every Woman to Find Her Perfect Fit.</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="../js/script.js"></script>
</body>
</html>
EOF
  chmod +x "${ARTICLE_TEMPLATE}"
fi

# Create new article from template and replace placeholders
cp "${ARTICLE_TEMPLATE}" "${ARTICLE_PATH}"
sed -i "s/{{TITLE}}/${ARTICLE_TITLE}/g" "${ARTICLE_PATH}"
sed -i "s/{{DATE}}/${CURRENT_DATE}/g" "${ARTICLE_PATH}"
sed -i "s/{{FILENAME}}/${FILENAME}/g" "${ARTICLE_PATH}"

# Placeholder for DESCRIPTION and KEYWORDS - user will need to manually edit these
sed -i "s/{{DESCRIPTION}}/A concise summary of ${ARTICLE_TITLE}./g" "${ARTICLE_PATH}"
sed -i "s/{{KEYWORDS}}/${ARTICLE_TITLE}, bra, girlsbratop/g" "${ARTICLE_PATH}"

echo "New article created: ${ARTICLE_PATH}"
echo "Remember to edit the file to add content, description, keywords, and update the image path and category."


