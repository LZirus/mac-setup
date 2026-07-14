# 🗂 Where things live — folder structure & conventions

> This file sorts to the top of `~/Documents` (the `00-` prefix). It's the map of the whole system.
> Golden rule: **code → `~/Developer`**, **documents → `~/Documents`**, **notes → Obsidian**.

## The two trees

### `~/Developer/` — all code (git repos). NOT in iCloud.
| Folder | For |
|---|---|
| `work/` | Client & work code projects |
| `personal/` | Your own projects / side projects |
| `learning/` | Courses, tutorials, guided practice |
| `sandbox/` | Throwaway spikes & experiments (delete freely) |
| `oss/` | Cloned repos you reference or contribute to (not yours) |

Repo naming: **kebab-case**, client-prefixed for work → `work/acme-risk-dashboard`, `personal/home-lab`.

### `~/Documents/` — documents & deliverables
| Folder | For |
|---|---|
| `Work/Clients/<Client>/<Engagement>/` | Per-engagement: proposals, slides, excel, reports, notes |
| `Work/Internal/` | Timesheets, expenses, admin |
| `Work/Templates/` | Branded deck/document templates |
| `Work/Knowledge/` | Methodologies, reusable work reference |
| `Work/Archive/` | Finished/old work material |
| `Personal/` | Finance, Health, Home, Travel, Legal, Learning (+ Archive) |
| `Resources/` | Cross-cutting reference: ebooks, cheat-sheets, datasets |
| `Inbox/` | Triage dump — sort weekly, keep it near-empty |
| `Obsidian/` | Notes vault — the connective tissue (see below) |
| `mac-setup/` | This machine's setup repo |

Inside an engagement, numbered subfolders keep a natural order:
`01-proposal/ 02-delivery/ 03-slides/ 04-data/ 05-notes/`

## Mixed engagements (code + docs)
When a client project has **both** software and documents:
- **Docs** → `~/Documents/Work/Clients/<Client>/<Engagement>/`
- **Code** → `~/Developer/work/<client>-<repo>/`
- Cross-link them: put the repo path in the engagement's `README.md`, and note the engagement folder in the repo's README. (See the `_ExampleClient` engagement README for the template.)

This keeps code out of iCloud while everything stays discoverable.

## Naming conventions
- **Dates:** ISO prefix for anything time-ordered → `2026-07-02-proposal-v2.pptx`, `2026-Q3-report.xlsx`.
- **Clients/engagements:** consistent names; engagement folders may prefix the year → `2026-SecurityAudit`.
- **Versions:** `-v1`, `-v2`, `-final` (or better: rely on git / file history).
- **`_` prefix** = template/example/placeholder (sorts first). **`Archive/`** = done, out of the way.

## Finding things fast
- **Raycast** (⌘Space) → type a file/app name; also its file-search & folder navigation.
- **zoxide** in the terminal → `z acme` jumps to the most-used matching dir.
- **Finder sidebar favorites** → Developer, Work, Personal, Inbox, Screenshots (added via `mysides`).
- **Finder tags** (optional) → color-code Active / Waiting / Archive; then filter by tag.
- **Spotlight** for content search; **`rg`/`fd`** for code/text search in the terminal.
- **Obsidian** → daily notes + per-client notes that `[[link]]` to everything; your searchable index/brain.

## Weekly 5-minute hygiene
1. Empty `~/Documents/Inbox/` and `~/Downloads/` (file or delete).
2. Move finished engagements/projects to their `Archive/`.
3. `sandbox/` — delete what you're done experimenting with.

## Optional upgrades (see mac-setup/EXPLORE-LATER.md)
- **Hazel** — auto-sort Downloads/Inbox by rules (paid).
- **DEVONthink** — heavyweight document manager with AI classification (paid).
- **Johnny.Decimal** — a strict numbering system if you want even more structure.
