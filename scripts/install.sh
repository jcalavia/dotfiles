#!/usr/bin/env bash
set -euo pipefail

# install.sh - First-time dotfiles setup
# Usage: ./install.sh
#
# NOTE: ansible-collection-setup is the PRIMARY source for machine provisioning.
# This script only creates symlinks for quick personal overrides.
# Prefer updating ansible role templates for permanent changes.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🔧 Setting up dotfiles from $DOTFILES_DIR"
echo "=========================================="
echo ""
echo -e "${YELLOW}Note:${NC} ansible-collection-setup is the primary source."
echo "These dotfiles are optional overrides."
echo ""

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
[[ -f ~/.zshrc ]] && cp ~/.zshrc "$BACKUP_DIR/"

echo ""
echo "🔗 Creating symlinks..."

# Safe configs (personal, not managed by ansible)
if [[ -f "$DOTFILES_DIR/shell/aliases.sh" ]]; then
    ln -sf "$DOTFILES_DIR/shell/aliases.sh" ~/.aliases
    echo "  ✓ ~/.aliases (personal aliases — safe)"
fi

if [[ -f "$DOTFILES_DIR/git/gitignore_global" ]]; then
    ln -sf "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global
    echo "  ✓ ~/.gitignore_global (personal ignores — safe)"
fi

# Optional overrides (ansible is primary — ask first)
echo ""
echo -e "${BLUE}Optional overrides (ansible is primary):${NC}"

if [[ -f "$DOTFILES_DIR/shell/zshrc" ]]; then
    if [[ -f ~/.zshrc ]] && ! [[ -L ~/.zshrc ]]; then
        echo "  ⚠ ~/.zshrc exists and is not a symlink."
        read -p "     Override with dotfiles version? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ln -sf "$DOTFILES_DIR/shell/zshrc" ~/.zshrc
            echo "  ✓ ~/.zshrc (override applied)"
        else
            echo "  ⏭ ~/.zshrc (skipped)"
        fi
    else
        ln -sf "$DOTFILES_DIR/shell/zshrc" ~/.zshrc
        echo "  ✓ ~/.zshrc"
    fi
fi

if [[ -f "$DOTFILES_DIR/git/gitconfig" ]]; then
    if [[ -f ~/.gitconfig ]] && ! [[ -L ~/.gitconfig ]]; then
        echo "  ⚠ ~/.gitconfig exists and may be managed by ansible."
        read -p "     Override with dotfiles version? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ln -sf "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
            echo "  ✓ ~/.gitconfig (override applied)"
        else
            echo "  ⏭ ~/.gitconfig (skipped — ansible template preserved)"
        fi
    else
        ln -sf "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
        echo "  ✓ ~/.gitconfig"
    fi
fi

if [[ -f "$DOTFILES_DIR/opencode/opencode.json" ]]; then
    if [[ -f ~/.config/opencode/opencode.json ]] && ! [[ -L ~/.config/opencode/opencode.json ]]; then
        echo "  ⚠ ~/.config/opencode/opencode.json exists and may be managed by ansible."
        read -p "     Override with dotfiles version? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ln -sf "$DOTFILES_DIR/opencode/opencode.json" ~/.config/opencode/opencode.json
            echo "  ✓ opencode.json (override applied)"
        else
            echo "  ⏭ opencode.json (skipped — ansible template preserved)"
        fi
    else
        ln -sf "$DOTFILES_DIR/opencode/opencode.json" ~/.config/opencode/opencode.json
        echo "  ✓ opencode.json"
    fi
fi

# Make scripts executable
chmod +x "$DOTFILES_DIR/scripts/"*.sh

echo ""
echo "✅ Dotfiles setup complete!"
echo ""
echo "Backups saved to: $BACKUP_DIR"
echo ""
echo "Available scripts:"
echo "  ./scripts/sync-org-standards.sh  - Sync organization AGENTS.md"
echo ""
echo "To sync organization standards now, run:"
echo "  ./scripts/sync-org-standards.sh"
