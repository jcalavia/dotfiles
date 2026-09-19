# Dotfiles

Personal development environment **overrides and quick tweaks** — designed to layer on top of `ansible-collection-setup`.

## Relationship to ansible-collection-setup

**Primary source of truth**: [`calavia-org/ansible-collection-setup`](https://github.com/calavia-org/ansible-collection-setup)
- Machine provisioning (packages, binaries, tools)
- Initial config deployment via Jinja2 templates
- Role-based setup: git, tmux, gpg, nvim, opencode, mise

**This repo's purpose**: Post-ansible overrides and quick personalizations
- Org standards sync scripts
- Shell aliases and quick environment tweaks
- Optional config overrides when you don't want to re-run ansible

> **Rule**: If a config is managed by ansible (gitconfig, opencode.json), prefer updating the ansible role templates. Use dotfiles only for quick personal tweaks or temporary overrides.

## Structure

```
.
├── README.md                  # This file
├── scripts/
│   ├── install.sh             # First-time setup (creates symlinks)
│   └── sync-org-standards.sh  # Sync org-wide AGENTS.md
├── shell/
│   ├── zshrc                  # Zsh configuration (personal overrides)
│   └── aliases.sh             # Quick aliases
├── git/
│   ├── gitconfig              # ⚠️ OPTIONAL override — ansible is primary
│   └── gitignore_global       # Global gitignore (safe to customize here)
└── opencode/
    └── opencode.json          # ⚠️ OPTIONAL override — ansible is primary
```

## Quick Start

### First Time Setup (after running ansible-collection-setup)

```bash
# Clone to ~/.dotfiles
git clone https://github.com/<your-username>/dotfiles.git ~/.dotfiles

# Run install script (safe to re-run)
cd ~/.dotfiles
./scripts/install.sh
```

### What Gets Installed

| File | Symlinks To | Note |
|------|-------------|------|
| `shell/aliases.sh` | `~/.aliases` | ✅ Safe — personal aliases |
| `shell/zshrc` | `~/.zshrc` | ⚠️ May override ansible — review first |
| `git/gitignore_global` | `~/.gitignore_global` | ✅ Safe — personal ignores |
| `git/gitconfig` | `~/.gitconfig` | ⚠️ Overrides ansible template — use with care |
| `opencode/opencode.json` | `~/.config/opencode/opencode.json` | ⚠️ Overrides ansible template — use with care |

## Syncing Organization Standards

```bash
# Sync latest AGENTS.md from calavia-org/org-standards
./scripts/sync-org-standards.sh ~/Development/Github
```

## Maintenance

```bash
cd ~/.dotfiles
git pull
./scripts/install.sh  # Re-apply symlinks
```

## When to Update What

| Scenario | Update ansible-collection-setup | Update dotfiles |
|----------|--------------------------------|-----------------|
| New tool installation | ✅ | ❌ |
| Git user/name email | ✅ (role vars) | ❌ |
| Global git aliases | ✅ (template) | ⚠️ Only if quick tweak |
| Personal shell aliases | ❌ | ✅ |
| Org standards sync script | ❌ | ✅ |
| Quick opencode plugin add | ⚠️ Prefer ansible | ✅ Temporary |

## Related Repositories

| Repository | Purpose |
|------------|---------|
| `calavia-org/ansible-collection-setup` | **Primary** machine provisioning and config |
| `calavia-org/org-standards` | Organization-wide development standards |
| `calavia-org/workflows-lib` | Reusable GitHub Actions workflows |

---

**Last Updated**: 2026-09-19
**Maintained By**: [Your Name]
