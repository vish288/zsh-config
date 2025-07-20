# =============================================================================
# DEVELOPMENT TOOLS ALIASES - Package managers and dev tools
# =============================================================================

# Python aliases
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'
alias venv='python3 -m venv'

# Node.js and package managers
alias pn='pnpm'
alias pni='pnpm install'
alias pnr='pnpm run'
alias pnx='pnpm dlx'
alias pnstart='pnpm start'
alias pndev='pnpm dev'
alias pnbuild='pnpm build'
alias pntest='pnpm test'

# Gradle shortcuts
alias gw='./gradlew'
alias gwb='./gradlew build'
alias gwt='./gradlew test'
alias gwr='./gradlew run'
alias gwclean='./gradlew clean'

# Kubernetes shortcuts
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'

# Cloud tools
alias gcl='gcloud'
alias gcp='gcloud projects list'
alias gcauth='gcloud auth list'
alias gcconfig='gcloud config list'

# Other development tools
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'

# Monitoring and debugging
alias htop='htop'
alias iotop='iotop'
alias netstat='netstat -tulanp'