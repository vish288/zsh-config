# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.6.0] - 2025-11-27

### Changed
- **Repository Structure**: Moved documentation files to `docs/` folder
- **Source Files**: All executable scripts remain at repository root for easy access

### Fixed
- **Git History**: Cleaned commit history to use consistent author identity
- **Documentation**: Updated CHANGELOG and VERSION to reflect all releases

## [1.5.1] - 2025-11-27

### Fixed
- **Homebrew Formula**: Updated SHA256 after git history cleanup

## [1.5.0] - 2025-11-27

### Added
- **Homebrew Distribution**: Install via `brew tap vish288/zsh-config && brew install zsh-config`
- **User Settings Preservation**: Existing `.zshrc` migrated to `~/.zshrc.local` (sourced automatically)
- **Rosetta 2 Detection**: Guides Apple Silicon users to run natively if under Rosetta emulation
- **Architecture Support**: Dynamic Homebrew prefix detection for ARM (`/opt/homebrew`) and Intel (`/usr/local`)

### Changed
- **Public Repository**: Made repo public for anonymous access and Homebrew distribution
- **Git Configuration**: Enabled rerere, configured consistent author identity

### Security
- **AI Files Excluded**: Added CLAUDE.md, .claude/, .cursor/, .cursorules, *.mdc to .gitignore
- **Clean History**: Removed work email addresses from git commit history

## [1.4.0] - 2025-11-27

### Added
- **Release Script**: `release.zsh` with semantic versioning (major/minor/patch)
- **Prerelease Support**: `--prerelease/-p` flag for beta/alpha/rc versions
- **Dry-run Mode**: `--dry-run` to preview release without changes

### Changed
- **Version Management**: Migrated from mise to dedicated release script
- **CI/CD**: GitHub Actions workflow for automated releases

## [1.3.0] - 2025-11-27

### Added
- **Expanded Git Aliases**: 90+ git aliases in `aliases/git.zsh` covering stash, rebase, worktree, bisect, tags
- **Git Helper Functions**: 15 functions in `functions/git.zsh` (ginit, gnew, gdel, gsync, gstats, gfind, gprune)
- **Unified Update System**: `functions/updates.zsh` with retry logic (update-all, update-brew, update-mise, update-omz, update-pnpm-globals)
- **Repo-Aware Welcome**: `functions/welcome.zsh` with cowsay + lolcat colors, detects Nx/Next.js/Node/Rust/Python/Java/Go projects
- **Alias Discovery**: `functions/helpers.zsh` for finding aliases
- **CLAUDE.md**: Repository configuration for AI assistants with MR workflow rules

### Changed
- **zshrc Optimization**: Reduced from 176 to 80 lines, removed dead PATH entries (gcloud SDK, ruby, ~/bin, PNPM_HOME)
- **OMZ Plugins**: Reduced from 23 to 13 plugins (removed redundant: gcloud, docker-compose, npm, node, vscode, brew, aliases)
- **Secrets Loading**: Lazy-load 1Password tokens on-demand (startup: 25.5s → 0.6s)
- **Gradle Aliases**: Renamed `gw*` → `grd*` to avoid conflict with git worktree `gwt`
- **Docker Aliases**: Use modern `docker compose` syntax (no hyphen)

### Fixed
- **SSH Agent Fallback**: Fixed logic bug where fallback never triggered (was checking empty var after setting)
- **secrets.zsh grep Bug**: Fixed `$(grep -q ...)` returning empty string instead of exit code
- **macOS Compatibility**: Fixed `ps aux --sort` → `ps aux -r/-m`, `du --max-depth` → `du -d`
- **Double compinit**: Removed duplicate compinit call in completions.zsh
- **Welcome Performance**: Added timeout protection for large repos (0.5s git check, 0.3s status)

### Removed
- Dead `~/bin` directory with obsolete bit script
- Legacy secrets templates (.ssh_auto_add_template.zsh, .zsh_secrets_template.zsh)
- Duplicate aliases (ports, myip) from core.zsh (functions exist in system.zsh)
- extract() function (OMZ plugin handles it)

