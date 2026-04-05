---
name: research-arc
description: Sequenced research workflow. One command triggers the full hypothesis-to-finding pipeline.
argument-hint: "[hypothesis or RQ-ID to pursue]"
---

Read ALIVE.md, RESEARCH.md, FINDINGS.md, and RETURNED.md to ground in the current research state.

## Research Arc

gstack-inspired sequential workflow for research. Each stage has exit criteria. The arc proceeds only when criteria are met.

**Target:** $ARGUMENTS

If no target specified, select the highest-priority item from RESEARCH.md.

## Stage 1: DREAM (Hypothesis Formation)

Generate or refine the hypothesis.

Questions:
- What specific prediction does this make?
- What would falsify it?
- What data/computation is required to test it?
- What prior findings does it depend on?

**Exit criteria:**
- Hypothesis is stated as a testable prediction
- Falsification condition is explicit
- Required resources are identified
- Dependencies are validated (not RETURNED)

Output: Hypothesis card with prediction, falsification, dependencies.

---

## Stage 2: PROFILE (Signal Measurement)

Measure the signal using the composition layer.

Protocol:
1. Identify relevant extractions
2. Run `compute_instrument_profile()` or `compute_folded_profile()`
3. Record grade_0, grade_1, stability for relevant extractions
4. Compare to baseline (random, uniform, prior best)

**Exit criteria:**
- Profile computed on clean data
- Comparison to baseline documented
- If signal < baseline: STOP, record in RETURNED.md

Output: Profile summary table with baseline comparison.

---

## Stage 3: VALIDATE (Statistical Gate)

Run the validation pipeline.

Protocol:
1. Build concrete expression using profile-optimal extractions
2. Run `validate()` with walk-forward (gate_2)
3. Compute permutation baseline for FDR
4. Check PF > 2.0, FDR < 0.05

**Exit criteria:**
- Walk-forward PF documented per fold
- Permutation baseline shows signal > noise
- If fails: STOP, record in RETURNED.md with specific failure mode

Output: Walk-forward results table, FDR analysis.

---

## Stage 4: INTEGRATE (Finding Promotion)

Promote validated result to finding.

Protocol:
1. Draft finding entry with claim, evidence, status, dependencies
2. Run `/cross-validate` on the finding
3. If cross-validation passes: add to FINDINGS.md
4. Update RESEARCH.md (remove completed RQ)
5. Update HORIZONS.md if new directions opened

**Exit criteria:**
- Finding ID assigned (F-V5-NNN)
- Cross-validation decision documented
- Downstream documents updated

Output: Finding entry ready for FINDINGS.md.

---

## Arc State Machine

```
DREAM ─┬─> PROFILE ─┬─> VALIDATE ─┬─> INTEGRATE ─> COMPLETE
       │            │             │
       └─> BLOCK    └─> RETURNED  └─> RETURNED
```

At each stage, three outcomes:
- **PROCEED**: Exit criteria met, advance to next stage
- **BLOCK**: Missing dependencies or resources, pause arc
- **RETURNED**: Falsified, record and terminate arc

## Output

Report current stage, exit criteria status, and next action.

If arc completes: celebrate briefly, then identify next RQ.

What would I need to see to trust this finding?
