# Compose: ghost, reframe --searches negative, crystallize : "the toolkit"

Date: 2026-03-08
Chain: ghost → reframe (negative space) → crystallize
Register trajectory: systematic grounding → spatial perception → compression

---

## Pass 1/3: ghost — Hidden Dependencies and Assumptions

### 1. Claude Code Platform Assumptions

- **[ghost-1]** important platform — plugin.json: The toolkit assumes Claude Code's plugin system supports `skills/`, `agents/`, `commands/` directories with frontmatter parsing, `/plugin:skill-name` invocation, and `claude plugin install github:org/repo`. None of this is version-pinned. **What breaks:** A Claude Code update changes plugin structure, frontmatter schema, or invocation syntax. All 43 skills stop working simultaneously. **Fix:** Document the minimum Claude Code version tested against. Add a `claude_code_version` field to plugin.json if the schema supports it.

- **[ghost-2]** important platform — SYSTEM.md:Distribution: The "What Doesn't Exist Yet" section documents four known gaps (no registry, no auto-update, no SDK discovery, no versioning). But these are *known* gaps. The hidden assumption is that Claude Code's plugin API is stable enough that these gaps don't matter yet. If the plugin API changes, the entire distribution model breaks with no migration path.

- **[ghost-3]** critical platform — all skills: Every skill opens with "Read all project markdown documents." This assumes the target project has readable markdown files, that Claude Code's Read tool can access them, and that the context window is large enough to hold them all plus the skill's analysis. **What breaks:** A project with 20+ large markdown documents exhausts the context window before analysis begins. The skill degrades silently — no error, just shallow output. **Fix:** No skill mentions context budget or provides a fallback reading strategy for large projects.

### 2. Cognitive Model Assumptions

- **[ghost-4]** important cognitive — CODEX.md + all cognitive skills: The register taxonomy (23 registers, position grammar, sequence archetypes) is empirically derived from Claude sessions. The assumption: these registers are model-stable. **What breaks:** A model update (Claude 5, different training) shifts register activation patterns. The codex becomes a map of a different territory. Codex practice would eventually catch this, but there's no versioning of which observations came from which model. **Fix:** Tag codex observations with model version. The practice already suggests this ("Do different model versions respond differently?") but the sessions don't enforce it.

- **[ghost-5]** important cognitive — skill prompts: The two-tier taxonomy (cognitive-shaping vs. analytical) assumes that cognitive skills produce behavior "the base model doesn't reach alone." This is an untested claim. No skill has been A/B tested against a plain-English request for the same analysis. **What breaks:** Nothing breaks — but the toolkit's core value proposition rests on an unvalidated assumption. If the base model can approximate archaeology or invoke without the skill prompt, the cognitive tier's distinctiveness is aspirational, not demonstrated.

### 3. Operational Assumptions

- **[ghost-6]** important operational — scripts/codex-practice.sh: Uses `claude --print` for headless sessions. Assumes the CLI is installed, in PATH, authenticated, and that `--print` produces clean output parseable for session storage. **What breaks:** Authentication expires, CLI path changes, or `--print` output format changes. The script has no error handling visible from the filename alone.

- **[ghost-7]** minor operational — commands/compose.md: The compose protocol assumes skills produce findings in a shape that subsequent skills can process. But only some skills use the finding shape convention (`[SKILL-N] severity dimension — location: finding. Fix: action`). Cognitive skills produce narrative. **What breaks:** A chain like `crucible → gaps` threads narrative into a skill expecting structured findings. The gap analysis works anyway (Claude adapts), but the threading is lossy — crucible's most important insights are in tone and trajectory, not extractable findings. **Fix:** The compose command could acknowledge this asymmetry: structured skills thread findings; cognitive skills thread *direction*.

