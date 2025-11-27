# =============================================================================
# OH MY ZSH CONFIGURATION
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM=~/.oh-my-zsh/custom/

# Plugins - minimal, no redundancy with mise-managed tools
plugins=(
    # Git (essential)
    git

    # Container/K8s
    docker
    kubectl

    # Shell enhancements
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search
    you-should-use

    # Utilities
    sudo              # ESC ESC to prefix sudo
    copypath          # Copy current path
    extract           # Universal archive extraction
    colored-man-pages
    macos
)

# you-should-use config
export YSU_MESSAGE_FORMAT="💡 Alias: %alias"
export YSU_MODE=ALL

# Autosuggestions config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Key bindings (after OMZ load)
bindkey '^ ' autosuggest-accept
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
