Save current work state and mental context so you can resume later without losing the thread.

## Steps

1. Run `git status` (never use `-uall`) to see current changes.
2. Run `git branch --show-current` to get the current branch name.
3. Run `git diff --stat` to summarize what's changed.
4. Run `git log --oneline -5` to see recent commits for context.
5. If there are uncommitted changes, stage them and create a WIP commit:
   ```
   git add -A && git commit -m "$(cat <<'EOF'
   WIP: park — work in progress, do not merge

   Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
   EOF
   )"
   ```
6. Create a park note at `.claude/park-notes/{branch-name}.md` with this structure:
   ```markdown
   # Park Note: {branch-name}
   Parked: {date and time}

   ## What I was doing
   {1-3 sentence summary of the current task}

   ## Current state
   {What's working, what's broken, what's half-done}

   ## Files in play
   {Key files being modified, with brief notes on each}

   ## Open questions
   {Decisions not yet made, things to investigate}

   ## Next steps
   {Specific actions to take when resuming, in order}
   ```
7. Populate the park note by analyzing the git diff, recent commits, and any todo list state visible in the conversation.
8. Confirm to the user: branch name, WIP commit hash (if created), and park note location.
