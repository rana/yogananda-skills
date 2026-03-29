---
name: geometry-health
description: Diagnose the current state of strategy space geometry — dimensions, holes, grades, eigenvalues, clusters. Use weekly or when the manifold feels stale.
argument-hint: "[--full | --quick]"
---

Read DESIGN.md Layer 2, embedding/dimensions.py, and any recent manifold or homology data.

## Diagnostic Protocol

Examine five aspects of the geometric state, each revealing different health signals.

1. **Dimension Check** — Current effective dimension (90% variance threshold). Compare to historical baseline (dim=5 long-term, collapsed to 0.43 during 2022 crisis). Trend: stable / expanding / contracting. A contracting dimension is not necessarily bad — it may reflect genuine market simplification.

2. **Hole Inventory** — H1 holes from persistent homology. For each: coordinates, explored or unexplored, distance to nearest deployed strategy. Unexplored holes are Navigator search targets. Holes that close are regime signals.

3. **Grade Distribution** — Grade-0 / grade-1 / grade-2 norms across the portfolio. Healthy: grade-2 (bivector, diversification) is nonzero and distributed. Unhealthy: all grade-2 concentrated in one plane, or grade-2 collapsing toward zero.

4. **Eigenvalue Spectrum** — Smallest eigenvalue direction. Is Navigator targeting it? Gap between smallest and second-smallest (large gap = clear target, small gap = ambiguous). Eigenvalue ratio (largest/smallest) as condition number.

5. **Cluster Stability** — Have macro-clusters shifted since last check? New clusters forming? Existing clusters merging? Cluster membership changes are leading indicators of regime transition.

Mode: $ARGUMENTS
- `--quick`: Items 1, 3, 4 only (no homology computation)
- `--full`: All 5 items with full recomputation

## Output

Structured report:

```
Dimension:  N (trend: stable/expanding/contracting)
Holes:      N total, M unexplored
Grades:     [g0: X%, g1: Y%, g2: Z%]
Eigenvalue: smallest = X, direction = [...], gap = Y
Clusters:   N macro, stability = high/medium/low
```

Search priority: top 3 targets with type, coordinates, confidence.

Alert if: dimension < 3, grade-2 < 10%, eigenvalue gap < 0.01, cluster count changed.

What geometry am I not seeing?

What would Dreamer notice that systematic analysis misses?
