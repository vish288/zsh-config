#!/usr/bin/env zsh

# =============================================================================
# ZSH CONFIGURATION TEST SCRIPT
# =============================================================================

echo "🧪 Testing ZSH configuration..."
echo "==============================="

# Test 1: Basic aliases
echo "\n1. Testing aliases..."
source ~/.config/zsh/aliases/core.zsh
if alias ll &>/dev/null; then
    echo "✅ Core aliases loaded"
else
    echo "❌ Core aliases failed"
fi

# Test 2: Git aliases
source ~/.config/zsh/aliases/git.zsh
if alias gs &>/dev/null; then
    echo "✅ Git aliases loaded"
else
    echo "❌ Git aliases failed"
fi

# Test 3: Functions
echo "\n2. Testing functions..."
source ~/.config/zsh/functions/core.zsh
if type killport &>/dev/null; then
    echo "✅ Core functions loaded"
else
    echo "❌ Core functions failed"
fi

# Test 4: asdf functionality
echo "\n3. Testing asdf..."
if command -v asdf &>/dev/null; then
    echo "✅ asdf available: $(asdf version)"
    if asdf list nodejs &>/dev/null; then
        echo "✅ asdf working: Node $(asdf current nodejs)"
    else
        echo "⚠️  asdf installed but no nodejs versions"
    fi
else
    echo "❌ asdf not found"
fi

# Test 5: System commands
echo "\n4. Testing system commands..."
if command -v op &>/dev/null; then
    echo "✅ 1Password CLI available"
else
    echo "⚠️  1Password CLI not found"
fi

if [[ -n "$JAVA_HOME" ]]; then
    echo "✅ Java configured: $JAVA_HOME"
else
    echo "⚠️  Java not configured"
fi

# Test 6: PATH configuration
echo "\n5. Testing PATH..."
if echo "$PATH" | grep -q pnpm; then
    echo "✅ pnpm in PATH"
else
    echo "❌ pnpm not in PATH"
fi

if echo "$PATH" | grep -q asdf; then
    echo "✅ asdf shims in PATH"
else
    echo "❌ asdf shims not in PATH"
fi

echo "\n🎉 Configuration test completed!"