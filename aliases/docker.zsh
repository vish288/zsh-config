# =============================================================================
# DOCKER ALIASES - Container management shortcuts
# =============================================================================

# Basic Docker commands
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs'

# Docker container management
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'
alias drm='docker rm'
alias drmi='docker rmi'

# Docker system management
alias dclean='docker system prune -f'
alias dcleanall='docker system prune -a -f'
alias dimages='docker images'
alias dvolumes='docker volume ls'
alias dnetworks='docker network ls'

# Docker logs and exec
alias dlogs='docker logs -f'
alias dexec='docker exec -it'
alias dshell='docker exec -it'

# Useful Docker combinations
alias dstopall='docker stop $(docker ps -q)'
alias drmall='docker rm $(docker ps -a -q)'
alias drmiall='docker rmi $(docker images -q)'