---
name: navigator-report
description: Report Navigator's search state — targets, mutations, coverage, stuck detection. Use to understand where exploration is and what it's missing.
argument-hint: "[--since DATE]"
---

Read navigate/search.py, navigate/mutate.py, DESIGN.md (Layer 1), and any navigator logs.

## Report Protocol

Assess Navigator's exploration from four angles.

1. **Target Queue** — Current search targets ordered by priority. For each:
   - Type (void / hole / eigenvalue / landmark)
   - Coordinates in conditional space
   - Confidence score
   - Source (which algorithm identified it)
   - Age (how long has this been a target without resolution?)

2. **Mutation Activity** — Recent expression mutations:
   - Total candidates generated (since $ARGUMENTS or last report)
   - Breakdown by mutation type (kernel_swap / param_shift / projection_composition)
   - Survival rate through Critic validation
   - Any mutations that reached embedding but were rejected — why?

3. **Coverage Map** — Which regions of expression space have been explored?
   - Dimensions well-covered (many strategies, small eigenvalue gap)
   - Dimensions sparse (few strategies, large eigenvalue gap)
   - Expression types attempted vs. not yet tried
   - Kernel utilization (which kernels from KERNEL_TABLE have been used? Which never?)

4. **Stuck Detection** — Is Navigator circling?
   - Mutation diversity (are recent mutations exploring different regions or minor variations of the same?)
   - Target persistence (targets that haven't moved in >N cycles)
   - Similarity clustering of recent candidates (if all cluster in same region, Navigator is stuck)
   - Recommendation: if stuck, suggest specific direction change (new kernel family, different mutation type, Dreamer session)

## Output

```
Targets:    N active (oldest: X days)
Mutations:  N generated, M survived (rate: M/N)
Coverage:   [sparse dimensions], [unused kernels]
Health:     exploring / converging / stuck
```

If stuck: specific recommendation for unsticking (not "explore more" — which kernel, which direction, which hole).

If converging: what is it converging toward? Is that valuable?

What region am I avoiding without knowing why?

What would Dreamer suggest that Navigator's systematic search would never try?
