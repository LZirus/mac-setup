# Local LLMs on Apple Silicon — MLX vs. Ollama vs. LM Studio

Three stacks coexist on this machine. They are **not** competitors so much as three
different entry points to the same idea; the interesting choices are the *model class*
and the *size ceiling*, not the runner.

- **MLX / `mlx-lm`** (Apple) — native Metal framework. On **M5** the GPU Neural
  Accelerators make matmul ~4× faster than M4, and MLX maps almost 1:1 onto that:
  **3.3–4.0× faster time-to-first-token**. Token *generation* only gains ~1.2×,
  because decode is limited by **memory bandwidth**, not compute. → the fast path,
  especially for long prompts / agentic work.
- **Ollama** — easiest daily driver, `localhost:11434`, OpenAI-compatible. Uses MLX
  under the hood on Apple Silicon in recent versions. Less control over the exact quant.
  This is what the `redact` pipeline talks to.
- **LM Studio** — GUI + model browser + one-click OpenAI-compatible server. Loads MLX
  quants directly. Installed here but not yet launched.

## ⚠️ The hard ceiling on this machine: ~24 GB

This is not a theoretical limit, it is **measured on this exact M5 Pro / 64 GB** and
recorded in [`~/Documents/redact/redact/config.py`](../../redact/redact/config.py):

> `qwen3.6:35b-a3b` in q8_0 occupies 37 GB and, together with GLiNER's PyTorch process,
> drives the machine into swapping — **9 minutes per chunk instead of 20 seconds**, plus
> an OOM kill. On 64 GB, anything above ~24 GB model size is unusable if you want to keep
> working in parallel.

The pipeline encodes this as `MAX_MODEL_RAM_SHARE = 0.40` → **25.6 GB hard cap**, with
`DEFAULT_MODEL = "qwen2.5:14b"` (9 GB) and a documented tier ladder topping out at
`qwen3.6:35b-a3b-q4_K_M` (23 GB).

**Consequence:** the widely recommended "80B MoE for 64 GB Macs" (Qwen3-Coder-Next
MLX-4bit, ~42 GB) is **wrong for this machine.** It fits in RAM on paper and destroys
interactive usability in practice. Ignore that advice.

## What actually matters: sparse MoE *within* the ceiling

On a bandwidth-bound machine, **active parameters** decide speed and **total
parameters** decide quality. A sparse Mixture-of-Experts model decouples the two — so
under a fixed size budget, an MoE beats a dense model of the same footprint.

