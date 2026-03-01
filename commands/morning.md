Daily development briefing. Summarize the current state of your work across branches, PRs, and recent activity.

## Steps

1. Run `git branch --show-current` to identify the current branch.
2. Run `git branch -vv` to see all local branches and their tracking status.
3. Run `git log --oneline --all --since="24 hours ago" --author="$(git config user.name)"` to see your recent commits.
4. Run `git stash list` to check for any stashed changes.
5. Run `git status` (never use `-uall`) to see working tree state.
6. Check for park notes: list files in `.claude/park-notes/` if the directory exists. Read any that exist.
7. If `gh` is available, run `gh pr list --author=@me --state=open` to check open PRs.
8. If `gh` is available, run `gh pr list --search="review-requested:@me"` to check PRs awaiting your review.
9. Present a structured briefing:

   ```
   ## Morning Briefing

   ### Current branch
   {branch name and status}

   ### Recent activity (last 24h)
   {commits made, branches touched}

   ### Open work
   {branches with uncommitted changes, park notes, stashes}

   ### PRs
   {your open PRs and their status, PRs awaiting your review}

   ### Suggested focus
   {based on state: resume parked work, address PR feedback, or start fresh}
   ```

10. Run `python3 scripts/conversation-analytics.py --project ~/.claude/projects/-home-rana-prj-srf-yogananda-teachings --output /tmp/morning-analytics.md 2>/dev/null` and read the Weekly Activity and Skill Usage sections from `/tmp/morning-analytics.md`. Add a brief "Session stats" section to the briefing showing sessions this week, top skills used, and any notable patterns (e.g., skill imbalance, unusually large sessions).
11. Keep the briefing concise. This is a 30-second orientation, not a deep dive.
