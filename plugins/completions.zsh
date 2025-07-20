# =============================================================================
# COMPLETION SYSTEM CONFIGURATION
# =============================================================================

# Performance optimizations for completions
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Completion options
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
setopt COMPLETE_ALIASES

# Homebrew completions (if available)
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Development tool completions
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

if command -v docker &> /dev/null; then
    complete -f docker
fi