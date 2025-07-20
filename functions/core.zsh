# =============================================================================
# CORE FUNCTIONS - Essential utility functions
# =============================================================================

# Enhanced directory navigation
function cdl() { cd "$1" && ls -la; }
function mkcd() { mkdir -p "$1" && cd "$1"; }

# Quick file search
function ff() {
  if [[ -z "$1" ]]; then
    echo "Usage: ff <filename-pattern>"
    return 1
  fi
  find . -type f -name "*$1*" 2>/dev/null
}

# Process management
function psg() {
  if [[ -z "$1" ]]; then
    echo "Usage: psg <process-name>"
    return 1
  fi
  ps aux | grep -i "$1" | grep -v grep
}

# Kill process on port
function killport() {
  if [[ -z "$1" ]]; then
    echo "Usage: killport <port>"
    return 1
  fi
  local pids=$(lsof -ti tcp:$1)
  if [[ -n "$pids" ]]; then
    echo "🔥 Killing processes on port $1: $pids"
    echo $pids | xargs kill -9
    echo "✅ Port $1 is now free"
  else
    echo "ℹ️  No processes found on port $1"
  fi
}

# Enhanced file extraction
function extract() {
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "❌ '$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "❌ '$1' is not a valid file"
  fi
}

# Backup function with timestamp
function backup() {
  if [[ -z "$1" ]]; then
    echo "Usage: backup <file-or-directory>"
    return 1
  fi
  local backup_name="$1.backup.$(date +%Y%m%d_%H%M%S)"
  cp -r "$1" "$backup_name"
  echo "✅ Backup created: $backup_name"
}