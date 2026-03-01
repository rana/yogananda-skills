Restore context from a parked work session and present a briefing to get back up to speed.

## Steps

1. If an argument is provided, treat it as the branch name. Otherwise, run `git branch --show-current` to get the current branch.
2. Check for a park note at `.claude/park-notes/{branch-name}.md`. Read it if it exists.
3. Run `git log --oneline -10` to see recent commits on this branch.
4. Check if the most recent commit is a WIP park commit (message starts with "WIP: park"). If so, note this — the user may want to `git reset HEAD~1` to unwrap it before continuing.
5. Run `git status` (never use `-uall`) to see current state.
6. Run `git diff --stat` if there are uncommitted changes.
7. Present a structured briefing:

   ```
   ## Resuming: {branch-name}

   ### Context
   {From park note: what you were doing, or from git log if no park note}

   ### Current state
   {From park note + git status: what's done, what's in progress}

   ### WIP commit
   {If a WIP park commit exists: suggest unwrapping with `git reset HEAD~1`}

   ### Open questions
   {From park note, if available}

   ### Suggested next steps
   {From park note, or inferred from state}
   ```

8. If no park note exists, reconstruct context from git log, diff, and branch name. Present the best briefing possible from available signals.
