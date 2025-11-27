# =============================================================================
# GIT ALIASES - Comprehensive git workflow shortcuts
# =============================================================================

# -----------------------------------------------------------------------------
# BASIC OPERATIONS
# -----------------------------------------------------------------------------
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch --all --prune'

# -----------------------------------------------------------------------------
# BRANCH MANAGEMENT
# -----------------------------------------------------------------------------
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbm='git branch -m'
alias gbrename='git branch -m'
alias gsw='git switch'
alias gswc='git switch -c'

# -----------------------------------------------------------------------------
# COMMIT OPERATIONS
# -----------------------------------------------------------------------------
alias gca='git commit -av'
alias gcam='git commit -am'
alias gca!='git commit -av --amend'
alias gcn!='git commit --amend --no-edit'
alias gcan!='git commit -a --amend --no-edit'
alias gamend='git commit --amend'

# -----------------------------------------------------------------------------
# PUSH/PULL WITH SAFETY
# -----------------------------------------------------------------------------
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gup='git pull --rebase --autostash'
alias gpr='git pull --rebase'
alias gpsu='git push --set-upstream origin $(git branch --show-current)'

# -----------------------------------------------------------------------------
# FETCH & REMOTE
# -----------------------------------------------------------------------------
alias gfa='git fetch --all --prune'
alias grv='git remote -v'
alias gru='git remote update'
alias gr='git remote -v'

# -----------------------------------------------------------------------------
# LOG & HISTORY
# -----------------------------------------------------------------------------
alias gl='git log --oneline -15'
alias glog='git log --oneline --graph --decorate --all -20'
alias glg='git log --graph --pretty=format:"%C(auto)%h%d %s %C(dim)(%cr)%C(reset)"'
alias glga='git log --graph --pretty=format:"%C(auto)%h%d %s %C(dim)(%cr)%C(reset)" --all'
alias glast='git log -1 --stat'
alias gcount='git shortlog -sn'

# -----------------------------------------------------------------------------
# DIFF OPERATIONS
# -----------------------------------------------------------------------------
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --color-words'
alias gshow='git show'

# -----------------------------------------------------------------------------
# STASH MANAGEMENT
# -----------------------------------------------------------------------------
alias gsta='git stash push'
alias gstam='git stash push -m'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gstc='git stash clear'
alias gsts='git stash show -p'

# -----------------------------------------------------------------------------
# RESET & UNDO
# -----------------------------------------------------------------------------
alias grh='git reset HEAD'
alias grhh='git reset --hard HEAD'
alias groh='git reset --hard origin/$(git branch --show-current)'
alias gundo='git reset --soft HEAD~1'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'

# -----------------------------------------------------------------------------
# REBASE & MERGE
# -----------------------------------------------------------------------------
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbs='git rebase --skip'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'

# -----------------------------------------------------------------------------
# CHERRY-PICK
# -----------------------------------------------------------------------------
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# -----------------------------------------------------------------------------
# WORKTREE
# -----------------------------------------------------------------------------
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtr='git worktree remove'

# -----------------------------------------------------------------------------
# TAGS
# -----------------------------------------------------------------------------
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl='git tag -l'

# -----------------------------------------------------------------------------
# SUBMODULES
# -----------------------------------------------------------------------------
alias gsub='git submodule'
alias gsubi='git submodule init'
alias gsubu='git submodule update --init --recursive'

# -----------------------------------------------------------------------------
# WORKFLOW SHORTCUTS
# -----------------------------------------------------------------------------
alias gwip='git add -A && git commit -m "WIP"'
alias gsave='git add -A && git commit -m "SAVEPOINT"'
alias gunwip='git log -1 --format="%s" | grep -q "^WIP" && git reset HEAD~1'

# -----------------------------------------------------------------------------
# BISECT
# -----------------------------------------------------------------------------
alias gbs='git bisect'
alias gbss='git bisect start'
alias gbsg='git bisect good'
alias gbsb='git bisect bad'
alias gbsr='git bisect reset'

# -----------------------------------------------------------------------------
# BLAME & SEARCH
# -----------------------------------------------------------------------------
alias gbl='git blame'
alias ggrep='git grep'
