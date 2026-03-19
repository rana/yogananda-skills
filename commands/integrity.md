Verify the cognitive toolkit's internal consistency and memory accuracy. The toolkit makes claims about its own structure, and memory makes claims about the world. This command checks both.

$ARGUMENTS

## Test Suite

### 1. Structural Integrity

Run `/catalog` to build the full skill inventory. Then verify:
- Skill count in CLAUDE.md, SYSTEM.md, and plugin.json matches actual `skills/*/SKILL.md` count
- Command count matches actual `commands/*.md` count
- Every skill referenced in SYSTEM.md selection matrix exists
- Every skill referenced in composition examples exists
- Stage map covers all skills (no orphans)
- Finding Shape Convention in CLAUDE.md lists the correct skills

### 2. Skill Anatomy Compliance

For each `skills/*/SKILL.md`:
- Frontmatter has `name`, `description`, `argument-hint`
- `name` in frontmatter matches directory name
- Output section exists with skill-specific guidance
- Skills claiming to produce standard finding shape actually instruct that format
- Cognitive/creative skills that shouldn't produce finding shape don't claim to

### 3. Cross-Reference Integrity

Run `/doc-health` scoped to the toolkit's own documents (CLAUDE.md, SYSTEM.md, plugin.json):
- Every skill name in SYSTEM.md maps to a `skills/<name>/` directory
- Composition topology (affinities, terminal skills, dead zones) references only existing skills
- Quick reference section references only existing skills
- No stale references to deleted skills

### 4. Composition Coherence

For each composition example in SYSTEM.md:
- All named skills exist
- Ordering follows stated principles (perception-expanding before analytical, simplification last)
- No examples violate stated dead zones
- Terminal skills appear only at chain end

### 5. Document Consistency

- CLAUDE.md and SYSTEM.md agree on: skill counts, command counts, skill classification (analytical vs mission vs cognitive)
- Plugin.json description matches CLAUDE.md opening paragraph
- Calibrate parameters documented in SYSTEM.md match `commands/calibrate.md`
- Environment contract tables are consistent between CLAUDE.md and SYSTEM.md

### 6. Memory Accuracy

Read the auto-memory directory (`~/.claude/projects/*/memory/MEMORY.md` for the current project). Cross-check claims against reality:

- **Fact verification** — Skill counts, command counts, agent counts, practice counts match actual files. File paths mentioned in memory exist. Conventions described in memory match CLAUDE.md.
- **Staleness detection** — Entries referencing deleted skills, renamed files, or superseded decisions. "Recent" annotations that are no longer recent. State descriptions that don't match current state.
- **Redundancy with CLAUDE.md** — Memory entries that duplicate information already in CLAUDE.md (wasted budget — CLAUDE.md is always loaded, memory doesn't need to repeat it).
- **Budget check** — Line count vs 200-line ceiling. If over 180 lines, flag entries ranked by reconstructibility (easiest to recover = lowest cost to drop).
- **Topic file coherence** — If separate topic files exist (e.g., `debugging.md`, `patterns.md`), verify MEMORY.md links to them and they don't contradict each other.

For each memory finding: state the claim, the reality, and the fix (update, remove, or compress).

## Execution

Run tests in order. For each test:
1. State what's being checked
2. Report pass/fail with specifics
3. For failures: state the exact discrepancy and the fix

## Output

Report each test section, then summarize at end: total checks, passes, failures. Failures are actionable — each includes the specific fix.
