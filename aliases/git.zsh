# =============================================================================
# GIT ALIASES - Safe git shortcuts
# =============================================================================

# Basic git operations
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gr='git remote -v'

# Enhanced git commands
alias gst='git status --short'
alias glog='git log --oneline --graph --decorate --all -10'
alias gdiff='git diff --color-words'
alias gfetch='git fetch --all --prune'
alias gclean='git clean -fd'
alias gstash='git stash save'
alias gpop='git stash pop'

# Branch management
alias gbr='git branch -r'
alias gba='git branch -a'
alias gbm='git branch -m'
alias gbd='git branch -d'

# Useful git combinations
alias gadd='git add -A'
alias gcommit='git commit -v'
alias gamend='git commit --amend'
alias greset='git reset --hard HEAD'