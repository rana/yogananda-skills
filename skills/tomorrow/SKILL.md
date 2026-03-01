---
name: tomorrow
description: Future-self documentation. While context is fresh, capture what will confuse you in 6 months — workarounds, magic numbers, implicit assumptions, dragons. Not reference docs — survival notes.
argument-hint: "[optional area or recent changes to document]"
---

Examine the codebase, recent changes, and project documents.

## Tomorrow Notes

Capture what future-you needs to know:

1. **The non-obvious** — What code looks wrong but is actually correct? What workarounds exist and why? What would you "fix" if you didn't know the context?
2. **Magic values** — Numbers, strings, thresholds, or timeouts that look arbitrary but have specific reasons. Document the reason, not just the value.
3. **Implicit ordering** — Things that must happen in a specific order but nothing enforces it. Initialization sequences, migration steps, deployment procedures.
4. **Fragile spots** — Code that works but will break if touched the wrong way. Areas where a reasonable-looking change would cause subtle bugs.
5. **Context that will evaporate** — Why was this approach chosen over the obvious alternative? What did you try that didn't work? What constraints existed that might not be apparent?
6. **Dependency knowledge** — Library quirks, API behaviors, platform-specific gotchas that you learned the hard way.
7. **The dragons** — Areas where "here be dragons" is the honest documentation. What should future-you approach with extreme caution?

Focus area: $ARGUMENTS

For every note:
1. What the thing is
2. Why it matters (what breaks or confuses without this knowledge)
3. Where to put the note (inline comment, CLAUDE.md, dedicated doc)

Present as an action list of notes to add. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 notes, ordered by "what would confuse future-you most."
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL notes are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
