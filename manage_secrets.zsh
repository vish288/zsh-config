#!/usr/bin/env zsh

# =============================================================================
# 1PASSWORD SECRETS MANAGER
# =============================================================================
# Helper script for managing development secrets in 1Password

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}🔐 1Password Secrets Manager${NC}"
    echo -e "${BLUE}=============================${NC}"
}

list_secrets() {
    echo -e "${GREEN}📋 Development secrets in Contracts vault:${NC}"
    op item list --vault="Contracts" --tags="development"
}

add_secret() {
    local title="$1"
    local secret="$2"
    local notes="${3:-Development secret}"
    
    echo -e "${GREEN}➕ Adding secret: $title${NC}"
    op item create --vault="Contracts" --title="$title" --category="API Credential" \
        --tags="development,lcl" \
        "credential[password]=$secret" \
        "notes=$notes"
    echo -e "${GREEN}✅ Secret added successfully${NC}"
}

update_secret() {
    local title="$1"
    local secret="$2"
    
    echo -e "${YELLOW}🔄 Updating secret: $title${NC}"
    op item edit "$title" --vault="Contracts" "credential[password]=$secret"
    echo -e "${GREEN}✅ Secret updated successfully${NC}"
}

get_secret() {
    local title="$1"
    
    echo -e "${GREEN}🔍 Retrieving secret: $title${NC}"
    op item get "$title" --vault="Contracts" --field="credential"
}

test_secrets() {
    echo -e "${GREEN}🧪 Testing current secret configuration:${NC}"
    source ~/.config/zsh/secrets/secrets.zsh
    
    echo ""
    echo "Environment variables loaded:"
    [[ -n "${GITLAB_ACCESS_TOKEN:-}" ]] && echo "✅ GITLAB_ACCESS_TOKEN: ${GITLAB_ACCESS_TOKEN:0:8}..."
    [[ -n "${BIT_TOKEN:-}" ]] && echo "✅ BIT_TOKEN: ${BIT_TOKEN:0:8}..."
    [[ -n "${GARFIELLD_API_KEY:-}" ]] && echo "✅ GARFIELLD_API_KEY: ${GARFIELLD_API_KEY:0:8}..."
}

backup_secrets() {
    local backup_file="$HOME/.config/zsh/secrets/backup_$(date +%Y%m%d_%H%M%S).json"
    
    echo -e "${GREEN}💾 Creating secrets backup...${NC}"
    op item list --vault="Contracts" --tags="development" --format=json > "$backup_file"
    echo -e "${GREEN}✅ Backup saved to: $backup_file${NC}"
}

usage() {
    print_header
    echo ""
    echo "Usage: $0 <command> [args]"
    echo ""
    echo "Commands:"
    echo "  list                     - List all development secrets"
    echo "  add <title> <secret>     - Add new secret"
    echo "  update <title> <secret>  - Update existing secret"
    echo "  get <title>              - Retrieve secret value"
    echo "  test                     - Test current configuration"
    echo "  backup                   - Backup all secrets to file"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 add 'New API Key' 'abc123xyz'"
    echo "  $0 get 'LCL GitLab Token'"
    echo "  $0 test"
}

# Main script
case "${1:-}" in
    list)
        print_header
        list_secrets
        ;;
    add)
        if [[ $# -lt 3 ]]; then
            echo -e "${RED}Error: add requires title and secret${NC}"
            usage
            exit 1
        fi
        print_header
        add_secret "$2" "$3" "${4:-}"
        ;;
    update)
        if [[ $# -lt 3 ]]; then
            echo -e "${RED}Error: update requires title and secret${NC}"
            usage
            exit 1
        fi
        print_header
        update_secret "$2" "$3"
        ;;
    get)
        if [[ $# -lt 2 ]]; then
            echo -e "${RED}Error: get requires title${NC}"
            usage
            exit 1
        fi
        print_header
        get_secret "$2"
        ;;
    test)
        print_header
        test_secrets
        ;;
    backup)
        print_header
        backup_secrets
        ;;
    *)
        usage
        ;;
esac