#!/usr/bin/env bash
set -euo pipefail

# sync-org-standards.sh - Sync organization standards from calavia-org/org-standards
# Usage: ./sync-org-standards.sh [DEV_DIR]
# Default DEV_DIR: ~/Development/Github

DEV_DIR="${1:-$HOME/Development/Github}"
ORG_STANDARDS_REPO="https://github.com/calavia-org/org-standards.git"
TEMP_DIR=$(mktemp -d)

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔄 Syncing organization standards from calavia-org/org-standards"
echo "================================================================="

# Clone org-standards repo
echo "📥 Fetching latest standards..."
git clone --depth 1 "$ORG_STANDARDS_REPO" "$TEMP_DIR" 2>/dev/null || {
    echo "⚠ Could not clone repo. Using local copy if available."
}

# Determine source directory
if [[ -d "$TEMP_DIR/github-harness" ]]; then
    SOURCE_DIR="$TEMP_DIR"
else
    # Fallback to local org-standards directory
    SOURCE_DIR="$HOME/Development/Github/org-standards"
    if [[ ! -d "$SOURCE_DIR" ]]; then
        echo "❌ ERROR: Cannot find org-standards repository"
        echo "   Clone it first: git clone $ORG_STANDARDS_REPO"
        rm -rf "$TEMP_DIR"
        exit 1
    fi
fi

# Ensure target directory exists
mkdir -p "$DEV_DIR"

# Copy base AGENTS.md
echo "📄 Copying base AGENTS.md to $DEV_DIR..."
cp "$SOURCE_DIR/github-harness/AGENTS.md" "$DEV_DIR/AGENTS.md"

# Run verification if script exists
if [[ -f "$SOURCE_DIR/scripts/verify-agents.sh" ]]; then
    echo ""
    echo "🔍 Running verification..."
    bash "$SOURCE_DIR/scripts/verify-agents.sh" "$DEV_DIR" || true
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}✅ Sync complete!${NC}"
echo ""
echo "The base AGENTS.md has been updated at: $DEV_DIR/AGENTS.md"
echo ""
echo "Next steps:"
echo "  1. Review changes: cd $DEV_DIR && git diff AGENTS.md"
echo "  2. Commit if needed: git add AGENTS.md && git commit -m 'chore(standards): sync org-wide AGENTS.md'"
