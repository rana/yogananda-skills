---
name: ftr-curate
description: FTR corpus curation — compare, merge, split, archive, and triage specification files. The operational layer between spec-survey diagnosis and manual refactoring. Write-enabled (preview by default).
argument-hint: "[mode] [FTR identifiers] — modes: (none)=triage, compare, merge, split, archive"
---

## FTR Corpus Curation

### Context

FTR files in `features/{domain}/` are the project's specification corpus. This skill curates that corpus: comparing overlapping specs, merging redundant ones, splitting overloaded ones, archiving stale ones, and triaging raw explorations into curated FTRs.

Evolved from dedup-proposals. Subsumes its exploration-consolidation role and extends to full FTR corpus operations.

### Mode Selection

**No arguments** (`/ftr-curate`): Triage mode — scan explorations and run lightweight FTR overlap detection.

**Compare** (`/ftr-curate compare FTR-034 FTR-035 FTR-124`): Deep structural comparison of 2-5 specified FTRs.

**Merge** (`/ftr-curate merge FTR-035 → FTR-034`): Absorb one FTR into another.

**Split** (`/ftr-curate split FTR-040 DES-007..DES-016`): Extract subsections into a new standalone FTR.

**Archive** (`/ftr-curate archive FTR-142 FTR-143`): Batch state transition to Archived.

---

### Triage Mode (no arguments)

Read `features/FEATURES.md` to determine current FTR count, domain allocation, and state distribution.

**Part A: Exploration scan.** Read all `.md` files in `.elmer/proposals/`. For each file, extract:
- The `elmer:archive` metadata block (topic, id, archetype, status)
- The first 200 words of the Summary section

Cluster explorations by topic similarity:
1. **Exact match:** Same `topic` field in elmer metadata
2. **Near match:** Topics sharing 3+ significant words (excluding stopwords)
3. **Content match:** Summaries with >40% semantic overlap

For each cluster, report:
- File names and sizes
- Overlap percentage (structural alignment of sections)
- Which file is more developed (word count, section completeness)
- Unique ideas in each file not present in the other(s)
- Contradictions between files (if any)
- Recommended FTR entry: title, domain, and which exploration to use as canonical base
- Cross-references to existing FTR identifiers mentioned in the explorations

For non-clustered explorations, report as standalone candidates for individual FTR files.

Classify each cluster/standalone by type:
- **Feature** — New capability
- **Theme** — Content theme for taxonomy integration
- **Policy** — Governance, legal, or process change
- **Enhancement** — Improvement to existing feature
- **Retrospective** — Design review findings (may not need FTR files)

**Part B: FTR overlap detection.** Read first 20 lines of each FTR file. Identify:
- FTRs in the same domain with similar titles (3+ shared significant words)
- FTRs referencing each other bidirectionally (mutual dependency suggests overlap)
- FTRs governing the same concern from different angles

Report overlap clusters with classification (contradictory, redundant, complementary, intentional) and recommended action (merge, compare deeper, leave alone).

Present the full report. Offer actions:
1. Auto-resolve all clusters and create FTR files (explorations)
2. Resolve cluster-by-cluster with approval
3. Show side-by-side comparison for a specific cluster or FTR group

---

### Compare Mode

**Syntax:** `/ftr-curate compare FTR-NNN FTR-MMM [FTR-PPP ...]` (2-5 identifiers)

Read the full text of all specified FTRs.

**Step 1: Structural alignment.** For each section present in any source FTR (Rationale, Specification, Notes, subsections), compare across all sources:
- **Shared decisions:** Present in 2+ sources (strengthened signal)
- **Unique to source A:** Decisions/content only in one FTR
- **Contradictions:** Claims or specifications that conflict

**Step 2: Dependency impact.** Scan the full corpus for references to any of the compared FTRs. Report which other FTRs cite them and how.

**Step 3: Resolution proposal.** Based on alignment and dependencies, propose one of:
- **Merge** — which FTR absorbs which, what unique content transfers
- **Absorb** — one FTR absorbs a section from another (partial merge)
- **Leave separate** — with rationale (complementary, not redundant)
- **Archive one** — if one is superseded

Present the alignment table and resolution proposal. User approves before any write operations.

---

### Merge Mode

**Syntax:** `/ftr-curate merge FTR-MMM → FTR-NNN` (absorb MMM into NNN)

**Step 1: Preview.** Read both FTRs fully. Show:
- What transfers from FTR-MMM to FTR-NNN (unique content)
- What's already covered (redundant — will be dropped)
- What contradicts (needs resolution — pause for user input)
- Cross-references that will be rewritten (list all FTRs that reference FTR-MMM)

