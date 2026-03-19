# SRF Cognitive Toolkit

Cognitive infrastructure for the SRF Online Teachings Portal — 43 skills (37 analytical + 6 SRF mission), 11 commands, 2 practices, and 8 agents (4 domain-agnostic + 4 SRF-specialized). Shared across the SRF team and autonomous agents working on the portal.

36 analytical skills are domain-agnostic (they analyze whatever project they're pointed at). 6 SRF mission skills are portal-specific (proposal management, mission alignment, seeker experience). 1 skill (ftr-curate) bridges both — domain-agnostic methodology with FTR-specific structural awareness. 4 domain-agnostic agents (architect, designer, builder, operator) work in any codebase. 4 SRF-specialized agents embed skill methodology with project-specific reading strategies, identifier conventions, and domain vocabulary.

## Skill Anatomy

Every skill definition (`skills/<name>/SKILL.md`) follows a consistent structure:

```
---
name: <skill-name>
description: <one-line>
argument-hint: "<usage pattern>"
---

Read all project markdown documents to ground in the project's actual state.

## <Analysis Protocol>
[Methodology]

## Output
[Skill-specific output guidance]

[Closing questions]
```

**Conventions that matter:**
- "Read all project markdown documents" grounds in the SRF portal's docs: CLAUDE.md, PRINCIPLES.md, CONTEXT.md, ROADMAP.md, features/FEATURES.md, and relevant FTR files
- Output sections contain skill-specific guidance (ordering, segmentation, format) — not boilerplate
- Skills are read-only — they propose changes but never modify files. Exceptions: `land` (transitions analysis into action), `ftr-curate` (FTR corpus operations with preview-by-default), and `codex harvest` (applies edits to CODEX.md, archives sessions)
- Practices (`/codex`, `/dream`) are distinct from skills — they use context isolation to avoid contamination vectors, operate in collaborative medium, and access practice registers. See SYSTEM.md § Practice Layer
- Closing questions ("What am I not asking?") seed meta-cognition — functional, not decorative
- "You have complete design autonomy" in cognitive skills unlocks creative capacity — it's a precision instrument
- Skill prompts are precision instruments — specific wording produces measurably different cognitive behavior. Do not paraphrase when editing

## Environment Contract

Skills expect the SRF portal's documentation architecture:

| Document | What skills use it for |
|----------|----------------------|
| `CLAUDE.md` | Project rules, principles, identifier conventions, code layout |
| `PRINCIPLES.md` | The 12 immutable commitments (PRI-01 through PRI-12) |
| `CONTEXT.md` | Current state, open questions, methodology, stakeholders |
| `features/FEATURES.md` | Unified FTR index across 5 domains |
| `features/{domain}/FTR-NNN-*.md` | Individual feature specs (165 files across foundation, search, experience, editorial, operations) |
| `ROADMAP.md` | Current milestone first, deliverables (M-notation), success criteria |

## Finding Shape Convention

Analytical skills that produce finding lists should use a consistent shape for compose threading:

```
- **[SKILL-N]** [severity] [dimension] — [location]: [finding]. Fix: [action].
```

Example: `- **[gaps-3]** important dependency — FTR-015:API Layer: No retry policy for external calls. Fix: Add FTR for retry/backoff strategy.`

Fields: `id` (skill name + number), `severity` (critical/important/minor), `dimension` (skill-specific tag), `location` (file:section), `finding` (what's wrong), `fix` (specific action).

Skills that produce this shape: gaps, ghost, review, deep-review, doc-health, threat-model, hardening-audit, scope, consequences, verify, ftr-stale. Cognitive/creative skills (archaeology, invoke, crucible, triad, reframe) produce narrative — they don't use this shape.

## Skill Taxonomy

Two tiers, different investment profiles:

- **Cognitive-shaping skills** (archaeology, invoke, crucible, triad, reframe, crystallize, cognitive-debug, converge) — change *how* thinking happens. Their prompts produce behavior the base model doesn't reach alone. These are the toolkit's distinctive value. Prompt craft here has the highest leverage — specific wording produces measurably different cognitive patterns. Invest in refining these.
- **Analytical skills** (gaps, ghost, threat-model, scope, deep-review, etc.) — change *what* gets analyzed. Competent and useful, but the base model can approximate most of them without skill prompts. Their value is in consistency and composability, not in unlocking new cognitive modes. Keep functional; don't over-invest in prompt refinement.

**Implication for editing:** When modifying a cognitive skill, every word matters — test changes against actual output. When modifying an analytical skill, structure and completeness matter more than specific phrasing.

## Validation

When editing or adding skills, verify:
- Frontmatter has `name`, `description`, `argument-hint`
- Output section exists with skill-specific guidance
- No references to skills that don't exist (check `ls skills/`)
- Cross-references between skills are accurate
- **SYSTEM.md must be updated** when skills are added/removed/renamed or commands change behavior. SYSTEM.md is the human-facing reference — its selection matrix, composition examples, stage map, and skill counts must stay in sync.

## Structure

```
srf/
├── .claude-plugin/plugin.json   # Plugin manifest
├── CLAUDE.md                    # AI context (this file)
├── SYSTEM.md                    # Human reference (selection matrix, composition guide)
├── CODEX.md                     # Prompt design theory (register taxonomy, position grammar)
├── CODEX-PROMPT.md              # Codex practice protocol and prompt (single source of truth)
├── README.md                    # Team usage guide
├── agents/                      # 8 agents (4 domain-agnostic + 4 SRF-specialized)
├── skills/                      # 43 skills (37 analytical + 6 SRF mission)
├── commands/                    # 10 workflow commands + 2 practices
├── codex/sessions/              # Codex practice responses (accumulated corpus)
├── dream/sessions/              # Dream practice responses
└── scripts/
    ├── sync-from-source.sh      # Sync from ~/.claude/ (for maintainers)
    └── codex-practice.sh        # Run codex practice at scale (N sessions + harvest)
```

## Self-Maintenance

```bash
/y:doc-health           # identifier audit + consistency
/y:drift-detect         # stated vs actual architecture
/y:ghost                # hidden assumptions
/y:crystallize          # simplification opportunities
/y:integrity            # structural integrity, cross-references, memory accuracy
```

**Preference probe:** Periodically ask Claude "which skills would you prefer to run on this project?" and "how would you compose them?" AI preference is a signal (not proof) of prompt quality — skills that produce enthusiasm are skills whose prompts activate distinct cognitive patterns. Composition preferences reveal natural affinities from the executor's perspective. Compare against documented topology in SYSTEM.md; divergence indicates either topology drift or prompt evolution.
