# Explore-Later — Curated Discovery Backlog

Tools intentionally **not installed yet** but worth exploring, with install hints. Pulled from a broad
2025–2026 sweep tailored to a cybersecurity + AI engineer who likes new tech.
When you dive into a topic, come here first. Move anything you adopt into the `Brewfile`.

---

## Keyboard-driven navigation (you wanted to try before installing)
- **Homerow** — Vimium-style click labels over any UI element, system-wide. `brew install --cask homerow` (paid ~$29/yr).
- **Leader Key** — nested single-key launcher (`o`→`e` = Mail). `brew install --cask leader-key` (free).
- **Karabiner-Elements** — key remapping; make Caps Lock a Hyper key (⌃⌥⌘⇧). `brew install --cask karabiner-elements` (free).
- Canonical stack: Karabiner Hyper key → Leader Key / Raycast → AltTab.

## Creative / Cross-Domain
### Creative coding / generative art
- **Nannou** 🦀 — creative coding in Rust. `cargo add nannou`.
- **Bevy** 🦀 — Rust game/interactive engine. `cargo`.
- **TouchDesigner** — node-based real-time visuals, ingests sensor/MIDI/OSC. `brew install --cask touchdesigner` (free non-commercial).
- **KodeLife** — live GPU shader editor. `brew install --cask kodelife`.
- **Processing** — `brew install --cask processing`. **openFrameworks** (C++), **Cables.gl** (web), **Shadertoy** (web).
### Music / live-coding
- **Sonic Pi** `--cask sonic-pi` · **SuperCollider** `--cask supercollider` · **VCV Rack** `--cask vcv-rack` · **Cardinal** `--cask cardinal` · **REAPER** `--cask reaper` (~$60) · **Strudel** (web: strudel.cc) · **TidalCycles**.
### 3D / fabrication (pairs with hardware hobby)
- **Blender** `--cask blender` · **OpenSCAD** `--cask openscad` (code-based CAD) · **FreeCAD** `--cask freecad` · **OrcaSlicer** `--cask orcaslicer` · **PrusaSlicer** `--cask prusaslicer` · **Bambu Studio** `--cask bambu-studio`.
### Data viz / notebooks
- **Rerun** 🦀🤖 — multimodal CV/robotics time-series viz. `pip install rerun-sdk` — **great for computer-vision work**.
- **marimo** — reactive Python notebook (git-friendly). `uv tool install marimo`.
- **Observable Framework** / **D3** / **Observable Plot** (npm).
### GIS / spatial
- **QGIS** `--cask qgis` · **kepler.gl** (web) · **Protomaps/PMTiles**.
### Quantified self
- **Grafana** `brew install grafana` + **InfluxDB** `brew install influxdb` + **ActivityWatch** (activitywatch.net).
### Retro / learning / CTF
- **Godot** `--cask godot` · **PICO-8** (~$15, lexaloffle) · **TIC-80** (free) · **pwn.college** / **picoCTF** / **OverTheWire** (web).

## Self-hosted automation engines
- **n8n** (fair-code, best AI/MCP breadth) — Docker: `docker.n8n.io/n8nio/n8n`.
- **Windmill** (AGPLv3, code→workflows+UIs) · **Activepieces** (MIT, MCP toolkit) · **Node-RED** `brew install node-red` (IoT) · **Kestra** (YAML data/ops) · **Trigger.dev** (TS jobs) · **Huginn** (monitoring/scraping).

## Bleeding-edge AI
- **Pi** — minimal sovereign coding agent; pair with local MLX → nothing leaves the Mac. `npm i -g --ignore-scripts @earendil-works/pi-coding-agent`.
- **OpenMemory / Mem0** — local persistent agent memory. `pip install mem0ai`.
- **Letta** (stateful agent runtime) · **Context7** (live docs-as-context) · **Conductor** / **Vibe Kanban** (parallel agents in git worktrees).
- **Karakeep** (self-hosted bookmarks + local-LLM auto-tag, Docker) · **Docmost** (OSS Notion/Confluence, Docker).

## Containers / editors / RE (alternatives)
- **OrbStack** (`--cask orbstack`, paid commercial) · **Rancher Desktop** (`--cask rancher`) · **Podman Desktop** (`--cask podman-desktop`).
- **Zed** (`--cask zed`) · **Aider** (`brew install aider`) · **Codex CLI** (`brew install codex`) · **Windsurf** · **Cline** / **Continue** (IDE extensions).
- **Hopper** (`--cask hopper-disassembler`, paid) · **Binary Ninja** (manual, paid) · **Cutter** (`--cask cutter`).

## Consultant extras
- **Gamma** (AI decks, web) · **Beautiful.ai** (web) · **NotebookLM** (web — ⚠️ sends docs to Google, NDA risk) · **Elephas** (local, NDA-safe) · **Eraser** / **Excalidraw** / **tldraw** (diagrams) · **Shortwave** / **Superhuman** (AI email — Gmail-first; check if your mailbox is MS) · **Notion Calendar** `--cask notion-calendar` · **Fantastical** `--cask fantastical`.

## Voice / AI glue
- **superwhisper** (`--cask superwhisper`, lifetime option) · **MacWhisper** (`--cask macwhisper`) · **whisper-cpp** (`brew install whisper-cpp`) · **Cherry Studio** (`--cask cherry-studio`) · **EnConvo**.

## Self-hosted gems / home
- **Immich** (photos) · **Jellyfin** (media) · **Beszel** (monitoring) · **Dawarich** (location history) · **Wealthfolio** (finance).
- **Vaultwarden** (self-host Bitwarden server, Docker) — the planned password-manager endgame.
- **Home Assistant** (Docker for dev; dedicated HW for prod) · **Homebridge** (native, not Docker-on-Mac) · **Node-RED**.

## Self-hosted automation × MCP note
n8n (MCP client + server trigger) and Activepieces (large MCP toolkit) are the two best for wiring
automation to LLM agents. Great fit given the local Ollama/Goose stack already installed.
