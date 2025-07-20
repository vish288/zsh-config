#!/usr/bin/env zsh

# =============================================================================
# ZSH CONFIGURATION UPDATER
# =============================================================================
# Updates the zsh configuration from the GitHub repository

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

CONFIG_DIR="$HOME/.config/zsh"
BACKUP_DIR="$HOME/.zsh-update-backup-$(date +%Y%m%d_%H%M%S)"

print_header() {
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BLUE}🔄 ZSH Configuration Updater${NC}"
    echo -e "${BLUE}===============================================${NC}"
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

print_error() {
    echo -e "${RED}✗${NC} $1"
}

check_git_repo() {
    if [[ ! -d "$CONFIG_DIR/.git" ]]; then
        print_error "Configuration directory is not a git repository"
        echo "Run the installer first: curl -fsSL https://raw.githubusercontent.com/yourusername/zsh-config/main/install.sh | bash"
        exit 1
    fi
}

backup_current() {
    print_step "Creating backup before update..."
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup current configuration
    if [[ -d "$CONFIG_DIR" ]]; then
        cp -r "$CONFIG_DIR" "$BACKUP_DIR/"
        print_success "Configuration backed up"
    fi
    
    echo -e "${GREEN}📦 Backup created at: $BACKUP_DIR${NC}"
}

update_configuration() {
    print_step "Updating configuration from repository..."
    
    cd "$CONFIG_DIR"
    
    # Check for local changes
    if ! git diff --quiet; then
        print_warning "Local changes detected!"
        echo "You have uncommitted changes. Options:"
        echo "1. Stash changes and update"
        echo "2. Commit changes first"
        echo "3. Cancel update"
        read -p "Choose (1-3): " -n 1 -r
        echo
        
        case $REPLY in
            1)
                git stash push -m "Auto-stash before update $(date)"
                print_success "Changes stashed"
                ;;
            2)
                print_warning "Please commit your changes and run update again"
                exit 0
                ;;
            3|*)
                print_warning "Update cancelled"
                exit 0
                ;;
        esac
    fi
    
    # Fetch and update
    git fetch origin
    
    # Check if updates are available
    local local_commit=$(git rev-parse HEAD)
    local remote_commit=$(git rev-parse origin/main)
    
    if [[ "$local_commit" == "$remote_commit" ]]; then
        print_success "Configuration is already up to date"
        return 0
    fi
    
    print_step "Applying updates..."
    git pull origin main
    
    # If there were stashed changes, offer to apply them
    if git stash list | grep -q "Auto-stash before update"; then
        echo ""
        read -p "Apply your stashed changes? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if git stash pop; then
                print_success "Stashed changes applied"
            else
                print_warning "Conflicts detected while applying stashes"
                echo "Please resolve conflicts manually"
            fi
        fi
    fi
    
    print_success "Configuration updated successfully"
}

update_plugins() {
    print_step "Updating Oh My Zsh and plugins..."
    
    # Update Oh My Zsh
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        cd "$HOME/.oh-my-zsh"
        git pull origin master 2>/dev/null || print_warning "Oh My Zsh update failed"
        print_success "Oh My Zsh updated"
    fi
    
    # Update plugins
    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
    
    for plugin_dir in "$plugins_dir"/*; do
        if [[ -d "$plugin_dir/.git" ]]; then
            local plugin_name=$(basename "$plugin_dir")
            cd "$plugin_dir"
            git pull origin master 2>/dev/null || git pull origin main 2>/dev/null || print_warning "$plugin_name update failed"
            print_success "$plugin_name updated"
        fi
    done
    
    # Update Powerlevel10k
    local p10k_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    if [[ -d "$p10k_dir/.git" ]]; then
        cd "$p10k_dir"
        git pull origin master 2>/dev/null || print_warning "Powerlevel10k update failed"
        print_success "Powerlevel10k updated"
    fi
}

test_configuration() {
    print_step "Testing updated configuration..."
    
    if zsh -l -c "source ~/.zshrc && echo 'Configuration test passed'" >/dev/null 2>&1; then
        print_success "Configuration loads correctly"
    else
        print_error "Configuration test failed"
        echo "Check the backup at: $BACKUP_DIR"
        return 1
    fi
}

show_changelog() {
    print_step "Recent changes:"
    
    cd "$CONFIG_DIR"
    echo ""
    git log --oneline -10 --pretty=format:"  %C(green)%h%C(reset) %s %C(dim)(%cr)%C(reset)"
    echo ""
}

main() {
    print_header
    
    check_git_repo
    backup_current
    update_configuration
    update_plugins
    test_configuration
    show_changelog
    
    echo ""
    echo -e "${GREEN}🎉 Update completed successfully!${NC}"
    echo ""
    echo "What was updated:"
    echo "✓ ZSH configuration from repository"
    echo "✓ Oh My Zsh and plugins"
    echo "✓ Powerlevel10k theme"
    echo ""
    echo -e "${BLUE}Backup location: $BACKUP_DIR${NC}"
    echo ""
    echo "Restart your terminal to use the updated configuration."
}

main "$@"