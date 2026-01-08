#!/bin/bash

# Create a new Laravel project with React, Pest, and npm
# Usage: ./create-laravel-project.sh

set -e

TEMP_DIR=".laravel-temp"

echo "🚀 Creating new Laravel project with React, Pest, and npm..."

# Remove temp directory if it exists
if [ -d "$TEMP_DIR" ]; then
    echo "🧹 Cleaning up existing temp directory..."
    rm -rf "$TEMP_DIR"
fi

# Create new Laravel project in temp directory
laravel new "$TEMP_DIR" --react --pest --npm --no-interaction

echo "📦 Moving files to current directory..."

# Copy everything from temp to current directory (including hidden files)
shopt -s dotglob
cp -r "$TEMP_DIR"/* .
shopt -u dotglob

# Clean up temp directory
echo "🧹 Cleaning up temp directory..."
rm -rf "$TEMP_DIR"

echo "✅ Laravel project created successfully!"
echo ""
echo "Next steps:"
echo "  - Run 'php artisan migrate' to set up the database"
echo "  - Run 'npm run dev' to start the development server"
