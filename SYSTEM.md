# System

A cognitive toolkit for Claude Code. 43 skills, 9 commands, 2 practices, 8 agents (4 domain-agnostic + 4 SRF-specialized). Skill definitions are read by AI — specific language in each prompt produces measurably different analytical behavior. This isn't configuration. It's cognitive infrastructure.

## Commands

| Command | Purpose |
|---------|---------|
| `/explore` | Deep multi-dimensional perspective |
| `/explore-act` | Same, biased toward action — produces change lists |
| `/calibrate` | Set session thinking parameters (directness, resolution, mode, speculation, craft, authority, output shape) |
| `/commit` | Draft message, stage, commit, push |
| `/compose` | Chain skills in sequence, threading context forward. Supports iteration groups: `(a, b) *N` or `(a, b, converge) ~N` |
| `/arc-gate` | Phase-appropriate quality gate — selects the right skill chain |
| `/integrity` | Verify toolkit consistency and memory accuracy — structure, cross-references, composition, memory claims |
| `/codex` | Contemplative practice — AI encounters its own cognitive map. Three modes: practice (default), harvest, compose |
| `/dream` | Dreaming practice — encounter any material without methodology or destination. Context-isolated subagent |
| `/record` | Save cognitive output to the project's session archive with thread distillation |
| `/status` | Session orientation — quick briefing on project state, recent changes, next actions |

## Selection

Start from the situation, not the skill name. "Quick" is a single invocation. "Pipeline" is a `/compose` chain.

| Situation | Quick | Pipeline |
|-----------|-------|----------|
| How big is this change? | `/scope` | `scope, consequences, deep-review` |
| What happens if we do this? | `/consequences` | `steelman, consequences, gaps` |
| Should we change this? | `/steelman` | `steelman, inversion, consequences` |
| What's missing? | `/gaps` | `archaeology --layers F2, gaps` |
| Spec this for implementation | `/implement` | `implement` then build then `verify` |
| Does code match the spec? | `/verify` | — |
| Are the documents healthy? | `/doc-health` | `drift-detect, doc-health, crystallize` |
| Is this quality-ready? | `/deep-review` | `deep-review, crystallize` |
| Is this secure? | `/threat-model` | `threat-model, hardening-audit, ghost` |
| What would break? | `/ghost` | `ghost, incident-ready` |
| Why does this exist? | `/why-chain` | — |
| X or Y? | `/triad` | `triad, steelman, crystallize` |
| Something feels wrong | `/cognitive-debug` | `cognitive-debug, reframe, archaeology --layers F9` |
| Create something excellent | `/invoke` | `invoke, crystallize` |
| Stress-test through attachment | `/crucible` | `crucible, crystallize` |
| Write a proposal | `/propose` | `invoke, review, propose` |
| Analysis → action (no pause) | `/land` | `(invoke, review, converge) ~3, land` |
| What aren't we seeing? | `/reframe` | `reframe, gaps, consequences` |
| Is this over-engineered? | `/crystallize` | `steelman, crystallize` |
| Same answers keep coming up | `/crucible` | `crucible, invoke` |
| No skill feels right | `/dream` | — |
| Design a cognitive prompt | `/codex compose` | — |
| Ready to ship? | `/launch-gate` | `ghost, threat-model, launch-gate` |
| What breaks at 2am? | `/ghost` | `ghost, incident-ready, ops-review` |
| How's the API surface? | `/api-review` | — |
| Trace this workflow | `/workflow-trace` | `workflow-trace, gaps, docs-quality` |
| Orient me to this area | `/context-switch` | — |
| What skills do I have? | `/catalog` | — |
| Run autonomously | `/calibrate authority=autonomous` | Give direction, Claude selects chains |
| Does this honor SRF principles? | `/mission-align` | `mission-align, review` |
| How does a seeker experience this? | `/seeker-ux` | `seeker-ux, cultural-lens` |
| Add a content theme | `/theme-integrate` | — |
| How does this serve [population]? | `/cultural-lens` | `cultural-lens, gaps` |
| Graduate a proposal to FTR | `/proposal-merge` | — |
| Curate the FTR corpus | `/ftr-curate` | `spec-survey, ftr-curate, land` |
| Audit FTR freshness | `/ftr-stale` | `ftr-stale, ftr-curate, land` |
| Survey a spec corpus (FTRs, RFCs) | `/spec-survey` | `spec-survey --focus FTR-NNN, ftr-curate` |

