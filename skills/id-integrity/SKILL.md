---
name: id-integrity
description: Identifier integrity audit. Checks finding IDs (F-VN-NNN), FTR IDs, and other identifier systems for uniqueness, formatting, sequence gaps, and cross-reference validity. Catches duplicates, orphans, and broken references.
argument-hint: "[optional: F-V4 | FTR | PRI | all] — identifier prefix to audit"
---

Read all project markdown documents to ground in the project's actual state.

## Identifier Integrity Audit

Target prefix: $ARGUMENTS (default: all identifier systems detected)

### Phase 1: Inventory

For each identifier system (F-VN-NNN, FTR-NNN, PRI-NN, etc.):

1. **Extract all IDs** — Every instance of the pattern across all documents
2. **Record location** — File:line for each occurrence
3. **Record context** — Is this a definition or a reference?

Build a registry: ID -> [definition locations] + [reference locations]

### Phase 2: Uniqueness Check

For each identifier:
- **Duplicates** — Same ID defined multiple times with different content
- **Collisions** — Same ID used for genuinely different things
- **Near-duplicates** — IDs that differ only by typo (F-V4-188 vs F-V4-189 vs F-V4-18)

**Flag:**
- Any ID with multiple definition locations
- Definition content that differs between locations

### Phase 3: Sequence Analysis

For numbered identifier systems:
- **Gaps** — Missing numbers in sequence (F-V4-180, F-V4-184 — where's 181-183?)
- **Highest allocated** — What's the next available number?
- **Density** — How sparse is the sequence?

Gaps are informational, not errors — but large gaps may indicate deleted content.

### Phase 4: Reference Integrity

For each reference (ID mentioned but not defined in that location):
- Does the ID exist somewhere?
- Is the reference in a context that makes sense?

**Flag:**
- **Orphan definitions** — IDs defined but never referenced
- **Dangling references** — IDs referenced but never defined
- **Ambiguous references** — References to duplicate IDs (which one is meant?)

### Phase 5: Format Consistency

Check identifier formatting:
- Consistent prefix (F-V4 vs FV4 vs F_V4)
- Consistent numbering (F-V4-01 vs F-V4-1 vs F-V4-001)
- Consistent casing

**Flag:**
- Format variations of the same ID
- IDs that almost match a pattern but don't quite

### Synthesis

Organize by severity:

1. **Duplicates** — Same ID, different content (data integrity issue)
2. **Dangling references** — References to non-existent IDs (broken links)
3. **Orphans** — IDs that exist but are never used (potential dead content)
4. **Format inconsistencies** — Cosmetic but confusing

For each issue:
- The ID(s) involved
- All locations
- What's wrong
- Proposed fix

## Output

Present as:
1. **Summary table** — ID system, total count, duplicate count, orphan count, dangling count
2. **Duplicates list** — Each duplicate with all its definitions
3. **Dangling references** — Each broken reference with location
4. **Sequence report** — Gaps and next available number per system

State total ID count and issue count.

What questions would I benefit from asking?

What am I not asking?
