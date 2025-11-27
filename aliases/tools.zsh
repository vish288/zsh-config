# =============================================================================
# DEVELOPMENT TOOLS ALIASES - Package managers and dev tools
# =============================================================================

# Python (mise-managed)
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'
alias venv='python3 -m venv'
alias pipr='pip3 install -r requirements.txt'

# pnpm (primary package manager)
alias pn='pnpm'
alias pni='pnpm install'
alias pnr='pnpm run'
alias pnx='pnpm dlx'
alias pns='pnpm start'
alias pnd='pnpm dev'
alias pnb='pnpm build'
alias pnt='pnpm test'
alias pnl='pnpm lint'

# Gradle (grd- prefix to avoid git worktree conflict)
alias grd='./gradlew'
alias grdb='./gradlew build'
alias grdt='./gradlew test'
alias grdr='./gradlew run'
alias grdc='./gradlew clean'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kl='kubectl logs -f'
alias kx='kubectl exec -it'

# Cloud tools (gcl prefix to avoid conflicts with git/gnu cp)
alias gcl='gcloud'
alias gclp='gcloud projects list'
alias gcla='gcloud auth list'
alias gclc='gcloud config list'

# Monitoring
alias watch='watch -n 1'
