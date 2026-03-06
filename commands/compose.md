Chain multiple skills in sequence, threading context between passes.

Argument format: skill names separated by commas, optional focus area after a colon.
Parenthesized groups iterate as a unit.

Examples:
- `/compose gaps, crystallize, deep-review`
- `/compose deep-review, api-review : authentication endpoints`
- `/compose (invoke, review, converge) ~3, land : API design`
- `/compose (gaps, crystallize) * 2, land`

$ARGUMENTS

## Steps

1. Parse the argument into an ordered list of skills and groups, plus an optional focus area.
   - Bare skill names execute once in sequence.
   - Parenthesized groups `(a, b, c)` execute as a unit, subject to iteration control.
2. For each skill or group in order:
   a. Announce which skill is running (e.g., "**Pass 1/3: /gaps**").
   b. Execute that skill's methodology against the project documents, applying the focus area if provided.
   c. Capture findings as a numbered list.
   d. Feed findings forward — each subsequent skill should account for what previous passes discovered.
3. After all passes, present a unified summary:
   - Key findings across all passes, deduplicated
   - Conflicts between passes (e.g., `/gaps` says "add X" but `/crystallize` says "remove complexity")
   - REDIRECT annotations from any converge passes (scope shifts to note)
   - Prioritized action list combining all recommendations
4. No changes to files — document only. Exception: if `land` is the final
   skill in the chain, it transitions to action mode and may write files.

## Iteration Groups

Parenthesized skill groups repeat as a unit. Iteration control:
- `* N` — repeat exactly N times
- `~ N` — repeat until the group's convergence gate says STABLE, max N
- `~` — alias for `~3` (default bounded)

If a group contains `converge`, its directive controls the loop:
- **STABLE** — exit group, continue to next skill in chain
- **CONTINUE** — repeat the group, feeding converge's focus forward
- **REDIRECT** — note the scope shift for the unified summary, continue the group
- **STUCK** — pause chain, present converge's assessment, wait for user input.
  Recovery options: user says "skip" (exit group, continue chain), "redirect to X"
  (alter focus and continue group), or "break" (stop entire chain).
  At autonomous authority, resolve STUCK by choosing the strongest path forward
  with reasoning noted.

Groups with `~ N` should include `converge` to control iteration. Without it,
exit after N iterations or when the final skill produces no new findings
compared to the previous cycle.

Between iteration cycles, annotate the output boundary: `--- Cycle N complete ---`.
This gives converge explicit markers for delta extraction.

## Chain Length

Three skills is the sweet spot. Four is the practical limit for reliable context
threading — each skill adds output that subsequent skills must process.
For longer analysis, use `land` to harvest findings mid-chain, or run separate
compose chains and synthesize manually.

## Output Management

If the combined analysis is extensive, deliver the highest-priority cross-cutting findings first. Note remaining detail available on request.
