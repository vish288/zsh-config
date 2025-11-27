# =============================================================================
# WELCOME MESSAGE - Repo-aware cowsay on shell start
# =============================================================================

_show_welcome() {
    # Skip in non-interactive or sub-shells
    [[ ! -o interactive ]] && return
    [[ -n "$_WELCOME_SHOWN" ]] && return
    export _WELCOME_SHOWN=1

    local msg=""
    local cow_file="small"

    # Quick check if in git repo (with timeout for large repos)
    if timeout 0.5 git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
        local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
        local branch=$(git branch --show-current 2>/dev/null || echo "detached")

        # Skip expensive status check in large repos, use timeout
        local status_clean=""
        if timeout 0.3 git status --porcelain 2>/dev/null | head -1 | read -r _; then
            status_clean=$(timeout 0.3 git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
        fi

        local uncommitted=""
        [[ -n "$status_clean" && "$status_clean" -gt 0 ]] && uncommitted=" [${status_clean} changes]"

        # Detect project type (fast file checks)
        local project_type=""
        if [[ -f "nx.json" ]]; then
            project_type="Nx"
        elif [[ -f "package.json" ]]; then
            if [[ -f "next.config.js" ]] || [[ -f "next.config.mjs" ]]; then
                project_type="Next.js"
            else
                project_type="Node"
            fi
        elif [[ -f "Cargo.toml" ]]; then
            project_type="Rust"
        elif [[ -f "pyproject.toml" ]]; then
            project_type="Python"
        elif [[ -f "build.gradle" ]] || [[ -f "pom.xml" ]]; then
            project_type="Java"
        elif [[ -f "go.mod" ]]; then
            project_type="Go"
        fi

        [[ -n "$project_type" ]] && project_type=" ($project_type)"
        msg="$repo_name$project_type | $branch$uncommitted"
    else
        # Not in a git repo
        local dir_name=$(basename "$PWD")
        msg="$dir_name"
    fi

    # Use cowsay if available, with optional color via lolcat
    local output=""
    if command -v cowsay &>/dev/null; then
        output=$(echo "$msg" | cowsay -f "$cow_file" 2>/dev/null || echo "$msg" | cowsay)
    else
        output="[$msg]"
    fi

    # Colorize with lolcat if available
    if command -v lolcat &>/dev/null; then
        echo "$output" | lolcat -f -S 42
    else
        echo "$output"
    fi
}