That is the same mechanism behind the viral [`kimi-k3-in-c`](https://github.com/FareedKhan-dev/kimi-k3-in-c)
demo (2.78 T params on a CPU in 8.24 GB RAM) — but that project pushes it to an absurd
extreme: 1.7 TB of disk and ~26–33 s **per token**. The usable version of the same idea
is a small MoE that sits comfortably inside the budget.

→ **Qwen3-Coder-30B-A3B: 30 B total, 3 B active, 16 GB at 4-bit.** Coding-tuned,
well under the cap, leaves ~10 GB headroom. This is the pick here.

## What fits in 64 GB — ranked by usability, not by size

| Model | Format | Footprint | Verdict |
|---|---|---|---|
| **Qwen3-Coder-30B-A3B-Instruct** | MLX 4bit | **16 GB** | ✅ coding — first choice, MoE 3B active |
| qwen2.5:14b | Ollama Q4 | 9 GB | ✅ the `redact` pipeline default; very frugal |
| qwen3.6:27b (dense) | MLX / Q4 | 17–19 GB | ✅ "fits comfortably" per config |
| qwen3.6:35b-a3b | Q4_K_M | 23 GB | ⚠️ documented ceiling — no parallel work |
| Qwen3-Coder-30B-A3B | MLX 6bit | 23 GB | ⚠️ same — at the cap, skip in favour of 4bit |
| qwen3.6:35b-a3b | **Q8_0** | **38 GB** | ❌ **measured: swapping + OOM kill.** Installed in Ollama — candidate for deletion |
| llama3.3:70b (dense) | Q4 | 42 GB | ❌ unusable in parallel; dense = all params read per token |
| Qwen3-Coder-Next 80B-A3B | MLX 4bit | 42 GB | ❌ over the cap despite the internet's advice |
| gpt-oss-120b | MXFP4 | 63 GB | ❌ far over |

Rule of thumb: **stay under ~20 GB** to keep the machine responsive, treat 24 GB as the
absolute wall, and never load two models at once (the pipeline runs GLiNER's PyTorch
process alongside the LLM — that is what pushed it over the edge).

## Install / uninstall

`mlx-lm` and `hf` are **Homebrew formulae** (Brewfile is the source of truth here).
Do *not* also install them via `uv tool` — same version, duplicate binaries, and
`~/.local/bin` shadows `/opt/homebrew/bin` in this shell's PATH.

```bash
brew install mlx-lm hf     # inference/finetune + Hugging Face CLI
```

Uninstall:
```bash
brew uninstall mlx-lm hf
rm -rf ~/.cache/huggingface          # ⚠️ removes ALL downloaded weights
```

**Where the disk goes:** three runners keep three separate copies. Audit occasionally:
```bash
du -sh ~/.ollama ~/.cache/huggingface ~/.lmstudio 2>/dev/null
hf cache scan                        # what's in the HF cache
hf cache rm <repo-id>                # remove one model
ollama rm <model>                    # remove one Ollama model
```

## Getting started (CLI)

```bash
M=lmstudio-community/Qwen3-Coder-30B-A3B-Instruct-MLX-4bit

# one-shot generation
mlx_lm.generate --model $M --prompt "Explain mTLS in three sentences." --max-tokens 300

# interactive chat (keeps the model loaded)
mlx_lm.chat --model $M

# OpenAI-compatible server on :8080 — point any tool at http://localhost:8080/v1
mlx_lm.server --model $M --port 8080

# measure it yourself
mlx_lm.benchmark --model $M
```

First run of a model downloads it; afterwards it is served from the cache. Set `HF_TOKEN`
for faster, rate-limit-free downloads.

**Watch memory while testing** — this is the metric that matters more than tok/s:
```bash
# peak footprint is printed by mlx_lm.generate itself; for live pressure:
memory_pressure | head -5
```

## Getting started (GUI)

LM Studio is installed but has never been launched (`~/.lmstudio` does not exist yet).
On first launch it creates its own model directory and wants its **own copy** — it does
not read the `~/.cache/huggingface` layout. Options:

1. Search "Qwen3-Coder-30B-A3B MLX" in LM Studio's model browser and download there
   (simplest, costs another 16 GB), or
2. keep the CLI cache as the single copy and use `mlx_lm.server` + any chat GUI
   (open-webui is already installed) instead.

Installing the `lms` CLI (from inside LM Studio: *Developer → Install CLI*) also gives
`lms server start` / `lms ls` for scripting.

## Measured on this machine (2026-08-12)

`Qwen3-Coder-30B-A3B-Instruct-MLX-4bit`, measured **under real working load**
(load avg ~20: VS Code, Claude, JumpCloud EndpointSecurity all running) — which is the
number that matters, since the whole point is staying usable in parallel:

| Prompt length | Prefill (tok/s) | Decode (tok/s) | Peak memory |
|---|---|---|---|
| 51 (cold start) | — | 12.0 | 17.3 GB |
| 51 (warm) | — | 22.9 | 17.3 GB |
| 512 | 479 | 18 (13.6–22.2) | 17.8 GB |
| 4 096 | 703 | 24 (11.1–37.5) | 18.4 GB |
| 16 384 | 609 | 12 (10.7–12.4) | 19.5 GB |

Reading this:
- **Prefill ~600–700 tok/s** → a 16 k-token context is ingested in ~27 s. This is the
  M5 Neural Accelerators doing their job.
- **Decode 12–24 tok/s, high variance.** The 3× spread between trials is contention with
  the desktop workload, not measurement noise — no thermal warnings were recorded.
  On an idle machine expect the upper end.
- **Peak memory 17.3–19.5 GB**, growing with context via the KV-cache. Comfortably under
  the 25.6 GB cap even at 16 k context. This is the number to re-check when raising
  context length.
- **Cold vs. warm start costs ~2×** on the first generation while 16 GB pages in from
  disk. Keep the model loaded (`mlx_lm.chat` or `mlx_lm.server`) for interactive use.

## Trade-offs / caveats

- **The ceiling is about responsiveness, not capacity.** A model can fit in RAM and still
  make the laptop unusable once another process (GLiNER, a browser, Docker) needs memory.
  Size the model for the *whole* workload, not for the model alone.
- **Decode speed is bandwidth-bound.** No quantization trick changes that; only fewer
  active parameters do. Hence: prefer MoE.
- **TTFT is compute-bound** and that is where the M5 wins big. Long-prompt / agentic
  workloads benefit far more than short chats.
- **Quality vs. hosted:** a 30B-A3B at 4-bit is genuinely useful for coding but is not a
  frontier model. For hard reasoning, the hosted route still wins.

## Transkription (ASR) — das deutsche Fine-Tune gewinnt zweifach

Gemessen 2026-08-18, 90-s-Ausschnitt aus einer echten deutschen 76-min-Aufnahme,
identische Parameter:

| Modell | Größe | Laufzeit | erfasste Wörter |
|---|---|---|---|
| `mlx-community/whisper-large-v3-mlx` (bisher) | 2,87 GB | 35,6 s | 142 |
| **`mlx-community/whisper-large-v3-turbo-german-f16`** | **1,50 GB** | **3,3 s** | **217** |

Kein Halluzinieren: beide erzeugen dieselben 19 Segmente, keine Wiederholungs-Loops.
Das alte Modell **verschluckt** Inhalt — Segment 14/17/19 liefern 2 Wörter gegen 18/11/14.
Ursache ist der bewusst strenge `WHISPER_COMPRESSION_RATIO = 2.2` der Pipeline, der
unsichere Segmente verwirft; generisches Whisper ist auf Deutsch häufiger unsicher.

Publizierte WER Deutsch (primeline, niedriger = besser): turbo-german **2,628** <
large-v3 3,279 < large-v3-turbo 3,649. Deckt sich mit der Messung — und das deutsche
*Turbo* schlägt das volle large-v3, was sonst nicht der Fall ist.

**Umstellen** in `redact/config.py` (`WHISPER_MODEL`) und
`Threat-Modeling-PoC/pipeline/prepare.sh` (`--model`). Vorher eine vollständige Aufnahme
stichprobenweise gegen das Audio prüfen: ein Modell, das mehr Text produziert, produziert
potenziell auch mehr falschen Text.

**Nicht empfohlen für Deutsch:** `mlx-community/parakeet-tdt-0.6b-v3` (2,34 GB, in Meetily
schon geladen) — 25 Sprachen, sehr schnell, aber publizierte WER Deutsch 7,4 % gegen 2,6 %.
Für gemischtsprachige Aufnahmen mit Auto-Spracherkennung einen zweiten Blick wert.

## Meetily 0.4.0 — Modell austauschen

Ist-Konfiguration (aus `~/Library/Application Support/com.meetily.ai/meeting_minutes.sqlite`):

| Rolle | Wert |
|---|---|
| `transcript_settings` | `localWhisper` / `large-v3-turbo` |
| `settings` | `builtin-ai` / **`qwen3.5:4b`** ← der Engpass |
| zusätzlich geladen | `parakeet` (ungenutzt) |

Die App unterstützt beides von Haus aus — im Binary sind `get_ollama_models`,
`pull_ollama_model`, Default `http://localhost:11434` **und**
`api_save_custom_openai_config` (mit `maxTokens`/`temperature` + Verbindungstest):

- **Ollama** — Provider umstellen, Modell wählen. Am einfachsten, Ollama läuft eh für redact.
- **MLX-Server** — `mlx_lm.server --port 8080`, in Meetily als Custom-OpenAI-Endpunkt
  `http://localhost:8080/v1`. Schneller auf M5.

⚠️ **Nicht das Coder-Modell dafür nehmen.** `Qwen3-Coder-30B-A3B` ist auf Code trainiert,
nicht auf deutsche Protokollführung.

### Eingepflegt: `ollama` / `qwen2.5:14b` (2026-08-18)

Bewusst **nicht** das stärkste Modell — Grund ist eine gemessene Meetily-Eigenheit.
Dasselbe deutsche Protokoll-Prompt über die Ollama-API:

| Modell | Dauer | Output | davon Reasoning |
|---|---|---|---|
| `qwen3.6:27b-q4_K_M` | **291,1 s** | 1 818 Tok | ~1 300 Tok |
| `qwen3.6:27b-q4_K_M` + `think:false` | 65,0 s | 406 Tok | 0 |
| **`qwen2.5:14b`** | **24,7 s** | 315 Tok | 0 |

qwen3.6 ist ein Reasoning-Modell. Meetily **filtert** `<think>`-Tags aus der Ausgabe,
bezahlt die Tokens aber — und es schickt nur `num_ctx`, `temperature`, `top_p`,
`keep_alive` an Ollama, **kein** `think`-Flag. Abschalten geht auch nicht über eine
abgeleitete Ollama-Variante: `PARAMETER think` existiert nicht, `/no_think` im
System-Prompt greift bei qwen3.6 nicht, und Ollama 0.31 nutzt für qwen3 einen eingebauten
Renderer (kein überschreibbares Template — `ollama show --template` ist leer).

Meetily chunkt lange Transkripte. 291 s/Chunk heißt bei einem 75-min-Meeting
hochgerechnet **30–50 min pro Protokoll**; mit `qwen2.5:14b` sind es 2–4 min.
Gegenüber dem vorherigen `builtin-ai` / `qwen3.5:4b` (eigener Sidecar-GGUF, *nicht* in
Ollama) ist das trotzdem ein klarer Sprung.

**Wenn Qualität > Wartezeit:** über `mlx_lm.server` als Custom-OpenAI-Endpunkt gehen
statt über Ollama — dort lässt sich ein stärkeres Instruct-Modell ohne Reasoning-Overhead
bedienen.

**Ändern/zurücksetzen** (App vorher beenden, sonst überschreibt sie beim Schließen):
```bash
DB=~/Library/Application\ Support/com.meetily.ai/meeting_minutes.sqlite
osascript -e 'quit app "meetily"'
sqlite3 "$DB" "UPDATE settings SET provider='ollama', model='qwen2.5:14b', ollamaEndpoint='http://localhost:11434' WHERE id='1'; PRAGMA wal_checkpoint(TRUNCATE);"
open -a meetily
```
Backup vor der Änderung liegt als `meeting_minutes.sqlite.bak-20260818-145030` daneben.

## Background reading

- [Apple ML Research — Exploring LLMs with MLX and the M5 Neural Accelerators](https://machinelearning.apple.com/research/exploring-llms-mlx-m5)
- [WWDC26 — Run local agentic AI on the Mac using MLX](https://developer.apple.com/videos/play/wwdc2026/232/)
- [llama.cpp PR #25294 — stream MoE routed experts from disk](https://github.com/ggml-org/llama.cpp/pull/25294) (the practical descendant of `kimi-k3-in-c`; still open)
- [karpathy/llama2.c](https://github.com/karpathy/llama2.c) — minimal C inference, for understanding the machinery
