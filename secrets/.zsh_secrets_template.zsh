# =============================================================================
# SECURE SECRETS MANAGEMENT - 1PASSWORD INTEGRATION
# =============================================================================
# Template for securely managing secrets via 1Password CLI
# Uses the "Contracts" vault as specified
# Tags: contracts/lcl,business

# Check if 1Password CLI is available
if command -v op &> /dev/null; then
    # Ensure we're signed in to 1Password
    if ! op account list &> /dev/null; then
        echo "🔐 Please sign in to 1Password CLI first: op signin"
        return 1
    fi
    
    # Function to securely load secrets from 1Password
    load_secret() {
        local item_name="$1"
        local field_name="$2"
        local vault="Contracts"
        
        if [[ -z "$item_name" || -z "$field_name" ]]; then
            echo "Usage: load_secret <item_name> <field_name>"
            return 1
        fi
        
        # Attempt to get secret from 1Password
        local secret=$(op item get "$item_name" --vault="$vault" --field="$field_name" 2>/dev/null)
        
        if [[ -n "$secret" ]]; then
            echo "$secret"
        else
            echo "⚠️  Failed to load $field_name from $item_name in vault $vault"
            return 1
        fi
    }
    
    # Load your secrets securely
    # All items should be tagged with: contracts/lcl,business
    
    # GitLab Token
    GITLAB_ACCESS_TOKEN=$(load_secret "GitLab-Dev-Access" "access_token")
    if [[ -n "$GITLAB_ACCESS_TOKEN" ]]; then
        export GITLAB_ACCESS_TOKEN
    fi
    
    # Bit Token  
    BIT_TOKEN=$(load_secret "Bit-Dev-Tools" "token")
    if [[ -n "$BIT_TOKEN" ]]; then
        export BIT_TOKEN
    fi
    
    # Garfield API Key
    GARFIELLD_API_KEY=$(load_secret "Garfield-API" "api_key")
    if [[ -n "$GARFIELLD_API_KEY" ]]; then
        export GARFIELLD_API_KEY
    fi
    
    # Add more secrets as needed
    # Example:
    # OPENAI_API_KEY=$(load_secret "OpenAI-API" "api_key")
    # export OPENAI_API_KEY
    
else
    echo "⚠️  1Password CLI not found. Install with: brew install --cask 1password-cli"
    echo "    Then run: op signin to authenticate"
fi

# =============================================================================
# SSH KEY MANAGEMENT
# =============================================================================

# Function to load SSH passphrase from 1Password
load_ssh_passphrase() {
    local ssh_key_name="$1"
    local vault="Contracts"
    
    if [[ -z "$ssh_key_name" ]]; then
        echo "Usage: load_ssh_passphrase <ssh_key_item_name>"
        return 1
    fi
    
    # Load SSH passphrase from 1Password
    local passphrase=$(op item get "$ssh_key_name" --vault="$vault" --field="passphrase" 2>/dev/null)
    
    if [[ -n "$passphrase" ]]; then
        echo "$passphrase"
    else
        echo "⚠️  Failed to load SSH passphrase from $ssh_key_name in vault $vault"
        return 1
    fi
}

# =============================================================================
# SECURE ENVIRONMENT VARIABLES
# =============================================================================

# Set secure defaults for sensitive operations
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK

# Ensure secure permissions on this file
chmod 600 "$0" 2>/dev/null

# Clear sensitive variables on shell exit
trap 'unset GITLAB_ACCESS_TOKEN BIT_TOKEN GARFIELLD_API_KEY' EXIT

# =============================================================================
# CONFIRMATION NEEDED
# =============================================================================
echo "📋 Please confirm SSH key setup:"
echo "   Where is your SSH key passphrase stored in 1Password?"
echo "   - Item name in 'Contracts' vault: [PLEASE SPECIFY]"
echo "   - Field name for passphrase: [PLEASE SPECIFY]"
echo ""
echo "🏷️  Remember to tag all new 1Password items with: contracts/lcl,business"