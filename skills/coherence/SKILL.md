---
name: coherence
description: Cross-document coherence and cross-reference integrity check. Use when checking if all project documents tell a consistent story, if identifiers match, if stated state matches actual state, or after significant document changes.
argument-hint: "[optional focus area]"
---

Read all project markdown documents (CLAUDE.md, CONTEXT.md, DESIGN.md, DECISIONS.md, ROADMAP.md, and any others present) to ground in the project's actual state.

## Coherence Audit

Systematically check:

1. **Cross-reference integrity** — Every identifier (ADR-NNN, DES-NNN, Phase N, or whatever conventions the project uses) referenced in one document exists in its canonical location. No dangling references. No stale identifiers.
2. **Stated vs actual state** — "Current state" sections match what's actually implemented. Phase statuses agree across documents. Counts (ADR count, phase count) are accurate.
3. **Consistent terminology** — The same concept uses the same term everywhere. No synonym drift.
4. **Bidirectional links** — If Document A references Document B section X, does B's section X make sense in that context? Are there references that should exist but don't?
5. **Narrative coherence** — Do the documents tell a unified story? Or have they drifted into contradictions through incremental edits?

Focus area: $ARGUMENTS

For every finding, state:
1. What the inconsistency is (with exact locations in both documents)
2. Which document should be considered authoritative
3. The specific edit to resolve it

Present findings as an action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 findings, ordered by severity of inconsistency.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
