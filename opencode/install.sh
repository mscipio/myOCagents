#!/bin/bash
#
# opencode-agentsuit installer
# Usage: curl -sL https://raw.githubusercontent.com/mscipio/opencode-agentsuit/main/install.sh | bash
#

set -e

REPO_URL="${REPO_URL:-https://github.com/YOUR_USERNAME/opencode-agentsuit.git}"
TARGET_DIR=".opencode"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Installing OpenCode Agent Suit...${NC}"

# Check if git is available
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is required but not installed.${NC}"
    exit 1
fi

# Create temp directory
TEMP_DIR=$(mktemp -d)
echo "Cloning to temporary directory..."

# Clone repo
git clone --depth 1 "$REPO_URL" "$TEMP_DIR" 2>/dev/null || {
    echo -e "${RED}Error: Failed to clone repository.${NC}"
    echo "Make sure the repository exists and you have network access."
    rm -rf "$TEMP_DIR"
    exit 1
}

# Remove existing .opencode if exists
if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Removing existing .opencode folder...${NC}"
    rm -rf "$TARGET_DIR"
fi

# Move to target
mv "$TEMP_DIR" "$TARGET_DIR"
echo -e "${GREEN}Moved to .opencode/${NC}"

# Install dependencies if package.json exists
if [ -f "$TARGET_DIR/package.json" ]; then
    echo "Installing dependencies..."
    cd "$TARGET_DIR" && npm install 2>/dev/null || echo -e "${YELLOW}Warning: npm install failed (may not be needed)${NC}"
fi

# Create context directory if it doesn't exist
mkdir -p "$TARGET_DIR/context"
mkdir -p "$TARGET_DIR/context/history"
mkdir -p "$TARGET_DIR/context/symbols"

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Review .opencode/agents/orchestrator.md"
echo "  2. Run: opencode init-context"
echo "  3. Start using: opencode <your-command>"
