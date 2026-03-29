---
name: sentinel-status
description: Report all monitoring channels, current alert state, and trend analysis. Use to understand system health and detect silent degradation.
argument-hint: ""
---

Read the Sentinel agent definition, DESIGN.md Layer 2 (monitoring), and any sentinel logs or alert history.

## Status Protocol

Examine each monitoring channel independently, then synthesize.

1. **WDI (Wasserstein Deformation Index)** — Current distance between live return distribution and training distribution. Threshold levels:
   - Green: WDI < 0.3 (within normal variation)
   - Yellow: 0.3 < WDI < 0.6 (drifting, investigate)
   - Red: WDI > 0.6 (regime shift, Governor must act)
   - Trend: increasing / stable / decreasing over last N periods

2. **Permutation p-value** — Statistical significance of recent performance relative to random.
   - p < 0.05: performance is real
   - p > 0.10: performance indistinguishable from noise
   - Per-strategy breakdown (which strategies are losing significance?)

3. **Isotropy Deficit (ID)** — Dimensional collapse indicator. How far is the current point cloud from uniform spherical distribution?
   - Deficit increasing = dimensions collapsing (2022-type event)
   - Compare current to historical range

4. **WaX (Wasserstein Acceleration)** — Rate of change of WDI. Second derivative matters:
   - WaX > 0 with WDI rising = accelerating drift (urgent)
   - WaX < 0 with WDI elevated = regime stabilizing (patience)

5. **Grade-Mixing Monitor** — Are bivectors collapsing to scalars? Grade-2 norm trend. This is a leading indicator: grade-mixing collapse precedes PCA eigenvalue changes by an estimated 1+ months.

## Output

```
Channel          Value    Threshold   Status    Trend
WDI              X.XX     0.3/0.6     green     stable
Perm p-value     0.XXX    0.05/0.10   green     stable
Isotropy Deficit X.XX     [range]     yellow    increasing
WaX              X.XX     0/0         green     stable
Grade-mixing     X.XX     [range]     green     stable
```

Active alerts: [list with severity, age, affected strategies]
Recent resolutions: [list with what triggered, what resolved, how long]

Synthesis: Is the system healthy, degrading, or recovering? Are multiple channels telling the same story?

What degradation am I normalizing?

What would look fine on every channel individually but be alarming in combination?
