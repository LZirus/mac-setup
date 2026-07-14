# Getting Started — Mini-Guides

Short intros to the tools you may not use yet, so you can actually wield them. Grouped by area.
Each: what it is → the 20% that gives 80% → first command to try.

---

## Terminal & shell
- **Ghostty** — fast GPU terminal. Config: `~/.config/ghostty/config` (e.g. `theme = ...`, `font-family = ...`). Reload with ⌘⇧, .
- **Starship** — the prompt. Config `~/.config/starship.toml`. Already shows git/lang context. `starship preset -h` for presets.
- **atuin** — magical shell history. Press **Ctrl-R** for fuzzy, syncable, context-aware history. `atuin search <term>`.
- **zoxide** — smarter `cd`. Use `z <partial-dir>` to jump to frequently used dirs. Learns as you go.
- **fzf** — fuzzy finder. **Ctrl-T** (files), **Ctrl-R** (history, atuin takes over), `**<Tab>` completion. Pipe anything: `ls | fzf`.
- **eza / bat / fd / rg** — modern `ls`/`cat`/`find`/`grep`. Try `eza --tree`, `bat file`, `fd pattern`, `rg query`.
- **yazi** — TUI file manager with previews. Run `yazi`. Arrows to navigate, `Space` select, `q` quit. `y`/`p` yank/paste.
- **zellij** — terminal multiplexer with on-screen hints. Run `zellij`. Ctrl-p (panes), Ctrl-t (tabs). Friendlier than tmux to start.
- **gum** — pretty interactive shell scripts: `gum choose a b c`, `gum input`, `gum spin -- long-cmd`.

## Git
- **lazygit** — full git TUI. Run `lazygit` in a repo. `Space` stage, `c` commit, `P` push, `space` on branches to checkout. Learn this — it's a huge speedup.
- **gh** — GitHub CLI. `gh auth login`, `gh pr create`, `gh pr checkout <n>`, `gh repo clone`.
- **git-delta** — pretty diffs (wired as git pager in post-install). Just `git diff` / `git show`.
- **jj (jujutsu)** — next-gen VCS, git-compatible. Optional/experimental. `jj git init --colocate` in a repo to try alongside git.

## Runtime managers
- **mise** — one tool for node/go/java/lua versions + env + tasks. `mise use -g node@lts`, `mise use go@latest` (per-project via `.mise.toml`). Replaces nvm/pyenv/sdkman.
- **uv** — Python everything. `uv init` (project), `uv add requests`, `uv run script.py`, `uv tool install <cli>`, `uv python install 3.12`. Blazing fast.
- **rustup** — Rust. After `rustup-init`: `rustc`, `cargo new`, `cargo add`, `cargo run`.

## Editors
- **Neovim + LazyVim** — run `nvim`. LazyVim gives you LSP/treesitter/telescope out of the box. **Space** is the leader key → `Space` opens the menu; `Space f f` find files, `Space /` grep, `Space e` file tree. Give it a real week.
- **Cursor** — AI IDE (VS Code fork). ⌘K inline edit, ⌘L chat, ⌘I agent. Point it at local models via Ollama if you want private AI.

## Local AI
- **Ollama** — `ollama run qwen2.5-coder:32b`, `ollama pull llama3.3:70b`, `ollama list`. Serves an OpenAI-compatible API on `localhost:11434` — point other tools at it.
- **LM Studio** — GUI to browse/run models; prefer **MLX** quants on Apple Silicon. Also exposes a server on :1234.
- **mlx-lm** — fastest local inference. `mlx_lm.generate --model mlx-community/<model> --prompt "..."`, or `mlx_lm.server` for an API.
- **Open WebUI** — ChatGPT-style UI over Ollama. Started as a service in post-install → open `http://localhost:8080`.
- **Goose** — local agentic assistant (MCP host). `goose session` in a repo; configure it to use Ollama for fully-local agents. Add MCP servers to extend it.
- **VoiceInk** — offline dictation. Set a hotkey; speak into any text field. All on-device.
- **Draw Things** — local image generation. Pick a model, type a prompt. Metal-accelerated.

