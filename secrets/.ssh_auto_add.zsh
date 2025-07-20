# =============================================================================
# SSH AUTO-ADD WITH 1PASSWORD INTEGRATION
# =============================================================================
# Automatically loads SSH keys with passphrases from 1Password
# Tags: contracts/lcl,business

# Function to add SSH keys automatically
ssh_auto_add() {
    # Check if ssh-agent is running
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        echo "🔐 Starting ssh-agent..."
        eval "$(ssh-agent -s)"
    fi
    
    # Check if 1Password CLI is available for passphrase loading
    if command -v op &> /dev/null && op account list &> /dev/null 2>&1; then
        echo "🔑 Loading SSH keys with 1Password integration..."
        
        # TODO: Update these with your actual SSH key details
        # SSH_KEY_PATH="$HOME/.ssh/id_rsa"  # or id_ed25519, etc.
        # SSH_PASSPHRASE_ITEM="lcl-gitlab-key"  # 1Password item name
        # SSH_PASSPHRASE_FIELD="passphrase"   # Field name in 1Password
        
        # Example SSH key loading (uncomment and customize):
        # if [[ -f "$SSH_KEY_PATH" ]]; then
        #     passphrase=$(op item get "$SSH_PASSPHRASE_ITEM" --vault="Contracts" --field="$SSH_PASSPHRASE_FIELD" 2>/dev/null)
        #     if [[ -n "$passphrase" ]]; then
        #         echo "$passphrase" | ssh-add "$SSH_KEY_PATH" 2>/dev/null
        #         if [[ $? -eq 0 ]]; then
        #             echo "✅ SSH key loaded successfully"
        #         else
        #             echo "❌ Failed to load SSH key"
        #         fi
        #     else
        #         echo "⚠️  Could not retrieve SSH passphrase from 1Password"
        #     fi
        # fi
        
        echo "⚠️  SSH auto-add template ready - please configure with your SSH key details"
        
    else
        echo "🔐 Loading SSH keys with standard ssh-add..."
        # Fallback to standard ssh-add (will prompt for passphrase)
        if [[ -f "$HOME/.ssh/id_rsa" ]]; then
            ssh-add "$HOME/.ssh/id_rsa" 2>/dev/null
        fi
        if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
            ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null
        fi
    fi
    
    # Show loaded keys
    echo "🔍 Currently loaded SSH keys:"
    ssh-add -l 2>/dev/null || echo "   No SSH keys loaded"
}

# Function to configure SSH auto-add
configure_ssh_auto_add() {
    echo "🔧 SSH Auto-Add Configuration"
    echo "==============================="
    echo ""
    echo "Please provide the following information:"
    echo ""
    read -p "1. SSH key file path (e.g., ~/.ssh/id_rsa): " ssh_key_path
    read -p "2. 1Password item name for SSH key: " ssh_item_name  
    read -p "3. 1Password field name for passphrase: " ssh_field_name
    echo ""
    echo "Configuration to add to this file:"
    echo "SSH_KEY_PATH=\"$ssh_key_path\""
    echo "SSH_PASSPHRASE_ITEM=\"$ssh_item_name\""
    echo "SSH_PASSPHRASE_FIELD=\"$ssh_field_name\""
    echo ""
    echo "🏷️  Remember to tag '$ssh_item_name' in 1Password with: contracts/lcl,business"
}

# Auto-run SSH setup on shell startup (uncomment when configured)
# ssh_auto_add

# Uncomment the line below to run configuration helper
# configure_ssh_auto_add
