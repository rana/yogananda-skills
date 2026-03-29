---
name: strategy-audit
description: Validate a strategy against return conditions, decoherence thresholds, and tourism immunization. Use when evaluating a candidate strategy or reviewing an existing one.
argument-hint: "<strategy-id or expression description>"
---

Read DESIGN.md, METHODS.md, RETURNED.md, and the strategy's FTR if it exists.

## Audit Protocol

Evaluate the strategy across five gates, in order. A failure at any gate is terminal — do not proceed.

1. **Signal Identity (SA-INV-10)** — Is the backtest function identical to the live function? Same code path, different data source? If separate implementations exist, stop. This is a bug.

2. **Decoherence Test** — Run with max_jitter=5. Report retention curve (% of base performance at each jitter level). Classify:
   - ROBUST: >80% retention at jitter=1
   - MODERATE: 50-80% retention at jitter=1
   - FRAGILE: <50% retention at jitter=1

3. **Tourism Immunization** — Does a dumb twin match performance? Construct the simplest possible baseline (random timing with same holding period, or buy-and-hold of same instrument). If strategy does not beat dumb twin by >1 Sharpe unit, it has not earned its complexity.

4. **Embedding Profile** — Compute character vector. Where does this strategy sit in the manifold? Does it occupy a novel region or duplicate existing coverage? Check distance to deployed strategies and H1 hole boundaries.

5. **Return Condition Scan** — Check RETURNED.md failure vocabulary. Does this strategy match any returned pattern? Check return-conditions on related FTRs. If a return condition is met, the strategy returns — regardless of backtest performance.

Focus: $ARGUMENTS

## Output

For each gate: PASS / CONCERN / RETURN with specific evidence.

Summary verdict:
- **VALIDATED**: All 5 gates pass
- **CONDITIONAL**: Passes with concerns (list what resolves them)
- **RETURNED**: Failed a gate (identify which failure vocabulary mode applies)

If CONDITIONAL: what single additional test would resolve?

What assumption am I not testing?

What edge am I attributing to skill that might be luck?
