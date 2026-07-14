# ============================================================================
# Mac Setup — Brewfile (Single Source of Truth)
# Target: Apple Silicon MacBook, macOS 26. A cybersecurity + AI engineering kit.
#
# Install:   brew bundle          (run from the repo root; defaults to ./Brewfile)
# Check:     brew bundle check
# Cleanup:   brew bundle cleanup   (removes anything NOT listed here — review first!)
# Dump:      brew bundle dump --force   (snapshot the current system into this file)
#
# NOTE: If your org manages some apps via MDM (e.g. Microsoft Office/Teams/Outlook
#       via JumpCloud/Intune/Jamf), leave them out of here to avoid conflicts.
# See docs/CATALOG.md for what/why/uninstall per tool, and docs/EXPLORE-LATER.md for the backlog.
# ============================================================================

# ---- Taps -----------------------------------------------------------------
tap "nikitabobko/tap"        # AeroSpace tiling WM
tap "netbirdio/tap"          # NetBird VPN
tap "felixkratz/formulae"    # SketchyBar

# ---- 1. Terminal, Shell & modern CLI --------------------------------------
cask "ghostty"                       # GPU terminal
brew "starship"                      # prompt
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "tmux"
brew "zellij"
brew "atuin"                         # shell history
brew "ripgrep"
brew "fd"
brew "bat"
brew "eza"
brew "fzf"
brew "zoxide"
brew "git-delta"
brew "jq"
brew "yq"
brew "btop"
brew "dust"
brew "sd"
brew "tldr"
brew "hyperfine"
brew "gum"
brew "duf"
brew "procs"
brew "htop"
brew "yazi"                          # TUI file manager
brew "ffmpegthumbnailer"             # yazi preview dep
brew "sevenzip"                      # yazi preview dep
brew "poppler"                       # yazi preview dep
brew "resvg"                         # yazi preview dep
brew "imagemagick"                   # yazi preview dep
brew "glow"                          # markdown in terminal
brew "lazygit"
brew "gh"
brew "difftastic"
brew "jj"                            # jujutsu VCS
brew "fastfetch"
brew "mas"                           # Mac App Store CLI
brew "pandoc"
brew "chezmoi"                       # dotfiles manager (~/.zshrc, ghostty, etc.)

# ---- 2. Languages & runtime managers --------------------------------------
brew "mise"                          # polyglot: node/go/java/lua
brew "uv"                            # Python
brew "rustup"                        # Rust (run rustup-init after)
cask "miniforge"                     # conda-forge for conda-only ML deps

# ---- 3. Editors -----------------------------------------------------------
cask "visual-studio-code"
cask "cursor"
cask "claude-code"                   # Claude Code CLI + app (links `claude`)
brew "neovim"                        # LazyVim starter in post-install

# ---- 4. Cloud / DevOps / Containers ---------------------------------------
brew "colima"
brew "docker"
brew "docker-compose"
brew "lazydocker"
brew "dive"
brew "kubernetes-cli"                # kubectl
brew "k9s"
brew "helm"
brew "kustomize"
brew "kubectx"                       # kubectx + kubens
brew "stern"
brew "k3d"
brew "trivy"
brew "k8sgpt"
brew "opentofu"
brew "terragrunt"
brew "azure-cli"
brew "azcopy"
brew "azure-dev"                     # Azure Developer CLI (azd)
brew "awscli"
brew "aws-vault"
brew "eksctl"
cask "session-manager-plugin"
cask "freelens"                      # K8s GUI (OpenLens successor)
# Portainer runs as a Docker container (see post-install.sh, optional)
cask "mongodb-compass"               # MongoDB GUI (browse/query/analyze)
brew "mongosh"                       # MongoDB Shell (CLI companion)

# ---- 5. Local AI (LLM + ML/CV) --------------------------------------------
brew "ollama"                        # LLM runtime/server (MLX-backed)
brew "mlx-lm"                        # Apple MLX, max speed
cask "open-webui"                    # self-hosted chat hub (desktop app)
cask "lm-studio"                     # GUI runtime
cask "anythingllm"                   # doc RAG
cask "draw-things"                   # local image gen (SD/Flux, Metal)
cask "slicer"                        # 3D Slicer (medical imaging)
cask "itk-snap"                      # 3D segmentation GUI
# Python ML stack via uv (post-install): torch torchvision monai SimpleITK jupyterlab diffusers
# CAVEAT: PyTorch-MPS has no Conv3D — heavy 3D CNN training needs CPU fallback or CUDA/cloud.

# ---- 6. Security / Pentest (host lean; heavy stuff in Kali VM) -------------
cask "utm"                           # VM host (primary, no login) — use ARM64 Kali!
brew "nmap"
brew "rustscan"
brew "masscan"
brew "ffuf"
brew "feroxbuster"
brew "gobuster"
brew "nuclei"
brew "httpx"
brew "subfinder"
brew "amass"
brew "katana"
brew "sqlmap"
cask "mitmproxy"                     # intercepting proxy (cask ships the CLI tools)
brew "hashcat"
brew "john-jumbo"
brew "socat"
brew "binwalk"
brew "exiftool"
brew "nikto"
brew "hydra"
brew "aircrack-ng"
brew "radare2"
brew "rizin"
cask "burp-suite"
cask "caido"
cask "wireshark-app"
cask "zap"
cask "proxyman"
brew "ghidra"                        # RE / decompiler (formula)
# frida: not in brew core → installed as frida-tools via uv (see post-install.sh)
# VMware Fusion: manual Broadcom download (free, login required) — optional backup
# Keep in Kali VM: responder, metasploit, impacket, netexec. External USB adapter for WiFi injection.

