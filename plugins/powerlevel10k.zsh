# =============================================================================
# POWERLEVEL10K CONFIGURATIONS
# =============================================================================

# Enable instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Kubernetes context display
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'

# GCP configuration
POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcp'

# Git performance optimization
POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=4096
POWERLEVEL9K_VCS_STAGED_MAX_NUM=10
POWERLEVEL9K_VCS_UNSTAGED_MAX_NUM=10
POWERLEVEL9K_VCS_UNTRACKED_MAX_NUM=10

# Performance improvements
POWERLEVEL9K_INSTANT_PROMPT=verbose
POWERLEVEL9K_DISABLE_GITSTATUS=false

# Load P10K theme configuration
[[ ! -f ~/.config/zsh/themes/p10k.zsh ]] || source ~/.config/zsh/themes/p10k.zsh