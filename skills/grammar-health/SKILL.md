---
name: grammar-health
description: Grammar layer system health check for v3. Assesses PCFG weight distribution entropy, pre-embedder accuracy status, evolutionary macro library utilization, RTG coverage, and layer dependency integrity. Use weekly during search or after any grammar layer change.
argument-hint: "[optional: specific layer number 0-5 or 'all']"
---

Read DESIGN.md, docs/GRAMMAR-ARCHITECTURE.md, GRAMMAR-CORPUS.md, and features/grammar/ftr-020 through ftr-026.

## Layer Scope

$ARGUMENTS specifies which layer(s) to assess. Default: all layers.

## Health Check Protocol

For each grammar layer, assess current state against health criteria:

### Layer 0 — Dispatch Table + ADT

1. **Type completeness** — Does the dispatch table in DESIGN.md §1.2a cover all terminals defined in §1.2? Any production in the BNF that has no dispatch table row is a gap.
2. **SA-INV-10 integrity** — Do the example expressions in §1.6 respect the no-lookahead invariant? Flag any expression that references future data in its evaluation semantics.
3. **Seed coverage** — Do FTR-025 and FTR-026 use only productions defined in the dispatch table? Any gap is a grammar coverage failure.

### Layer 1 — RTG

1. **Normalization rule completeness** — Are there expression patterns in the BNF that have no normalization rule in FTR-020? List any missing commutative or idempotent cases.
2. **Deduplication estimate** — Based on the warm-start seeds (§8.1a), how many F01-F11 frontier expressions would be collapsed by normalization? High collapse rate = seeds are too similar.

### Layer 2 — PCFG

If search has run: check data/pcfg/weights.json for:
1. **Entropy per category** — If any category has entropy < 0.5 (< 50% of max), alert: monoculture risk.
2. **Min weight** — If any production has weight < 0.01, it's near elimination. Flag if the eliminated production is a frontier class (Calendar, Seq, SignOuter).

If search has NOT run: assess initial weight distribution in FTR-021. Are the initial weights reasonable (not already biased)?

### Layer 3 — Geometric Grammar

1. **Pre-embedder status** — Has sufficient training data been collected? (Need 500+ expression-character pairs.) What is current accuracy estimate?
2. **Structural heuristics** — Are the STRUCTURAL_HINTS in FTR-022 Option A consistent with the character space definitions in DESIGN.md §3.2?
3. **Affinity map** — If data/geometric/affinity_map.pkl exists: when was it last updated? Is it stale relative to point cloud changes?

### Layer 4 — Evolutionary Grammar

1. **Library size** — How many macros in data/evolutionary/library.json? Is size > 50 with utilization < 30%? (Bloat condition.)
2. **Abstraction quality** — For each macro: does it represent a parameterizable class (good) or specific parameter values (memorization)?
3. **Criteria review** — Are the abstraction criteria in FTR-023 appropriate for current search state, or too conservative/aggressive?

### Layer 5 — CCG

1. **Category assignments** — Are all CCG categories in FTR-024 consistent with the dispatch table in DESIGN.md §1.2a?
2. **Composition rule applicability** — Given the current warm-start expressions (§8.1, §8.1a), how many valid CCG derivations are possible? If zero, CCG cannot contribute yet (point cloud too small or too homogeneous).

### Cross-Layer: Dependency Integrity

Check the six Layer Dependency Invariants (GRAMMAR-ARCHITECTURE.md §Layer Dependency Invariants):

- I1: No layer references a higher-numbered layer
- I2: Dispatch table is not bypassed anywhere
- I3: RTG runs before PCFG weight updates
- I4: Geometric conditioning is multiplicative, not replacement
- I5: Evolutionary macros are subject to RTG and type-checking
- I6: Layer 2 functions returning float are documented with rationale

## Output

For each layer: `✓ Healthy | ⚠ Warning | ✗ Problem`

**Summary table:**
| Layer | Status | Finding | Action |
|-------|--------|---------|--------|

Followed by specific findings with file/line references where applicable.

**Bottom line:** Is the grammar system ready for search? If any Layer 0-2 has ✗ status, search should not begin. Layers 3-5 are Phase 2+ and warnings are acceptable at Phase 0-1.

What am I not checking? What health signal might be present in the documents that this protocol misses?
