---
name: garden
description: Document identifier lifecycle maintenance. Audit ADR-NNN, DES-NNN, and similar identifier systems for safe deletion, merge candidates, category coherence, cross-reference integrity, and cognitive load reduction. Use when identifier systems accumulate weight, after greenfield analysis questions, or when documents feel harder to navigate than they should.
argument-hint: "[optional: 'prune', 'merge', 'reorder', 'refs', 'greenfield', identifier range, or category name] [--plan]"
---

Read all project markdown documents (CLAUDE.md, CONTEXT.md, DESIGN.md, DECISIONS.md, ROADMAP.md, and any others present) to ground in the project's actual state.

## Document Identifier Gardening

### Phase 1: Discover Identifier Conventions

Before analyzing, inventory what exists:
- What `PREFIX-NNN` patterns are in use? (ADR-NNN, DES-NNN, Phase N, or others)
- Where is each identifier scheme's canonical home? (e.g., ADRs in DECISIONS.md, DES in DESIGN.md)
- What is the total count per scheme? What is the highest number?
- Are there numbering gaps? Are gaps intentional (reserved ranges) or accidental?

### Phase 2: Apply the Requested Lens

If `$ARGUMENTS` specifies a mode, run only that mode. If no mode specified, run **Safe Deletion** and **Merge Candidates** first (highest cognitive load reduction per finding).

#### Safe Deletion Audit (`prune`)

For each identifier, evaluate deletion safety:

1. **Superseded** — Is this fully replaced by a later identifier that captures all essential content? (e.g., "ADR-013 amended by ADR-117" — is ADR-013's original content still needed?)
2. **Reversed** — Was this decision reversed and the reversal is the operative state?
3. **Absorbed** — Was this content absorbed into a broader identifier? Does the broader one stand alone?
4. **Orphaned** — Is this identifier referenced by anything outside its own document? No inbound references + no unique content = candidate for deletion.
5. **Vestigial** — Does this describe a state or decision that no longer applies and has no historical value as context?
6. **Reconstructible** — Could a developer or AI session reconstruct this identifier's essential content from DESIGN.md, the code, and domain knowledge? Distinguish between reconstructible-fact (the decision is visible in the codebase — low reconstruction cost) and irreplaceable-reasoning (the *why* behind the decision would require a design session to re-derive — high reconstruction cost). Only low-cost reconstructibility qualifies. If keeping the identifier costs more scan-time than reconstructing its content would cost, it's weight.

**Before confirming safe deletion:** Check whether the identifier is referenced in other documents, cross-reference chains, or commit messages. An identifier with zero inbound references and no unique surviving content is safe. An identifier with inbound references requires updating those references first.

#### Merge Candidates (`merge`)

Identify identifiers that cover overlapping territory:
- Same topic split across multiple identifiers (e.g., three ADRs about search that could be one)
- Progressive refinement chains (ADR-X → amended by ADR-Y → updated by ADR-Z) that could collapse into a single canonical version
- Identifiers that exist only to cross-reference each other

For each merge candidate group: what would the merged identifier contain? What would its number be? What cross-references need updating?

#### Category Coherence (`reorder`)

Evaluate the grouping structure:
- Are identifiers in the right categories? Would moving any reduce scan cost?
- Are categories balanced? (A category with 15 items and another with 2 suggests restructuring)
- Does the category ordering match the reader's likely priority? (Foundational first, distant-future last)
- Within categories, are identifiers in a logical order? (By dependency, by phase, or by topic cluster)

#### Cross-Reference Repair (`refs`)

Check reference health:
- **Dangling references** — Identifier mentioned but doesn't exist (typo, deleted without cleanup)
- **Stale amendment chains** — "Updated by ADR-X" where ADR-X doesn't reference back, or the chain is broken
- **Missing bidirectional links** — A references B but B doesn't reference A
- **Implicit references** — Content that clearly relates to another identifier but has no explicit cross-reference
- **Index-body mismatch** — Index entry differs from the actual heading (title drift after edits)

#### Greenfield Audit (`greenfield`)

For each identifier, apply one test: if this identifier disappeared entirely, would a developer or AI session with access to the codebase lose knowledge they cannot reconstruct from DESIGN.md, the code, and domain conventions?

Categorize each identifier as:
- **Irreplaceable** — contains unique reasoning, constraints, trade-off analysis, or context not derivable from other sources. The *why* behind the decision would require a design session to re-derive.
- **Reconstructible** — content is derivable from the codebase or other documents at low cost. The identifier adds scan-time overhead without informational value. State *what source* makes it reconstructible (specific code file, DESIGN.md section, domain convention).
- **Borderline** — the fact is reconstructible but the reasoning holds nuance that might be lost. Worth flagging but not a deletion candidate without judgment.

This mode assumes a technical audience (developers and AI sessions with code access). For identifiers that serve non-technical stakeholders who can't read the codebase, note the audience dependency rather than marking as reconstructible.

### Phase 3: Sequence Health (always runs)

Brief assessment regardless of mode:
- Numbering gaps and whether they matter
- Highest allocated number vs. total count (gap density)
- Whether renumbering would help or hurt (default recommendation: **don't renumber** — it breaks external references in git history, conversations, and notes. Instead, annotate gaps or use a mapping note.)

### Plan Mode (`--plan`)

If `--plan` is specified, instead of findings list, produce a concrete execution plan:
- Ordered list of edits to perform
- For each edit: which file, which section, what changes
- Dependency ordering (update references before deleting the target)
- What to verify after each step

Without `--plan`, present findings as an action list (standard format).

---

For every finding:
1. The specific identifier(s) involved
2. What the issue is (with exact document locations)
3. The proposed action (delete, merge into X, move to category Y, add reference, etc.)
4. Risk level (safe / needs verification / requires judgment call)

Present as a prioritized action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 findings, ordered by cognitive load reduction impact.
- If no $ARGUMENTS mode is given, run Safe Deletion and Merge Candidates only — the two modes with highest signal-to-noise.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings across all requested modes are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read document indexes and tables of contents first. These reveal structure, counts, and categories without reading every identifier's full text.
- Only drill into specific identifier text when evaluating merge candidates or safe deletion (need to compare content).
- For cross-reference repair, grep for identifier patterns across all documents rather than reading linearly.

What identifiers are carrying weight they shouldn't?

What structure has accumulated rather than been composed?

What would a newcomer find hardest to navigate — and would gardening fix that or is the problem deeper?
