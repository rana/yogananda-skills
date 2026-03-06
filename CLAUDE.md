# SRF Cognitive Toolkit

Cognitive infrastructure for the SRF Online Teachings Portal — 42 skills (36 analytical + 6 SRF mission), 10 commands, and 8 agents (4 domain-agnostic + 4 SRF-specialized). Shared across the SRF team and autonomous agents working on the portal.

35 analytical skills are domain-agnostic (they analyze whatever project they're pointed at). 6 SRF mission skills are portal-specific (proposal management, mission alignment, seeker experience). 1 skill (ftr-curate) bridges both — domain-agnostic methodology with FTR-specific structural awareness. 4 domain-agnostic agents (architect, designer, builder, operator) work in any codebase. 4 SRF-specialized agents embed skill methodology with project-specific reading strategies, identifier conventions, and domain vocabulary.

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

## Output Management
**Hard constraints:**
- Segment output into groups of up to N findings
- Write each segment incrementally
- After each segment, continue immediately to the next
- Continue until ALL findings are reported

[Closing questions]
```

**Conventions that matter:**
- "Read all project markdown documents" grounds in the SRF portal's docs: CLAUDE.md, PRINCIPLES.md, CONTEXT.md, DESIGN.md, DECISIONS.md, ROADMAP.md, PROPOSALS.md
- Output management segments prevent token-limit timeouts; auto-continuation ensures completeness
- Skills are read-only — they propose changes but never modify files. Exceptions: `land` (transitions analysis into action) and `ftr-curate` (FTR corpus operations with preview-by-default)
- Closing questions ("What am I not asking?") seed meta-cognition — functional, not decorative
- "You have complete design autonomy" in cognitive skills unlocks creative capacity — it's a precision instrument
- Skill prompts are precision instruments — specific wording produces measurably different cognitive behavior. Do not paraphrase when editing

## Environment Contract

Skills expect the SRF portal's documentation architecture:

| Document | What skills use it for |
|----------|----------------------|
| `CLAUDE.md` | Project rules, principles, identifier conventions, code layout |
| `PRINCIPLES.md` | The 11 immutable commitments (PRI-01 through PRI-11) |
| `CONTEXT.md` | Current state, open questions, methodology, stakeholders |
| `DESIGN.md` | Architecture index + cross-cutting sections; individual specs in `design/` |
| `DECISIONS.md` | ADR index; bodies in DECISIONS-core.md, -experience.md, -operations.md |
| `ROADMAP.md` | 3 arcs, milestones, deliverables (M-notation), success criteria |
| `PROPOSALS.md` | PRO-NNN registry, graduation protocol, scheduling lifecycle |

## Finding Shape Convention

Analytical skills that produce finding lists should use a consistent shape for compose threading:

```
- **[SKILL-N]** [severity] [dimension] — [location]: [finding]. Fix: [action].
```

Example: `- **[gaps-3]** important dependency — DESIGN.md:API Layer: No retry policy for external calls. Fix: Add ADR for retry/backoff strategy.`

Fields: `id` (skill name + number), `severity` (critical/important/minor), `dimension` (skill-specific tag), `location` (file:section), `finding` (what's wrong), `fix` (specific action).

Skills that produce this shape: gaps, ghost, review, deep-review, doc-health, threat-model, hardening-audit, scope, consequences, verify, ftr-stale. Cognitive/creative skills (archaeology, invoke, triad, reframe) produce narrative — they don't use this shape.

## Skill Taxonomy

Two tiers, different investment profiles:

- **Cognitive-shaping skills** (archaeology, invoke, triad, reframe, crystallize, cognitive-debug, converge) — change *how* thinking happens. Their prompts produce behavior the base model doesn't reach alone. These are the toolkit's distinctive value. Prompt craft here has the highest leverage — specific wording produces measurably different cognitive patterns. Invest in refining these.
- **Analytical skills** (gaps, ghost, threat-model, scope, deep-review, etc.) — change *what* gets analyzed. Competent and useful, but the base model can approximate most of them without skill prompts. Their value is in consistency and composability, not in unlocking new cognitive modes. Keep functional; don't over-invest in prompt refinement.

**Implication for editing:** When modifying a cognitive skill, every word matters — test changes against actual output. When modifying an analytical skill, structure and completeness matter more than specific phrasing.

## Validation

When editing or adding skills, verify:
- Frontmatter has `name`, `description`, `argument-hint`
- Output management section exists with segment size and auto-continue instruction
- No references to skills that don't exist (check `ls skills/`)
- Cross-references between skills are accurate
- **SYSTEM.md must be updated** when skills are added/removed/renamed or commands change behavior. SYSTEM.md is the human-facing reference — its selection matrix, composition examples, stage map, and skill counts must stay in sync.

## Structure

```
srf/
├── .claude-plugin/plugin.json   # Plugin manifest
├── CLAUDE.md                    # AI context (this file)
├── SYSTEM.md                    # Human reference (selection matrix, composition guide)
├── README.md                    # Team usage guide
├── agents/                      # 8 agents (4 domain-agnostic + 4 SRF-specialized)
├── skills/                      # 42 skills (36 analytical + 6 SRF mission)
├── commands/                    # 10 workflow commands
└── scripts/
    └── sync-from-source.sh      # Sync from ~/.claude/ (for maintainers)
```

## Self-Maintenance

```bash
/y:doc-health           # identifier audit + consistency
/y:drift-detect         # stated vs actual architecture
/y:ghost                # hidden assumptions
/y:crystallize          # simplification opportunities
/y:self-test            # structural integrity, cross-references, composition coherence
```

**Preference probe:** Periodically ask Claude "which skills would you prefer to run on this project?" and "how would you compose them?" AI preference is a signal (not proof) of prompt quality — skills that produce enthusiasm are skills whose prompts activate distinct cognitive patterns. Composition preferences reveal natural affinities from the executor's perspective. Compare against documented topology in SYSTEM.md; divergence indicates either topology drift or prompt evolution.
