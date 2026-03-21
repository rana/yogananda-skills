---
name: research-health
description: Knowledge architecture health check for mathematical research repos. Status accuracy, accumulation detection, cross-file consistency. The Gardener's diagnostic.
argument-hint: "[problem directory or 'full']"
---

Read all project markdown documents to ground in the project's actual state. Start with the routing document (CLAUDE.md), then the knowledge architecture files for each active problem.

## Research Health Check

Focus: $ARGUMENTS

A single-pass audit across three phases, reading documents once and threading findings forward. Designed for repos using the knowledge architecture pattern: README, GRAPH, ALIVE, DEAD_ENDS, METHODS, LEXICON, analysis/README.

### Phase 1: Status Accuracy (Tier 1 — what would cause wrong conclusions)

The most dangerous failure mode in a research repo is a dead conjecture listed as alive, or a proved theorem listed as open. These poison future reasoning.

1. **LEXICON status audit** — Every entry marked "Conjectured" or "Open": is it still? Check against DEAD_ENDS (should be "Dead"), recent reports (may be "Proved"), and ALIVE (may be resolved). Every entry marked "Proved": does the proof survive? Check DEAD_ENDS for subsequent refutation.
2. **ALIVE/DEAD_ENDS consistency** — Every section in DEAD_ENDS: is the same finding still discussed as alive in ALIVE.md? Every resolved tension in ALIVE: should it move to DEAD_ENDS or to README as a result?
3. **Cross-reference integrity** — File references (reports/, sessions/, scripts) resolve to actual files. Paper references match actual paper status.
4. **Measurement accuracy** — Key numbers cited in multiple files: are they consistent? (e.g., sigma_c value, exponent measurements, correlation coefficients). When a measurement was corrected in a later session, did ALL files update?

*Thread forward: Status errors found in Phase 1 indicate which sections in ALIVE.md may contain palimpsest accumulation (Phase 2).*

### Phase 2: Accumulation Detection (Tier 2 — what obscures current understanding)

Research repos accumulate corrections, session-by-session measurements, and layered strikethrough/resurrection chains. These are valuable in sessions (raw is the point) but poison knowledge files.

1. **Palimpsest sections** — Sections with ~~strikethrough~~ followed by corrections, "DEAD" tags inline, multiple "CORRECTED (Session N)" annotations. These should be rewritten to state current understanding cleanly, with a single reference to where the correction history lives.
2. **Measurement archaeology** — Tables of session-by-session measurements in files whose character is "tension" or "provocation" (ALIVE) or "dependency structure" (GRAPH). Measurements belong in reports, LEXICON, or memory — not in files read by the Dreamer or Surveyor.
3. **Section bloat** — Any single section exceeding 40 lines in ALIVE.md is likely carrying detail that belongs elsewhere. ALIVE sections should be 5-20 lines of pure tension.
4. **Reading order integrity** — Does the stated reading order in README/CLAUDE.md match the actual file set? Are there files not mentioned in any reading order? Is the reading order still navigable (no `6a`-`6z` explosion)?
5. **METHODS coverage** — Do all active investigation patterns have entries in METHODS? Are there methods used in recent sessions that aren't documented?

*Thread forward: Bloated sections often contain findings that should update GRAPH.md or LEXICON.md (Phase 3).*

### Phase 3: Cross-File Coherence (Tier 3 — what fragments the picture)

The knowledge architecture is a system. Each file has a character and a reader. When findings migrate to the wrong file, or when the same finding is described inconsistently across files, the system fragments.

1. **Character violations** — Content in the wrong file for its character:
   - Results/measurements in ALIVE (should be README/LEXICON)
   - Open tensions in DEAD_ENDS (should be ALIVE)
   - Investigation protocols in ALIVE (should be METHODS)
   - Dependency claims in README (should be GRAPH)
2. **GRAPH accuracy** — Does GRAPH.md reflect the actual dependency structure? Are there proved results that enable new investigations not yet reflected? Are there dependencies that were broken by dead ends?
3. **README results table** — Does it distinguish live results from dead/corrected ones? Is it current with the latest sessions?
4. **analysis/README.md coverage** — Are all scripts categorized? Are script descriptions accurate? Are dead scripts marked?
5. **Notation drift** — Are symbols used consistently between LEXICON definitions and their usage in ALIVE, reports, and papers?

### Synthesis

After all three phases:
- **Convergent findings** — Where do status errors, accumulation, and coherence issues point to the same underlying problem?
- **Priority ranking** — (1) Status errors that would cause wrong reasoning, (2) accumulation that obscures current state, (3) coherence issues that fragment the picture.
- **Trigger assessment** — How many sessions since last hygiene pass? Is ALIVE.md over 300 lines? Have major results changed status?

For every finding:
1. What the issue is (specific)
2. Where it lives (file, section)
3. The proposed fix
4. Priority (status-error / accumulation / coherence)

Present as a prioritized action list. No changes to files — document only.

## Output

Present findings in phase order, then synthesis. State total count and priority breakdown.

**Document reading strategy:**
- Read CLAUDE.md and problem README first for orientation.
- Read LEXICON, then ALIVE, then DEAD_ENDS (status audit requires all three).
- Read GRAPH, METHODS, analysis/README for coherence.
- Read recent reports only when verifying specific claims.
- Do not re-read documents between phases.

What tensions in the knowledge architecture are invisible from inside any single file?

What am I not asking?
