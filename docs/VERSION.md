# Version History

## v1.6.0 - 2025-11-27

### Repository Cleanup
- Moved documentation to `docs/` folder
- Source files remain at repository root
- Updated all documentation to reflect current state

---

## v1.5.1 - 2025-11-27

### Homebrew Fix
- Updated SHA256 after git history rewrite

---

## v1.5.0 - 2025-11-27

### Distribution & Architecture
- Homebrew distribution: `brew tap vish288/zsh-config`
- User settings preserved in `~/.zshrc.local`
- Rosetta 2 detection for Apple Silicon
- Dynamic brew prefix (ARM/Intel support)
- Public repository for anonymous access
- Git history cleaned (consistent author identity)

---

## v1.4.0 - 2025-11-27

### Release Management
- Added `release.zsh` script with semantic versioning
- Prerelease support (`--prerelease/-p beta`)
- Dry-run mode for preview
- GitHub Actions for automated releases

---

## v1.3.0 - 2025-11-27

### Major Improvements
- 90+ git aliases, 15 helper functions
- Unified update system with retry logic
- Repo-aware welcome with cowsay
- zshrc optimized (176 → 80 lines)
- Lazy-load 1Password (startup: 25.5s → 0.6s)

---

## v1.2.0 - 2025-07-21

### 🎯 Major Improvements
- **User-Agnostic Configuration** - Replaced hardcoded user paths with generic `$HOME` variables
- **CI/CD Pipeline Fixes** - Resolved secret scanning false positives and configuration loading issues
- **Enhanced Portability** - Configuration now works for any user without modification

### 🔧 CI/CD Enhancements
- Fixed secret scanning patterns to avoid false positives from GitHub URLs
- Improved configuration syntax validation in CI environment
- Better handling of missing dependencies during testing
- More precise AWS key detection patterns

### 🐛 Bug Fixes
- **Path Generalization** - Updated pnpm, custom bin, gcloud SDK, and JetBrains paths to use `$HOME`
- **Secret Scanner** - Increased base64 threshold and excluded legitimate URL patterns
- **CI Testing** - Replaced runtime testing with syntax validation for better reliability

### 📦 Distribution Ready
- Configuration is now fully portable across different users and systems
- Proper CI/CD validation ensures code quality
- No user-specific hardcoded paths remaining

---

## v1.1.1 - 2025-07-21

### 🐛 Bug Fixes
- **ASDF Completion File Fix** - Changed from `asdf.bash` to `asdf` for proper completions
- **ASDF Shims Path Fix** - Updated to use `$HOME/.asdf/shims` instead of homebrew path
- **SSH Config Fix** - Corrected malformed `IdentitiesOnly` configuration

### 🔧 Improvements
- Fixed ASDF auto-loading in fresh terminal sessions
- Resolved `claude` command availability issues
- Enhanced compatibility with user-installed asdf vs homebrew asdf

---

## v1.1.0 - 2025-07-20

### 🎯 Major Improvements
- **Enhanced 1Password Integration** - Complete secrets management system
- **Snake_case Naming Convention** - Consistent naming across all components
- **Secrets Manager Tool** - CLI utility for managing 1Password secrets
- **Non-interactive Installation** - Automated setup for CI/CD environments
- **Comprehensive Testing** - Multiple test utilities for validation

### 🔐 Security Enhancements
- Full 1Password CLI integration with helper functions
- Secure secret loading with proper error handling
- Snake_case naming for better organization
- Automatic secret validation and testing
- Backup and restore capabilities for secrets

### 🛠️ New Tools Added
- `manage_secrets.zsh` - 1Password secrets management utility
- `quick_test.zsh` - Fast installation validation
- Enhanced `test_config.zsh` with more comprehensive checks
- Non-interactive installation scripts

### 🐛 Bug Fixes
- Fixed installation script read prompts for automation
- Resolved 1Password CLI format compatibility issues
- Improved error handling in secret loading
- Enhanced backup and restore reliability

### 📚 Documentation Updates
- Complete 1Password setup guide
- Snake_case naming conventions documented
- Enhanced troubleshooting section
- Added secrets management best practices

### 🚀 Performance Improvements
- Optimized secret loading with caching
- Faster installation validation
- Improved error reporting and debugging
- Enhanced backup operations

---

## v1.0.0 - 2025-07-20

### 🎉 Initial Release
- Complete ZSH configuration overhaul
- Modular directory structure
- Oh My Zsh and Powerlevel10k integration
- asdf lazy loading implementation
- Git, Docker, and Kubernetes aliases
- Installation and update scripts
- Comprehensive documentation