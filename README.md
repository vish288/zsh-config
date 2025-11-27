# 🚀 Professional ZSH Configuration

A comprehensive, modular, and performance-optimized ZSH configuration for macOS development environments with integrated 1Password secrets management.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-compatible-brightgreen.svg)](https://www.apple.com/macos/)
[![ZSH](https://img.shields.io/badge/ZSH-5.8+-blue.svg)](https://www.zsh.org/)
[![Version](https://img.shields.io/badge/Version-1.4.0-blue.svg)](VERSION.md)
[![Homebrew](https://img.shields.io/badge/Homebrew-tap-orange.svg)](https://github.com/vish288/homebrew-zsh-config)

## ✨ Features

### 🎯 **Core Improvements**
- **Zero dependency issues** - No more `> asdf` required to initialize shell
- **No alias conflicts** - Safe aliases that don't override system commands
- **Fast startup** - Optimized lazy loading for performance
- **Modular design** - Easy to customize and extend

### 🛠️ **Development Tools**
- **mise version management** - Automatic Node.js, Python, Java version switching
- **Git integration** - Enhanced git aliases and functions
- **Docker & Kubernetes** - Productive container management shortcuts
- **Cloud tools** - GCP, AWS integration ready

### 🛡️ **Security & Organization**
- **Full 1Password CLI integration** - Complete secrets management system
- **Snake_case naming convention** - Consistent organization standards
- **Secrets manager utility** - CLI tool for managing 1Password secrets
- **Clean home directory** - All configs organized in `~/.config/zsh/`
- **Proper permissions** - Security-focused file permissions
- **Comprehensive backup system** - Automatic backups and restore capabilities

## 🚀 Quick Install

### Homebrew (Recommended)
```bash
brew tap vish288/zsh-config
brew install zsh-config
cd $(brew --prefix)/share/zsh-config && ./install.zsh
```

### One-liner (Homebrew)
```bash
brew install vish288/zsh-config/zsh-config && cd $(brew --prefix)/share/zsh-config && ./install.zsh
```

### Manual Install
```zsh
git clone https://github.com/vish288/zsh-config.git ~/.config/zsh
cd ~/.config/zsh
./install.zsh
```

### curl Install
```zsh
curl -fsSL https://raw.githubusercontent.com/vish288/zsh-config/main/install.zsh | zsh
```

## 📁 Directory Structure

```
~/.config/zsh/
├── README.md              # This documentation
├── install.zsh            # Installation script
├── update.zsh             # Update script
├── uninstall.zsh          # Uninstall script
├── test_config.zsh        # Configuration test
├── quick_test.zsh         # Fast validation test
├── manage_secrets.zsh     # 1Password secrets manager
├── zshrc                  # Main configuration
├── zprofile              # Login shell config
├── plugins/              # Plugin configurations
│   ├── oh-my-zsh.zsh     # Oh My Zsh setup
│   ├── powerlevel10k.zsh # P10k theme config
│   └── completions.zsh   # Custom completions
├── aliases/              # Alias definitions
│   ├── core.zsh          # Essential aliases
│   ├── git.zsh           # Git shortcuts
│   ├── docker.zsh        # Docker commands
│   └── tools.zsh         # Development tools
├── functions/            # Custom functions
│   ├── core.zsh          # Utility functions
│   ├── dev.zsh           # Development helpers
│   └── system.zsh        # System utilities
├── secrets/              # Secure configurations
│   ├── secrets.zsh       # API tokens and keys
│   └── ssh-keys.zsh      # SSH key management
└── themes/               # Theme customizations
    └── p10k.zsh          # Powerlevel10k config
```

## 🎨 What You Get

### **Aliases**
```bash
# Git (safe, no conflicts)
gs     # git status
ga     # git add
gc     # git commit
gp     # git push
glog   # pretty git log

# Docker
d      # docker
dc     # docker-compose
dps    # docker ps with nice formatting
dlogs  # docker logs -f

# System
ll     # ls -alF
la     # ls -A
ports  # show listening ports
```

### **Functions**
```bash
# Development
killport 8080        # Kill process on port
gac "commit msg"     # Git add, commit in one command
proj myproject       # Jump to project directory
nx-new workspace     # Create new Nx workspace

# System utilities
extract file.tar.gz  # Smart extraction
backup myfile        # Timestamped backup
sysinfo             # System information
weather Toronto      # Weather info
```

### **Performance Features**
- ⚡ **Lazy loading** - mise, gcloud, heavy tools load on demand
- 🧠 **Smart completions** - Fast and context-aware
- 📊 **50k history** - With deduplication and search
- 🔄 **Auto cleanup** - Temporary files cleaned automatically

## 🔧 Customization

### Adding Aliases
Edit or create files in `~/.config/zsh/aliases/`:
```bash
# Create custom aliases
echo 'alias myalias="my command"' >> ~/.config/zsh/aliases/custom.zsh
```

### Adding Functions
Edit or create files in `~/.config/zsh/functions/`:
```bash
# Add to ~/.config/zsh/functions/custom.zsh
myfunction() {
  echo "Custom function"
}
```

### Configuring Secrets (1Password Integration)
Set up secure secrets management:
```zsh
# 1. Install 1Password CLI (if not already installed)
brew install --cask 1password-cli

# 2. Sign in to 1Password
op signin

# 3. Create secrets in your vault
op item create --vault="Contracts" --title="my_api_token" --category="API Credential" credential="your-secret-here"

# 4. Configure in secrets.zsh
code ~/.config/zsh/secrets/secrets.zsh

# 5. Test the setup
~/.config/zsh/manage_secrets.zsh test
```

**Snake_case naming convention**: All secrets should use snake_case names (e.g., `my_api_token`, `github_access_token`)

## 🔄 Management Commands

### Update Configuration
```zsh
~/.config/zsh/update.zsh
```

### Test Configuration
```zsh
~/.config/zsh/test_config.zsh
```

### Quick Test
```zsh
~/.config/zsh/quick_test.zsh
```

### Manage Secrets
```zsh
# List all secrets
~/.config/zsh/manage_secrets.zsh list

# Test secrets loading
~/.config/zsh/manage_secrets.zsh test

# Add new secret
~/.config/zsh/manage_secrets.zsh add "secret_name" "secret_value"
```

### Uninstall
```zsh
~/.config/zsh/uninstall.zsh
```

## 🛠️ Prerequisites

The installer will automatically install these if missing:

- **Homebrew** - Package manager for macOS
- **Oh My Zsh** - ZSH framework
- **Powerlevel10k** - Modern theme
- **ZSH plugins** - autosuggestions, syntax highlighting, etc.
- **mise** - Version manager (replaces asdf)
- **1Password CLI** - Secure secrets management

## 🐛 Troubleshooting

### Shell doesn't load properly
```bash
# Test configuration
~/.config/zsh/test_config.zsh

# Check symlinks
ls -la ~/.zshrc ~/.zprofile ~/.p10k.zsh
```

### mise not working
```bash
# Check mise installation
which mise
mise --version

# Reinstall if needed
brew uninstall mise
brew install mise

# Activate in current shell
eval "$(mise activate zsh)"
```

### Reset to defaults
```zsh
# Uninstall and restore defaults
~/.config/zsh/uninstall.zsh
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) - ZSH framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Theme
- [mise](https://mise.jdx.dev/) - Version manager
- [1Password CLI](https://developer.1password.com/docs/cli) - Secrets management

---

**🎉 Enjoy your supercharged terminal!**

If you find this configuration helpful, please ⭐ star the repository!