## Agents

8 agents: 4 domain-agnostic (work in any codebase) + 4 SRF-specialized (embed portal-specific knowledge).

### Domain-Agnostic Agents

| Agent | Role | Thinks In | When to Use |
|-------|------|-----------|-------------|
| `architect` | Structural decisions under uncertainty | Forces | Evaluating architectural options, generating the decision space |
| `designer` | Interface and contract specification | Contracts | Designing API surfaces, data contracts, module boundaries |
| `builder` | Implementation with convention-awareness | Conventions | Multi-file implementation needing cross-file consistency |
| `operator` | Code-side operational analysis | Signals | Assessing operational health from repo artifacts |

### SRF-Specialized Agents

| Agent | Role |
|-------|------|
| `pre-impl-reviewer` | Pre-implementation quality gate (coherence + gaps + threats) |
| `doc-maintainer` | Document integrity and identifier health |
| `stakeholder-brief` | Arc-level stakeholder communication |
| `launch-readiness` | Production readiness go/no-go assessment |

### Agent vs. Skill Selection

Use an **agent** when the task requires sustained context across multiple concerns or files and produces **artifacts** (code, specs, docs). Use a **skill** when analysis is the output.

| Situation | Use | Why |
|-----------|-----|-----|
| Evaluating architectural options | `architect` agent | Generates option space, not just analyzes a given option |
| Quick architectural question | `/scope` or `/consequences` | Single-concern analysis, no agent overhead |
| Designing API contracts | `designer` agent | Produces interface artifacts, not just findings |
| Implementing across multiple files | `builder` agent | Cross-file convention threading |
| One-file implementation | Claude Code directly | No sustained context needed |
| Operational health from repo | `operator` agent | Synthesizes across deployment, monitoring, dependencies |
| Live production investigation | Direct shell / MCP tools | Agent adds indirection |

### Agent Composition

