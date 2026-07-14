#!/usr/bin/env bash
# ============================================================================
# Post-install configuration — REVIEW BEFORE RUNNING.
# Idempotent-ish; safe to re-run. Assumes `brew bundle` already completed.
# Run with:  bash scripts/post-install.sh   (from the repo root, or anywhere)
# ============================================================================
set -uo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
# Optional local overrides (git identity, etc.) — copy user.env.example → user.env
[ -f "$REPO/user.env" ] && . "$REPO/user.env"

log() { printf "\n\033[1;34m==> %s\033[0m\n" "$1"; }

log "Xcode Command Line Tools"
xcode-select -p >/dev/null 2>&1 || xcode-select --install || true

log "Rust toolchain"
command -v rustc >/dev/null 2>&1 || rustup-init -y --no-modify-path

log "mise global runtimes (node/go/java/lua)"
if command -v mise >/dev/null 2>&1; then
  mise use -g node@lts || true
  mise use -g go@latest || true
  mise use -g java@temurin || true
  mise use -g lua@latest || true
fi

log "uv tools (embedded + red-teaming)"
if command -v uv >/dev/null 2>&1; then
  uv tool install esptool || true
  uv tool install esphome || true
  uv tool install mpremote || true
  uv tool install garak || true          # LLM vuln scanner (CLI)
  uv tool install frida-tools || true    # dynamic instrumentation (CLI)
  # PyRIT is a library, not a CLI → add it to a project when needed: `uv add pyrit`
fi
command -v npm >/dev/null 2>&1 && npm i -g promptfoo || true
command -v pipx >/dev/null 2>&1 && pipx install mcp-scan || uv tool install mcp-scan 2>/dev/null || true

log "Git config (delta pager)"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global merge.conflictStyle "zdiff3"
# Set identity if not already set — values come from user.env (see user.env.example)
[ -z "$(git config --global user.name)" ]  && [ -n "${GIT_NAME:-}" ]  && git config --global user.name  "$GIT_NAME"
[ -z "$(git config --global user.email)" ] && [ -n "${GIT_EMAIL:-}" ] && git config --global user.email "$GIT_EMAIL"

log "Neovim: LazyVim starter"
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi

log "Ollama service + a sane default model"
if command -v ollama >/dev/null 2>&1; then
  brew services start ollama || true
  sleep 3
  ollama pull qwen2.5-coder:7b || true   # ~4.7GB, works immediately
  echo "Bigger pulls for your 64GB M5 Pro (run when you want them):"
  echo "  ollama pull qwen2.5-coder:32b     # ~19GB, strong local coding"
  echo "  ollama pull llama3.3:70b          # ~40GB, flagship @ 4-bit"
  echo "  ollama pull llama3.2-vision:11b   # multimodal / CV"
fi

log "Open WebUI (desktop app — bundles the server, connects to local Ollama)"
open -a "Open WebUI" 2>/dev/null || echo "Launch 'Open WebUI' from Applications after install."

log "Espanso service"
command -v espanso >/dev/null 2>&1 && (espanso service register 2>/dev/null; espanso start 2>/dev/null) || true

log "Quick Look: refresh plugin registry"
qlmanage -r >/dev/null 2>&1 || true
# If a plugin doesn't work (unsigned), you may need: xattr -cr /path/to/plugin.qlgenerator

cat <<'EOF'

==> Manual steps remaining (can't be scripted safely):
  • App Store sign-in, then re-run: brew bundle   (for any mas apps)
  • CH340 driver: reboot + allow in System Settings → Privacy & Security
  • UTM: download ARM64 Kali image (kali.org) and import
  • NetBird (if you use it): connect with the setup key / SSO from your org
  • VMware Fusion (optional): manual download from Broadcom portal
  • chezmoi: `chezmoi init` to start managing dotfiles (fresh, unless you have a repo)
  • Review + run: bash scripts/defaults.sh
  • Set git identity: copy user.env.example → user.env and fill it in
  • Configure Ghostty/Starship/zsh via chezmoi (see docs/GETTING-STARTED.md)
EOF
log "post-install complete"
