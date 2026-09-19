#!/usr/bin/env bash
set -euo pipefail

# install.sh - First-time dotfiles setup
# Usage: ./install.sh

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔧 Setting up dotfiles from $DOTFILES_DIR"
echo "=========================================="

# Create necessary directories
mkdir -p ~/.config/opencode
mkdir -p ~/.config/git

# Backup existing configs
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📦 Backing up existing configs to $BACKUP_DIR..."

[[ -f ~/.config/opencode/opencode.json ]] && cp ~/.config/opencode/opencode.json "$BACKUP_DIR/"
[[ -f ~/.gitconfig ]] && cp ~/.gitconfig "$BACKUP_DIR/"
[[ -f ~/.gitignore_global ]] && cp ~/.gitignore_global "$BACKUP_DIR/"

# Create symlinks
echo "🔗 Creating symlinks..."

if [[ -f "$DOTFILES_DIR/opencode/opencode.json" ]]; then
    ln -sf "$DOTFILES_DIR/opencode/opencode.json" ~/.config/opencode/opencode.json
    echo "  ✓ opencode.json"
fi

if [[ -f "$DOTFILES_DIR/git/gitconfig" ]]; then
    ln -sf "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
    echo "  ✓ gitconfig"
fi

if [[ -f "$DOTFILES_DIR/git/gitignore_global" ]]; then
    ln -sf "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global
    echo "  ✓ gitignore_global"
fi

# Make scripts executable
chmod +x "$DOTFILES_DIR/scripts/"*.sh

echo ""
echo "✅ Dotfiles setup complete!"
echo ""
echo "Available scripts:"
echo "  ./scripts/sync-org-standards.sh  - Sync organization AGENTS.md"
echo ""
echo "To sync organization standards now, run:"
echo "  ./scripts/sync-org-standards.sh"
