# =============================================================================
# ZSH CONFIGURATION - Optimized & Clean
# =============================================================================

# =============================================================================
# PERFORMANCE OPTIMIZATIONS
# =============================================================================

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS

setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT

# =============================================================================
# PATH CONFIGURATION (minimal - most tools via mise)
# =============================================================================

# JetBrains Toolbox scripts
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] && \
    export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# =============================================================================
# VERSION MANAGER (mise handles: node, python, pnpm, java, gcloud, lazygit)
# =============================================================================

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# =============================================================================
# SSH AGENT (1Password)
# =============================================================================

export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# Fallback to system SSH agent if 1Password socket unavailable
if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    unset SSH_AUTH_SOCK
    eval "$(ssh-agent -s)" >/dev/null 2>&1
    ssh-add --apple-use-keychain 2>/dev/null || true
fi

# =============================================================================
# MODULAR CONFIGURATION LOADING
# =============================================================================

# Powerlevel10k instant prompt (must be first)
source ~/.config/zsh/plugins/powerlevel10k.zsh

# Oh My Zsh and plugins
source ~/.config/zsh/plugins/oh-my-zsh.zsh

# Aliases
for f in ~/.config/zsh/aliases/*.zsh; do [[ -f "$f" ]] && source "$f"; done

# Functions
for f in ~/.config/zsh/functions/*.zsh; do [[ -f "$f" ]] && source "$f"; done

# Secrets (lazy-loading)
for f in ~/.config/zsh/secrets/*.zsh; do [[ -f "$f" ]] && source "$f"; done

# Claude Code aliases
[[ -f ~/.zshrc_claude_aliases ]] && source ~/.zshrc_claude_aliases

# =============================================================================
# SECURITY
# =============================================================================

umask 022

# =============================================================================
# WELCOME (repo-aware cowsay)
# =============================================================================

_show_welcome
