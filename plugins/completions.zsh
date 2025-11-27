# =============================================================================
# COMPLETION CONFIGURATION
# =============================================================================
# Note: OMZ already runs compinit, this file only adds extra settings

# Completion options
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH

# Homebrew completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
