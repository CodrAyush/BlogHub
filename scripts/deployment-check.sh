#!/bin/bash

# Deployment Readiness Checklist Script
# This script helps verify that your environment is ready for deployment

echo "🚀 BlogHub Deployment Readiness Checklist"
echo "=========================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env.local exists
echo -n "Checking for .env.local file... "
if [ -f .env.local ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    echo -e "${YELLOW}Warning: .env.local not found. Copy .env.example to .env.local${NC}"
fi

# Check required environment variables
echo ""
echo "Checking required environment variables..."

required_vars=(
    "DATABASE_URL"
    "NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY"
    "CLERK_SECRET_KEY"
    "NEXT_PUBLIC_ROOT_DOMAIN"
)

if [ -f .env.local ]; then
    source .env.local 2>/dev/null
    
    for var in "${required_vars[@]}"; do
        echo -n "  $var... "
        if [ -z "${!var}" ]; then
            echo -e "${RED}✗ Missing${NC}"
        else
            # Check if it's a placeholder value
            if [[ "${!var}" == *"example"* ]] || [[ "${!var}" == *"xxxxx"* ]] || [[ "${!var}" == *"your_"* ]]; then
                echo -e "${YELLOW}⚠ Placeholder value detected${NC}"
            else
                echo -e "${GREEN}✓${NC}"
            fi
        fi
    done
fi

# Check if node_modules exists
echo ""
echo -n "Checking if dependencies are installed... "
if [ -d node_modules ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    echo -e "${YELLOW}Run: pnpm install${NC}"
fi

# Check if pnpm is installed
echo ""
echo -n "Checking if pnpm is installed... "
if command -v pnpm &> /dev/null; then
    echo -e "${GREEN}✓ ($(pnpm --version))${NC}"
else
    echo -e "${YELLOW}⚠ Not found (npm will be used)${NC}"
fi

# Check if git is clean
echo ""
echo -n "Checking git status... "
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${GREEN}✓ Clean${NC}"
else
    echo -e "${YELLOW}⚠ Uncommitted changes${NC}"
fi

echo ""
echo "=========================================="
echo ""
echo "📋 Next Steps for Deployment:"
echo ""
echo "1. Ensure all environment variables are set correctly"
echo "2. Review DEPLOYMENT.md for detailed instructions"
echo "3. Push your code to GitHub"
echo "4. Connect to Vercel and deploy"
echo ""
echo "For detailed deployment guide, see: DEPLOYMENT.md"
