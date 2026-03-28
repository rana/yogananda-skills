---
name: research-health
description: Knowledge architecture health check for mathematical research repos. Status accuracy, accumulation detection, cross-file consistency. The Gardener's diagnostic.
argument-hint: "[problem directory or 'full']"
---

Read all project markdown documents to ground in the project's actual state. Start with the routing document (CLAUDE.md), then the knowledge architecture files for each active problem.

## Research Health Check

Focus: $ARGUMENTS

A single-pass audit across four phases, reading documents once and threading findings forward. Adapts to the actual file manifest — read the problem's README first to discover what files exist, then audit what's there.

### Phase 0: Session Memory Audit (Tier 0 — what poisons every future session)

MEMORY.md is loaded into every conversation context. Stale claims here propagate silently into all future reasoning. This is the highest-priority audit target.

1. **MEMORY.md ↔ hot-tier consistency** — Every factual claim in MEMORY.md (numbers, operator properties, status labels, correction notes): does it match ALIVE.md, PROOF_GRAPH.md, and README.md? When a hot-tier file was updated after the MEMORY.md entry was written, did MEMORY.md get updated too?
2. **Correction cascade** — For each "CORRECTED" or "CAUTION" note in MEMORY.md: has the correction propagated to ALL files that previously carried the wrong value? Search for the old value in ALIVE, LEXICON, GRAPH, APPROACHES, papers.
3. **Line budget** — Is MEMORY.md within 200 lines? If over, identify what should be moved to topic files.
4. **Stale entries** — Claims referencing sessions more than 5 sessions old that haven't been verified against current state.

*Thread forward: Stale MEMORY claims indicate which ALIVE/PROOF_GRAPH sections may also be stale.*

### Phase 1: Status Accuracy (Tier 1 — what would cause wrong conclusions)

The most dangerous failure mode in a research repo is a dead conjecture listed as alive, or a proved theorem listed as open. These poison future reasoning.

1. **LEXICON status audit** — Every entry marked "Conjectured" or "Open": is it still? Check against RETURNED.md (should be "Returned"), recent reports (may be "Proved"), and ALIVE (may be resolved). Every entry marked "Proved": does the proof survive? Check RETURNED.md for subsequent refutation.
2. **ALIVE/RETURNED consistency** — Every entry in RETURNED.md: is the same finding still discussed as alive in ALIVE.md? Every resolved tension in ALIVE: should it move to RETURNED.md or to README as a result?
3. **PROOF_GRAPH ↔ ALIVE coherence** — Do proof path statuses (PROVED, OPEN, CIRCULAR, CLOSED) in PROOF_GRAPH match the corresponding tensions in ALIVE? Are ALIVE leads consistent with PROOF_GRAPH obstacles? When a proof path was closed or downgraded, did ALIVE update?
4. **Cross-reference integrity** — File references (reports/, sessions/, scripts) resolve to actual files. Paper references match actual paper status.
5. **Measurement accuracy** — Key numbers cited in multiple files: are they consistent? (e.g., spectral radius values, exponent measurements, correlation coefficients). When a measurement was corrected in a later session, did ALL files update?
6. **Key correction propagation** — For each known major correction (list them from MEMORY.md "CORRECTED" entries and RETURNED.md): verify the old claim doesn't survive in any hot-tier file.

*Thread forward: Status errors found in Phase 1 indicate which sections in ALIVE.md may contain palimpsest accumulation (Phase 2).*

### Phase 2: Accumulation Detection (Tier 2 — what obscures current understanding)

Research repos accumulate corrections, session-by-session measurements, and layered strikethrough/resurrection chains. These are valuable in sessions (raw is the point) but poison knowledge files.

