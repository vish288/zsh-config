# =============================================================================
# SYSTEM UPDATE FUNCTIONS - Unified update management
# =============================================================================
# Usage:
#   update-all           - Update everything (graceful, retry on failure)
#   update-brew          - Homebrew packages (zsh plugins via brew if installed)
#   update-mise          - mise-managed tools (node, python, pnpm, java, etc)
#   update-omz           - Oh My Zsh + plugins only
#   update-pnpm-globals  - Global pnpm packages only
#   update-status        - Check what needs updating

# Color codes
_UPD_RED='\033[0;31m'
_UPD_GREEN='\033[0;32m'
_UPD_YELLOW='\033[1;33m'
_UPD_BLUE='\033[0;34m'
_UPD_NC='\033[0m'

# State tracking
typeset -gA _UPDATE_RESULTS

_upd_log() { echo -e "${_UPD_BLUE}▶${_UPD_NC} $1"; }
_upd_ok() { echo -e "${_UPD_GREEN}✓${_UPD_NC} $1"; }
_upd_warn() { echo -e "${_UPD_YELLOW}⚠${_UPD_NC} $1"; }
_upd_err() { echo -e "${_UPD_RED}✗${_UPD_NC} $1"; }

# Retry wrapper - retries command up to N times
_retry() {
    local max_attempts=${1:-2}
    local delay=${2:-3}
    shift 2
    local cmd="$@"
    local attempt=1

    while (( attempt <= max_attempts )); do
        if eval "$cmd"; then
            return 0
        fi
        if (( attempt < max_attempts )); then
            _upd_warn "Attempt $attempt failed, retrying in ${delay}s..."
            sleep $delay
        fi
        ((attempt++))
    done
    return 1
}

# =============================================================================
# INDIVIDUAL UPDATE FUNCTIONS
# =============================================================================

update-brew() {
    _upd_log "Updating Homebrew packages..."
    local failed=0

    if ! _retry 2 3 "brew update"; then
        _upd_err "brew update failed"
        _UPDATE_RESULTS[brew]="failed"
        return 1
    fi

    local outdated=$(brew outdated --formula 2>/dev/null)
    if [[ -z "$outdated" ]]; then
        _upd_ok "All brew packages up to date"
        _UPDATE_RESULTS[brew]="up-to-date"
        return 0
    fi

    echo "Outdated: $outdated"
    if ! _retry 2 5 "brew upgrade"; then
        _upd_err "brew upgrade failed"
        failed=1
    fi

    # Cleanup
    brew cleanup -s 2>/dev/null
    brew autoremove 2>/dev/null

    if (( failed )); then
        _UPDATE_RESULTS[brew]="partial"
        return 1
    fi
    _upd_ok "Homebrew updated"
    _UPDATE_RESULTS[brew]="updated"
    return 0
}

update-mise() {
    _upd_log "Updating mise-managed tools (node, python, pnpm, java, gcloud, lazygit)..."

    if ! command -v mise &>/dev/null; then
        _upd_warn "mise not installed"
        _UPDATE_RESULTS[mise]="skipped"
        return 0
    fi

    # Self-update mise
    if ! _retry 2 3 "mise self-update -y 2>/dev/null"; then
        _upd_warn "mise self-update failed (may require manual update)"
    fi

    # Show what's outdated
    _upd_log "Checking outdated tools..."
    mise outdated 2>/dev/null || true

    # Upgrade all tools to latest versions
    if ! _retry 2 5 "mise upgrade -y"; then
        _upd_err "mise upgrade failed"
        _UPDATE_RESULTS[mise]="failed"
        return 1
    fi

    # Prune old versions
    mise prune -y 2>/dev/null

    _upd_ok "mise tools updated"
    _UPDATE_RESULTS[mise]="updated"
    return 0
}

