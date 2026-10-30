#!/usr/bin/env bash
# =============================================================================
# macOS (M4 Pro / Apple Silicon) Bootstrap Script
# =============================================================================

set -euo pipefail

echo "🚀 Starting macOS Dotfiles Bootstrap..."

# 1. Install Xcode Command Line Tools if missing
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "⏳ Waiting for Xcode Command Line Tools installation to complete..."
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
fi

# 2. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure Homebrew is in PATH (Apple Silicon /opt/homebrew or Intel /usr/local)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Install Chezmoi if missing
if ! command -v chezmoi &>/dev/null; then
  echo "🏠 Installing Chezmoi..."
  brew install chezmoi
fi

# 4. Apply Dotfiles via Chezmoi (runs Brewfile, Oh-My-Zsh setup, macOS defaults)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "✨ Applying dotfiles from ${DOTFILES_DIR}..."
chezmoi init --apply --source="${DOTFILES_DIR}"

echo "✅ Done! Restart your terminal (or open iTerm2) to enjoy your new setup."
