---
name: constant-audit
description: Magic number and threshold audit. Extracts all numeric constants, checks cross-document consistency, and traces to source findings. Catches threshold mismatches, undocumented magic numbers, and constants without provenance.
argument-hint: "[optional focus: thresholds | counts | percentages | all]"
---

Read all project markdown documents to ground in the project's actual state.

## Constant and Threshold Audit

Focus: $ARGUMENTS (default: all)

### Phase 1: Extraction

Scan all documents for numeric constants:

1. **Thresholds** — Pass/fail criteria (PF > 2.0, TC >= 50, WF >= 3/5)
2. **Counts** — Claimed quantities (5 files, 190 findings, 14 patterns)
3. **Percentages** — Ratios and fractions (85.5%, 97.9%, 3/5)
4. **Measurements** — Specific values (Q5/Q1 = 5.28, Sharpe 0.84)
5. **Configuration** — Settings (warmup = 200, tau_scales max = 144)

For each constant, record:
- Value
- Location (file:line)
- Context (what it's measuring or controlling)
- Apparent purpose

### Phase 2: Consistency Check

Group constants by apparent purpose. For each group:
- Do all instances have the same value?
- If values differ, is the difference intentional and documented?
- Is there a single authoritative source?

**Flag:**
- Same constant, different values, no explanation
- Same purpose, different constant names
- Values that appear once with no cross-reference

### Phase 3: Provenance Trace

For each threshold or measurement:
- Is it traced to a finding? (e.g., "per F-V4-152")
- Is the finding still valid? (not RETURNED or RE-VERIFY)
- Is the derivation documented?

**Flag:**
- Thresholds with no provenance ("magic numbers")
- Thresholds traced to invalidated findings
- Thresholds that claim provenance but the finding doesn't support the value

### Phase 4: Staleness Detection

For counts and quantities:
- Verify against actual state (claimed "5 files" — are there 5 files?)
- Flag any count that doesn't match reality

### Synthesis

Organize findings by severity:

1. **Critical** — Threshold mismatch that would cause wrong pass/fail decisions
2. **Undocumented** — Magic number with no provenance (may be correct but untraceable)
3. **Stale** — Count that doesn't match reality
4. **Cosmetic** — Minor inconsistency in formatting or precision

For each finding:
- The constant and its value(s)
- Where it appears
- What's wrong
- Proposed fix (which value is correct, or "needs human decision")

## Output

Present as tables:
1. **Threshold Inventory** — All thresholds with their values and provenance
2. **Mismatches** — Constants with inconsistent values
3. **Magic Numbers** — Thresholds without provenance
4. **Stale Counts** — Quantities that don't match reality

State total constant count and issue count.

What questions would I benefit from asking?

What am I not asking?
