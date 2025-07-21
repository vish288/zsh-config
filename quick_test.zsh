#!/usr/bin/env zsh

# =============================================================================
# QUICK INSTALLATION TEST (For private repo)
# =============================================================================
# This simulates the installation process for testing

echo "🧪 Testing ZSH Configuration Installation Process..."
echo "=================================================="

# Test 1: Check prerequisites
echo "\n1. Testing Prerequisites..."
command -v brew >/dev/null && echo "✅ Homebrew installed" || echo "❌ Homebrew missing"
[[ -d ~/.oh-my-zsh ]] && echo "✅ Oh My Zsh installed" || echo "❌ Oh My Zsh missing"
command -v asdf >/dev/null && echo "✅ asdf installed" || echo "❌ asdf missing"
command -v op >/dev/null && echo "✅ 1Password CLI installed" || echo "❌ 1Password CLI missing"

# Test 2: Check configuration files
echo "\n2. Testing Configuration Files..."
[[ -f ~/.config/zsh/zshrc ]] && echo "✅ Main zshrc exists" || echo "❌ Main zshrc missing"
[[ -f ~/.config/zsh/zprofile ]] && echo "✅ zprofile exists" || echo "❌ zprofile missing"
[[ -f ~/.config/zsh/themes/p10k.zsh ]] && echo "✅ P10K theme exists" || echo "❌ P10K theme missing"

# Test 3: Check symlinks
echo "\n3. Testing Symlinks..."
[[ -L ~/.zshrc ]] && echo "✅ .zshrc symlink exists" || echo "❌ .zshrc symlink missing"
[[ -L ~/.zprofile ]] && echo "✅ .zprofile symlink exists" || echo "❌ .zprofile symlink missing"
[[ -L ~/.p10k.zsh ]] && echo "✅ .p10k.zsh symlink exists" || echo "❌ .p10k.zsh symlink missing"

# Test 4: Test configuration loading
echo "\n4. Testing Configuration Loading..."
if zsh -c "source ~/.zshrc && echo 'Config loads successfully'" >/dev/null 2>&1; then
    echo "✅ Configuration loads without errors"
else
    echo "❌ Configuration has loading errors"
fi

# Test 5: Test key functionality
echo "\n5. Testing Key Functionality..."
if zsh -c "asdf version" >/dev/null 2>&1; then
    echo "✅ asdf working"
else
    echo "❌ asdf not working"
fi

if zsh -c "source ~/.config/zsh/aliases/core.zsh && alias ll" >/dev/null 2>&1; then
    echo "✅ Aliases loading"
else
    echo "❌ Aliases not loading"
fi

if zsh -c "source ~/.config/zsh/functions/core.zsh && type killport" >/dev/null 2>&1; then
    echo "✅ Functions loading"
else
    echo "❌ Functions not loading"
fi

echo "\n🎉 Installation test completed!"
echo "🔗 Repository: https://github.com/vish288/zsh-config (private)"
echo "📁 Local config: ~/.config/zsh/"
