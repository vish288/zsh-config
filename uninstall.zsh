#!/usr/bin/env zsh

# =============================================================================
# ZSH CONFIGURATION UNINSTALLER
# =============================================================================
# Removes the organized zsh configuration and restores system defaults

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

CONFIG_DIR="$HOME/.config/zsh"
BACKUP_DIR="$HOME/.zsh-uninstall-backup-$(date +%Y%m%d_%H%M%S)"

print_header() {
    echo -e "${RED}===============================================${NC}"
    echo -e "${RED}🗑️  ZSH Configuration Uninstaller${NC}"
    echo -e "${RED}===============================================${NC}"
}

print_step() {
    echo -e "${GREEN}▶${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

backup_current() {
    print_step "Creating backup before uninstall..."
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup current configuration
    if [[ -d "$CONFIG_DIR" ]]; then
        cp -r "$CONFIG_DIR" "$BACKUP_DIR/"
        print_success "Configuration backed up"
    fi
    
    # Backup current shell files
    for file in .zshrc .zprofile .p10k.zsh; do
        if [[ -f "$HOME/$file" || -L "$HOME/$file" ]]; then
            cp -L "$HOME/$file" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done
    
    echo -e "${GREEN}📦 Backup created at: $BACKUP_DIR${NC}"
}

remove_symlinks() {
    print_step "Removing configuration symlinks..."
    
    for file in .zshrc .zprofile .p10k.zsh; do
        if [[ -L "$HOME/$file" ]]; then
            rm "$HOME/$file"
            print_success "Removed $file symlink"
        fi
    done
}

restore_defaults() {
    print_step "Restoring default zsh configuration..."
    
    # Create minimal .zshrc
    cat > "$HOME/.zshrc" << 'EOF'
# Default zsh configuration
# Restored by zsh-config uninstaller

# Basic aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable basic completion
autoload -Uz compinit
compinit

echo "Default zsh configuration restored"
echo "You can customize this file or reinstall a configuration manager"
EOF

    # Create minimal .zprofile
    cat > "$HOME/.zprofile" << 'EOF'
# Default zsh profile
# Restored by zsh-config uninstaller

# Homebrew (if installed)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
EOF

    print_success "Default configuration files created"
}

remove_config_directory() {
    print_step "Removing configuration directory..."
    
    if [[ -d "$CONFIG_DIR" ]]; then
        read -p "Remove ~/.config/zsh directory? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$CONFIG_DIR"
            print_success "Configuration directory removed"
        else
            print_warning "Configuration directory preserved"
        fi
    fi
}

cleanup_oh_my_zsh() {
    print_step "Oh My Zsh cleanup options..."
    
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Oh My Zsh is installed. Options:"
        echo "1. Keep Oh My Zsh (recommended)"
        echo "2. Remove Oh My Zsh completely"
        echo "3. Skip"
        read -p "Choose (1-3): " -n 1 -r
        echo
        
        case $REPLY in
            2)
                print_warning "Removing Oh My Zsh..."
                rm -rf "$HOME/.oh-my-zsh"
                print_success "Oh My Zsh removed"
                ;;
            1|3|*)
                print_success "Oh My Zsh preserved"
                ;;
        esac
    fi
}

main() {
    print_header
    
    echo "This will uninstall the zsh configuration and restore defaults."
    echo "Your current configuration will be backed up first."
    echo ""
    read -p "Continue with uninstall? (y/N): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Uninstall cancelled."
        exit 0
    fi
    
    backup_current
    remove_symlinks
    restore_defaults
    remove_config_directory
    cleanup_oh_my_zsh
    
    echo ""
    echo -e "${GREEN}🎉 Uninstall completed!${NC}"
    echo ""
    echo "What was done:"
    echo "✓ Current configuration backed up"
    echo "✓ Symlinks removed"
    echo "✓ Default .zshrc and .zprofile restored"
    echo ""
    echo -e "${BLUE}Backup location: $BACKUP_DIR${NC}"
    echo ""
    echo "Restart your terminal to use the default configuration."
}

main "$@"