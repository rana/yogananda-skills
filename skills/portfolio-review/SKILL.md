---
name: portfolio-review
description: Evaluate the deployed portfolio against geometric diversification, grade balance, and dimensional coverage. Use before portfolio changes or monthly.
argument-hint: ""
---

Read DESIGN.md, deployed strategy data, and reports/multi-strategy-position-sizing.md.

## Review Protocol

Evaluate the portfolio as a geometric object, not a list of strategies.

1. **Effective Bets** — Compute cosine distance matrix between all deployed strategy characters. Count independent directions (eigenvalue decomposition of correlation matrix, threshold at 1/N). Compare to number of deployed strategies. Ratio = diversification efficiency.

2. **Hole Coverage** — Do deployed strategies span any H1 holes? A hole boundary that touches deployed strategies is partially covered. A hole with no nearby deployment is a diversification opportunity. Overlay deployment on hole map.

3. **Grade Balance** — Portfolio-level geometric product. Decompose into grades:
   - Grade-0 (scalar): net correlation, should be low
   - Grade-1 (vector): net directional exposure, acceptable if intentional
   - Grade-2 (bivector): diversification planes, should be distributed across multiple independent planes

4. **Concentration Risk** — Which conditional dimensions are overrepresented? Which are absent? Dimensional loading histogram. Flag any dimension with >40% of total portfolio loading.

5. **Gap Analysis** — What character vectors are missing relative to the manifold's structure? Specific coordinates of the largest gaps. Prioritize gaps near H1 hole barycenters.

6. **Risk Regime Sensitivity** — How does portfolio geometry change under 2022-type dimensional collapse (dim 5 → 0.43)? Which strategies survive? Which become redundant?

## Output

```
Deployed:       N strategies
Effective bets: M independent directions (efficiency: M/N)
Grade balance:  g0=X, g1=Y, g2=Z
Concentration:  [dimension]: loading%
Missing:        [list character vectors with coordinates]
Regime risk:    [collapse scenario summary]
```

Recommended action: add / remove / rebalance with specific geometric target (not just "diversify more").

What diversification am I mistaking for independence?

What would this portfolio look like to Governor?
