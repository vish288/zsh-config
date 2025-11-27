# ZSH Configuration Repository

Personal ZSH configuration with modular structure, lazy-loading secrets, and mise-based tool management.

## Repository Rules

### Branch Protection (MANDATORY)
- **NEVER push directly to main** - all changes through Pull Request
- **Branch naming**: `feat/*`, `fix/*`, `refactor/*`, `docs/*`
- Create feature branch → commit → push → PR → merge

### Git Workflow
```bash
# Create feature branch
git checkout -b feat/description-of-change

# Make changes, commit with conventional format
git add .
git commit -m "feat: description"

# Push and create PR
git push -u origin feat/description-of-change
gh pr create --title "feat: description" --body "## Changes\n- item"
```

### Commit Format
Use conventional commits:
- `feat:` new functionality
- `fix:` bug fixes
- `refactor:` code restructuring
- `docs:` documentation only
- `chore:` maintenance tasks

### Release Process
Releases are automatic via GitHub Actions:
1. Merge PR to main
2. **ALWAYS use release.zsh script**: `./release.zsh` (or `./release.zsh --dry-run` to preview)
3. Release workflow generates changelog from commits since last tag
4. Archives created and attached to GitHub Release

**IMPORTANT**: Never manually create tags - always use `./release.zsh` for consistent versioning and changelog generation.

### Version Strategy
- **Major (X.0.0)**: Breaking changes to zshrc structure
- **Minor (1.X.0)**: New features, aliases, functions
- **Patch (1.0.X)**: Bug fixes, small improvements

## Repository Structure

```
~/.config/zsh/
├── zshrc                     # Main entry (~80 lines)
├── aliases/
│   ├── core.zsh              # System shortcuts
│   ├── git.zsh               # 90+ git aliases
│   ├── docker.zsh            # Container shortcuts
│   └── tools.zsh             # Dev tool shortcuts (grd* for gradle)
├── functions/
│   ├── core.zsh              # File/navigation
│   ├── system.zsh            # System monitoring
│   ├── git.zsh               # 15 git helpers
│   ├── helpers.zsh           # Alias discovery
│   ├── updates.zsh           # update-all, update-brew, etc.
│   └── welcome.zsh           # Repo-aware cowsay
├── plugins/
│   ├── oh-my-zsh.zsh         # OMZ config (13 plugins)
│   ├── powerlevel10k.zsh     # P10K instant prompt
│   └── completions.zsh       # Completion settings
├── secrets/
│   └── secrets.zsh           # Lazy-loading 1Password tokens
├── .github/workflows/
│   ├── ci.yml                # PR validation
│   └── release.yml           # Tag-triggered release
├── CHANGELOG.md              # Keep a Changelog format
└── VERSION.md                # Version history
```

## Key Patterns

### Lazy Secret Loading
Tokens loaded on-demand, not at shell startup:
```zsh
# Auto-loads GITLAB_ACCESS_TOKEN and BIT_TOKEN
pnpm install  # in lcl-sdm repos

# Manual loading
load-dev-tokens    # GITLAB + BIT
load-api-tokens    # CODA + JIRA
secrets-status     # Show loaded state
```

### Update Commands
```zsh
update-all            # Everything with retry
update-brew           # Homebrew
update-mise           # mise and shims
update-omz            # Oh My Zsh
update-pnpm-globals   # pnpm globals
```

### Git Identity
This repo uses GitHub identity:
- user.name: vish288
- user.email: vish288@users.noreply.github.com

## Testing Changes

Before committing:
```bash
# Syntax check
zsh -n zshrc

# Startup time
time zsh -i -c exit  # Target: <1s

# Quick validation
./quick_test.zsh
```

## CI/CD

### Pull Request Checks (ci.yml)
- ZSH syntax validation
- Required files check
- Directory structure validation
- Script permission check
- Secret scanning

### Release (release.yml)
Triggered by tag push (`v*`):
- Validates configuration
- Extracts changelog from commits
- Creates tar.gz and zip archives
- Generates release notes
- Publishes GitHub Release

## Forbidden Practices

- Direct commits to main branch
- Synchronous 1Password calls in zshrc
- Hardcoded user paths (use $HOME)
- Aliases conflicting with existing commands
- More than 13 OMZ plugins (startup perf)
