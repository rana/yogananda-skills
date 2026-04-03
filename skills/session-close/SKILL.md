---
name: session-close
description: End-of-session documentation maintenance. Archives session history, trims ALIVE.md to current state, updates handoff context.
argument-hint: "[optional session title]"
---

End-of-session documentation maintenance for projects with AI-native documentation architecture.

## Prerequisites

This skill expects:
- `ALIVE.md` — Living document with current state + session history
- `sessions/` directory — For archived session details
- `SESSION-CONTINUITY.md` or similar — Handoff document for next AI

## Protocol

### 1. Read Current State

Read ALIVE.md and identify:
- Current session content (what happened this session)
- Previous session content (should be archived)
- Core state (phase, what's built, what's next)

### 2. Determine Session Number

Check `sessions/INDEX.md` for last session number, or count existing session files.
New session number = last + 1.

### 3. Archive Session History

If ALIVE.md contains detailed session history beyond the current session:

Create `sessions/NNN-title.md` with:
```markdown
# Session NNN: [Title]

**Date:** YYYY-MM-DD
**Focus:** [Main activity]
**Findings:** [F-XXX-NNN if any]

## Session Details

[Move detailed session content here]

## Outcomes

[What was accomplished]

## Next Steps Identified

[What the session determined should come next]
```

### 4. Trim ALIVE.md

Reduce ALIVE.md to essential current state:

```markdown
# [Project] ALIVE

**Phase:** [Current phase]
**Updated:** YYYY-MM-DD

## What's Built
[Table of components - 10-15 items max]

## Current State
[3-5 lines: where we are, blockers, active work]

## What's Next
1. [Priority 1]
2. [Priority 2]
3. [Priority 3]

## Last Session
**Focus:** [one line]
**Outcome:** [2-3 lines]
**Findings:** [IDs if any]

---
*Session history: sessions/*
```

Target: **<300 lines**

### 5. Update Handoff Document

Overwrite SESSION-CONTINUITY.md (or equivalent) with context for next AI:
- What was this session doing
- What's the current system state
- What should the next session prioritize
- Any warnings or gotchas

### 6. Update Session Index

Add entry to `sessions/INDEX.md`:
```markdown
| NNN | YYYY-MM-DD | [Title] | [F-XXX-NNN, ...] |
```

## Output

Report:
1. Session archived to: `sessions/NNN-title.md`
2. ALIVE.md trimmed from X lines to Y lines
3. SESSION-CONTINUITY.md updated
4. Session index updated

If no archival needed (session was brief), report that too.

## Arguments

$ARGUMENTS — Optional session title. If not provided, derive from session focus.

## When to Use

- End of any substantial work session
- When ALIVE.md exceeds 500 lines
- Before context compaction in long conversations
- When explicitly asked to hand off to next AI

## When NOT to Use

- Mid-session (use normal documentation)
- For trivial sessions (quick questions, no state changes)
- If there's no sessions/ directory (create it first)

---

What questions would benefit the next AI session?

What context might be lost if this session ends now?
