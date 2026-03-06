Validate the cognitive toolkit against itself. Run analytical skills on the toolkit's own documentation and skill definitions.

$ARGUMENTS

## Purpose

The toolkit makes claims about its own structure — skill counts, composability properties, finding shapes, cross-references. This command verifies those claims by running the toolkit's analytical skills inward.

## Test Suite

### 1. Structural Integrity

Run `/catalog` to build the full skill inventory. Then verify:
- Skill count in CLAUDE.md, SYSTEM.md, and plugin.json matches actual `skills/*/SKILL.md` count
- Command count matches actual `commands/*.md` count (excluding self-test from the command count if self-referential)
- Every skill referenced in SYSTEM.md selection matrix exists
- Every skill referenced in composition examples exists
- Stage map covers all skills (no orphans)
- Finding Shape Convention in CLAUDE.md lists the correct skills

### 2. Skill Anatomy Compliance

For each `skills/*/SKILL.md`:
- Frontmatter has `name`, `description`, `argument-hint`
- `name` in frontmatter matches directory name
- Output management section exists with segment size and auto-continue instruction
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

## Execution

Run tests in order. For each test:
1. State what's being checked
2. Report pass/fail with specifics
3. For failures: state the exact discrepancy and the fix

## Output Management

**Hard constraints:**
- Report each test section as a segment. Do not accumulate.
- Continue through all 5 test sections without pausing.
- Summarize at end: total checks, passes, failures.
- Failures are actionable — each includes the specific fix.
