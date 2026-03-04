# SRF Cognitive Toolkit

Cognitive infrastructure for the SRF Online Teachings Portal — 38 skills (32 analytical + 6 SRF mission), 9 commands, and 4 SRF-specialized agents. Shared across the SRF team and autonomous agents working on the portal.

32 analytical skills are domain-agnostic (they analyze whatever project they're pointed at). 6 SRF mission skills are portal-specific (proposal management, mission alignment, seeker experience). Agents are SRF-specialized configurations that embed skill methodology with project-specific reading strategies, identifier conventions, and domain vocabulary.

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
- Skills are read-only — they propose changes but never modify files
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

## Validation

When editing or adding skills, verify:
- Frontmatter has `name`, `description`, `argument-hint`
- Output management section exists with segment size and auto-continue instruction
- No references to skills that don't exist (check `ls skills/`)
- Cross-references between skills are accurate

## Structure

```
srf/
├── .claude-plugin/plugin.json   # Plugin manifest
├── CLAUDE.md                    # AI context (this file)
├── SYSTEM.md                    # Human reference (selection matrix, composition guide)
├── README.md                    # Team usage guide
├── agents/                      # 4 SRF-specialized agents
├── skills/                      # 38 skills (32 analytical + 6 SRF mission)
├── commands/                    # 9 workflow commands
└── scripts/
    └── sync-from-source.sh      # Sync from ~/.claude/ (for maintainers)
```

## Self-Maintenance

```bash
/y:doc-health           # identifier audit + consistency
/y:drift-detect         # stated vs actual architecture
/y:ghost                # hidden assumptions
/y:crystallize          # simplification opportunities
```
