#!/usr/bin/env bash
# ============================================================================
# macOS defaults tweaks — REVIEW BEFORE RUNNING.
# These change system behavior. Read each block; comment out anything you don't want.
# Run with:  bash scripts/defaults.sh   (from the repo root)
# Most changes need a relaunch (Finder/Dock) or logout — handled at the end.
# ============================================================================
set -euo pipefail

echo "Applying macOS defaults tweaks…"

# --- Keyboard: blazing key repeat (great for vim-style editing) -------------
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 12
# Disable press-and-hold accent popup so key repeat works everywhere
defaults write -g ApplePressAndHoldEnabled -bool false

# --- Screenshots ------------------------------------------------------------
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location "$HOME/Screenshots"
defaults write com.apple.screencapture type jpg          # smaller files (use 'png' to keep PNG)
defaults write com.apple.screencapture disable-shadow -bool true

# --- Finder -----------------------------------------------------------------
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"   # search current folder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Show hidden files (you can also just press Cmd+Shift+.)
# defaults write com.apple.finder AppleShowAllFiles -bool true

# --- Dock -------------------------------------------------------------------
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# --- Apply ------------------------------------------------------------------
killall Finder  >/dev/null 2>&1 || true
killall Dock    >/dev/null 2>&1 || true
echo "Done. Some changes (key repeat) fully apply after logout/restart."
