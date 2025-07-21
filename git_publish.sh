#!/bin/bash

# Configuration
WEBSITE_ROOT="WEBSITE_ROOT="/mnt/d/girlsbra shell Script" # Adjust this path if your website is in a different location

# Check if commit message is provided
if [ -z "$1" ]; then
  echo "Usage: $0 \"Your commit message\""
  exit 1
fi

COMMIT_MESSAGE="$1"

# Navigate to the website root directory
cd "${WEBSITE_ROOT}" || { echo "Error: Could not navigate to ${WEBSITE_ROOT}"; exit 1; }

# Stage all changes
echo "Staging all changes..."
git add .

# Commit changes
echo "Committing changes with message: \"${COMMIT_MESSAGE}\""
git commit -m "${COMMIT_MESSAGE}"

# Push to GitHub (assuming 'origin' remote and 'main' branch)
echo "Pushing changes to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
  echo "Successfully pushed changes to GitHub. Vercel deployment should start automatically."
else
  echo "Error: Failed to push changes to GitHub. Please check your Git configuration and network connection."
fi


