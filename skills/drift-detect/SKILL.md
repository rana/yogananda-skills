---
name: drift-detect
description: Detect unconscious architectural evolution. Compare the stated architecture in documents against emergent patterns in the actual code. Surface drift that nobody designed. Use periodically or when the codebase feels inconsistent.
argument-hint: "[optional focus area or subsystem]"
---

Read all project markdown documents to understand the stated architecture.

## Architectural Drift Detection

Compare intent vs. reality:

1. **Stated patterns** — What does the documentation say the architecture should look like? Design patterns, module boundaries, data flow, naming conventions, layering.
2. **Actual patterns** — Sample the codebase. What patterns are actually in use? Are there emergent conventions that nobody decided on?
3. **Divergence vectors** — Where has the code drifted from the stated architecture? Categorize each drift:
   - **Accidental** — Small PRs that individually made sense but collectively changed the architecture
   - **Intentional but undocumented** — Deliberate improvements that were never reflected in docs
   - **Contradictory** — Multiple conflicting patterns coexisting in the same codebase
4. **Emerging patterns** — Are there new patterns forming that should be codified? Conventions that most code follows but no document specifies?
5. **Erosion points** — Where is the architecture actively eroding? Module boundaries being crossed? Layers being bypassed?

Focus area: $ARGUMENTS

For every drift detected:
1. What the stated pattern is (with doc location)
2. What the actual pattern is (with code examples)
3. Whether to update the code or update the docs
4. Priority (structural risk vs. cosmetic inconsistency)

Present as an action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 drift findings, ordered by structural impact over cosmetic inconsistency.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL drift findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
