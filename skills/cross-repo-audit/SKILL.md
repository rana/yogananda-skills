---
name: cross-repo-audit
description: Cross-repository consistency audit for related repositories (e.g., spec + scaffold + archive). Detects mismatches in cross-references, file paths, counts, thresholds, and shared terminology across repo boundaries.
argument-hint: "repo1 repo2 [repo3] — paths to related repositories to audit together"
---

Read the CLAUDE.md and key documents from each repository specified in $ARGUMENTS.

## Cross-Repository Consistency Audit

Target repositories: $ARGUMENTS

Parse the repository paths. If relative paths, resolve from current working directory. If none specified, look for common patterns: `*-spec`, `*-scaffold`, `*-archive` in parent directory.

### Phase 1: Cross-Reference Integrity

For each repository, extract:
1. **Outbound references** — Paths and identifiers that point to OTHER repositories
2. **Inbound expectations** — What this repo expects other repos to provide

Then verify:
- Every cross-repo path resolves to an actual file
- Every cross-repo identifier (F-VN-NNN, FTR-NNN, etc.) exists in the target
- File counts match ("5 files" claims match actual file counts)
- Line counts match where claimed

**Output:** Table of broken cross-references with: source file, target repo, claimed path/identifier, actual state.

### Phase 2: Threshold and Constant Alignment

Extract all numeric thresholds and constants mentioned across repositories:
- Pass/fail thresholds (PF > X, TC >= Y)
- Counts (N files, M findings)
- Percentages and ratios

Then verify:
- Same threshold has same value everywhere it appears
- When one repo overrides another's default, the override is explicit

**Output:** Table of threshold mismatches with: constant name, repo1 value, repo2 value, which is authoritative.

### Phase 3: Terminology Alignment

Extract key terms and their definitions from each repository. Check:
- Same concept uses same name across repos
- No silent synonyms (different names for same thing)
- No homonyms (same name for different things)
- Abbreviations expand consistently

**Output:** Table of terminology conflicts with: term, repo1 meaning, repo2 meaning, proposed resolution.

### Phase 4: Structural Alignment

For repositories that should mirror structure (e.g., spec sections mapping to archive evidence):
- Does each spec section have corresponding archive evidence?
- Does each archive finding have spec coverage where relevant?
- Are the mappings explicit or implicit?

**Output:** Coverage matrix showing which spec sections map to which archive sections.

### Synthesis

1. **Critical mismatches** — Would cause implementation errors or wrong decisions
2. **Confusing mismatches** — Would cause reader confusion but not errors
3. **Cosmetic mismatches** — Inconsistent but harmless

For each mismatch:
- What the issue is
- Which repository is authoritative (or if unclear, flag for human decision)
- Proposed fix (which repo to update)

## Output

Present findings by phase, then synthesis. State total mismatch count.

Priority order: Critical (blocks work) > Confusing (slows work) > Cosmetic (annoys).

What questions would I benefit from asking?

What am I not asking?
