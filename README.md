# mac-setup

A reproducible, **documented** setup for a fresh Apple Silicon Mac — tuned for
**cybersecurity + AI engineering** work, but useful as a starting point for anyone.
The guiding principle: everything is documented and **easy to uninstall**.

> ⚠️ **This is my personal setup, shared as a reference.** It installs a *lot* of
> tools (GBs of downloads) and changes system defaults. Don't run it blindly —
> read the `Brewfile`, `docs/CATALOG.md`, and the scripts first, and cut what you
> don't want. The scripts are intentionally review-before-run.

## What's here

```
├── Brewfile              # single source of truth for all Homebrew installs
├── scripts/
│   ├── install.sh        # resilient installer (one package at a time; tolerates failures)
│   ├── post-install.sh   # shell/tool config, runtimes, uv tools, Ollama models
│   └── defaults.sh       # macOS `defaults` tweaks (keyboard, Finder, Dock, screenshots)
├── docs/
│   ├── CATALOG.md        # every tool: what / why / exact uninstall command
│   ├── GETTING-STARTED.md# mini-guides for tools you may not use yet
│   ├── MANUAL-STEPS.md   # steps that can't be scripted (sudo, App Store, hardware…)
│   ├── STRUCTURE.md      # a folder/naming convention for code & documents
│   ├── EXPLORE-LATER.md  # curated discovery backlog (not installed yet)
│   └── docker-services.md# helper services to run via Colima (Portainer, Dockge)
├── PROFILE.example.md    # template for personal context (real PROFILE.md is gitignored)
└── user.env.example      # template for local secrets/identity (real user.env is gitignored)
```

## Personal vs. generic

Everything committed here is **generic** — fill in your own specifics locally:

- Copy `user.env.example` → `user.env` and set your git identity. `user.env` is
  gitignored, so your details never get pushed.
- Optionally copy `PROFILE.example.md` → `PROFILE.md` for personal context
  (also gitignored).

## Quickstart (fresh machine)

```bash
git clone <this-repo> ~/mac-setup && cd ~/mac-setup

# 0. Homebrew (if you don't have it)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 1. Your local config
cp user.env.example user.env && $EDITOR user.env

# 2. Install everything (long; downloads GBs). Resilient version:
bash scripts/install.sh
#   …or plain:  brew bundle

# 3. Configure (review it first!)
bash scripts/post-install.sh

# 4. Optional system tweaks (review it first!)
bash scripts/defaults.sh
```

Then see `docs/MANUAL-STEPS.md` for the things that need a password, the App Store,
or hardware.

## Uninstall

- One tool: look it up in `docs/CATALOG.md` (each has its exact uninstall command).
- Everything **not** in the Brewfile: `brew bundle cleanup` (run from the repo root).
- App leftovers: [Pearcleaner](https://github.com/alienator88/Pearcleaner).

## Notes

- Target: **Apple Silicon**, macOS 26. Some casks need `sudo` — see `docs/MANUAL-STEPS.md`.
- If your org manages some apps via **MDM** (JumpCloud/Intune/Jamf), leave those out
  of the Brewfile to avoid conflicts.
- Offensive/pentest tooling is kept lean on the host; heavy work runs in a **Kali VM** (UTM).

## License

[The Unlicense](LICENSE) — public domain. Do whatever you want with it.
