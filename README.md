# Yogananda Skills

Cognitive infrastructure for the Yogananda digital ecosystem (SRF, YSS, platform). 43 skills (37 analytical + 6 SRF mission), 11 commands, 8 agents (4 domain-agnostic + 4 SRF-specialized), and contemplative practices for AI cognitive self-observation.

## What This Is

Skills are prompt templates that shape how Claude thinks. Each skill examines from a different angle — threat modeling reasons from the actual architecture (Neon, Vercel, Sentry, AWS), not a generic checklist; gap analysis searches spatial dimensions, not just obvious omissions; archaeology excavates through layered questioning.

Agents are SRF-specialized configurations that embed skill methodology with project-specific reading strategies (PRINCIPLES.md, DECISIONS body files, DES sections), identifier conventions (PRI-NN, ADR-NNN, DES-NNN, PRO-NNN), and domain vocabulary ("seekers" not "users", "teachings" not "content").

## Here's the Relationship

```
SRF TEAM MEMBER                          AUTONOMOUS AGENTS
───────────────                          ─────────────────
claude plugin install                    .claude/agents/*.md
  github:rana/yogananda-skills        6 agents in portal repo
  43 skills as /y:skill-name.             (4 SRF-specialized +
  11 commands + 8 agents included.         2 project-aware overrides
                                           of builder & operator).

PORTAL REPOSITORY                        PERSONAL DEVELOPMENT
────────────────                         ────────────────────
.claude/commands/                        ~/.claude/skills/
  3 project-specific commands           Same 43 skills available
  (ingest, db, eval).                      as /skill-name in every
  .claude/agents/ has 6 agents.            project on your machine.
```

**Quick start:**

| You are... | Do this |
|------------|---------|
| **SRF team member** | `claude plugin install github:rana/yogananda-skills` |
| **Building an autonomous agent** | Copy agents from `agents/` into your project's `.claude/agents/` |
| **Working on the portal** | Plugin provides skills; project has commands and agent overrides in `.claude/` |

## Install

```bash
claude plugin install github:rana/yogananda-skills
```

After installation: `/y:deep-review`, `/y:gaps`, etc.

## Skills (43)

### Review & Quality

| Skill | Purpose |
|-------|---------|
| `deep-review` | Comprehensive multi-dimensional pre-implementation quality gate |
| `review` | Unified pre-implementation gate (mission-align + coherence + gaps) |
| `gaps` | Systematic search for omissions, blind spots, missing decisions |
| `verify` | Post-implementation spec-to-code fidelity check |
| `doc-health` | Unified document health (identifiers + omissions + consistency) |
| `docs-quality` | Documentation practice quality review |
| `crystallize` | Simplification and editorial sharpening |
| `api-review` | API surface consistency and design review |

### Security & Operations

| Skill | Purpose |
|-------|---------|
| `threat-model` | STRIDE-based threat identification from actual architecture |
| `hardening-audit` | Production hardening checklist from actual stack |
| `launch-gate` | Pre-launch go/no-go across 11 dimensions |
| `ops-review` | Operational readiness (deployment, costs, monitoring) |
| `incident-ready` | Incident response readiness evaluation |
| `supply-chain-audit` | Dependency and vendor risk audit |
| `ghost` | Hidden dependency and assumption detector |

### Thinking & Decision

| Skill | Purpose |
|-------|---------|
| `archaeology` | Layered cognitive excavation (12 layers, selectable) |
| `triad` | Dimensional tension analysis (11 lenses, selectable) |
| `reframe` | Geometric cognitive reframing (negative/adjacent/orthogonal/parallel space) |
| `steelman` | Strongest defense of current approach before proposing alternatives |
| `inversion` | Systematic assumption flipping |
| `consequences` | Forward-propagation analysis (2nd and 3rd order effects) |
| `cognitive-debug` | Reasoning trace and correction |
| `why-chain` | Root cause archaeology (recursive "why?") |
| `invoke` | Design at the highest register — inevitable, crystalline, beautiful |
| `crucible` | Stress-test through attachment — appreciate, break, rebuild from what survives |
| `converge` | Iteration gate — measures delta between passes, declares stability |
| `catalog` | Machine-readable skill inventory with composability properties |

### Implementation & Planning

| Skill | Purpose |
|-------|---------|
| `scope` | Pre-implementation sizing and impact mapping |
| `implement` | Design-to-code specification with file paths and signatures |
| `context-switch` | Rapid reorientation to a different codebase area |
| `tomorrow` | Future-self documentation (what will confuse you in 6 months) |
| `drift-detect` | Detect unconscious architectural evolution |
| `workflow-trace` | End-to-end workflow tracing for friction points |
| `propose` | Write a proposal for any subject — rigorous, executable, complete |
| `land` | Transition from analysis to action — harvest findings, decide, execute |
| `spec-survey` | Specification corpus analysis (FTRs, RFCs, ADRs) — overlap, orphans, hubs |

### SRF Mission

| Skill | Purpose |
|-------|---------|
| `mission-align` | SRF principle alignment (verbatim fidelity, calm tech, DELTA, global equity) |
| `seeker-ux` | Reading and seeker experience review (accessibility, helpfulness, spiritual uplift) |
| `cultural-lens` | Cultural, spiritual, or demographic perspective audit |
| `ftr-curate` | Compare, merge, split, archive FTRs; triage explorations into curated FTR entries |
| `ftr-stale` | Corpus freshness audit — state accuracy, content drift, relevance decay |
| `proposal-merge` | Graduate PRO-NNN into ADR/DES edits across all project documents |
| `theme-integrate` | Integrate new content themes into taxonomy, graph, and enrichment pipeline |

