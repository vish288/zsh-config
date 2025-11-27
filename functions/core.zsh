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

# Note: extract() provided by OMZ extract plugin

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