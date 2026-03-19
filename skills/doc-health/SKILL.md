---
name: doc-health
description: Unified document health check combining identifier audit, omission search, and cross-document consistency in a single pass. Reads all documents once, threads findings across phases. Use for recurring document maintenance or pre-implementation review.
argument-hint: "[optional focus area or 'greenfield']"
---

Read all project markdown documents to ground in the project's actual state.

## Document Health Check

Focus area: $ARGUMENTS

A single-pass audit across three dimensions, reading documents once and threading findings forward.

### Phase 1: Identifier Audit

Audit the identifier systems (PRI-NN, FTR-NNN, STG-NNN) for lifecycle health:

1. **Inventory** — Count FTRs per domain and state. Note gaps in numbering, find the highest allocated number per domain.
2. **Safe deletion candidates** — FTRs that are: superseded by later decisions, absorbed into other FTRs, orphaned (no cross-references point to them), vestigial (govern features that were cut), or reconstructible from code and domain knowledge alone.
3. **Merge candidates** — FTRs with overlapping territory that could be consolidated without losing information.
4. **Cross-reference integrity** — Every FTR and PRI reference resolves to an actual file or entry. Bidirectional: if A references B, does B make sense in that context? Dangling references. Missing back-references.

*Thread forward: Findings from Phase 1 (especially orphaned identifiers and broken references) inform what Phase 2 looks for.*

### Phase 2: Omission Search

Search for what's missing — informed by the identifier landscape:

1. **Missing decisions** — Explicit assumptions that should be FTRs. Implicit contracts between components. Design choices embedded in code that lack documentation.
2. **Unaddressed scenarios** — Edge cases, failure modes, error paths that aren't specified. What happens when things go wrong?
3. **Dependency gaps** — Unarticulated service contracts, implicit ordering, assumed infrastructure.
4. **Persona blind spots** — Underserved user roles or personas. Workflows not traced.
5. **Phase transition gaps** — Prerequisites for the next stage that aren't documented. Hand-off points between arcs.
6. **Spatial gaps** — What's conspicuously absent? What should exist by analogy to what does exist?

*Thread forward: Gaps found in Phase 2 inform what Phase 3 checks for — a gap may indicate an inconsistency rather than a true omission.*

### Phase 3: Consistency Check

Verify all documents tell a coherent story:

1. **Stated vs. actual state** — Do descriptions match current reality? Are stage statuses accurate? Are "Current State" sections up to date?
2. **Terminology consistency** — Same concepts use the same terms everywhere. No silent synonyms.
3. **Narrative coherence** — Do the documents tell a unified story, or do different sections contradict each other?
4. **Status alignment** — FTR state markers match reality. FTRs marked `implemented` have code. Provisional FTRs reference the correct future arc.
5. **Table alignment** — Roadmap deliverables match DESIGN sections. Credential tables match tech stack tables. Sub-processor tables match vendor lists.

### Synthesis

After all three phases:
- **Cross-phase findings** — Where do identifier issues, omissions, and inconsistencies converge on the same problem?
- **Priority ranking** — Order all findings by: (1) things that would cause implementation errors, (2) things that would confuse future readers, (3) cosmetic issues.
- **Deduplication** — Merge findings that surface the same root issue from different angles.

If `$ARGUMENTS` is `greenfield`: Focus Phase 1 on reconstructibility — which documents or sections could be reconstructed from code and domain knowledge alone? Which are truly irreplaceable? This reframes document weight as investment vs. insurance.

For every finding:
1. What the issue is (specific)
2. Where it lives (file, line, identifier)
3. The proposed fix
4. Priority (implementation-blocking / confusing / cosmetic)

Present as a prioritized action list. No changes to files — document only.

## Output

Present findings in phase order: Phase 1, then Phase 2, then Phase 3, then Synthesis. State the total count when complete.

**Document reading strategy:**
- Read CLAUDE.md, FEATURES.md index, and ROADMAP.md first for structural overview.
- Read CONTEXT.md for cross-reference verification.
- Read specific FTR files only when identifiers need verification.
- Do not re-read documents between phases — build the picture incrementally.

What questions would I benefit from asking?

What am I not asking?
