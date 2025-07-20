# =============================================================================
# OH MY ZSH CONFIGURATION
# =============================================================================

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="powerlevel10k/powerlevel10k"

# Custom folder for Oh My Zsh
ZSH_CUSTOM=~/.oh-my-zsh/custom/

# Plugins configuration - optimized for performance
plugins=(
  # Core productivity
  git
  kubectl
  docker
  docker-compose
  gradle
  npm
  node
  gcloud
  
  # Enhanced shell experience
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
  you-should-use
  macos
  
  # Performance and productivity
  history-substring-search
  copypath
  copyfile
  extract
  jsontools
  sudo
  colored-man-pages
  command-not-found
  
  # Development workflow
  vscode
  brew
  aliases
)

# Plugin configurations
export ZSH_PLUGINS_ALIAS_TIPS_FORMAT="💡 %s"
export YSU_MESSAGE_FORMAT="\n✨ $(tput bold)Alias available: %alias$(tput sgr0)"

# Autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Key bindings
bindkey '^ ' autosuggest-accept
bindkey '^[f' autosuggest-accept  # Alt+f to accept suggestion

# History search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Better navigation
bindkey '^[[1;5C' forward-word    # Ctrl+Right
bindkey '^[[1;5D' backward-word   # Ctrl+Left
bindkey '^H' backward-kill-word   # Ctrl+Backspace
bindkey '^[[3;5~' kill-word       # Ctrl+Delete

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh