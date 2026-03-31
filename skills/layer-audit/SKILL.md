---
name: layer-audit
description: Check layer dependency invariants in the v3 grammar architecture. Detects layer boundary violations, inverted dependencies, cognitive drift at layer crossings, and incorrect return types. Run before any significant change to generation logic or when implementing a new layer.
argument-hint: "[optional: specific boundary e.g. '1-2' or layer number]"
---

Read docs/GRAMMAR-ARCHITECTURE.md (Layer Dependency Invariants section), DESIGN.md §2.0 (Layer Boundary), and relevant FTRs for the layer(s) in question.

## Boundary Scope

$ARGUMENTS specifies which layer boundary to audit. Default: all six boundaries.

## Audit Protocol

For each layer boundary, verify the six invariants:

### I1: Direction of Dependencies

For each layer N in {1, 2, 3, 4, 5}:
- Does Layer N reference or import from Layer N+1 or higher?
- Acceptable: Layer 3 (Geometric) references Layer 2 (PCFG) weights — same direction.
- Violation: Layer 2 (PCFG) conditions on Layer 4 (Evolutionary) macros — inverted dependency.

In design documents: does any FTR-02X claim to use outputs from a higher-numbered FTR?
In DESIGN.md: does the Navigator phase-gated protocol (§5.2b) correctly gate layer activation in order?

### I2: Dispatch Table Integrity

Does any expression generation path in DESIGN.md §4 (Search Algorithm) skip type-checking?
Does the warm-start generation in §8.1a produce expressions that bypass the dispatch table?
Flag: any "fast path" that constructs Expression objects without type validation.

### I3: RTG Before PCFG

In the AGENT_CYCLE (§5.3): does Critic feedback to PCFG weights happen BEFORE or AFTER RTG normalization?
In the feedback loop (§5.2a): is `is_novel(candidate)` called before `pcfg.update()`?
Violation: updating PCFG weights for a duplicate expression reinforces a pattern that adds no information.

### I4: Geometric as Modifier, Not Replacement

In FTR-022 (Geometric Grammar) and DESIGN.md §4.3:
Is geometric conditioning implemented as `effective_weight = base_weight * modifier` or as `effective_weight = geometric_score`?
If the modifier can produce zero effective weight for ALL productions in a category — the grammar has been replaced, not conditioned. Flag.

### I5: Macros as Grammar Citizens

In FTR-023 (Evolutionary Grammar):
Do evolutionary macros pass through RTG normalization? (They must — a macro instantiation is an Expression like any other.)
Do evolutionary macros receive PCFG weights that compete with other productions? (They must — not exempt from probability distribution.)
Do evolutionary macros pass through type-checking? (They must — macros are syntactic sugar, not a separate execution path.)

### I6: Layer 2 Return Types

Scan Layer 2 function specifications in DESIGN.md §2.2 and §3.3 for return types:
- `geometric_product(a, b)` → must return `GradeProduct` (grade-0 + grade-2)
- `portfolio_geometry([c1..cK])` → must return `PortfolioGeometry`
- Any Layer 2 function returning `float` → must document why grade-2 is irrelevant

**Grade expansion check (from user direction):**
v3 approaches grades with greenfield curiosity. Grade-3+ may yield findings v2 missed.
The audit is NOT "grade-3 is forbidden" — it is "grade-3 in Critic gates or Navigator scoring requires Tourism Immunization test."
Flag grade-3+ only when it appears in:
- Critic gate thresholds
- Navigator scoring functions
- PCFG weight updates
Without a Tourism Immunization test documenting the evidence.

### The Cognitive Shift Check

For the specific boundary specified in $ARGUMENTS:
- Has the implementing AI described their mental model shift when crossing this boundary?
- Does any code or spec at Layer N use concepts that belong to Layer N+1 or N-1?
- Example: Layer 1 using "character vector" terminology (Layer 2 concept) without crossing the boundary explicitly.

## Output

For each invariant: `✓ Holds | ⚠ Potential issue | ✗ Violation`

**Summary table:**
| Invariant | Status | Location | Severity |
|-----------|--------|----------|----------|

Followed by: which cognitive shifts are present in the design documents? Which are absent (suggesting the boundary hasn't been crossed intentionally yet)?

**Bottom line:** Is the layer architecture clean? Any ✗ violations should be fixed before search begins.

What layer boundary has the most cognitive drift risk in the current design? What am I not seeing?
