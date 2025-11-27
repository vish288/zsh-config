# =============================================================================
# DOCKER ALIASES - Safe container management
# =============================================================================

# Basic Docker commands
alias d='docker'
alias dc='docker compose'  # Modern syntax (no hyphen)
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'

# Container management
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'
alias drm='docker rm'
alias drmi='docker rmi'

# System management
alias dclean='docker system prune -f'
alias dimages='docker images'
alias dvolumes='docker volume ls'
alias dnetworks='docker network ls'

# Logs and exec
alias dlogs='docker logs -f'
alias dsh='docker exec -it'
alias dinspect='docker inspect'

# Useful shortcuts
alias dstats='docker stats --no-stream'
alias dtop='docker stats'
