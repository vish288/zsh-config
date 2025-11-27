#!/usr/bin/env zsh

# =============================================================================
# ZSH CONFIGURATION INSTALLER
# =============================================================================
# Installs the organized zsh configuration on any macOS system
# Author: Your Name
# Repository: https://github.com/vish288/zsh-config

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/vish288/zsh-config.git"
CONFIG_DIR="$HOME/.config/zsh"
BACKUP_DIR="$HOME/.zsh-backup-$(date +%Y%m%d_%H%M%S)"

# Helper functions
print_header() {
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BLUE}🚀 ZSH Configuration Installer${NC}"
    echo -e "${BLUE}===============================================${NC}"
}

print_step() {
    echo -e "${GREEN}▶${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Retry with exponential backoff
retry_with_backoff() {
    local max_attempts=${1:-3}
    local delay=${2:-2}
    local attempt=1
    shift 2
    local cmd="$@"

    while [[ $attempt -le $max_attempts ]]; do
        if eval "$cmd"; then
            return 0
        fi
        if [[ $attempt -lt $max_attempts ]]; then
            print_warning "Attempt $attempt failed, retrying in ${delay}s..."
            sleep $delay
            delay=$((delay * 2))
        fi
        attempt=$((attempt + 1))
    done
    return 1
}

# Backup existing configuration
backup_existing() {
    print_step "Backing up existing zsh configuration..."

    mkdir -p "$BACKUP_DIR"

    for file in .zshrc .zprofile .p10k.zsh .zsh_history; do
        if [[ -f "$HOME/$file" || -L "$HOME/$file" ]]; then
            cp -L "$HOME/$file" "$BACKUP_DIR/" 2>/dev/null || true
            print_success "Backed up $file"
        fi
    done

    if [[ -d "$HOME/.config/zsh" ]]; then
        cp -r "$HOME/.config/zsh" "$BACKUP_DIR/config-zsh" 2>/dev/null || true
        print_success "Backed up existing .config/zsh"
    fi

    echo -e "${GREEN}📦 Backup created at: $BACKUP_DIR${NC}"
}

# Install prerequisites
install_prerequisites() {
    print_step "Installing prerequisites..."

    # Check for Homebrew
    if ! command_exists brew; then
        print_warning "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew available"

    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_warning "Oh My Zsh not found. Installing..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    print_success "Oh My Zsh available"

    # Install Powerlevel10k theme
    local p10k_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        print_warning "Powerlevel10k not found. Installing..."
        retry_with_backoff 3 2 "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git '$p10k_dir'" || {
            print_error "Failed to install Powerlevel10k"
            return 1
        }
    fi
    print_success "Powerlevel10k available"

    # Install zsh plugins
    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"

    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        retry_with_backoff 3 2 "git clone https://github.com/zsh-users/zsh-autosuggestions '$plugins_dir/zsh-autosuggestions'"
    fi

    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        retry_with_backoff 3 2 "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git '$plugins_dir/zsh-syntax-highlighting'"
    fi

    if [[ ! -d "$plugins_dir/you-should-use" ]]; then
        retry_with_backoff 3 2 "git clone https://github.com/MichaelAquilina/zsh-you-should-use.git '$plugins_dir/you-should-use'"
    fi

    print_success "ZSH plugins installed"

    # Install mise if not present
    if ! command_exists mise; then
        print_warning "mise not found. Installing..."
        brew install mise
    fi
    print_success "mise available"

    # Install 1Password CLI
    if ! command_exists op; then
        print_warning "1Password CLI not found. Installing..."
        brew install --cask 1password-cli
    fi
    print_success "1Password CLI available"
}

# Clone or update configuration
install_config() {
    print_step "Installing zsh configuration..."

    if [[ -d "$CONFIG_DIR/.git" ]]; then
        print_warning "Configuration directory exists. Updating..."
        cd "$CONFIG_DIR"
        git pull origin main
    else
        print_warning "Cloning configuration repository..."
        rm -rf "$CONFIG_DIR"
        git clone "$REPO_URL" "$CONFIG_DIR"
    fi

    print_success "Configuration installed"
}

# Create symlinks
create_symlinks() {
    print_step "Creating symlinks..."

    # Remove existing files/symlinks
    for file in .zshrc .zprofile .p10k.zsh; do
        [[ -f "$HOME/$file" || -L "$HOME/$file" ]] && rm "$HOME/$file"
    done

    # Create new symlinks
    ln -sf "$CONFIG_DIR/zshrc" "$HOME/.zshrc"
    ln -sf "$CONFIG_DIR/zprofile" "$HOME/.zprofile"
    ln -sf "$CONFIG_DIR/themes/p10k.zsh" "$HOME/.p10k.zsh"

    print_success "Symlinks created"
}

# Set up secrets template
setup_secrets() {
    print_step "Setting up secrets management..."

    local secrets_file="$CONFIG_DIR/secrets/secrets.zsh"
    if [[ ! -f "$secrets_file" ]]; then
        print_warning "Creating secrets template..."
        cat > "$secrets_file" << 'EOF'
# =============================================================================
# SECRETS MANAGEMENT
# =============================================================================
# Customize this file with your secrets
# Use 1Password CLI for secure secret management

# Example: Load secret from 1Password
# export GITLAB_ACCESS_TOKEN=$(op item get "GitLab Token" --field credential --vault "Development")

# Or set directly (less secure)
# export GITLAB_ACCESS_TOKEN="your-token-here"

echo "💡 Secrets loaded. Configure your tokens in ~/.config/zsh/secrets/secrets.zsh"
EOF
    fi

    # Set proper permissions
    chmod 600 "$CONFIG_DIR"/secrets/*.zsh

    print_success "Secrets template ready"
}

# Test installation
test_installation() {
    print_step "Testing installation..."

    # Test new shell
    if zsh -l -c "source ~/.zshrc && echo 'Configuration loaded successfully'" >/dev/null 2>&1; then
        print_success "ZSH configuration loads correctly"
    else
        print_error "ZSH configuration failed to load"
        return 1
    fi

    # Test mise
    if zsh -c "mise --version" >/dev/null 2>&1; then
        print_success "mise working"
    else
        print_warning "mise not working - may need manual setup"
    fi

    print_success "Installation test completed"
}

# Main installation function
main() {
    print_header

    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This installer is designed for macOS only"
        exit 1
    fi

    echo "This will install a comprehensive zsh configuration on your system."
    echo "Your existing configuration will be backed up."
    echo ""
    read -p "Continue? (y/N): " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    backup_existing
    install_prerequisites
    install_config
    create_symlinks
    setup_secrets
    test_installation

    echo ""
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Restart your terminal or run: exec zsh"
    echo "2. Configure your secrets in: ~/.config/zsh/secrets/secrets.zsh"
    echo "3. Install Node.js versions: mise install node@lts"
    echo "4. Customize aliases in: ~/.config/zsh/aliases/"
    echo ""
    echo -e "${BLUE}Backup location: $BACKUP_DIR${NC}"
    echo -e "${BLUE}Configuration: $CONFIG_DIR${NC}"
}

# Run installer
main "$@"
