Chain multiple skills in sequence, threading context between passes.

Argument format: skill names separated by commas, optional focus area after a colon.
Examples:
- `/compose gaps, crystallize, deep-review`
- `/compose coherence, api-review : authentication endpoints`

$ARGUMENTS

## Steps

1. Parse the argument into an ordered list of skill names and an optional focus area.
2. For each skill in order:
   a. Announce which skill is running (e.g., "**Pass 1/3: /gaps**").
   b. Execute that skill's methodology against the project documents, applying the focus area if provided.
   c. Capture findings as a numbered list.
   d. Feed findings forward — each subsequent skill should account for what previous passes discovered.
3. After all passes, present a unified summary:
   - Key findings across all passes, deduplicated
   - Conflicts between passes (e.g., `/gaps` says "add X" but `/crystallize` says "remove complexity")
   - Prioritized action list combining all recommendations
4. No changes to files — document only.

## Output Management

If the combined analysis is extensive, deliver the highest-priority cross-cutting findings first. Note remaining detail available on request.
