# =============================================================================
# DEVELOPMENT FUNCTIONS - Project and development utilities
# =============================================================================

# Git productivity functions
function gac() { 
  if [[ -z "$1" ]]; then
    echo "Usage: gac <commit-message>"
    return 1
  fi
  git add . && git commit -m "$1" 
}

function gacp() { 
  if [[ -z "$1" ]]; then
    echo "Usage: gacp <commit-message>"
    return 1
  fi
  git add . && git commit -m "$1" && git push 
}

# Create new Nx workspace
function nx-new() {
  if [[ -z "$1" ]]; then
    echo "Usage: nx-new <workspace-name> [app-name]"
    return 1
  fi
  local app_name=${2:-$1}
  echo "🚀 Creating Nx workspace: $1 with app: $app_name"
  pnpm dlx create-nx-workspace@latest $1 \
    --preset=ts \
    --appName=$app_name \
    --nxCloud=true
}

# Fast Java Spring Boot development
function gradle-run-hot() {
  echo "🔥 Starting Spring Boot with hot reload..."
  ./gradlew bootRun --args='--spring.devtools.restart.enabled=true'
}

# Docker utility functions
function dlog() { 
  if [[ -z "$1" ]]; then
    echo "Usage: dlog <container-name>"
    return 1
  fi
  docker logs -f "$1" 
}

function dexec() {
  if [[ -z "$1" ]]; then
    echo "Usage: dexec <container-name> [command]"
    return 1
  fi
  local cmd=${2:-/bin/bash}
  docker exec -it "$1" "$cmd"
}

# Kubernetes utility functions
function klogs() { 
  if [[ -z "$1" ]]; then
    echo "Usage: klogs <pod-name> [namespace]"
    return 1
  fi
  local ns=${2:+-n $2}
  kubectl logs -f $ns "$1" 
}

# Project management
function proj() {
  if [[ -z "$1" ]]; then
    echo "📁 Available projects:"
    ls -la ~/Workspace/ 2>/dev/null || echo "No Workspace directory found"
    return 0
  fi
  cd ~/Workspace/"$1" 2>/dev/null || echo "❌ Project '$1' not found"
}