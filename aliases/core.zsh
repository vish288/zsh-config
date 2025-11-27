# =============================================================================
# CORE ALIASES - Essential system shortcuts
# =============================================================================

# Enhanced ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -altr'     # Sort by time
alias lss='ls -alhS'    # Sort by size
alias lsd='ls -la | grep ^d'  # Directories only

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# System shortcuts
alias reload='source ~/.zshrc && echo "🔄 .zshrc reloaded!"'
alias cl='clear'
alias h='history'
alias j='jobs'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# System information (macOS optimized)
alias df='df -h'
alias du='du -h'
alias mem='vm_stat'
alias cpu='top -l 1 | head -n 10'

# Network (macOS compatible)
alias ping='ping -c 5'
# Note: ports() and myip() functions in system.zsh provide more detail

# Quick editors
alias v='vim'
alias nano='nano -c'

# Productivity
alias wget='wget -c'
alias json='jq .'