## [1.2.0] - 2025-07-21

### Added
- **User-Agnostic Configuration**: All hardcoded user paths replaced with `$HOME` variables
- **Enhanced CI/CD Pipeline**: Comprehensive validation with proper secret scanning
- **Distribution Readiness**: Configuration now portable across different users and systems

### Changed
- **Path References**: Updated pnpm, custom bin, gcloud SDK, and JetBrains Toolbox paths to use generic variables
- **Secret Scanning**: Improved patterns to avoid false positives from legitimate GitHub URLs
- **CI Testing Strategy**: Replaced runtime configuration testing with syntax validation

### Fixed
- **Secret Scanner False Positives**: Increased base64 threshold and excluded URL patterns
- **CI Configuration Loading**: Better handling of missing dependencies in test environment
- **AWS Key Detection**: More precise patterns to reduce false alerts

### Security
- **Portable Security**: Configuration maintains security while being user-agnostic
- **Enhanced Secret Detection**: More accurate secret scanning with fewer false positives

## [1.1.1] - 2025-07-21

### Fixed
- **ASDF Completion File**: Changed from `asdf.bash` to `asdf` for proper completions
- **ASDF Shims Path**: Updated to use `$HOME/.asdf/shims` instead of homebrew path
- **SSH Configuration**: Corrected malformed `IdentitiesOnly` setting
- **Claude Command Availability**: Fixed auto-loading in fresh terminal sessions

### Improved
- Enhanced compatibility with user-installed asdf vs homebrew asdf
- Better error handling for ASDF initialization

## [1.1.0] - 2025-07-20

### Added
- **1Password CLI Integration**: Complete secrets management system with helper functions
- **Secrets Manager Tool**: `manage_secrets.zsh` utility for managing 1Password secrets
- **Quick Test Utility**: `quick_test.zsh` for fast installation validation
- **Non-interactive Scripts**: Automation-friendly installation and uninstall scripts
- **Snake_case Naming**: Consistent naming convention across all components
- **Enhanced Error Handling**: Better error reporting and debugging capabilities
- **Backup System**: Automated backup creation for secrets and configurations

### Changed
- **Secrets Configuration**: Migrated from plaintext to secure 1Password integration
- **Naming Convention**: Updated all item names to use snake_case format
- **Installation Process**: Enhanced with non-interactive options for automation
- **Test Coverage**: Expanded testing with multiple validation utilities
- **Documentation**: Updated with comprehensive 1Password setup guide

### Fixed
- **Installation Prompts**: Resolved read prompt issues in automated environments
- **1Password Compatibility**: Fixed format parameter compatibility with latest CLI
- **Secret Loading**: Improved error handling and validation
- **Backup Reliability**: Enhanced backup and restore operations

### Security
- **Enhanced Secret Management**: Full migration to 1Password with encryption
- **Secure Loading**: Proper error handling prevents secret exposure
- **Validation System**: Automated testing ensures secure configuration
- **Access Control**: Proper vault organization and tagging

## [1.0.0] - 2025-07-20

### Added
- Initial release of comprehensive ZSH configuration
- Modular directory structure in `~/.config/zsh/`
- Oh My Zsh and Powerlevel10k integration
- asdf lazy loading for performance
- Git, Docker, and Kubernetes aliases and functions
- Installation, update, and uninstall scripts
- Comprehensive documentation and README
- Performance optimizations and security features

### Changed
- Complete overhaul from monolithic to modular configuration
- Migration from home directory clutter to organized structure
- Implementation of lazy loading for better performance

### Fixed
- asdf dependency issues requiring manual initialization
- Alias conflicts with system commands
- Performance bottlenecks in shell startup
- Home directory organization and cleanup

### Security
- Secure permissions implementation
- Template-based secrets management
- Proper PATH management and validation
