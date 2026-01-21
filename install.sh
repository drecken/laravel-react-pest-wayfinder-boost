#!/bin/bash

# One-line installer for Laravel + React + Pest + Wayfinder + Boost stack
# Usage: curl -fsSL https://raw.githubusercontent.com/drecken/laravel-react-pest-wayfinder-boost/main/install.sh | bash -s my-project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if directory name is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a directory name${NC}"
    echo "Usage: bash install.sh <directory-name>"
    echo "   or: curl -fsSL <url>/install.sh | bash -s <directory-name>"
    exit 1
fi

PROJECT_DIR="$1"

# Check if directory already exists
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${RED}Error: Directory '$PROJECT_DIR' already exists${NC}"
    exit 1
fi

echo -e "${GREEN}Installing Laravel + React + Pest + Wayfinder + Boost stack...${NC}"
echo ""

# Clone the repository
echo -e "${YELLOW}Cloning repository into '$PROJECT_DIR'...${NC}"
git clone git@github.com:drecken/laravel-react-pest-wayfinder-boost.git "$PROJECT_DIR"

# Change into the project directory
cd "$PROJECT_DIR"

# Build containers
echo -e "${YELLOW}Building Docker containers...${NC}"
docker compose build

# Remove boilerplate README (Laravel will provide its own)
rm -f README.md

# Create Laravel project with React and Pest
echo -e "${YELLOW}Creating Laravel project with React and Pest...${NC}"
docker compose run -T --rm workspace laravel new .laravel-temp --react --pest --npm --no-interaction
cp -r .laravel-temp/. .
rm -rf .laravel-temp

echo -e "${YELLOW}Installing Boost...${NC}"
docker compose run -T --rm workspace composer require laravel/boost --dev

# Clean up boilerplate files
echo -e "${YELLOW}Cleaning up boilerplate files...${NC}"

# Remove .git directory (boilerplate history)
rm -rf .git

# Remove install.sh
rm -f install.sh

# Initialize fresh git repository
echo -e "${YELLOW}Initializing fresh git repository...${NC}"
git init
git add .
git commit -m "Initial commit"

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Your project is ready at: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Run Boost installer:"
echo "     docker compose exec -ti workspace php artisan boost:install"
echo ""
echo "Available services:"
echo "  - App: http://localhost"
echo "  - Vite dev server: http://localhost:5174"
echo ""
