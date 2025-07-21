# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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