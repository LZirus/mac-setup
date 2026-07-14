# Profile & Context (template)

> Copy this to `PROFILE.md` (gitignored) and fill it in with your own context.
> Purpose: give any future AI agent (or future you) the context of who this machine
> belongs to, what you care about, and *why* it's set up the way it is. The setup
> decisions below make a lot more sense with this context, so agents read it first.
>
> This file is a **template**. The real, personal `PROFILE.md` is intentionally
> gitignored so it never gets pushed.

## Who
- **Role:** <your role / focus, e.g. "Cybersecurity + AI engineer">
- **Machine:** <model, chip, RAM, macOS version, work or personal>

## What you do
- <domains you work in — this drives which tools are installed>
- e.g. Cybersecurity (pentesting, Kali, offensive tooling), AI (local LLMs, agents),
  ML/CV, Cloud/DevOps, embedded/hardware, consulting deliverables, ...

## How you like to work (preferences)
- <e.g. loves exploring new tech; heavy CLI *and* GUI user; everything documented
  and easy to uninstall; polyglot; wants short getting-started intros for new tools>

## Environment / constraints
- <e.g. some apps managed by org MDM — don't reinstall via brew>
- <VPN, hardening baseline, App Store limitations, password manager, ...>

## Key decisions (this setup)
- <the non-obvious choices and their rationale — containers runtime, editors,
  window manager, local-AI stack, etc. See docs/CATALOG.md for the full tool list.>

## Pointers
- `Brewfile` — everything installed. `docs/CATALOG.md` — per-tool what/why/uninstall.
- `docs/EXPLORE-LATER.md` — backlog. `docs/GETTING-STARTED.md` — mini-guides.
- `scripts/defaults.sh` / `scripts/post-install.sh` — reviewable config.
