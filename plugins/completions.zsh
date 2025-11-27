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

# Homebrew completions (cached prefix for performance)
if type brew &>/dev/null; then
    # Cache brew prefix - avoid running brew --prefix on every shell start (~50ms)
    : ${HOMEBREW_PREFIX:=$(brew --prefix)}
    FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
fi
