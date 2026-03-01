---
name: review
description: Unified pre-implementation quality gate. Runs mission-align + coherence + gaps in a single pass with prioritized output. Replaces invoking three skills separately.
argument-hint: "[optional focus area or file/section to review]"
---

Read CONTEXT.md, DESIGN.md, DECISIONS.md, and ROADMAP.md first to ground in the project's actual state.

## Unified Review

Perform a single-pass review covering three dimensions simultaneously. Do NOT run them sequentially — interleave findings by severity.

### Dimension 1: Intent Alignment

Check whether the design and implementation align with the project's stated purpose, principles, and constraints. Draw these from CONTEXT.md, DECISIONS.md, project README, or any document that states goals or governing principles.

Look for:
- Deviations from stated goals or success criteria
- Violations of recorded design decisions (ADRs)
- Scope creep beyond defined boundaries
- Patterns that serve implementer preference over stated project needs

Focus on the top 3 most at-risk alignments unless $ARGUMENTS specifies otherwise.

For each misalignment: what goal or principle is at risk, where the issue is, the specific fix.

### Dimension 2: Cross-Document Coherence (from /coherence)

Check:
- Cross-reference integrity (identifiers exist where referenced)
- Stated vs actual state (counts, phase statuses)
- Consistent terminology (no synonym drift)
- Bidirectional links
- Narrative coherence across documents

For each inconsistency: what it is, which document is authoritative, the fix.

### Dimension 3: Gap Analysis (from /gaps)

Search for:
- Missing decisions (implicit assumptions needing ADRs)
- Unaddressed scenarios (edge cases, failure modes)
- Dependency gaps (undefined contracts)
- Phase transition gaps (undocumented prerequisites)
- The unasked questions

For each gap: what's missing, where it belongs, proposed resolution.

## Focus

Focus area: $ARGUMENTS

If a focus area is given, constrain all three dimensions to that area. If not, apply judgment to identify the highest-severity findings across all dimensions.

## Output

**Critical rule:** Merge findings from all three dimensions into a single prioritized list. Do not present three separate sections — present one unified action list ordered by impact.

Each finding includes:
1. **Dimension** tag: `[alignment]`, `[coherence]`, or `[gap]`
2. **Severity:** critical / important / minor
3. **Location:** exact file, section, identifier
4. **Finding:** what's wrong or missing
5. **Fix:** specific edit or question to resolve

**Hard constraints:**
- Maximum 15 findings per invocation. If more exist, report count and offer to continue.
- Group by severity (critical first), not by dimension.
- Write findings to REVIEW-AUDIT.md incrementally.
- After completing the review, state: total findings, breakdown by dimension, breakdown by severity.
- No file modifications — audit only.

What questions would I benefit from asking?

What am I not asking?
