# =============================================================================
# MODERN TOOLS INTEGRATION - zoxide, fzf
# =============================================================================

# Zoxide - smarter cd command
# Usage: z <partial-path> to jump to frequently used directories
#        zi              - interactive selection with fzf
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"

    # Enable zoxide interactive mode with fzf (zi command)
    # This shows ranked directories you can fuzzy-search through
fi

# FZF - fuzzy finder
# Usage: Ctrl+T (files), Ctrl+R (history), Alt+C (cd)
if command -v fzf &>/dev/null; then
    # Try Homebrew fzf setup first, fallback to generic
    if [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]]; then
        source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
        source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
    elif [[ -f ~/.fzf.zsh ]]; then
        source ~/.fzf.zsh
    fi

    # FZF configuration
    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --info=inline
        --preview-window=right:50%:wrap
    "

    # Use fd if available (faster than find)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi
fi
