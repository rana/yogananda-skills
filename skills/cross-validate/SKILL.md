---
name: cross-validate
description: Multi-perspective validation gate. Stress-test claims through independent reasoning paths before promotion.
argument-hint: "<finding-id or hypothesis to validate>"
---

Read FINDINGS.md and RETURNED.md to understand the validation context.

## Cross-Validation Protocol

Inspired by gstack's multi-model validation (Claude /review + OpenAI /codex on same diff). Agreement validates rigor; divergence reveals blind spots.

The target claim: **$ARGUMENTS**

## Validation Passes

Run three independent validation passes. Each uses a structurally different reasoning approach.

### Pass 1: Navigator Lens (Constructive)

Assume the claim is true. What would that imply?
- What predictions does it make?
- What downstream effects should we observe?
- What would we expect to see in adjacent instruments/timeframes?
- Does the prediction match what we actually see?

Output: evidence FOR the claim from implications.

### Pass 2: Critic Lens (Adversarial)

Assume the claim is false. What would explain the observed signal?
- Data contamination (backward field, lookahead, selection bias)
- Overfitting (lucky fold, regime-specific, parameter sensitivity)
- Measurement artifact (wrong baseline, incorrect comparison)
- Alternative explanation (correlation with something unmeasured)

Output: evidence AGAINST the claim from alternative explanations.

### Pass 3: Cartographer Lens (Orthogonal)

Step outside the frame. What are we not seeing?
- What assumptions do both Navigator and Critic share?
- What adjacent questions does this claim connect to?
- What would an outside observer find surprising about this debate?
- Is the claim even asking the right question?

Output: reframing that neither validates nor invalidates, but expands.

## Synthesis

After all three passes:

1. **Convergence matrix**: Where do all three agree? (high confidence)
2. **Divergence points**: Where do they disagree? (research frontiers)
3. **Blind spots**: What did none of them address? (unknown unknowns)

## Decision

Based on synthesis:

| Outcome | Criteria | Action |
|---------|----------|--------|
| PROMOTE | 2+ passes support, 0 critical objections | Move finding from PROVISIONAL to VALIDATED |
| HOLD | Mixed support, resolvable objections | Design experiment to resolve divergence |
| DEMOTE | 2+ passes reject or critical objection | Move to RETURNED.md with reason |
| REFRAME | Cartographer reveals wrong question | Revise hypothesis, re-run validation |

## Output

1. Three-pass analysis (Navigator, Critic, Cartographer)
2. Convergence/divergence matrix
3. Decision with rationale
4. If HOLD: specific experiment to resolve

What would change my mind about this claim?
