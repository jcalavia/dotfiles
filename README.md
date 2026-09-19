# Dotfiles

Personal development environment configuration and synchronization.

## Overview

This repository contains:
- **OpenCode configuration** (`opencode/`) - AI agent settings and customizations
- **Git configuration** (`git/`) - Global git hooks, aliases, and templates
- **Shell configuration** (`shell/`) - Zsh/bash profiles and aliases
- **Scripts** (`scripts/`) - Setup and sync utilities

## Structure

```
.
├── README.md                  # This file
├── opencode/
│   ├── opencode.json          # Main OpenCode config
│   └── context/               # Custom context files
├── git/
│   ├── gitconfig              # Global git configuration
│   ├── gitignore_global       # Global gitignore
│   └── hooks/                 # Global git hooks
├── shell/
│   ├── zshrc                  # Zsh configuration
│   └── aliases.sh             # Common aliases
└── scripts/
    ├── install.sh             # First-time setup
    └── sync.sh                # Sync latest changes
```

## Quick Start

### First Time Setup

```bash
# Clone to ~/.dotfiles
git clone https://github.com/<your-username>/dotfiles.git ~/.dotfiles

# Run install script
cd ~/.dotfiles
./scripts/install.sh
```

### Manual Symlinks

```bash
# OpenCode config
ln -sf ~/.dotfiles/opencode/opencode.json ~/.config/opencode/opencode.json

# Git config
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/gitignore_global ~/.gitignore_global

# Shell config
ln -sf ~/.dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/.dotfiles/shell/aliases.sh ~/.aliases
```

## Syncing Organization Standards

This dotfiles repo includes scripts to sync organization-wide AGENTS.md from `calavia-org/org-standards`:

```bash
# Sync latest AGENTS.md to development directory
./scripts/sync-org-standards.sh
```

## Maintenance

Keep this repo updated:

```bash
cd ~/.dotfiles
git pull
./scripts/sync.sh
```

## Related Repositories

| Repository | Purpose |
|------------|---------|
| `calavia-org/org-standards` | Organization-wide development standards |
| `calavia-org/workflows-lib` | Reusable GitHub Actions workflows |

---

**Last Updated**: 2026-09-19
**Maintained By**: [Your Name]
