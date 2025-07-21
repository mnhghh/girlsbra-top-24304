#!/bin/bash

# Configuration
WEBSITE_ROOT="mnt/d/girlsbra shell Script" # Adjust this path if your website is in a different location

# Check if article title is provided
if [ -z "$1" ]; then
  echo "Usage: $0 \"Your New Article Title\""
  exit 1
fi

ARTICLE_TITLE="$1"

# Step 1: Create the new article HTML file
echo "\n--- Step 1: Creating new article HTML file ---"
./create_article.sh "${ARTICLE_TITLE}"
if [ $? -ne 0 ]; then
  echo "Error: create_article.sh failed. Aborting."
  exit 1
fi

# Step 2: Update the main blog index file
echo "\n--- Step 2: Updating blog index file ---"
./update_blog_index.sh "${ARTICLE_TITLE}"
if [ $? -ne 0 ]; then
  echo "Error: update_blog_index.sh failed. Aborting."
  exit 1
fi

# Step 3: Stage, commit, and push changes to GitHub
echo "\n--- Step 3: Pushing changes to GitHub ---"
COMMIT_MESSAGE="Add new article: ${ARTICLE_TITLE}"
./git_publish.sh "${COMMIT_MESSAGE}"
if [ $? -ne 0 ]; then
  echo "Error: git_publish.sh failed. Please resolve Git issues manually."
  exit 1
fi

echo "\n--- Publishing process completed for: ${ARTICLE_TITLE} ---"
echo "Your new article should now be live on your Vercel site after automatic deployment."