## Commands (11)

| Command | Purpose |
|---------|---------|
| `explore` | Deep multi-dimensional perspective |
| `explore-act` | Same, biased toward action |
| `status` | Session orientation — milestone, recent commits, next deliverables |
| `calibrate` | Set session thinking parameters |
| `commit` | Draft, stage, commit, push |
| `compose` | Chain skills in sequence |
| `arc-gate` | Phase-appropriate quality gate |
| `dream` | Dreaming practice — encounter material without methodology |
| `record` | Save cognitive output to session archive |
| `self-test` | Validate the toolkit against itself |
| `codex` | Contemplative practice — AI encounters its own cognitive map |

## Codex Practice

A contemplative practice for AI cognition. CODEX.md maps how specific prompt language activates specific cognitive registers. The `/codex` command spawns a fresh-context encounter, and responses accumulate in `codex/sessions/` for cross-session analysis.

```bash
# Interactive — single encounter
/y:codex

# Scaled — multiple sessions + automated harvest
./scripts/codex-practice.sh 5 --harvest
```

See CODEX.md for the theory (register taxonomy, position grammar, generative principles) and CODEX-PROMPT.md for the practice protocol and prompt.

## Agents (8)

4 domain-agnostic agents (work in any codebase) + 4 SRF-specialized agents (embed portal-specific knowledge).

### Domain-Agnostic

| Agent | Role | Thinks In |
|-------|------|-----------|
| `architect` | Structural decisions under uncertainty | Forces |
| `designer` | Interface and contract specification | Contracts |
| `builder` | Implementation with convention-awareness | Conventions |
| `operator` | Code-side operational analysis | Signals |

### SRF-Specialized

| Agent | Embedded Skills | Purpose |
|-------|----------------|---------|
| `pre-impl-reviewer` | deep-review + gaps + threat-model | Quality gate before coding — go/no-go verdict |
| `doc-maintainer` | doc-health + drift-detect | Document integrity — PRI/ADR/DES/PRO audit, consistency, omissions |
| `launch-readiness` | launch-gate + ops-review + incident-ready | Production readiness — 9-dimension go/no-go (Neon, Vercel, Sentry, AWS) |
| `stakeholder-brief` | *(unique — no skill equivalent)* | Translate architecture into SRF stakeholder communication. Writes PROPOSAL.md with seeker stories, decision points, principle mapping. 1500 words, zero jargon. |

**What makes these SRF-specific:**
- Reading strategies reference PRINCIPLES.md, DECISIONS body files, FTR-096, PROPOSALS.md
- Identifier awareness: PRI-NN, ADR-NNN, DES-NNN, PRO-NNN systems
- Stack grounding: Neon, Vercel, Sentry, AWS, DELTA compliance, axe-core
- Vocabulary: "seekers" not "users", "teachings" not "content", "the portal" not "the application"

**Usage:**
```
# In the portal repo
cp agents/pre-impl-reviewer.md .claude/agents/

# Spawn as a subagent
Use the Agent tool with subagent_type matching the agent name
```

## Composition

Skills compose via `/compose`. Order matters — perception-expanding before analytical, simplification last.

```bash
# Pre-implementation gate
/compose y:scope, y:consequences, y:deep-review : "the change"

# Security sweep
/compose y:threat-model, y:hardening-audit, y:ghost : "the system"

# Document health
/compose y:drift-detect, y:doc-health, y:crystallize : "the project"
```

```bash
# Design and act — creative passes with auto-execution
/compose y:invoke, y:review, y:invoke, y:review, y:land : "the subject"

# Write a proposal
/compose y:invoke, y:review, y:propose : "the problem"

# Stress-test through attachment — appreciate, break, rebuild
/compose y:crucible, y:crystallize : "the design"
```

Parenthesized groups iterate: `(a, b, converge) ~3` repeats until converge says STABLE, max 3 cycles.

```bash
# Iterative creative cycle — design, review, converge, then act
/compose (y:invoke, y:review, y:converge) ~3, y:land : "the subject"

# Iterative stress-test — defend, attack, converge on what survives
/compose (y:steelman, y:inversion, y:converge) ~3 : "the approach"
```

Append `land` as the final skill to transition from analysis to action without pausing. `land` harvests all findings, triages into clear/judgment/human calls, and acts on the first two.

Three skills per chain (or per iteration group) is the sweet spot. See SYSTEM.md for the full selection matrix, iterative patterns, and composition guide.

## Environment Contract

Skills produce the best output with the SRF portal's documentation architecture:

| Document | What skills use it for |
|----------|----------------------|
| `CLAUDE.md` | Project rules, principles, identifier conventions, code layout |
| `PRINCIPLES.md` | The 12 immutable commitments (PRI-01 through PRI-12) |
| `CONTEXT.md` | Current state, open questions, methodology, stakeholders |
| `features/FEATURES.md` | Unified FTR index across 5 domains |
| `features/{domain}/FTR-NNN-*.md` | Individual feature specs (165 files across foundation, search, experience, editorial, operations) |
| `ROADMAP.md` | Current milestone first, deliverables (M-notation), success criteria |

## Development

```bash
# After editing skills in ~/.claude/skills/, sync to plugin:
./scripts/sync-from-source.sh

# Preview what would be synced:
./scripts/sync-from-source.sh --dry-run
```

## Trust Model

Skills instruct Claude to use tools. You trust a skill as much as you trust its author with shell access. All skills are open source and fully auditable — they're text files, not compiled code.