update-omz() {
    _upd_log "Updating Oh My Zsh and plugins..."
    local failed=0

    # Update Oh My Zsh
    if [[ -d "$HOME/.oh-my-zsh/.git" ]]; then
        if ! git -C "$HOME/.oh-my-zsh" pull --rebase origin master 2>/dev/null; then
            _upd_warn "Oh My Zsh update failed"
            failed=1
        else
            _upd_ok "Oh My Zsh updated"
        fi
    fi

    # Update custom plugins
    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
    for plugin_dir in "$plugins_dir"/*; do
        if [[ -d "$plugin_dir/.git" ]]; then
            local plugin_name=$(basename "$plugin_dir")
            if git -C "$plugin_dir" pull --rebase 2>/dev/null; then
                _upd_ok "$plugin_name updated"
            else
                _upd_warn "$plugin_name update failed"
                failed=1
            fi
        fi
    done

    # Update Powerlevel10k
    local p10k_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    if [[ -d "$p10k_dir/.git" ]]; then
        if git -C "$p10k_dir" pull --rebase 2>/dev/null; then
            _upd_ok "Powerlevel10k updated"
        else
            _upd_warn "Powerlevel10k update failed"
            failed=1
        fi
    fi

    if (( failed )); then
        _UPDATE_RESULTS[omz]="partial"
        return 1
    fi
    _UPDATE_RESULTS[omz]="updated"
    return 0
}

update-pnpm-globals() {
    _upd_log "Updating global pnpm packages..."

    if ! command -v pnpm &>/dev/null; then
        _upd_warn "pnpm not found (should be managed by mise)"
        _UPDATE_RESULTS[pnpm]="skipped"
        return 0
    fi

    # List global packages
    local globals=$(command pnpm list -g --depth=0 2>/dev/null | tail -n +2)
    if [[ -z "$globals" ]]; then
        _upd_ok "No global pnpm packages installed"
        _UPDATE_RESULTS[pnpm]="up-to-date"
        return 0
    fi

    echo "Global packages: "
    echo "$globals"

    if ! _retry 2 5 "command pnpm update -g"; then
        _upd_err "pnpm global update failed"
        _UPDATE_RESULTS[pnpm]="failed"
        return 1
    fi

    _upd_ok "Global pnpm packages updated"
    _UPDATE_RESULTS[pnpm]="updated"
    return 0
}

update-zsh-config() {
    _upd_log "Updating ZSH configuration..."

    local config_dir="$HOME/.config/zsh"
    if [[ ! -d "$config_dir/.git" ]]; then
        _upd_warn "ZSH config not a git repo, skipping"
        _UPDATE_RESULTS[zsh-config]="skipped"
        return 0
    fi

    cd "$config_dir"

    # Stash local changes
    local had_changes=0
    if ! git diff --quiet; then
        git stash push -m "auto-stash before update" 2>/dev/null
        had_changes=1
    fi

    if ! git pull --rebase origin main 2>/dev/null && ! git pull --rebase origin master 2>/dev/null; then
        _upd_err "ZSH config update failed"
        [[ $had_changes -eq 1 ]] && git stash pop 2>/dev/null
        _UPDATE_RESULTS[zsh-config]="failed"
        return 1
    fi

    [[ $had_changes -eq 1 ]] && git stash pop 2>/dev/null

    _upd_ok "ZSH configuration updated"
    _UPDATE_RESULTS[zsh-config]="updated"
    cd - >/dev/null
    return 0
}

# =============================================================================
# STATUS CHECK
# =============================================================================

update-status() {
    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"
    echo -e "${_UPD_BLUE}  📊 SYSTEM UPDATE STATUS${_UPD_NC}"
    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"

    # Homebrew
    local brew_outdated=$(brew outdated --formula 2>/dev/null | wc -l | tr -d ' ')
    if (( brew_outdated > 0 )); then
        echo -e "${_UPD_YELLOW}🍺 Homebrew:${_UPD_NC} $brew_outdated packages outdated"
    else
        echo -e "${_UPD_GREEN}🍺 Homebrew:${_UPD_NC} up to date"
    fi

    # mise
    if command -v mise &>/dev/null; then
        local mise_outdated=$(mise outdated 2>/dev/null | grep -v "^Tool" | grep -v "^$" | wc -l | tr -d ' ')
        if (( mise_outdated > 0 )); then
            echo -e "${_UPD_YELLOW}📦 mise:${_UPD_NC} $mise_outdated tools outdated"
            mise outdated 2>/dev/null | head -5
        else
            echo -e "${_UPD_GREEN}📦 mise:${_UPD_NC} up to date"
        fi
    fi

    # pnpm globals
    if command -v pnpm &>/dev/null; then
        local pnpm_globals=$(command pnpm list -g --depth=0 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')
        echo -e "${_UPD_BLUE}📦 pnpm globals:${_UPD_NC} $pnpm_globals packages"
    fi

    # OMZ
    if [[ -d "$HOME/.oh-my-zsh/.git" ]]; then
        cd "$HOME/.oh-my-zsh"
        git fetch origin master 2>/dev/null
        local behind=$(git rev-list HEAD..origin/master --count 2>/dev/null || echo 0)
        if (( behind > 0 )); then
            echo -e "${_UPD_YELLOW}🐚 Oh My Zsh:${_UPD_NC} $behind commits behind"
        else
            echo -e "${_UPD_GREEN}🐚 Oh My Zsh:${_UPD_NC} up to date"
        fi
        cd - >/dev/null
    fi

    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"
}

# =============================================================================
# UNIFIED UPDATE COMMAND
# =============================================================================

update-all() {
    local start_time=$(date +%s)
    _UPDATE_RESULTS=()

    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"
    echo -e "${_UPD_BLUE}  🔄 SYSTEM UPDATE${_UPD_NC}"
    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"
    echo ""

    local failed_count=0

    # Run updates in order of importance
    # 1. Homebrew first (system packages, zsh if installed via brew)
    update-brew || ((failed_count++))
    echo ""

    # 2. mise (manages node, python, pnpm, java, gcloud, lazygit)
    update-mise || ((failed_count++))
    echo ""

    # 3. Oh My Zsh and plugins
    update-omz || ((failed_count++))
    echo ""

    # 4. pnpm global packages
    update-pnpm-globals || ((failed_count++))
    echo ""

    # 5. ZSH config repo
    update-zsh-config || ((failed_count++))

    # Summary
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    echo ""
    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"
    echo -e "${_UPD_BLUE}  📊 UPDATE SUMMARY (${duration}s)${_UPD_NC}"
    echo -e "${_UPD_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_UPD_NC}"

    for component result in ${(kv)_UPDATE_RESULTS}; do
        case "$result" in
            updated)     echo -e "${_UPD_GREEN}✓${_UPD_NC} $component: updated" ;;
            up-to-date)  echo -e "${_UPD_GREEN}✓${_UPD_NC} $component: already up to date" ;;
            partial)     echo -e "${_UPD_YELLOW}⚠${_UPD_NC} $component: partially updated" ;;
            failed)      echo -e "${_UPD_RED}✗${_UPD_NC} $component: failed" ;;
            skipped)     echo -e "${_UPD_BLUE}○${_UPD_NC} $component: skipped" ;;
        esac
    done

    echo ""
    if (( failed_count > 0 )); then
        _upd_warn "Some updates had issues. Run individual commands to retry."
        echo "Commands: update-brew, update-mise, update-omz, update-pnpm-globals"
        return 1
    else
        _upd_ok "All updates complete"
        echo ""
        echo "Reload shell: exec zsh"
        return 0
    fi
}

# Alias for convenience
alias sysupdate='update-all'
alias upd='update-all'
