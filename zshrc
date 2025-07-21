# =============================================================================
# ORGANIZED ZSH CONFIGURATION
# =============================================================================
# Modular, performance-optimized zsh configuration
# Location: ~/.config/zsh/zshrc

# =============================================================================
# PERFORMANCE OPTIMIZATIONS
# =============================================================================

# History optimization
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Directory navigation optimization
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# =============================================================================
# ENVIRONMENT SETUP
# =============================================================================

# Java Home Configuration (prioritize newer versions)
if [[ -d "/opt/homebrew/opt/openjdk@21" ]]; then
  export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
  export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
elif [[ -d "/Library/Java/JavaVirtualMachines/jdk-14.0.2.jdk/Contents/Home" ]]; then
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-14.0.2.jdk/Contents/Home"
else
  export JAVA_HOME=$(/usr/libexec/java_home -v 17 2>/dev/null || /usr/libexec/java_home)
fi

# Node.js Version Management
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true

# =============================================================================
# PATH CONFIGURATIONS
# =============================================================================

# pnpm configuration
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Custom bin directory
case ":$PATH:" in
  *":$HOME/bin:"*) ;;
  *) export PATH="$PATH:$HOME/bin" ;;
esac

# =============================================================================
# ASDF SETUP (Lazy loading for performance)
# =============================================================================

# Initialize asdf when first used
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  function asdf() {
    unfunction asdf
    source /opt/homebrew/opt/asdf/libexec/asdf.sh
    # Also source completions
    source /opt/homebrew/opt/asdf/etc/bash_completion.d/asdf
    asdf "$@"
  }

  # Auto-load asdf shims into PATH
  export PATH="$HOME/.asdf/shims:$PATH"
fi

# =============================================================================
# MODULAR CONFIGURATION LOADING
# =============================================================================

# Load Powerlevel10k instant prompt first
source ~/.config/zsh/plugins/powerlevel10k.zsh

# Load Oh My Zsh and plugins
source ~/.config/zsh/plugins/oh-my-zsh.zsh

# Load completions
source ~/.config/zsh/plugins/completions.zsh

# Load aliases
for alias_file in ~/.config/zsh/aliases/*.zsh; do
  [[ -f "$alias_file" ]] && source "$alias_file"
done

# Load functions
for function_file in ~/.config/zsh/functions/*.zsh; do
  [[ -f "$function_file" ]] && source "$function_file"
done

# Load secrets (if available)
for secret_file in ~/.config/zsh/secrets/*.zsh; do
  [[ -f "$secret_file" ]] && source "$secret_file"
done

# =============================================================================
# GOOGLE CLOUD SDK (Lazy loading)
# =============================================================================

function gcloud() {
  unfunction gcloud
  local gcloud_path="$HOME/Workspace/LcL-SDM/setup/google-cloud-sdk"
  [[ -f "$gcloud_path/path.zsh.inc" ]] && source "$gcloud_path/path.zsh.inc"
  [[ -f "$gcloud_path/completion.zsh.inc" ]] && source "$gcloud_path/completion.zsh.inc"
  gcloud "$@"
}

# =============================================================================
# SSH AGENT SETUP (1Password)
# =============================================================================

# Use 1Password SSH agent
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# Verify 1Password SSH agent is available
if [[ -S "$SSH_AUTH_SOCK" ]]; then
  # 1Password SSH agent handles key loading automatically
  # No need to manually load keys - they're managed by 1Password
  true
else
  echo "Warning: 1Password SSH agent not found. Ensure 1Password is running and SSH agent is enabled."
  # Fallback to system SSH agent
  if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" >/dev/null 2>&1
    # Load keys manually as fallback
    ssh-add ~/.ssh/github-vish 2>/dev/null || true
    ssh-add ~/.ssh/id_rsa 2>/dev/null || true
  fi
fi

# =============================================================================
# SECURITY AND CLEANUP
# =============================================================================

# Secure permissions on startup
umask 022

# Clean up temporary files occasionally (1% chance)
if [[ $(( RANDOM % 100 )) -eq 0 ]]; then
  find /tmp -name "zsh*" -mtime +7 -delete 2>/dev/null || true
  find ~/.zcompdump* -mtime +7 -delete 2>/dev/null || true
fi

# =============================================================================
# WELCOME MESSAGE
# =============================================================================

# Load enhanced welcome message if available
[[ -f ~/.cowsay_welcome.zsh ]] && source ~/.cowsay_welcome.zsh

# Performance monitoring (uncomment for debugging)
# [[ -n "${ZSH_DEBUGRC+1}" ]] && zprof