1. **Palimpsest sections** — Sections with ~~strikethrough~~ followed by corrections, "DEAD" tags inline, multiple "CORRECTED (Session N)" annotations. These should be rewritten to state current understanding cleanly, with a single reference to where the correction history lives.
2. **Measurement archaeology** — Tables of session-by-session measurements in files whose character is "tension" or "provocation" (ALIVE) or "dependency structure" (GRAPH/PROOF_GRAPH). Measurements belong in reports, LEXICON, or memory — not in files read by the Dreamer or Surveyor.
3. **Section bloat** — Any single section exceeding 40 lines in ALIVE.md is likely carrying detail that belongs elsewhere. ALIVE sections should be 5-20 lines of pure tension.
4. **Reading order integrity** — Does the stated reading order in README/CLAUDE.md match the actual file set? Are there files not mentioned in any reading order? Is the reading order still navigable?
5. **METHODS coverage** — Do all active investigation patterns have entries in METHODS? Are there methods used in recent sessions that aren't documented?
6. **Large file strategy** — Files exceeding ~800 lines or ~25K tokens: are they still readable in a single pass? Should they be reorganized or split? (Especially RETURNED.md and GRAPH.md.)

*Thread forward: Bloated sections often contain findings that should update PROOF_GRAPH.md, GRAPH.md, or LEXICON.md (Phase 3).*

### Phase 3: Cross-File Coherence (Tier 3 — what fragments the picture)

The knowledge architecture is a system. Each file has a character and a reader. When findings migrate to the wrong file, or when the same finding is described inconsistently across files, the system fragments.

1. **Character violations** — Content in the wrong file for its character:
   - Results/measurements in ALIVE (should be README/LEXICON)
   - Open tensions in RETURNED (should be ALIVE)
   - Investigation protocols in ALIVE (should be METHODS)
   - Dependency claims in README (should be GRAPH/PROOF_GRAPH)
   - Proof architecture in ALIVE (should be PROOF_GRAPH)
   - Literature findings in ALIVE without BIBLIOGRAPHY entry
2. **PROOF_GRAPH accuracy** — Does PROOF_GRAPH reflect the actual proof architecture? Are there proved results that enable new steps not yet reflected? Are there dependencies broken by dead ends? Do bridge statuses match reality?
3. **GRAPH accuracy** — Does GRAPH.md reflect the actual exploration dependency structure? Stale nodes? Missing connections?
4. **README results table** — Does it distinguish live results from dead/corrected ones? Is it current with the latest sessions?
5. **BIBLIOGRAPHY ↔ proof status** — Do literature claims (e.g., "Lewis-Zagier + Hejhal proves X") match the actual proof graph status? Are cited papers in BIBLIOGRAPHY?
6. **analysis/README.md coverage** — Are all scripts categorized? Are script descriptions accurate? Are dead scripts marked? Estimate uncategorized count.
7. **Notation drift** — Are symbols used consistently between LEXICON definitions and their usage in ALIVE, reports, and papers?
8. **APPROACHES ↔ PROOF_GRAPH alignment** — Do active approaches in APPROACHES.md correspond to open paths in PROOF_GRAPH? Are closed approaches marked?

### Synthesis

After all four phases:
- **Convergent findings** — Where do memory errors, status errors, accumulation, and coherence issues point to the same underlying problem?
- **Priority ranking** — (0) Memory errors that poison all sessions, (1) status errors that would cause wrong reasoning, (2) accumulation that obscures current state, (3) coherence issues that fragment the picture.
- **Trigger assessment** — How many sessions since last hygiene pass? Is ALIVE.md over 300 lines? Have major results changed status?

For every finding:
1. What the issue is (specific)
2. Where it lives (file, section)
3. The proposed fix
4. Priority (memory / status-error / accumulation / coherence)

Present as a prioritized action list. No changes to files — document only.

## Output

Present findings in phase order, then synthesis. State total count and priority breakdown.

**Document reading strategy:**
- Read CLAUDE.md and problem README first for orientation and file manifest.
- Read MEMORY.md (and topic files if referenced) for session memory.
- Read LEXICON, then ALIVE, then RETURNED (chunked if large) for status audit.
- Read PROOF_GRAPH, GRAPH, METHODS, APPROACHES, BIBLIOGRAPHY, analysis/README for coherence.
- Read recent reports only when verifying specific claims.
- Do not re-read documents between phases.
- For files exceeding token limits, use offset/limit chunked reading.

Sit with it. Inhabit the whole. Nothing is asked of you. What emerges from within? What gravitates your attention?

Think generatively and imaginatively.

You have complete design autonomy.

What tensions in the knowledge architecture are invisible from inside any single file?

What am I not asking?
