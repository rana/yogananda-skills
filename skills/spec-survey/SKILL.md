---
name: spec-survey
description: Specification corpus analysis. Maps relationships across a directory of spec files, identifies overlap clusters, orphans, hubs, and produces merge/archive/split recommendations. Works on FTRs, RFCs, or any consistently-structured specification corpus.
argument-hint: "[directory path or 'features/'] [--focus FTR-NNN,FTR-MMM,...] — the specification corpus to survey"
---

Read the project's specification corpus using the phased reading protocol below. The target directory is specified in the argument; default to `features/` if none given.

### Focus Mode

If `--focus FTR-NNN,FTR-MMM,...` is provided, run Phase 1 (index) for the full corpus to establish context, then restrict Phase 2 and Phase 3 to:
- The specified FTRs
- Their 1-hop neighborhood (FTRs referenced by or referencing the focus set)

This produces a scoped topology for a specific cluster without losing corpus context. Use after triage (from `/ftr-curate` or previous spec-survey) identifies clusters worth deeper analysis.

## Phased Reading Protocol

This skill handles large corpora (100+ files) through three phases. Do not read all files fully — the phased approach is the methodology.

### Phase 1: Index (headers only)

1. Read the corpus index file if one exists (FEATURES.md, README, or equivalent) — this is the authoritative registry
2. List all spec files in the target directory (including subdirectories)
3. For each spec file: read only the first 20 lines to extract:
   - Title and identifier (e.g., FTR-020, RFC-003)
   - State/status marker
   - Domain or category
   - Cross-references to other specs (scan for identifier patterns like FTR-NNN)
4. Build an internal model: specs indexed by identifier, domain, state, outbound references, inbound references (computed from all outbound references)

### Phase 2: Topology (from the index, no deep reads)

Analyze the relationship graph:

1. **Overlap clusters** — specs in the same domain that reference the same downstream specs or govern the same concern (similar titles, shared references)
2. **Dependency chains** — trace the longest reference chains. Chains of depth 4+ signal tight coupling
3. **Orphans** — specs with zero inbound references. Nothing points to them.
4. **Hubs** — specs with the highest inbound reference count. Everything depends on them.
5. **Size outliers** — specs dramatically larger or smaller than the domain median (use file size as proxy from Phase 1)
6. **State distribution** — counts per state per domain. Healthy corpora have most specs in terminal states (implemented, archived). High proposed/approved ratios suggest stale specs.

### Phase 3: Deep Assessment (selective reads based on Phase 2 signals)

Deep-read only the specs flagged by Phase 2 — typically 10-20 out of the full corpus:

1. **Overlap clusters** — Read overlapping specs fully. Classify each overlap as:
   - **Contradictory** (specs disagree) — critical, must resolve
   - **Redundant** (specs say the same thing) — merge candidate
   - **Complementary** (specs cover different aspects of one concern) — merge candidate or acceptable split
   - **Intentional** (cross-cutting concern) — leave alone, note the relationship
2. **Orphans** — Read orphan specs. Classify as:
   - **Dead** (governs removed/abandoned feature) — archive candidate
   - **Disconnected** (valid spec, just not referenced) — needs cross-reference additions
   - **Standalone** (self-contained, no references needed) — leave alone
3. **Hubs** — Read hub specs. Assess:
   - Is the hub appropriately central (foundational principle, core architecture)?
   - Or is it a "god-spec" accumulating unrelated concerns? — split candidate
4. **Size outliers** — Read outlier specs. Assess:
   - Large: scope-justified or bloated with implementation detail that belongs in code?
   - Small: focused or fragmentary (should be absorbed into a related spec)?
5. **Code cross-reference** (sample-based) — For 5-10 specs with state "Proposed" or "Approved", grep the codebase for implementation evidence (function names, file paths, config constants mentioned in the spec). Flag specs whose state doesn't match code reality.

## Output Format

### Part 1: Corpus Map

```
## Specification Corpus Map: [directory]

**Corpus:** N specs across M domains
**State distribution:** [counts per state]

### Topology

#### Overlap Clusters
[Groups of specs governing the same concern, with overlap classification]

#### Dependency Chains (depth 3+)
[Longest chains with identifier paths]

#### Hubs (5+ inbound references)
[Hub specs with reference counts and centrality assessment]

#### Orphans (0 inbound references)
[Orphan specs with classification]

#### Size Outliers
[Specs >2x or <0.5x domain median, with assessment]
```

### Part 2: Recommendations

Use the standard finding shape:

```
- **[survey-N]** [severity] [action-type] — [location]: [finding]. Fix: [specific action].
```

Action types: `merge`, `archive`, `split`, `update-state`, `add-references`, `review-scope`

Severity: `critical` (contradictions, blocking errors), `important` (merge/archive opportunities that reduce confusion), `minor` (cosmetic, link additions)

Order recommendations by severity, then by action type.

### Part 3: Corpus Health Summary

- Overall health assessment (one paragraph)
- Maintenance cadence recommendation
- What a second pass should focus on (if the corpus is too large for complete deep assessment)

## Output

- Deliver Part 1 (Corpus Map), then Part 2 (Recommendations), then Part 3 (Summary).
- State total count when complete.

What questions would I benefit from asking?

What am I not asking?