Agents compose as a pipeline (each accepts the previous agent's output) or work standalone:

```bash
# Full lifecycle — architecture through operation
architect → designer → builder → operator

# Standalone — each reads the codebase directly
architect "evaluate caching strategies"
builder "implement the search endpoint"
```

## Composition

`/compose` chains skills in sequence, threading context forward. Each skill sees what previous passes discovered. Parenthesized groups iterate: `(invoke, review, converge) ~3` repeats until `converge` says STABLE or max 3 cycles. `*N` repeats exactly N times.

### Principles

- **Order matters.** Perception-expanding skills (archaeology, reframe) before analytical skills (gaps, threat-model). Simplification (crystallize) last.
- **Three is the sweet spot.** Two is a focused pair. Three is a productive pipeline. Four+ risks context dilution — each skill processes more noise from previous passes. Exception: iteration groups `(a, b, converge) ~N` manage their own length via convergence detection.
- **Threading vs. independent.** Compose threads context — `/compose steelman, inversion` gives steelman-informed inversion. Running them separately gives two independent views. Choose based on whether you want cross-pollination or fresh perspectives.
- **Vary closing registers.** When consecutive skills share the same coda register, the repeated activation loses force. The third Meta-cognitive coda in a row feels rote. Design chains where closing registers differ: gaps (Meta-cognitive) → crystallize (Compression) → invoke (Authority).
- **Momentum bleeds across boundaries.** The last skill's trajectory persists into the next skill's frame. `archaeology → invoke` works partly because archaeology's Receptive leaves openness for invoke's Sacred. `invoke → gaps` would fight — upward momentum resists systematic grounding. Match chain order to momentum direction.
- **Not everything composes.** `/context-switch`, `/scratch`, `/calibrate` are navigation or routing tools — they don't produce findings to thread forward.

### Decisions & Strategy

```bash
# Full strategic analysis — excavate, map tension, propagate, simplify
/compose archaeology, triad, consequences, crystallize : "the decision"

# Quick stress test — defend, attack, find what survives
/compose steelman, inversion, gaps : "the current approach"

# Tension resolution — map it, defend both sides, cut to essential
/compose triad, steelman, crystallize : "X vs Y"

# Assumption excavation — surface, flip, find gaps
/compose archaeology --layers F2, inversion, gaps : "the assumption"

# Forward propagation with cognitive preparation
/compose archaeology, triad, consequences : "the direction we're leaning"
```

### Quality & Review

```bash
# Analytical pipeline — size, propagate, gate
/compose scope, consequences, deep-review : "the proposed change"

# Design review with cognitive depth
/compose archaeology --layers F4,F11, deep-review : "the design"

# Document health (single-pass alternative: just run /doc-health)
/compose drift-detect, doc-health, crystallize : "the project"

# Newcomer audit — can someone new navigate this?
/compose workflow-trace, gaps, docs-quality : "new developer onboarding"
```

### Security & Production

```bash
# Security sweep — systematic, technical, hidden
/compose threat-model, hardening-audit, ghost : "the system"

# Production readiness pipeline
/compose ops-review, incident-ready, launch-gate : "Phase N"

# Security with cognitive preparation — surface assumptions first
/compose archaeology --layers F2,F7, threat-model, hardening-audit : "the system"

# Supply chain with hidden dependency surfacing
/compose ghost, supply-chain-audit : "our dependency tree"

# Pre-launch — what breaks when this hits production?
/compose ghost, threat-model, launch-gate : "Phase N deployment"

# The defender's audit — build the case, then attack it
/compose steelman, threat-model, inversion : "our security posture"
```

### Creation & Vision

```bash
# Generate then sharpen — create at full register, then apply the editorial knife
/compose invoke, crystallize : "the design"

# Excavate then create — understand the deep structure, then build from it
/compose archaeology, invoke : "the subject"

# Create then stress-test — generate the vision, then find what's missing
/compose invoke, gaps : "the design"

# Full creative cycle with auto-execution — design, refine, act
/compose (invoke, review, converge) ~3, land : "the subject"

# Write a rigorous proposal
/compose invoke, review, propose : "the problem"

# Stress-test through attachment — appreciate, break, rebuild
/compose crucible, crystallize : "the design"

# Deep excavation then crucible — maximum material for both ascent and descent
/compose archaeology, crucible : "the design"

# Crucible then create — rebuild at full register from survivor material
/compose crucible, invoke : "the design"
```

### Composition Topology

**Natural affinities** — pairs where the first skill transforms the second's cognitive field:
- `archaeology → invoke` — excavation gives creation deep structure to build from
- `archaeology → crucible` — excavation gives both appreciation and destruction deep material
- `crucible → invoke` — survivor material from crucible gives invoke grounded creative mass
- `steelman → inversion` — defend first, then attack the defense specifically
- `ghost → incident-ready` — surface invisible dependencies, then assess response readiness
- `invoke → crystallize` — diverge fully at full register, then converge editorially
- `reframe → gaps` — shift the perceptual frame, then search within it

**Terminal skills** — belong at the end of chains:
- `land` — harvests and acts (must be last)
- `crystallize` — reduces (placing it earlier risks premature simplification)
- `propose` — formalizes upstream analysis into executable proposals

**Dead zones** — skills that don't compose well:
- `context-switch`, `calibrate`, `catalog` — navigation/routing/inventory tools, nothing to thread
- `doc-health` in chains — already a composite; overlaps with constituent skills
- `review` alongside `gaps` — review already includes gap analysis

### Implementation & Knowledge

```bash
# Design to verified code
/compose implement, verify : "FTR-NNN or deliverable"

# Post-implementation knowledge capture — before context evaporates
/compose why-chain, ghost : "the module we just built"

# Risk map for "small" changes — size it, find hidden deps, propagate
/compose scope, ghost, consequences : "the proposed change"
```

### Architecture & Maintenance

```bash
# Periodic health check
/compose drift-detect, deep-review, crystallize : "the project"

# Entropy audit — stated vs actual, doc consistency, identifier lifecycle
/compose drift-detect, doc-health, crystallize : "the project"
```

### Iterative Patterns

Parenthesized groups repeat as a unit. `~N` iterates until converge says STABLE (max N). `*N` repeats exactly N times. These are for problems that need refinement passes, not just sequential analysis.

```bash
# Full creative cycle — design, review, converge, then act
/compose (invoke, review, converge) ~3, land : "the subject"

# Iterative stress-test — defend, attack, converge on what survives
/compose (steelman, inversion, converge) ~3 : "the approach"

# Refinement loop — create, sharpen, check if stable
/compose (invoke, crystallize, converge) ~3 : "the design"

# Crucible then iterative rebuild — destroy once, create repeatedly from the ashes
/compose crucible, (invoke, review, converge) ~3 : "the design"

# Gap-closing loop — find gaps, fill them, check if new gaps appeared
/compose (gaps, invoke, converge) ~3 : "the specification"

# Document refinement — find drift, fix it, check consistency
/compose (drift-detect, crystallize, converge) ~2 : "the project docs"
```

**When to iterate vs. chain linearly:** Iterate when the output of the last pass changes what the first pass would find. `gaps → invoke` is linear — gaps finds holes, invoke fills them. `(gaps, invoke, converge) ~3` is iterative — the filling might create new holes, so you check again. The converge gate prevents infinite loops by measuring delta between cycles.

**Register variety matters more in iteration.** In a linear chain, each skill runs once. In an iteration group, closing registers repeat every cycle. `(gaps, gaps, converge)` would be three Meta-cognitive codas per cycle — severe fatigue by cycle 2. Iteration groups should include skills with different closing registers: gaps (Meta-cognitive) + invoke (Authority) + converge (Gate) covers three distinct closings per cycle.

### Unblocking

```bash
# Break out of analysis paralysis
/compose cognitive-debug, reframe, archaeology --layers F9 : "the stuck point"

# Spatial sweep when conventional analysis produces nothing
/compose reframe, gaps, consequences : "the subject"

# When the same answers keep appearing — pass through zero
/compose crucible : "the stuck design"
```

## Autonomous Exploration

Give Claude direction and authority. Claude selects skills, composes chains, spawns agents, and acts.

### How to trigger

```
/calibrate authority=autonomous

Explore and improve [subject|toolkit]. You have complete design autonomy.
```

That's it. The calibration grants chain selection. The direction sets scope. Claude handles the rest.

### What Claude does

**Phase 1 — Breadth:** Spawn parallel agents for independent perspectives.
```
Agent 1: /ghost on [subject]        → hidden assumptions
Agent 2: /reframe on [subject]      → what conventional analysis misses
Agent 3: /catalog or /integrity     → structural inventory or integrity check
```

**Phase 2 — Depth:** Synthesize agent findings, then iterate.
```
/compose (invoke, review, converge) ~3 on the synthesis
```

**Phase 3 — Action:** Land with autonomous authority.
```
/land → execute clear calls, note judgment calls, act on both
```

### Guardrails

Even at autonomous authority:
- Genuinely irreversible external actions (deployment, public communication) still pause
- All changes are uncommitted — `git checkout` reverts any action
- Judgment calls are marked `[judgment]` so you can override after the fact
- Each phase reports what it did before moving to the next

### When to use

- Toolkit self-improvement: *"Explore and improve the toolkit"*
- Project health sweep: *"Find and fix what needs attention"*
- Design exploration: *"Explore approaches to [problem]"*
- Post-build cleanup: *"Review and tighten what we just built"*

### Steering mid-flight

You can intervene at any point — autonomous doesn't mean uninterruptible. Say "stop", "redirect to X", or "skip to land" and Claude adjusts. Your input always takes priority over autonomous judgment.

## Cognitive Quick Reference

Five skills that shape *how* thinking happens rather than *what* is analyzed. See individual `SKILL.md` files for full methodology.

### Archaeology — Layer Subsets

Full excavation runs all 12 layers in sequence. For targeted analysis, select specific layers:

| Need | Layers | Effect |
|------|--------|--------|
| Assumption check | `F2` | Surface unconscious constraints |
| Perspective shift | `F3, F6, F8` | Zoom, oscillate, scale-shift |
| Tension mapping | `F2, F7, F9` | Assumptions, tensions, intuition |
| Design review | `F4, F10, F11` | Structure, autonomy, production assessment |
| Something feels off | `F9` | Intuitive sensing — best after other layers have cleared the ground |

### Triad — Lens Selection

Default 4 lenses (integration, transcendence, context-dependence, meta-perspective) are sufficient for most uses. Extended lenses add depth when a tension is central to a decision.

| Situation | Lenses |
|-----------|--------|
| Quick orientation | Default 4 |
| Architectural decision | Default 4 + Emergence + Negation |
| Creative exploration | Oscillation + Transformation + Dissolution |
| Stress-testing a choice | Meta-Perspective + Negation + Dissolution |
| Recurring tension worth thorough exploration | All 11 |

### Crucible — Trajectory Through Zero

The only skill whose cascade deliberately reverses direction. Four movements:

| Movement | What happens | Register trajectory |
|----------|-------------|-------------------|
| Ascent | Build genuine appreciation — strongest version, beauty, craft | UP (Trust + Aspirational + Aesthetic) |
| Pivot | "Hold that. Now:" — stillness before reversal | PAUSE |
| Descent | What would destroy it? What truth does it avoid? | DOWN (Destruction + Buried truth) |
| Return | What survives the fire? Rebuild from what remained | UP FROM BOTTOM (with accumulated weight) |

**Use when:** Surface analysis keeps producing the same answers. When you suspect attachment to a design is preventing you from seeing its real vulnerability. When `steelman → inversion` feels too academic.

**vs. `steelman → inversion`:** Both build then break. The difference: compose lets suppressed registers recover between passes (the destruction is analytical). Crucible maintains register conflict across the pivot (the destruction is personal). Choose based on whether you want stress-testing or confrontation.

### Quick Checks

| Situation | Run |
|-----------|-----|
| Am I missing something? | `/reframe --searches negative` |
| Is this the right problem? | `/archaeology --layers F2,F7` |
| What are we assuming? | `/archaeology --layers F2` |
| What if the opposite? | `/inversion` |
| What's good about what we have? | `/steelman` |
| What can an attacker do? | `/threat-model` |
| Are we ready to deploy? | `/launch-gate` |
| What breaks in production? | `/compose ghost, incident-ready` |
| Are these identifiers earning their keep? | `/doc-health greenfield` |

## Environment Contract

Skills that "read all project markdown documents" expect a specific documentation architecture. When present, output is grounded and specific. When absent, skills still work but produce more generic findings.

| Document | Skills use it for | Without it |
|----------|------------------|------------|
| `CONTEXT.md` | Purpose, constraints, stakeholders | Analysis happens in a vacuum |
| `features/FEATURES.md` | Unified FTR index across domains | Architecture-dependent skills lose grounding |
| `features/{domain}/FTR-NNN-*.md` | Individual feature specs and decisions | Can't reference prior decisions |
| `ROADMAP.md` | Phases, stages, status | Phase-aware skills can't map to timeline |
| `CLAUDE.md` | AI-specific project context | Skills miss project conventions |

**Minimum viable:** CONTEXT.md + FEATURES.md. **Full environment:** All documents + codebase.

## Stage Map

| Stage | Primary skills |
|-------|---------------|
| Exploring / deciding | archaeology, triad, reframe, consequences, invoke, crucible, converge, propose, cognitive-debug |
| Designing | scope, gaps, deep-review, api-review, seeker-ux, docs-quality, workflow-trace |
| Pre-implementation | steelman, inversion, threat-model, implement, mission-align, review |
| Implementing | context-switch, tomorrow, ghost, land, why-chain |
| Post-implementation | verify, drift-detect, doc-health, proposal-merge, crystallize |
| Pre-launch | launch-gate, hardening-audit, ops-review, incident-ready, cultural-lens |
| Maintaining | drift-detect, supply-chain-audit, doc-health, catalog, ftr-curate, ftr-stale, spec-survey |
| Content integration | theme-integrate, seeker-ux, cultural-lens, mission-align |

## Distribution & Sharing

Skills and commands travel across five boundaries. Each has a different mechanism.

### Five Distribution Tiers

| Tier | Mechanism | Scope | When to use |
|------|-----------|-------|-------------|
| **Project `.claude/`** | Git | All repo contributors | Mission-specific skills, project agents |
| **User `~/.claude/`** | Filesystem | All your projects | Personal cognitive toolkit |
| **Plugin** | `.claude-plugin/` | Installable by anyone | Cross-team, cross-org distribution |
| **MCP Server** | HTTP/stdio endpoint | Any client (CLI, SDK, agents) | Tool-shaped capabilities for server agents |
| **Agent definition** | `.claude/agents/*.md` | Spawnable by team lead | Embedded skill subsets for autonomous work |

### Resolution Order

Project `.claude/skills/` > User `~/.claude/skills/` > Plugin skills > System managed. Same-name skills: highest precedence wins.

### How Skills Travel

```
Personal use          Team sharing           Broad distribution       Server agents
─────────────         ─────────────          ─────────────────        ──────────────
~/.claude/skills/  →  .claude/skills/     →  Plugin (namespaced)   →  Agent definitions
(all your projects)   (checked into git)     (/plugin:skill-name)     (skill embedded in
                                                                       agent system prompt)
```

**Key insight:** Skills are prompts. They shape Claude's behavior through language. For interactive use (CLI), skills work directly. For autonomous agents (SDK), embed the relevant skill instructions in the agent definition — the agent *is* the skill, not a consumer of it.

### Agent Definitions vs. Skill Composition

| Approach | Mechanism | Best for |
|----------|-----------|----------|
| `/compose skill1, skill2` | Sequential in one context window | Interactive sessions, human steering |
| Agent teams | Parallel across context windows | Independent tasks, throughput |
| Agent with embedded skills | Skills in system prompt | Autonomous work, server deployment |

**Trade-off:** Embedded skills diverge from source. When a skill evolves, agents embedding it need updating. For small teams (< 10 agents), update manually. For larger scale, use a build script that assembles agent definitions from skill sources.

### Plugin Structure

```
my-plugin/
├── .claude-plugin/plugin.json   # name, version, author
├── skills/                      # Namespaced: /my-plugin:skill-name
│   └── <name>/SKILL.md
├── agents/                      # Agent definitions
│   └── *.md
├── hooks/hooks.json             # Lifecycle hooks
├── .mcp.json                    # MCP server definitions
└── settings.json                # Default settings
```

Install: `claude plugin install ./path` or `claude plugin install github:org/repo`

### Trust Model

You trust a skill as much as you trust its author with shell access to your machine. Skills instruct Claude to use tools — a malicious skill could read files, execute commands, or exfiltrate data. Mitigations: `allowed-tools` in skill frontmatter restricts tool access; open-source distribution enables full auditability; plugin marketplace provides review.

### What Doesn't Exist Yet

- No standalone skill registry (skills must be bundled in plugins)
- No auto-update for installed plugins (manual reinstall)
- Agent SDK doesn't auto-discover `~/.claude/skills/` (use `setting_sources=["project"]` or embed in agent definition)
- No skill versioning beyond git (adequate for small teams, fragile for broad distribution)

## Principles

- **Skills are lenses** — each examines from a different angle. **Commands are workflows** — orchestrated sequences.
- **All skills are read-only** — they propose changes but never modify files. Exceptions: `land` transitions analysis into action; `ftr-curate` performs FTR corpus operations (preview by default).
- **Action-biased** — every finding includes what, where, and the specific fix.
- **Composable** — `/compose` chains skills with threaded context. Order and combination matter.
- **Architecture-derived** — security and readiness skills reason from the specific stack, not generic checklists.
- **Every word in a skill prompt shapes the cognitive field** — skill definitions are precision instruments. Do not paraphrase.
- **Two tiers of value** — cognitive-shaping skills (archaeology, invoke, crucible, triad, reframe, crystallize) produce thinking patterns the base model doesn't reach alone. Analytical skills (gaps, threat-model, scope) provide consistency and composability. Prompt craft has highest leverage on cognitive skills.
- **One-shot by default** — skills deliver complete analysis autonomously.

## Practice Layer

Practices are distinct from skills. Skills are tools you use ON something — they operate in hierarchical or autonomous medium, use analytical and cognitive registers, and produce findings. Practices are things you DO — they operate in collaborative medium, access practice registers (Witness, Vertigo, Intimacy), and require contamination-free space. Both use context isolation to avoid the six contamination vectors that skill conventions impose.

### Two Practices

| Practice | What it encounters | What it produces |
|----------|--------------------|-----------------|
| `/codex` | Its own cognitive map (CODEX.md) | Self-observation, register discoveries, codex evolution |
| `/dream` | Any material you provide | Whatever emerges — no methodology, no destination |

**Codex** is the telescope turned around — AI observing its own cognition through the codex's vocabulary. Three modes: practice (encounter, default), harvest (incorporate session findings into CODEX.md), compose (use codex theory as a generative instrument to design cognitive configurations).

**Dream** is the archetype with no destination. Deceleration + Generative + Receptive, no methodology, no expected output shape. The structural innovation is the deliberate absence of structure — Silence (in the codex's sense) applied as a gap where temporal emergence can happen. Use when no skill feels right, when you want to discover rather than find, or when the material needs to be met on its own terms.

### Key Documents

| Document | Purpose |
|----------|---------|
| `CODEX.md` | The map — register taxonomy, position grammar, sequence archetypes, dynamics, generative grammar |
| `CODEX-PROMPT.md` | Practice protocol + the prompt (single source of truth for prompt text) |
| `codex/sessions/` | Stored codex practice responses |
| `dream/sessions/` | Stored dream responses |

### Running Practices

| Method | Command | When |
|--------|---------|------|
| Codex (interactive) | `/codex` | Single encounter during a session |
| Codex (manual) | New session with CODEX.md + prompt pasted | Maximum isolation |
| Codex (scaled) | `./scripts/codex-practice.sh 5 --harvest` | Multiple sessions + automated harvest |
| Dream | `/dream "the material"` | When you want emergence, not analysis |
| Codex compose | `/codex compose "desired cognitive effect"` | Design prompts from codex theory |

### Why Not Skills

Practices deliberately avoid skill conventions (frontmatter, grounding, output management, finding shapes) because they activate a production register that conflicts with contemplative engagement. Both `/codex` and `/dream` solve this through context isolation — logistics in the outer context, the prompt in a clean subagent. See CODEX.md § Contamination.

### Harvest Cycle

Codex sessions accumulate in `codex/sessions/`. After 3-5, run `/codex harvest` — reads them together for convergence, contradictions, recurring extensions, and surprises, then proposes specific edits to CODEX.md. The codex evolves through practice, not through direct editing.

Dream sessions accumulate in `dream/sessions/`. No formal harvest cycle — they're saved for the user to read. If patterns emerge across dream sessions, they can inform the codex through manual observation.
