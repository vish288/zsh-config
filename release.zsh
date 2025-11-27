#!/usr/bin/env zsh
# =============================================================================
# RELEASE SCRIPT - Automated version tagging and release
# =============================================================================
# Usage: ./release.zsh [major|minor|patch] [--dry-run|-n]
# Default: minor
# Options:
#   --dry-run, -n  Show what would happen without creating/pushing tag
#
# This script:
# 1. Ensures clean working tree and up-to-date main branch
# 2. Calculates next version from latest tag
# 3. Creates and pushes tag (triggers GitHub release workflow)

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo "${BLUE}ℹ${NC} $1"; }
log_success() { echo "${GREEN}✓${NC} $1"; }
log_warn() { echo "${YELLOW}⚠${NC} $1"; }
log_error() { echo "${RED}✗${NC} $1"; exit 1; }

# Parse arguments
DRY_RUN=false
BUMP_TYPE="minor"

for arg in "$@"; do
    case "$arg" in
        --dry-run|-n) DRY_RUN=true ;;
        major|minor|patch) BUMP_TYPE="$arg" ;;
        *) log_error "Invalid argument: $arg (use major|minor|patch or --dry-run)" ;;
    esac
done

# Ensure we're on main
CURRENT_BRANCH=$(git branch --show-current)
if [[ "$CURRENT_BRANCH" != "main" ]]; then
    log_error "Must be on main branch (currently on: $CURRENT_BRANCH)"
fi

# Ensure clean working tree
if [[ -n $(git status --porcelain) ]]; then
    log_error "Working tree not clean. Commit or stash changes first."
fi

# Fetch and check if up to date
log_info "Fetching latest from origin..."
git fetch origin main --quiet

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)
if [[ "$LOCAL" != "$REMOTE" ]]; then
    log_error "Local main not up to date with origin. Run: git pull"
fi

# Get latest version tag
LATEST_TAG=$(git tag -l 'v*' | sort -V | tail -1)
if [[ -z "$LATEST_TAG" ]]; then
    LATEST_TAG="v0.0.0"
fi
log_info "Latest tag: $LATEST_TAG"

# Parse version components
VERSION="${LATEST_TAG#v}"
MAJOR=$(echo "$VERSION" | cut -d. -f1)
MINOR=$(echo "$VERSION" | cut -d. -f2)
PATCH=$(echo "$VERSION" | cut -d. -f3)

# Calculate new version
case "$BUMP_TYPE" in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
esac

NEW_VERSION="v${MAJOR}.${MINOR}.${PATCH}"
log_info "New version: $NEW_VERSION ($BUMP_TYPE bump)"

# Check if changelog has entry for this version
if ! grep -q "## \[$NEW_VERSION\]" CHANGELOG.md 2>/dev/null; then
    if ! grep -q "## \[${NEW_VERSION#v}\]" CHANGELOG.md 2>/dev/null; then
        log_warn "CHANGELOG.md missing entry for $NEW_VERSION"
        log_warn "Release notes will be auto-generated from commits"
    fi
fi

# Confirm
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📦 RELEASE SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Previous: $LATEST_TAG"
echo "  New:      $NEW_VERSION"
echo "  Type:     $BUMP_TYPE"
echo "  Dry-run:  $DRY_RUN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Show commits since last tag
echo ""
log_info "Commits since $LATEST_TAG:"
git log --oneline "${LATEST_TAG}..HEAD" | head -10
COMMIT_COUNT=$(git rev-list --count "${LATEST_TAG}..HEAD")
echo "  ($COMMIT_COUNT commits total)"
echo ""

if [[ "$DRY_RUN" == "true" ]]; then
    log_info "DRY RUN - No changes will be made"
    log_info "Would create tag: $NEW_VERSION"
    log_info "Would push to: origin"
    exit 0
fi

echo -n "Proceed with release? [y/N] "
read -r CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    log_warn "Release cancelled"
    exit 0
fi

# Create and push tag
log_info "Creating tag $NEW_VERSION..."
git tag -a "$NEW_VERSION" -m "Release $NEW_VERSION"

log_info "Pushing tag to origin..."
git push origin "$NEW_VERSION"

log_success "Tag $NEW_VERSION pushed!"
echo ""
echo "GitHub Actions will now:"
echo "  1. Validate configuration"
echo "  2. Generate release notes"
echo "  3. Create release with archives"
echo ""
echo "Monitor: https://github.com/vish288/zsh-config/actions"
echo "Release: https://github.com/vish288/zsh-config/releases/tag/$NEW_VERSION"