- **[ghost-8]** minor operational — agents/*.md: SRF-specialized agents reference specific portal documents (PRINCIPLES.md, DECISIONS body files, FTR-096, PROPOSALS.md). These are hardcoded filenames. **What breaks:** The portal renames or reorganizes these documents. Agents silently fail to find context and produce generic output. No agent has a "can't find expected documents" diagnostic.

### 4. Human Assumptions

- **[ghost-9]** important human — the toolkit broadly: The toolkit assumes a single power user (Rana) who understands the cognitive theory, has internalized the selection matrix, and can compose chains fluently. SYSTEM.md is a reference, not a tutorial. README.md is an install guide, not an onboarding journey. **What breaks:** A second team member installs the plugin and faces 43 skills, 11 commands, 8 agents with no guided entry point. They'd likely use only the obvious analytical skills and never discover the cognitive tier.

- **[ghost-10]** minor human — compose chains: The selection matrix in SYSTEM.md provides ~30 pre-built chains. The assumption is that users will either use these recipes or have enough understanding to compose novel chains. There's no intermediate — no "chain builder" that suggests compositions based on the user's situation.

**Ghost finding count: 10** (1 critical, 5 important, 4 minor)

---

## Pass 2/3: reframe — Negative Space Search

### Negative Space Search — What's conspicuously absent?

**N1. No feedback loop from skill execution to skill design.**

The toolkit has elaborate infrastructure for designing skills (CODEX.md theory, position grammar, register taxonomy) and for running skills (compose, agents, commands). But there's no mechanism that connects execution outcomes back to skill improvement. Codex practice feeds back into CODEX.md — that loop exists. But when `/gaps` misses something, or `/invoke` produces flat output, or a compose chain degrades at skill 3 — that signal evaporates. The practitioner adjusts (runs a different skill, adds context), but the skill prompt never learns.

Ghost found that cognitive skills are untested against base model ([ghost-5]). This is a symptom of the deeper absence: **no observation infrastructure for skill output quality**. The toolkit can generate analysis endlessly but cannot evaluate its own analysis.

**N2. No negative examples.**

Every skill definition says what to do. No skill says what bad output looks like. CODEX.md has a suppression model (what each register suppresses) and a brief failure modes section, but individual skills have no "if your output looks like X, you've gone wrong." The compose protocol has no "this chain failed because..." diagnostics.

The toolkit knows what success looks like. It has no vocabulary for failure — which means failure is invisible.

**N3. No skill for the toolkit's own evolution.**

The toolkit has `self-test` (structural integrity), `doc-health` (document consistency), `drift-detect` (stated vs. actual), and `crystallize` (simplification). These maintain what exists. It has codex practice for cognitive theory evolution. But there's no skill or process for: *Should this skill exist? Should these two skills merge? Is this agent earning its keep? Has the toolkit's complexity outgrown its utility?*

`ftr-curate` and `spec-survey` do this for FTR documents in the portal. The toolkit doesn't point those tools at itself. The self-maintenance section in CLAUDE.md lists four skills to run periodically — all diagnostic. None are existential. The toolkit can detect rot but can't question its own necessity.

**N4. No notion of skill cost.**

Every skill is free to invoke — there's no budget concept. But skills consume context window, user attention, and calendar time. A three-skill compose chain on a large project might take 10+ minutes of Claude processing. The selection matrix helps choose the right skill but doesn't help decide *whether to run a skill at all*.

Ghost found context window pressure ([ghost-3]). That's one dimension of cost. The broader absence: the toolkit optimizes for analytical coverage and never asks "is this analysis worth its cost?"

**N5. No user journey through the toolkit.**

Ghost found the single-power-user assumption ([ghost-9]). The negative space around it is sharper: the toolkit has no concept of progression. Day 1 and day 100 look the same — the full 43-skill surface is always presented. There's no "start here," no "graduate to this," no skill that's marked as advanced vs. foundational. The catalog skill provides a machine-readable inventory, but inventory isn't pedagogy.

SYSTEM.md's selection matrix is organized by *situation*, which is good. But it's organized for someone who already knows what situations exist. A new user doesn't know they should be asking "what am I not seeing?" — they haven't learned to think in toolkit terms yet.

**N6. No practice beyond codex.**

Codex practice exists for cognitive self-observation. But there's no equivalent practice for the analytical tier. No "run threat-model on a known-vulnerable system and compare findings to known vulnerabilities." No "run gaps on a completed design and measure coverage." The cognitive tier has a contemplative practice that evolves its theory. The analytical tier has nothing that evolves its methodology.

This is consistent with the two-tier value proposition: cognitive skills are where the leverage is, so they get the investment. But it means the analytical tier accumulates without pruning — 37 analytical skills, each added because it seemed useful, none ever evaluated against actual use.

**Negative space finding count: 6**

---

## Pass 3/3: crystallize — Editorial Knife

### Structural Simplification

**C1. The documentation architecture is redundant across three files.**

CLAUDE.md, SYSTEM.md, and README.md all describe the toolkit. They serve different audiences (AI, human reference, team onboarding), but the overlap is extensive:
- Skill counts appear in all three (and plugin.json description)
- Skill tables appear in README.md and SYSTEM.md (different groupings, same content)
- Composition examples appear in SYSTEM.md and README.md
- Agent descriptions appear in all three
- The environment contract appears in CLAUDE.md and SYSTEM.md (different formats, same info)

**Proposal:** README.md should be a concise install + quick-start guide that links to SYSTEM.md for the full reference. It currently duplicates ~60% of SYSTEM.md content. Remove the full skill tables, agent details, and composition examples from README.md. Keep: install instructions, one-paragraph "what this is," quick-start examples, link to SYSTEM.md.

**C2. SYSTEM.md is overloaded — reference manual + cognitive guide + distribution docs.**

SYSTEM.md covers: commands, selection matrix, agents, composition theory, autonomous exploration, cognitive quick reference (archaeology layers, triad lenses, dialogue mode, crucible), environment contract, stage map, distribution & sharing (5 tiers, trust model, plugin structure), and principles. That's at least three documents:
- **Selection & composition** (the operational reference people actually consult)
- **Cognitive guide** (archaeology layers, triad lenses, crucible trajectory, dialogue mode)
- **Distribution** (plugin structure, trust model, resolution order, what doesn't exist)

**Proposal:** Note the tension, don't act yet. SYSTEM.md works as a single reference *for one power user*. If the toolkit ever has a second user (ghost-9), splitting becomes necessary. For now, the cost of splitting (maintaining cross-references, risk of drift) exceeds the benefit.

**C3. Four count-synchronization points is three too many.**

The string "43 skills" (or equivalent counts) appears in: plugin.json, CLAUDE.md, SYSTEM.md, README.md. Every skill addition requires four edits. This is the kind of maintenance burden that crystallize exists to cut.

**Proposal:** Declare one canonical count location (CLAUDE.md, since it's the AI-facing source of truth). All other files either derive from it or use a vaguer description ("40+ skills" in README.md). plugin.json description can drop the count entirely.

**C4. The "finding shape convention" is aspirational scaffolding.**

CLAUDE.md documents a finding shape: `[SKILL-N] severity dimension — location: finding. Fix: action`. It lists 11 skills that "should" produce this shape. Ghost found ([ghost-7]) that cognitive skills produce narrative, making this convention partial. Reframe found (N2) that there's no vocabulary for what bad output looks like.

**Proposal:** The finding shape is useful for compose threading when it works. But declaring it as a convention and listing 11 skills creates an expectation of consistency that doesn't hold. Either enforce it (add the shape to each skill's output section) or demote it to a note in compose.md ("analytical skills tend to produce structured findings; cognitive skills produce narrative; compose handles both").

**C5. The codex practice section in SYSTEM.md duplicates CODEX-PROMPT.md.**

SYSTEM.md § Codex Practice describes the practice, harvest cycle, and session storage — all of which is in CODEX-PROMPT.md in more detail. The SYSTEM.md version adds nothing except a summary table.

**Proposal:** Replace the SYSTEM.md codex section with a brief pointer: "See CODEX.md (theory) and CODEX-PROMPT.md (practice protocol). Run with `/codex` or `./scripts/codex-practice.sh`."

### Communication Quality

**C6. CLAUDE.md's "Environment Contract" table has a structural problem.**

The table lists what skills use each document for — but some entries reference SRF-portal-specific documents (PRINCIPLES.md, PROPOSALS.md) that only exist in the portal project, not in this toolkit repo. For a reader encountering CLAUDE.md in the yogananda-skills repo, these references point at nothing. The table conflates "what skills expect when running in the portal" with "what exists in this repo."

**Proposal:** Split into two: "Documents in this repo" (CLAUDE.md, SYSTEM.md, CODEX.md, README.md) and "Documents skills expect in target projects" (the current table). Or add a note: "These documents exist in the SRF portal repo, not here."

**C7. The autonomous exploration section in SYSTEM.md is teaching, not reference.**

The three-phase description (breadth → depth → action) with code examples reads like a tutorial. It's the only section of SYSTEM.md that explains *how Claude should behave* rather than *what the user can do*. It's addressed to Claude (the executor), not to the human (the user).

**Proposal:** Shorten to: trigger command, what it does (one paragraph), guardrails, steering. The detailed phase description is Claude's implementation detail — it belongs in a command definition (calibrate.md or a dedicated autonomous.md), not in the human reference.

### Reinforcements

- **CODEX.md and the practice system.** Genuinely novel — an AI cognitive self-observation practice with accumulated sessions, harvest cycles, and theory evolution. Nothing else in the ecosystem does this.
- **The two-tier skill taxonomy.** The distinction between cognitive-shaping and analytical skills is honest and useful. It prevents over-investment in the wrong things.
- **Compose's register dynamics documentation.** "Vary closing registers" and "momentum bleeds across boundaries" are insights that make composition predictable rather than trial-and-error.
- **Crucible's trajectory.** The only skill that passes through zero. The structural innovation is real.

### Concerns

- **The maintenance surface.** 43 skills x 4 documentation files x cross-reference validation = a system that wants to drift. Self-test catches structural drift but can't catch semantic drift (a skill description that's technically accurate but no longer reflects how the skill is actually used).
- **The SRF-specific agents in a "domain-agnostic" toolkit.** The 4 SRF agents hardcode portal filenames and identifier conventions. They're in a repo called "yogananda-skills" alongside domain-agnostic tools. This creates a category confusion: is this a general cognitive toolkit or an SRF project tool? The answer is "both," but the repo doesn't separate them cleanly.

**Crystallize finding count: 7 proposals + 2 reinforcements + 2 concerns**

---

## Unified Summary

### Cross-cutting findings (deduplicated, priority-ordered)

1. **The toolkit cannot observe its own effectiveness.** (ghost-5 + N1 + N6) No mechanism connects skill execution quality back to skill design. The cognitive tier has codex practice; the analytical tier has nothing. The two-tier value claim is unvalidated. This is the toolkit's deepest ghost dependency — it depends on the assumption that its skills work, with no way to verify.

2. **Single-user architecture creates invisible fragility.** (ghost-9 + N5 + C2) Everything — documentation density, selection matrix, compose fluency — assumes one expert user. No progression, no onboarding, no "start here." If the toolkit succeeds and others adopt it, this becomes the primary bottleneck.

3. **Documentation redundancy is a maintenance tax.** (C1 + C3 + C5) Three files (CLAUDE.md, SYSTEM.md, README.md) plus plugin.json all describe the same toolkit with overlapping content. Count synchronization alone requires four edits per skill change. The fix is straightforward: README becomes a pointer, counts live in one place, SYSTEM.md codex section becomes a link.

4. **Context window pressure is unacknowledged.** (ghost-3 + N4) Skills assume unlimited reading capacity. No skill mentions context budget, provides a fallback reading strategy, or warns about large-project degradation. The compose protocol doesn't account for cumulative context cost across chained skills.

5. **Cognitive/narrative and analytical/structured threading is asymmetric.** (ghost-7 + N2 + C4) The compose system works cleanly for analytical → analytical chains. Cognitive → analytical chains lose signal because narrative doesn't thread into structured finding shapes. The finding shape convention is documented but partial.

6. **SRF-specific content creates category confusion.** (ghost-8 + C6 + C7 concern) SRF agents with hardcoded filenames sit alongside domain-agnostic tools. The environment contract table references portal documents that don't exist in this repo. The toolkit's identity oscillates between "general cognitive infrastructure" and "SRF project tool."

### Conflicts between passes

- **ghost says "make assumptions explicit" (document more) while crystallize says "reduce documentation weight" (document less).** Resolution: make the *right* things explicit (platform version, context budget, model versioning) while removing redundancy in what's already explicit (duplicate skill tables, repeated counts, duplicated codex practice docs).

### Prioritized action list

| Priority | Action | Source |
|----------|--------|--------|
| 1 | Collapse README.md to install + quick-start + links; remove duplicated tables | C1 |
| 2 | Single canonical count in CLAUDE.md; other files use approximate or derived counts | C3 |
| 3 | Replace SYSTEM.md codex section with pointer to CODEX-PROMPT.md | C5 |
| 4 | Add "Documents in this repo vs. documents skills expect in targets" distinction to CLAUDE.md | C6 |
| 5 | Shorten SYSTEM.md autonomous exploration to user-facing reference; move phase detail to command | C7 |
| 6 | Demote finding shape convention to compose.md note rather than CLAUDE.md convention | C4 |
| 7 | Add context budget awareness to skill grounding instruction or compose protocol | ghost-3 |
| 8 | Tag codex sessions with model version | ghost-4 |
| 9 | Document minimum Claude Code version tested against | ghost-1 |

### The question underneath

Whether the toolkit's complexity is *itself* the primary ghost dependency — whether the 43-skill surface creates a cognitive overhead that suppresses the very clarity the skills are designed to produce. Crystallize can trim documentation, but the question underneath is whether fewer, sharper skills would serve better than more, documented skills. That's a crucible question, not a crystallize question.
