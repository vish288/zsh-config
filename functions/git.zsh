# =============================================================================
# GIT HELPER FUNCTIONS - Advanced git workflow utilities
# =============================================================================

# Initialize new repo with first commit
ginit() {
    git init
    git add -A
    git commit -m "Initial commit"
    echo "Repository initialized with first commit"
}

# Create branch and push upstream
gnew() {
    [[ -z "$1" ]] && { echo "Usage: gnew <branch-name>"; return 1; }
    git checkout -b "$1"
    git push -u origin "$1"
    echo "Created and pushed branch: $1"
}

# Delete branch locally and remotely
gdel() {
    [[ -z "$1" ]] && { echo "Usage: gdel <branch-name>"; return 1; }
    local branch="$1"
    local current=$(git branch --show-current)

    [[ "$branch" == "$current" ]] && { echo "Cannot delete current branch"; return 1; }
    [[ "$branch" =~ ^(main|master|develop)$ ]] && { echo "Cannot delete protected branch: $branch"; return 1; }

    git branch -d "$branch" 2>/dev/null || git branch -D "$branch"
    git push origin --delete "$branch" 2>/dev/null
    echo "Deleted branch: $branch"
}

# Sync: pull, add all, commit, push
gsync() {
    local msg="${1:-Sync changes}"
    git pull --rebase --autostash
    git add -A
    git commit -m "$msg"
    git push
}

# Repository statistics
gstats() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  REPOSITORY STATISTICS"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Commits: $(git rev-list --count HEAD 2>/dev/null || echo 0)"
    echo "Contributors: $(git shortlog -sn 2>/dev/null | wc -l | tr -d ' ')"
    echo "Branches: $(git branch -a 2>/dev/null | wc -l | tr -d ' ')"
    echo "Tags: $(git tag 2>/dev/null | wc -l | tr -d ' ')"
    echo ""
    echo "Top contributors:"
    git shortlog -sn --no-merges 2>/dev/null | head -5
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Search commits by message
gfind() {
    [[ -z "$1" ]] && { echo "Usage: gfind <search-term>"; return 1; }
    git log --oneline --all --grep="$1"
}

# Find commits affecting a file
gfile() {
    [[ -z "$1" ]] && { echo "Usage: gfile <file-path>"; return 1; }
    git log --oneline --follow -- "$1"
}

# Checkout file from another branch
gcof() {
    [[ -z "$1" || -z "$2" ]] && { echo "Usage: gcof <branch> <file>"; return 1; }
    git checkout "$1" -- "$2"
    echo "Checked out $2 from $1"
}

# Compare branches (files changed)
gcompare() {
    local branch1="${1:-main}"
    local branch2="${2:-HEAD}"
    echo "Files changed between $branch1 and $branch2:"
    git diff --name-status "$branch1".."$branch2"
}

# Interactive rebase shortcut
grebase() {
    local count="${1:-5}"
    git rebase -i HEAD~"$count"
}

# Contributor statistics with line counts
gcontrib() {
    echo "Contributor line statistics:"
    git log --format='%aN' | sort -u | while read name; do
        echo -n "$name: "
        git log --author="$name" --pretty=tformat: --numstat | \
            awk '{ add += $1; subs += $2 } END { printf "+%d/-%d\n", add, subs }'
    done
}

# Remove merged branches (excludes protected)
gprune() {
    echo "Branches merged to current branch:"
    git branch --merged | grep -vE '^\*|main|master|develop' | while read branch; do
        echo "  $branch"
    done
    echo ""
    read "confirm?Delete these branches? (y/N): "
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git branch --merged | grep -vE '^\*|main|master|develop' | xargs -r git branch -d
        echo "Merged branches deleted"
    else
        echo "Cancelled"
    fi
}

# Show recent branches by last commit
grecent() {
    local count="${1:-10}"
    git for-each-ref --sort=-committerdate refs/heads/ \
        --format='%(committerdate:short) %(refname:short)' | head -n "$count"
}

# Undo last N commits (soft reset)
gundo-n() {
    local count="${1:-1}"
    git reset --soft HEAD~"$count"
    echo "Undid last $count commit(s), changes staged"
}

# Show branch diff summary
gdiff-branch() {
    local base="${1:-main}"
    echo "Changes from $base to current branch:"
    echo "Files: $(git diff --name-only "$base"... | wc -l | tr -d ' ')"
    echo "Commits: $(git rev-list --count "$base"..HEAD)"
    echo ""
    git diff --stat "$base"...
}

# Quick fixup commit
gfixup() {
    [[ -z "$1" ]] && { echo "Usage: gfixup <commit-hash>"; return 1; }
    git commit --fixup="$1"
    echo "Created fixup commit for $1"
    echo "Run 'grbi' to squash"
}

# Create .gitignore with common patterns
gignore-create() {
    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
vendor/
.venv/
__pycache__/

# Build outputs
dist/
build/
*.o
*.pyc

# IDE
.idea/
.vscode/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local
*.local

# Logs
*.log
logs/

# Test coverage
coverage/
.nyc_output/
EOF
    echo "Created .gitignore with common patterns"
}
