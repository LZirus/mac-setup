# Container runtimes — Colima vs. Apple `container`

Two ways to run Linux containers on Apple Silicon without Docker Desktop. They have
**fundamentally different architectures** and coexist fine (separate binaries/stacks).

- **Colima** — *one* Linux VM (Lima + Virtualization.framework) running a normal
  Docker/containerd daemon. All containers share that VM. → the classic Docker
  experience, minus Docker Desktop. **This is the daily driver here.**
- **Apple `container`** — *one lightweight VM per container* (Swift, Apple's
  Containerization framework, arm64-native). Each container gets its own IP on a
  private subnet. Stronger isolation, sub-second starts. Newer, rougher edges.

## Decision — use both, Colima as default

| Use-case | Tool |
|---|---|
| Everyday `docker` CLI, **Compose**, dev environments, CI parity, x86 images via Rosetta | **Colima** |
| Single strongly-isolated containers; security sandboxing (untrusted payloads/PoCs); trying the new model | **Apple `container`** |

Rule of thumb: the moment you need Compose or classic `-p` port publishing (most dev
workflows), reach for Colima. Use Apple `container` where hard VM-per-container
isolation is the actual point — which fits the security work well.

## Trade-offs

**Apple `container` wins:** VM-per-container isolation, fast/lean startup, native Apple
Silicon, tight macOS integration.

**Apple `container` gaps (as of v1.x, mid-2026):**
- **No Docker Compose** — only third-party bridges (e.g. `container-compose`), not production-ready.
- **No `-p` port mapping** — you reach containers via their own IP, not `localhost:PORT`.
  Breaks many tutorials, dev-container flows, and tools that assume `localhost`.
- Per-container IP / networking only works properly on **macOS 26+**.
- Young ecosystem; fewer edge cases covered than the battle-tested Docker stack.

## Install / uninstall

### Colima (already installed — see CATALOG §4)
```bash
brew install colima docker docker-compose   # runtime + CLI
colima start                                 # or: brew services start colima
```
Uninstall: `brew uninstall colima docker docker-compose`

### Apple `container`
Requires **macOS 26**. Official install is a signed `.pkg` (no Homebrew cask upstream;
check `brew info --cask container` if you prefer brew).
```bash
# Download the latest signed installer .pkg from:
#   https://github.com/apple/container/releases
# Double-click it, follow the prompts, then:
container system start
container run --rm docker.io/library/alpine uname -a   # smoke test
```
Uninstall (keeps vs. removes data):
```bash
/usr/local/bin/uninstall-container.sh -k   # keep user data
/usr/local/bin/uninstall-container.sh -d   # delete all data
```

## Re-evaluate: ~October 2026
Apple `container` is under active development; the Compose/port-mapping gaps are the
things to recheck. If Compose lands (or a solid bridge matures) and port publishing
gets friendlier, reconsider promoting it beyond the isolation/sandbox niche.
_Baseline captured 2026-07-27 at apple/container v1.x._

## Alternatives (not installed — see EXPLORE-LATER.md)
OrbStack (paid), Rancher Desktop, Podman Desktop.
