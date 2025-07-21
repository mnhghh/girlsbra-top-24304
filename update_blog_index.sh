#!/bin/bash

# Configuration
WEBSITE_ROOT="mnt/d/girlsbra shell Script" # Adjust this path if your website is in a different location
BLOG_INDEX="${WEBSITE_ROOT}/blog.html"

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
CURRENT_DATE=$(date +"%B %d, %Y")
CURRENT_DATE_SHORT=$(date +"%Y-%m-%d")

# Create a backup of the blog index
cp "${BLOG_INDEX}" "${BLOG_INDEX}.backup"

# Create the new blog post entry HTML
NEW_ENTRY=$(cat <<EOF
                        <div class="blog-post">
                            <div class="blog-post-image">
                                <img src="images/blog-placeholder.jpg" alt="${ARTICLE_TITLE}">
                            </div>
                            <div class="blog-post-content">
                                <div class="blog-post-meta">
                                    <span class="category">ARTICLE</span>
                                    <span class="date">${CURRENT_DATE}</span>
                                </div>
                                <h3><a href="blog/${FILENAME}">${ARTICLE_TITLE}</a></h3>
                                <p>A comprehensive guide about ${ARTICLE_TITLE}. Click to read the full article and discover expert insights.</p>
                                <a href="blog/${FILENAME}" class="read-more">Read More →</a>
                            </div>
                        </div>
EOF
)

# Find the insertion point in blog.html (after the first blog-post div)
# This assumes there's a section with class "blog-posts" or similar
if grep -q "blog-post" "${BLOG_INDEX}"; then
    # Insert the new entry after the opening of the blog posts container
    # Look for the pattern that indicates where blog posts start
    if grep -q '<div class="blog-posts">' "${BLOG_INDEX}"; then
        # Insert after the blog-posts container opening
        sed -i "/<div class=\"blog-posts\">/a\\
${NEW_ENTRY}" "${BLOG_INDEX}"
    elif grep -q '<div class="row">' "${BLOG_INDEX}" && grep -q 'blog-post' "${BLOG_INDEX}"; then
        # Alternative: insert after the first row div that contains blog posts
        sed -i "0,/<div class=\"row\">/s//<div class=\"row\">\n${NEW_ENTRY}/" "${BLOG_INDEX}"
    else
        # Fallback: insert before the first existing blog-post
        sed -i "0,/<div class=\"blog-post\">/s//${NEW_ENTRY}\n\n                        <div class=\"blog-post\">/" "${BLOG_INDEX}"
    fi
else
    echo "Warning: Could not find existing blog posts in ${BLOG_INDEX}"
    echo "You may need to manually add the blog post entry."
    echo "Here's the HTML to add:"
    echo "${NEW_ENTRY}"
fi

echo "Blog index updated: ${BLOG_INDEX}"
echo "New entry added for: ${ARTICLE_TITLE}"
echo "Backup created: ${BLOG_INDEX}.backup"
echo ""
echo "Note: You may need to manually adjust the image path and excerpt text in ${BLOG_INDEX}"