# ---- 8. Local AI-agent stack ----------------------------------------------
cask "block-goose"                   # local MCP agent (GUI)
brew "block-goose-cli"               # Goose CLI
cask "voiceink"                      # offline voice-to-text (whisper.cpp)

# ---- 9. Consultant-AI tools -----------------------------------------------
cask "granola"                       # silent meeting notes (no bot in call)
cask "screen-studio"                 # cinematic demos
cask "cap"                           # OSS demo recorder
cask "comet"                         # Perplexity agentic browser
cask "reader"                        # Readwise Reader
# --- Local meeting transcription (no cloud, no account) ---
cask "meetily"                       # OSS local meeting notes (Whisper + local LLM via Ollama)
cask "macwhisper"                    # on-device transcription (paid tier, no account)
cask "blackhole-2ch"                 # virtual audio driver to capture system audio — NEEDS SUDO

# ---- 10. Productivity / Browsers / Password / VPN -------------------------
cask "google-chrome"
cask "vivaldi"
cask "zen"
cask "brave-browser"
cask "firefox"
cask "raycast"                       # launcher/clipboard/window/AI/snippets
cask "rectangle"                     # window snapping
cask "nikitabobko/tap/aerospace"     # i3-style tiling (to try)
cask "obsidian"                      # PKM (local Markdown)
cask "shottr"                        # screenshots + OCR (free)
cask "jordanbaird-ice"               # menu-bar manager
cask "stats"                         # menu-bar system monitor
cask "alt-tab"                       # per-window Alt-Tab
cask "maccy"                         # clipboard history (free)
cask "pdf-expert"                    # PDF editor (paid, optional)
cask "bitwarden"
brew "bitwarden-cli"
brew "netbirdio/tap/netbird"         # NetBird VPN CLI/daemon (open-source WireGuard mesh)
cask "netbirdio/tap/netbird-ui"      # NetBird GUI (connect needs a setup key / SSO from your org)

# ---- 11. Hardware / Embedded ----------------------------------------------
cask "arduino-ide"
brew "platformio"
brew "arduino-cli"
cask "thonny"                        # MicroPython IDE
brew "picocom"
brew "minicom"
cask "coolterm"                      # serial GUI
cask "kicad"                         # PCB/EDA
cask "wch-ch34x-usb-serial-driver"   # CH340 clone driver
# via uv (post-install): esptool esphome mpremote
# Wokwi = VS Code extension; Home Assistant = Docker (dev) — see CATALOG.md

# ---- 12. Efficiency layer (Quick Look + Transfer & Text) ------------------
cask "qlmarkdown"
cask "qlstephen"                     # preview extension-less/plain-text files
cask "quicklook-video"              # video preview
cask "quicklookase"
cask "apparency"                     # inspect .app bundles
cask "suspicious-package"            # inspect .pkg installers before running
cask "qlcolorcode"                   # syntax-highlighted code preview (covers JSON too)
# quicklook-json: removed from Homebrew 2025-12-23 (disabled) — qlcolorcode covers JSON preview
cask "localsend"                     # AirDrop alternative (LAN, cross-platform)
cask "espanso"                       # text expander
cask "hammerspoon"                   # Lua automation
cask "keepingyouawake"               # caffeinate GUI
cask "secretive"                     # Secure-Enclave SSH keys (hardware-backed, no passphrase)
cask "pearcleaner"                   # thorough app uninstaller
# Keyboard-Nav (homerow, leader-key, karabiner-elements) → EXPLORE-LATER (review first)
# defaults tweaks → defaults-tweaks.sh (review + run manually)

# ---- 13. Fun / Rice -------------------------------------------------------
brew "cava"                          # terminal audio visualizer
brew "cbonsai"
brew "pipes-sh"
brew "asciiquarium"
brew "lolcat"
brew "cowsay"
brew "fortune"
brew "tty-clock"
brew "cmatrix"
brew "sl"
brew "felixkratz/formulae/sketchybar"  # scriptable menu bar
cask "ubersicht"                     # desktop widgets
cask "font-hack-nerd-font"           # for SketchyBar/Starship/yazi glyphs
cask "font-symbols-only-nerd-font"
cask "aerial"                        # Apple-TV screensaver + live wallpaper
cask "tomatobar"                     # menu-bar Pomodoro
cask "itsycal"                       # menu-bar calendar
# mas "RunCat", id: 1429033973       # DISABLED: App Store unavailable (company Apple ID can't download).
#   → use Stats (installed) for menu-bar CPU, or `brew install --cask iglance` (open-source). No mas apps.
# Backdrop (Cindori), Bongo Cat (GitHub), Desktop Goose (itch.io) → direct download, see CATALOG.md