**Step 2: Execute (on approval).**
1. Add unique content from FTR-MMM to FTR-NNN's relevant sections
2. Add provenance note to FTR-NNN: `<!-- Merged from FTR-MMM on [date] -->`
3. Update FTR-MMM's state to `Absorbed` with redirect: `→ Absorbed into FTR-NNN`
4. Rewrite all `FTR-MMM` references across the corpus to `FTR-NNN`
5. Update `features/FEATURES.md` index: mark FTR-MMM as Absorbed, note redirect
6. Update `features/MIGRATION.md` if it exists: add merge mapping
7. If FTR-MMM appears in the "Always-Load FTRs" table, transfer that designation to FTR-NNN
8. If FTR-MMM has DES-NNN subsections listed in FEATURES.md, reassign them to FTR-NNN

**Step 3: Report.** Summarize: what transferred, what was dropped, how many cross-references rewritten, files modified.

---

### Split Mode

**Syntax:** `/ftr-curate split FTR-NNN DES-007..DES-016` or `/ftr-curate split FTR-NNN "Section Name"`

**Step 1: Preview.** Read FTR-NNN fully. Show:
- Content being extracted
- Proposed new FTR number (next available in the appropriate domain overflow range)
- Proposed title for the new FTR
- Cross-references that need updating
- What remains in the parent FTR after extraction

**Step 2: Execute (on approval).**
1. Create new FTR file in `features/{domain}/FTR-NNN-{slug}.md`
2. Move extracted content, adding back-reference to parent
3. Update parent FTR to reference the new FTR where content was removed
4. Update `features/FEATURES.md`: add new entry, update parent entry if needed
5. Update "Subsection Identifiers" table in FEATURES.md if DES-NNN subsections were promoted
6. Update `features/MIGRATION.md` if it exists

**Step 3: Report.** Summarize: new FTR created, parent updated, cross-references adjusted.

---

### Archive Mode

**Syntax:** `/ftr-curate archive FTR-NNN [FTR-MMM ...]`

**Step 1: Preview.** For each FTR to archive:
- Current state
- Inbound references (which other FTRs cite this one)
- Whether it appears in "Always-Load FTRs" (warn — requires confirmation)
- Whether it has DES-NNN subsections

**Step 2: Execute (on approval).**
1. Update each FTR's state to `Archived`
2. Add archive note: `<!-- Archived on [date]. Reason: [from user or inferred] -->`
3. Update `features/FEATURES.md` index
4. Do NOT delete files or remove cross-references — archived FTRs remain navigable

**Step 3: Report.** Summarize: FTRs archived, warnings about inbound references.

---

### Exploration Synthesis (legacy dedup-proposals behavior)

**Syntax:** `/ftr-curate FTR-NNN` or `/ftr-curate filename.md`

Finds related explorations in `.elmer/proposals/` and synthesizes them into a curated FTR file.

**Step 1: Find related explorations.** If argument is an FTR-NNN, find the file in `features/` and identify the topic. If argument is a filename, read it from `.elmer/proposals/` and extract the `topic` field from elmer metadata.

Scan all `.md` files in `.elmer/proposals/`:
- Exact topic match (same elmer topic string)
- Near topic match (3+ shared significant words)
- Content overlap (>40% of referenced FTR identifiers are the same)

**Step 2: Structural alignment.** For each section present in any source (Summary, Analysis, Proposed Changes, Open Questions, What's Not Being Asked), compare across sources. Present alignment table.

**Step 3: Synthesize and create FTR file (on approval).**
1. Create FTR file with next available number in domain overflow range
2. Update `features/FEATURES.md` index
3. Archive source explorations to `.elmer/proposals/archived/`
4. Add synthesis note to archived files: `<!-- Consolidated into FTR-NNN on [date] -->`

**Step 4: Report.** FTR-NNN assigned, word counts, unique ideas preserved, contradictions flagged, files archived.

---

### Quality Standards

- **Lossless on ideas, lossy on phrasing.** Every distinct insight from every source must appear in the target or be noted as a cross-reference. Redundant prose is collapsed.
- **Parallax is signal.** When two sources reach the same conclusion independently, that's stronger evidence. Mark it.
- **Don't resolve tensions.** If sources disagree, present both positions. Curation combines — it doesn't decide.
- **Preview by default.** Every write operation shows its full plan before executing. No silent mutations.
- **Provenance always.** Every merge, split, and archive records where content came from and when.
- **Preserve "What's Not Being Asked" sections fully.** These contain the highest-value insights.

## Output

**Triage mode:** Part A (explorations) first, then Part B (FTR overlaps).

**Compare mode:** Alignment table first, then dependency impact, then resolution proposal.

**Write modes (merge/split/archive/synthesis):** Preview first. Execute only on approval. Report after execution.

State total count when complete.
