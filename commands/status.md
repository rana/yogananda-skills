Session orientation. Quick briefing on project state, recent changes, and next actions.

Read these in parallel:

1. **ROADMAP.md** — find the section marked **Current**
2. **CONTEXT.md** — find "Current State" and "Open Questions" (Tier 2 only)
3. Run `git log --oneline -8` for recent commits
4. Run `git status` (never `-uall`) for working directory state
5. Run `git diff --stat HEAD~3..HEAD` for recent change scope

## Output

Deliver a dense briefing. No narrative filler.

### Where We Are
- Current milestone name and one-sentence goal
- Deliverables: N/M complete (list remaining by number — e.g., STG-006-1, STG-006-4, STG-006-9)

### What Changed Recently
- Last 3–5 commits (one line each, emphasize what shipped)
- Uncommitted changes (if any — file count and nature)

### What's Next
- Next 1–2 unstarted deliverables from current milestone (number + name)
- Any Tier 2 open questions that could block near-term work

### Active Concerns
- Only if something looks off: failing CI, large uncommitted diffs, stale branches, schema drift

Keep the entire briefing under 200 words. If the project has no ROADMAP.md, fall back to README.md and recent git history.

$ARGUMENTS

If an argument is provided, focus the briefing on that area (e.g., "search", "ingestion", "frontend") — filter deliverables and recent commits to that domain.
