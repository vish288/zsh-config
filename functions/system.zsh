# =============================================================================
# SYSTEM FUNCTIONS - System monitoring and utilities
# =============================================================================

# Network and system monitoring
function ports() {
  echo "📡 Active network connections:"
  lsof -i -P -n | grep LISTEN
}

function myip() {
  echo "🌐 External IP: $(curl -s https://ipinfo.io/ip)"
  echo "🏠 Local IP: $(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')"
}

function weather() {
  local city=${1:-Toronto}
  curl -s "wttr.in/$city?format=3"
}

# System information
function sysinfo() {
  echo "💻 System Information:"
  echo "────────────────────"
  echo "🖥️  CPU: $(sysctl -n machdep.cpu.brand_string)"
  echo "💾 Memory: $(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2, $3}')"
  echo "💿 Disk: $(df -h / | awk 'NR==2{print $3"/"$2" ("$5" used)"}')"
  echo "⚡ Load: $(uptime | awk -F'load averages:' '{print $2}')"
}

# Performance monitoring functions
function cpu_usage() {
  echo "📊 Top CPU processes:"
  ps aux --sort=-%cpu | head -11
}

function mem_usage() {
  echo "📊 Top memory processes:"
  ps aux --sort=-%mem | head -11
}

function disk_usage() {
  echo "📊 Disk usage by directory:"
  du -h --max-depth=1 . | sort -hr
}

# Cleanup functions
function cleanup_logs() {
  echo "🧹 Cleaning up log files..."
  find /tmp -name "*.log" -mtime +7 -delete 2>/dev/null || true
  find ~/.cache -name "*.log" -mtime +7 -delete 2>/dev/null || true
  echo "✅ Log cleanup completed"
}

function cleanup_downloads() {
  echo "🧹 Cleaning up Downloads folder..."
  find ~/Downloads -type f -mtime +30 -exec ls -la {} \;
  read "?Delete files older than 30 days? (y/N): " choice
  if [[ "$choice" =~ ^[Yy]$ ]]; then
    find ~/Downloads -type f -mtime +30 -delete
    echo "✅ Downloads cleanup completed"
  else
    echo "❌ Downloads cleanup cancelled"
  fi
}