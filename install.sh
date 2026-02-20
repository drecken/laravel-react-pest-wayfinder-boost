#!/bin/bash

# One-line installer for Laravel + React + Pest + Wayfinder + Boost stack
# Usage: curl -fsSL https://raw.githubusercontent.com/drecken/laravel-react-pest-wayfinder-boost/main/install.sh | bash -s my-project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Cross-platform sed helper (macOS uses sed -i '', Linux uses sed -i)
sed_inplace() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "$@"
    else
        sed -i "$@"
    fi
}

# Check if directory name is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a directory name${NC}"
    echo "Usage: bash install.sh <directory-name>"
    echo "   or: curl -fsSL <url>/install.sh | bash -s <directory-name>"
    exit 1
fi

PROJECT_DIR="$1"

# Create log file for verbose output
LOG_FILE="/tmp/$(date +%Y-%m-%d)-${PROJECT_DIR}.log"
trap 'echo -e "${RED}Installation failed. Check log: $LOG_FILE${NC}"' ERR

# Check if directory already exists
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${RED}Error: Directory '$PROJECT_DIR' already exists${NC}"
    exit 1
fi

echo -e "${GREEN}Installing Laravel + React + Pest + Wayfinder + Boost stack...${NC}"
echo "Log file: $LOG_FILE"
echo ""

# Clone the repository
echo -e "${YELLOW}Cloning repository into '$PROJECT_DIR'...${NC}"
git clone git@github.com:drecken/laravel-react-pest-wayfinder-boost.git "$PROJECT_DIR" >> "$LOG_FILE" 2>&1

# Change into the project directory
cd "$PROJECT_DIR"

# Build containers
echo -e "${YELLOW}Building Docker containers...${NC}"
docker compose build >> "$LOG_FILE" 2>&1

# Remove boilerplate README (Laravel will provide its own)
rm -f README.md

# Create Laravel project with React and Pest
echo -e "${YELLOW}Creating Laravel project with React and Pest...${NC}"
docker compose run -T --rm workspace laravel new .laravel-temp --react --pest --npm --no-interaction < /dev/null >> "$LOG_FILE" 2>&1

echo -e "${YELLOW}Copying Laravel files to project root...${NC}"
cp -r .laravel-temp/. . >> "$LOG_FILE" 2>&1
rm -rf .laravel-temp >> "$LOG_FILE" 2>&1

# Copy custom vite.config.ts with HMR settings
echo -e "${YELLOW}Configuring Vite for Docker HMR...${NC}"
cp templates/vite.config.ts vite.config.ts >> "$LOG_FILE" 2>&1

echo -e "${YELLOW}Configuring app name and URL for Docker...${NC}"
sed_inplace "s/^APP_NAME=.*/APP_NAME=$PROJECT_DIR/" .env
echo "APP_SLUG=$PROJECT_DIR" >> .env
sed_inplace "s|^APP_URL=.*|APP_URL=http://${PROJECT_DIR}.localhost|" .env

echo -e "${YELLOW}Installing Boost...${NC}"
docker compose run -T --rm workspace composer require laravel/boost --dev --no-scripts < /dev/null >> "$LOG_FILE" 2>&1
docker compose run -T --rm workspace composer run-script post-autoload-dump < /dev/null >> "$LOG_FILE" 2>&1

# Copy MCP configuration for Docker
echo -e "${YELLOW}Configuring MCP for Docker...${NC}"
cp templates/.mcp.json .mcp.json >> "$LOG_FILE" 2>&1

echo -e "${YELLOW}Configuring Claude Code project settings...${NC}"
rm -rf .claude >> "$LOG_FILE" 2>&1
mkdir -p .claude >> "$LOG_FILE" 2>&1
cp templates/claude-settings.json .claude/settings.json >> "$LOG_FILE" 2>&1

echo -e "${YELLOW}Starting Docker containers...${NC}"
docker compose up -d >> "$LOG_FILE" 2>&1

# Clean up boilerplate files
echo -e "${YELLOW}Cleaning up boilerplate files...${NC}"

# Remove .git directory (boilerplate history)
rm -rf .git >> "$LOG_FILE" 2>&1

# Remove install.sh
rm -f install.sh

# Remove boilerplate-specific directories
rm -rf templates >> "$LOG_FILE" 2>&1

# Initialize fresh git repository
echo -e "${YELLOW}Initializing fresh git repository...${NC}"
git init >> "$LOG_FILE" 2>&1
git add . >> "$LOG_FILE" 2>&1
git commit -m "Initial commit" >> "$LOG_FILE" 2>&1

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Your project is ready at: $PROJECT_DIR"
echo "  Installation log: $LOG_FILE"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_DIR"
echo "  docker compose exec workspace php artisan boost:install --guidelines --skills"
echo ""
echo "Helper scripts available in scripts/:"
echo "  scripts/artisan migrate      Run artisan commands"
echo "  scripts/test                 Run tests"
echo "  scripts/npm install          Run npm commands"
echo "  scripts/tinker               Open Laravel tinker"
echo "  scripts/log                  Tail Laravel log"
echo ""
echo "Available services:"
echo "  - App: http://${PROJECT_DIR}.localhost"
echo ""