## Cloud / DevOps
- **Colima** — your Docker engine. `colima start` (once per boot), then normal `docker ...`. `colima stop` to free RAM.
- **lazydocker** — Docker TUI. Run `lazydocker` to see containers/images/logs. `dive <image>` to inspect layers.
- **k9s** — Kubernetes TUI. `k9s` → `:pods`, `:svc`, `/` filter, `l` logs, `d` describe. The fastest way to work a cluster.
- **kubectx / kubens** — switch context/namespace fast.
- **az / aws** — `az login`, `aws configure` (or `aws-vault` for secure creds). `azd up` for Azure Developer CLI projects.
- **OpenTofu** — `tofu init`, `tofu plan`, `tofu apply` (Terraform-compatible).

## Security
- **UTM** — run Kali. Download the **ARM64** Kali UTM image (kali.org), import, boot. Snapshots via UTM UI.
- **Caido** — modern Burp alternative. Launch, set browser proxy, intercept. Try it alongside Burp.
- **ProjectDiscovery pipeline** — `subfinder -d target | httpx | katana | nuclei`. The dominant recon flow.
- **k8sgpt** — `k8sgpt analyze --explain` (optionally with a local Ollama backend) to triage clusters.

## AI × Security (red-teaming)
- **garak** — "nmap for LLMs". `garak --model_type ollama --model_name <model> --probes <probe>`.
- **PyRIT** — Python framework for automated LLM attack chains. Import as a library.
- **promptfoo** — eval + red-team in CI. `promptfoo redteam init` then `promptfoo redteam run`.
- **mcp-scan** — audit MCP servers before trusting them. `mcp-scan scan` / point it at your config.

## Efficiency
- **Quick Look plugins** — just press **Space** on a file in Finder: Markdown renders, JSON pretty-prints, `.pkg` shows its scripts (suspicious-package), `.app` shows its innards (apparency).
- **LocalSend** — AirDrop for everything. Open on two devices on the same LAN → send files/text. No cloud.
- **Espanso** — text expander. Define triggers in `~/Library/Application Support/espanso/match/base.yml` (e.g. `:sig` → your signature). Works in every app.
- **Hammerspoon** — automate macOS in Lua (`~/.hammerspoon/init.lua`). Bind hotkeys, move windows, react to events. "AutoHotkey for Mac".
- **KeepingYouAwake** — click the menu-bar coffee cup to prevent sleep (with timers).

## Hardware / Embedded
- **PlatformIO** — install the VS Code extension; or CLI `pio run`, `pio device monitor`. Multi-board, better than Arduino IDE for real projects.
- **esptool / esphome / mpremote** — `esptool.py flash_id`, `esphome run config.yaml`, `mpremote connect auto repl`.
- **Wokwi** — simulate ESP32/Arduino before touching hardware (VS Code extension or wokwi.com).
- **CoolTerm / picocom** — serial monitors. `picocom -b 115200 /dev/tty.usbserial-XXXX`.

## Productivity
- **Raycast** — ⌘Space (replace Spotlight). Launch apps, clipboard history, snippets, window management, AI, extensions. The single biggest leverage tool — spend 10 min in its Store.
- **AeroSpace** — i3-style tiling. Config `~/.aerospace.toml`. Alt-hjkl to focus, Alt-Shift-hjkl to move. Try it; keep Rectangle as the safe default.
- **Obsidian** — local Markdown vault. Create `~/Documents/vault`. `[[links]]`, backlinks, plugins (QuickAdd, Advanced URI). Your data stays as files.

## Fun (for when you want a smile)
- `fortune | cowsay | lolcat` · `cbonsai -l` (growing bonsai) · `pipes-sh` · `asciiquarium` · `cava` (music visualizer) · `cmatrix`.
- **RunCat** — the menu-bar cat runs faster under CPU load. **SketchyBar** — fully scriptable menu bar (`~/.config/sketchybar/`). **Aerial** — set as screensaver in System Settings.
