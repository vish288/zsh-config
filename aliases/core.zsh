# =============================================================================
# CORE ALIASES - Safe, essential aliases only
# =============================================================================

# Enhanced ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -altr'     # Sort by time
alias lss='ls -alhS'    # Sort by size
alias lsd='ls -la | grep ^d'  # Directories only

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# System shortcuts
alias reload='source ~/.zshrc && echo "🔄 .zshrc reloaded!"'
alias zshconfig='code ~/.config/zsh/zshrc'
alias cl='clear'
alias h='history'
alias j='jobs'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# System information
alias df='df -h'
alias du='du -h'
alias free='top -l 1 | head -n 10 | grep PhysMem'
alias ps='ps auxf'

# Network utilities
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'

# Quick editors
alias v='vim'
alias c='code'
alias nano='nano -c'

# Productivity shortcuts
alias wget='wget -c'
alias json='jq .'