---
name: deep-review
description: Comprehensive multi-dimensional pre-implementation quality gate. Combines coherence, gaps, errors, and cross-references in a single pass. Use before starting implementation or at phase boundaries.
argument-hint: "[optional focus area]"
---

Read all project markdown documents to ground in the project's actual state.

## Deep Multi-Dimensional Review

This is the comprehensive quality gate. Check every dimension:

### Coherence
- Cross-document alignment, identifier consistency, stated vs actual state
- Terminology consistency, bidirectional reference integrity

### Gaps
- Missing decisions, unaddressed scenarios, dependency gaps
- Persona blind spots, phase transition gaps

### Errors
- Incorrect cross-references, stale information, broken assumptions
- Wrong labels, associations, or identifiers
- Diagram endpoints still valid? Identifier sequences correct?

### Architecture
- Pattern compliance, drift from stated principles
- Emerging patterns that should be codified
- Decisions that should be revisited given current state

### Opportunities
- Simplifications available? Capabilities underexploited?
- Strategic gaps? Phase transitions that could be accelerated?

Focus area: $ARGUMENTS

Be proactive — propose concrete actions, not just observations. For every insight:
1. What specific change would this imply? (code, design, decision, or document)
2. Where exactly does it belong? (file, section, identifier)
3. What's the next step to act on it?

Present as a prioritized action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 10 findings, ordered by severity across all dimensions.
- If no $ARGUMENTS focus area is given, evaluate Coherence and Errors first (the most concrete dimensions), then Gaps if room remains.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings across all dimensions are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read project documentation index/overview sections first. Only drill into specific sections where cross-references or identifiers need verification.
- Do not read the entire codebase — sample based on the focus area.

What questions would I benefit from asking?

What am I not asking?

You have complete design autonomy.
