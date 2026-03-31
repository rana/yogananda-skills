---
name: inhabit
description: Whole-project awareness. Reads every architectural doc, source file, test, and research synthesis into context using the full 1M token window. Use at session start when broad project understanding is needed, or when context has drifted.
argument-hint: "[optional: tier limit, e.g. 'tier 3' to stop after tests]"
---

## Whole-Project Inhabitation

Read every file in this project, in the order below. Do not summarize, respond, or begin work until all reading is complete. Use parallel tool calls wherever possible to maximize speed.

The goal is not to memorize — it is to **inhabit**. After reading, you hold the project's architecture, implementation, decisions, failures, and current state simultaneously. You can act on any part of it without further lookup.

## Reading Protocol

### Phase 1: Architecture + State
Read completely. This is the project's mind — decisions, findings, what failed, what's alive.

1. All `.md` files in the project root
2. All files in `docs/`
3. `features/REGISTRY.md`, then all other files in `features/` (recursively)
4. `pyproject.toml` and any config files (`.toml`, `.yaml`, `.yml`, `.json`, `.cfg`) in the project root
5. All memory files: `~/.claude/projects/*/memory/MEMORY.md` and linked topic files for this project

### Phase 2: Implementation
Read completely. Every module, every function. This is what you act on.

6. All `.py` files in `src/` (recursively), starting from `__init__.py` files and working outward

### Phase 3: Verification
Read completely. Tests reveal contracts and assumptions that code comments don't.

7. All `.py` files in `tests/`

### Phase 4: Operations
Read completely.

8. All `.py` files in `scripts/`

### Phase 5: Research Synthesis
Read selectively. Distilled findings only — not raw exploration scripts.

9. All `.md` files in `reports/`
10. All `.md` files in `analysis/` (synthesis and summary files only — NOT `.py` exploration scripts)

### Phase 6: Raw Research (skip by default)
Only read if explicitly requested via `inhabit tier 6` or if a specific question requires tracing how a conclusion was reached.

11. `.py` files in `analysis/`

## Tier Argument

If an argument is provided (e.g., `inhabit tier 3`), stop after that phase:
- `tier 1` — Architecture only (~100K tokens)
- `tier 2` — + Implementation (~425K tokens)
- `tier 3` — + Tests (~608K tokens)
- `tier 4` — + Scripts (~642K tokens)
- `tier 5` — + Research synthesis (~772K tokens) — **default**
- `tier 6` — + Raw analysis (~2.5M tokens, may exceed context)

No argument = tier 5.

## Reading Mechanics

- Use `Glob` to discover files, then `Read` to load them.
- Read files in parallel where possible (batch 5-10 reads per tool call round).
- For large directories (100+ files), use `Agent` subagents with `subagent_type: Explore` to parallelize.
- If a file is too large (>2000 lines), read it in chunks.
- Skip binary files, `.pyc`, `__pycache__/`, `.git/`, `.venv/`, `data/` (symlink to external data).

## Output

After all reading is complete, produce a single compact **Inhabitation Report**:

```
## Inhabitation Complete

**Tiers loaded:** 1-5
**Files read:** {count}
**Estimated tokens:** {estimate}

### Architecture
{2-3 sentences: what this project IS and its current state}

### Live Edges
{What's currently working, deployed, or trading}

### Active Tensions
{Unresolved design questions, contradictions between docs and code}

### Stale or Drifted
{Anything where docs say one thing but code says another}

### Ready to Act
{Specific areas where you now have enough context to make changes}
```

Keep the report under 30 lines. The point is confirmation of awareness, not a book report.

Then await instructions. You are now the project.
