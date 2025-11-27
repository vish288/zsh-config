# =============================================================================
# HELPER FUNCTIONS - Alias discovery and shell utilities
# =============================================================================

# Show available aliases by category
alias-help() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  SHELL ALIASES"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Core: ll, la, lt, .., ..., reload"
    echo "Git:  gs, ga, gc, gp, gpl, glog, gb"
    echo "pnpm: pn, pni, pnr, pnb, pnt"
    echo "Docker: d, dc, dps, dcu, dcd, dlogs"
    echo "K8s:  k, kgp, kgs, kdp, kl"
    echo ""
    echo "Use: alias-show <category> | alias-find <term>"
    echo "Categories: core, git, docker, tools, all"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Show aliases by category
alias-show() {
    local cat="${1:-all}"
    case "$cat" in
        core)   alias | grep -E '^(ll|la|l|lt|lss|lsd|reload|cl|h|j|rm|cp|mv)=' ;;
        git)    alias | grep -E '^g[a-z]+=' ;;
        docker) alias | grep -E '^d[a-z]*=' ;;
        tools)  alias | grep -E '^(pn|py|pip|gw|k)[a-z]*=' ;;
        all)    alias | sort ;;
        *)      echo "Unknown: $cat (use: core, git, docker, tools, all)" ;;
    esac
}

# Search aliases
alias-find() {
    [[ -z "$1" ]] && { echo "Usage: alias-find <term>"; return 1; }
    alias | grep -i "$1"
}
