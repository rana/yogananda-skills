---
name: ftr-stale
description: Corpus freshness audit. Systematic staleness detection across state accuracy, content drift, and relevance decay. The triage pass that identifies which FTRs need verify, update, or archive.
argument-hint: "[optional: domain filter or FTR range, e.g. 'search' or 'FTR-060..079']"
---

Read `features/FEATURES.md` to load the full FTR index with states, domains, and cross-references.

## Corpus Freshness Audit

Systematic staleness detection across three dimensions. This is the triage pass — lightweight and corpus-wide. For deep single-FTR verification, hand off to `/verify FTR-NNN`.

**Relationship to other skills:**
- **spec-survey** maps topology (overlap, orphans, hubs). ftr-stale maps freshness (state accuracy, content drift, relevance decay). Complementary, not overlapping.
- **drift-detect** compares stated architecture against emergent code patterns. ftr-stale compares FTR specifications against code implementation and corpus state. drift-detect is code-focused; ftr-stale is FTR-focused.
- **verify** does deep single-FTR fidelity checking. ftr-stale does lightweight corpus-wide triage. Findings that say `review-needed` are handoffs to verify.

### Scope

$ARGUMENTS

If a domain filter or FTR range is provided, restrict analysis to those FTRs. Otherwise, audit the full corpus.

---

### Dimension 1: State Accuracy

For each FTR in Approved or Proposed state, grep the codebase for implementation evidence:
- Function names, component names, or route patterns mentioned in the spec
- File paths referenced in the spec
- Config constants, environment variables, or feature flags named in the spec
- Database tables or API endpoints specified

Classify each FTR:
- **`implemented-not-marked`** — substantial code evidence exists, state still says Approved/Proposed. Fix: update state to Implemented.
- **`marked-not-implemented`** — state says Implemented but no code evidence found. Fix: verify manually or revert state.
- **`partially-implemented`** — some spec sections have code evidence, others don't. Fix: note which sections are implemented.
- **`accurate`** — state matches code evidence. No action needed.

For each FTR in Deferred or Declined state, check whether implementation evidence exists despite the deferral. Flag as `implemented-despite-deferral` if so.

---

### Dimension 2: Content Drift

For FTRs classified as implemented (either by state or by Dimension 1 evidence), compare spec claims against code reality:

1. **API contracts** — do the endpoints, request/response shapes, and status codes match the spec?
2. **Data model** — do the database schemas, field names, and relationships match?
3. **Behavior** — do the described user flows, feature behaviors, and business rules match?
4. **Technology choices** — does the spec reference the same libraries, services, and infrastructure the code uses?

Flag divergences where the code does something materially different from what the FTR specifies. Minor naming differences are not drift; behavioral differences are.

Classify drift as:
- **`spec-behind`** — code evolved beyond the spec (most common). Fix: update FTR to match code.
- **`code-behind`** — spec was approved but code doesn't fully implement it. Fix: verify intent — deliberate deferral or oversight?
- **`diverged`** — code and spec went in different directions. Fix: reconcile — which is authoritative?

---

### Dimension 3: Relevance Decay

Identify FTRs referencing:
1. **Deprecated technology** — check against FTR-004 (Architecture Longevity) tiering and the actual dependency list. Flag specs referencing libraries, services, or APIs no longer in the stack.
2. **Superseded decisions** — FTRs that reference other FTRs in Absorbed, Archived, or Declined state. The reference may be stale.
3. **Withdrawn dependencies** — FTRs that depend on other FTRs whose state changed after this FTR was written. The dependency chain may be broken.
4. **Stale Proposed specs** — Proposed FTRs with no activity (no cross-references from newer FTRs, no discussion evidence). May be abandoned ideas that should be archived.

---

## Output Format

Use the standard finding shape:

```
- **[stale-N]** [severity] [dimension] — [FTR-NNN]: [finding]. Fix: [action].
```

Dimensions: `state-accuracy`, `content-drift`, `relevance-decay`

Severity:
- **critical** — state is materially wrong (implemented but says Proposed, or vice versa)
- **important** — significant content drift or broken dependency chains
- **minor** — cosmetic staleness, stale-but-harmless Proposed specs

Recommended actions: `update-state`, `update-spec`, `archive`, `review-needed` (handoff to `/verify FTR-NNN`), `reconcile` (needs human judgment)

---

### Summary

After all findings, provide:
1. **Freshness score** — percentage of FTRs with accurate state, no drift, and no decay
2. **Domain breakdown** — which domains are freshest and which are stalest
3. **Triage list** — top 10 FTRs most in need of attention, ordered by combined severity
4. **Maintenance recommendation** — suggested cadence for re-running this audit

## Output Management

**Hard constraints:**
- Segment output: Dimension 1 findings first (groups of up to 10), then Dimension 2 (groups of up to 8), then Dimension 3 (groups of up to 8), then Summary.
- Write each segment incrementally.
- After each segment, continue immediately to the next.
- Continue until ALL findings are reported; state total count when complete.
- If the corpus is too large for complete assessment in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
