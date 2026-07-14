# Catalog — What / Why / Uninstall

Every installed tool with a one-line description and its exact uninstall command.

**Uninstall conventions**
- Formula: `brew uninstall <name>`
- Cask: `brew uninstall --cask <name>` (add `--zap` to also remove prefs/support files)
- Nuke everything not in the Brewfile: `brew bundle cleanup` (run from the repo root)
- App leftovers: use **Pearcleaner** (GUI) for a thorough app removal.
- uv tools: `uv tool uninstall <name>` · npm: `npm rm -g <name>` · pipx: `pipx uninstall <name>`

---

## 1. Terminal, Shell & modern CLI
| Tool | What | Uninstall |
|---|---|---|
| ghostty | GPU terminal emulator | `brew uninstall --cask ghostty` |
| starship | Cross-shell prompt | `brew uninstall starship` |
| zsh-autosuggestions / zsh-syntax-highlighting | zsh UX plugins | `brew uninstall zsh-autosuggestions zsh-syntax-highlighting` |
| tmux / zellij | Terminal multiplexers | `brew uninstall tmux zellij` |
| atuin | SQLite shell history + search | `brew uninstall atuin` |
| ripgrep, fd, bat, eza, fzf, zoxide | Modern grep/find/cat/ls/fuzzy/cd | `brew uninstall ripgrep fd bat eza fzf zoxide` |
| git-delta | Syntax-highlighted git pager | `brew uninstall git-delta` |
| jq, yq | JSON / YAML processors | `brew uninstall jq yq` |
| btop, htop, procs, dust, duf | Monitors / disk / process tools | `brew uninstall btop htop procs dust duf` |
| sd, tldr, hyperfine, gum, glow | sed-alt / cheat-pages / bench / TUI-scripts / md-render | `brew uninstall sd tldr hyperfine gum glow` |
| yazi (+ ffmpegthumbnailer, sevenzip, poppler, resvg, imagemagick) | TUI file manager + preview deps | `brew uninstall yazi ffmpegthumbnailer sevenzip poppler resvg imagemagick` |
| lazygit, gh, difftastic, jj | Git TUI / GitHub CLI / structural diff / jujutsu | `brew uninstall lazygit gh difftastic jj` |
| fastfetch, mas, pandoc | Sysinfo / App-Store-CLI / doc-converter | `brew uninstall fastfetch mas pandoc` |
| chezmoi | Dotfiles manager (source in ~/.local/share/chezmoi) | `brew uninstall chezmoi` |

## 2. Languages & runtime managers
| Tool | What | Uninstall |
|---|---|---|
| mise | Polyglot runtime/env/task manager | `brew uninstall mise` |
| uv | Python package/env/tool manager | `brew uninstall uv` |
| rustup | Rust toolchain manager | `rustup self uninstall` then `brew uninstall rustup` |
| miniforge | conda-forge (conda-only ML deps) | `brew uninstall --cask miniforge` |

## 3. Editors
| Tool | What | Uninstall |
|---|---|---|
| visual-studio-code | VS Code | `brew uninstall --cask visual-studio-code` |
| cursor | AI IDE (VS Code fork) | `brew uninstall --cask cursor` |
| neovim | Neovim (+ LazyVim config in ~/.config/nvim) | `brew uninstall neovim` (config: `rm -rf ~/.config/nvim ~/.local/share/nvim`) |

## 4. Cloud / DevOps / Containers
| Tool | What | Uninstall |
|---|---|---|
| colima, docker, docker-compose | Container runtime + CLI | `brew uninstall colima docker docker-compose` |
| lazydocker, dive | Docker TUI / image inspector | `brew uninstall lazydocker dive` |
| kubernetes-cli, k9s, helm, kustomize | kubectl + K8s ecosystem | `brew uninstall kubernetes-cli k9s helm kustomize` |
| kubectx, stern, k3d | ctx/ns switch / log tail / local cluster | `brew uninstall kubectx stern k3d` |
| trivy, k8sgpt | Vuln scanner / AI cluster triage | `brew uninstall trivy k8sgpt` |
| opentofu, terragrunt | IaC + DRY wrapper | `brew uninstall opentofu terragrunt` |
| azure-cli, azcopy, azure-dev | Azure CLI / data copy / dev CLI (azd) | `brew uninstall azure-cli azcopy azure-dev` |
| awscli, aws-vault, eksctl, session-manager-plugin | AWS CLI / creds / EKS / SSM | `brew uninstall awscli aws-vault eksctl` · `brew uninstall --cask session-manager-plugin` |
| freelens | Kubernetes GUI | `brew uninstall --cask freelens` |

## 5. Local AI (LLM + ML/CV)
| Tool | What | Uninstall |
|---|---|---|
| ollama | LLM runtime/server (localhost:11434) | `brew services stop ollama; brew uninstall ollama` (models: `rm -rf ~/.ollama`) |
| mlx-lm | Apple MLX inference/finetune | `brew uninstall mlx-lm` |
| open-webui | Self-hosted chat UI (desktop app) | `brew uninstall --cask open-webui` |
| lm-studio | GUI model runner | `brew uninstall --cask lm-studio` |
| anythingllm | Doc RAG desktop app | `brew uninstall --cask anythingllm` |
| draw-things | Local image generation | `brew uninstall --cask draw-things` |
| slicer, itk-snap | 3D Slicer / ITK-SNAP (medical imaging) | `brew uninstall --cask slicer itk-snap` |
> ⚠️ **Conv3D gap:** PyTorch-MPS doesn't implement Conv3D. Heavy 3D CNN training → CPU fallback or CUDA/cloud. 2D + inference fine locally.

## 6. Security / Pentest
| Tool | What | Uninstall |
|---|---|---|
| utm | VM host (ARM64 Kali) | `brew uninstall --cask utm` |
| nmap, rustscan, masscan | Port scanners | `brew uninstall nmap rustscan masscan` |
| ffuf, feroxbuster, gobuster | Web fuzzers/dir-brute | `brew uninstall ffuf feroxbuster gobuster` |
| nuclei, httpx, subfinder, amass, katana | ProjectDiscovery recon pipeline | `brew uninstall nuclei httpx subfinder amass katana` |
| sqlmap, nikto, hydra | SQLi / web scan / login brute | `brew uninstall sqlmap nikto hydra` |
| mitmproxy | Intercepting proxy (cask, incl. CLI) | `brew uninstall --cask mitmproxy` |
| hashcat, john-jumbo | Password cracking | `brew uninstall hashcat john-jumbo` |
| socat, binwalk, exiftool, aircrack-ng | Relay / firmware / metadata / wifi | `brew uninstall socat binwalk exiftool aircrack-ng` |
| radare2, rizin | RE frameworks (CLI) | `brew uninstall radare2 rizin` |
| burp-suite, caido, wireshark-app, zap, proxyman | Web/proxy/packet GUIs | `brew uninstall --cask burp-suite caido wireshark-app zap proxyman` |
| ghidra | RE / decompiler (formula; launch with `ghidraRun`) | `brew uninstall ghidra` |
> Keep in the **Kali VM**: responder, metasploit, impacket, netexec. WiFi injection needs an **external USB adapter** (internal card can't). VMware Fusion = manual Broadcom download (optional).

## 7. AI-Security Red-Teaming (non-brew)
| Tool | What | Uninstall |
|---|---|---|
| garak | LLM vulnerability scanner | `uv tool uninstall garak` |
| pyrit | LLM attack-orchestration **library** (add to a project: `uv add pyrit`) | remove the project venv / `uv remove pyrit` |
| promptfoo | Eval + red-team harness | `npm rm -g promptfoo` |
| mcp-scan | Audit MCP servers | `pipx uninstall mcp-scan` |
| frida-tools | Dynamic instrumentation (frida) | `uv tool uninstall frida-tools` |

## 8. Local AI-agent stack
| Tool | What | Uninstall |
|---|---|---|
| block-goose | Local MCP agent (GUI) | `brew uninstall --cask block-goose` |
| block-goose-cli | Goose CLI | `brew uninstall block-goose-cli` |
| voiceink | Offline voice-to-text | `brew uninstall --cask voiceink` |

## 9. Consultant-AI tools
| Tool | What | Uninstall |
|---|---|---|
| granola | Silent AI meeting notes | `brew uninstall --cask granola` |
| screen-studio | Cinematic screen recording | `brew uninstall --cask screen-studio` |
| cap | OSS screen recorder | `brew uninstall --cask cap` |
| comet | Perplexity agentic browser | `brew uninstall --cask comet` |
| reader | Readwise Reader | `brew uninstall --cask reader` |
| meetily | Local OSS meeting notes (Whisper + Ollama) | `brew uninstall --cask meetily` |
| macwhisper | On-device transcription (paid, no account) | `brew uninstall --cask macwhisper` |
| blackhole-2ch | Virtual audio driver (system-audio capture) | `brew uninstall --cask blackhole-2ch` |

## 10. Productivity / Browsers / Password / VPN
| Tool | What | Uninstall |
|---|---|---|
| google-chrome, vivaldi, zen, brave-browser, firefox | Browsers | `brew uninstall --cask google-chrome vivaldi zen brave-browser firefox` |
| raycast | Launcher/clipboard/window/AI | `brew uninstall --cask raycast` |
| rectangle | Window snapping | `brew uninstall --cask rectangle` |
| aerospace | i3-style tiling WM | `brew uninstall --cask aerospace` then `brew untap nikitabobko/tap` |
| obsidian | PKM (local Markdown) | `brew uninstall --cask obsidian` |
| shottr | Screenshots + OCR | `brew uninstall --cask shottr` |
| jordanbaird-ice | Menu-bar manager (Ice) | `brew uninstall --cask jordanbaird-ice` |
| stats | Menu-bar system monitor | `brew uninstall --cask stats` |
| alt-tab | Per-window switcher | `brew uninstall --cask alt-tab` |
| maccy | Clipboard history | `brew uninstall --cask maccy` |
| pdf-expert | PDF editor (paid) | `brew uninstall --cask pdf-expert` |
| bitwarden, bitwarden-cli | Password manager (GUI+CLI) | `brew uninstall --cask bitwarden` · `brew uninstall bitwarden-cli` |
| netbird / netbird-ui | NetBird VPN (CLI/daemon + GUI) | `brew uninstall netbird; brew uninstall --cask netbird-ui` then `brew untap netbirdio/tap` |
> If your org pushes Office/Teams/Outlook/OneDrive via **MDM** (JumpCloud/Intune/Jamf), leave them out of the Brewfile.

## 11. Hardware / Embedded
| Tool | What | Uninstall |
|---|---|---|
| arduino-ide, arduino-cli, platformio | Embedded IDEs/toolchains | `brew uninstall --cask arduino-ide` · `brew uninstall arduino-cli platformio` |
| thonny | MicroPython IDE | `brew uninstall --cask thonny` |
| picocom, minicom, coolterm | Serial monitors | `brew uninstall picocom minicom` · `brew uninstall --cask coolterm` |
| kicad | PCB/EDA | `brew uninstall --cask kicad` |
| wch-ch34x-usb-serial-driver | CH340 clone driver | `brew uninstall --cask wch-ch34x-usb-serial-driver` |
| esptool, esphome, mpremote | ESP flashing / firmware / MicroPython (uv) | `uv tool uninstall esptool esphome mpremote` |

## 12. Efficiency layer
| Tool | What | Uninstall |
|---|---|---|
| qlmarkdown, qlstephen, quicklook-video, quicklookase, apparency, suspicious-package, qlcolorcode | Quick Look plugins (qlcolorcode covers JSON) | `brew uninstall --cask qlmarkdown qlstephen quicklook-video quicklookase apparency suspicious-package qlcolorcode` |
| localsend | AirDrop alternative | `brew uninstall --cask localsend` |
| espanso | Text expander | `brew uninstall --cask espanso` |
| hammerspoon | Lua automation | `brew uninstall --cask hammerspoon` |
| keepingyouawake | Prevent sleep | `brew uninstall --cask keepingyouawake` |
| pearcleaner | App uninstaller | `brew uninstall --cask pearcleaner` |

## 13. Fun / Rice
| Tool | What | Uninstall |
|---|---|---|
| cava, cbonsai, pipes-sh, asciiquarium, lolcat, cowsay, fortune, tty-clock, cmatrix, sl | Terminal toys | `brew uninstall cava cbonsai pipes-sh asciiquarium lolcat cowsay fortune tty-clock cmatrix sl` |
| sketchybar | Scriptable menu bar | `brew uninstall sketchybar` then `brew untap felixkratz/formulae` |
| ubersicht | Desktop widgets | `brew uninstall --cask ubersicht` |
| font-hack-nerd-font, font-symbols-only-nerd-font | Nerd fonts (glyphs) | `brew uninstall --cask font-hack-nerd-font font-symbols-only-nerd-font` |
| aerial | Screensaver + live wallpaper | `brew uninstall --cask aerial` |
| tomatobar, itsycal | Pomodoro / menu-bar calendar | `brew uninstall --cask tomatobar itsycal` |
| RunCat | Menu-bar CPU cat (App Store) | `mas uninstall 1429033973` |
> Direct-download extras (not brew): **Backdrop** (cindori.com), **Bongo Cat** (GitHub), **Desktop Goose** (itch.io) — remove by dragging the app to Trash + Pearcleaner.
