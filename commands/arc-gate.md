Phase-appropriate quality gate. Selects the right skill chain for the current project phase.

$ARGUMENTS

## Gate Selection

Parse the argument to determine which gate to run. Accept: `pre-implementation`, `during-implementation`, `pre-launch`, `boundary`, or a milestone/arc number.

### Gate: `pre-implementation` (default if no argument)

The project has a design but no code (or code is about to begin). Focus: are the documents ready to implement from?

Run these skills in sequence, threading findings:
1. **`/doc-health`** — Identifier audit + omission search + consistency check
2. **`/gaps`** — Intent alignment: check the design against the project's stated purpose, principles, and constraints. Focus on the top 3 gaps between intent and design.
3. **`/ghost`** — Hidden dependencies and assumptions that would block implementation
4. **`/crystallize`** — Simplify before building

### Gate: `during-implementation`

Code exists and is evolving. Focus: is the code drifting from the design?

Run these skills in sequence, threading findings:
1. **`/drift-detect`** — Compare stated architecture against actual code patterns
2. **`/ghost`** — Hidden dependencies surfaced by real implementation
3. **`/coherence`** — Cross-document consistency (focused on implemented sections)
4. **`/crystallize`** — Simplify what's accumulated during implementation

### Gate: `pre-launch`

A milestone or arc is about to ship. Focus: is it production-ready?

Run these skills in sequence, threading findings:
1. **`/launch-gate`** — Go/no-go across SLAs, monitoring, backups, rollback
2. **`/ops-review`** — Deployment, costs, monitoring, incident response
3. **`/hardening-audit`** — HTTP headers, secrets, input validation, dependencies
4. **`/threat-model`** — STRIDE-based threat identification from actual architecture

### Gate: `boundary` or `boundary [N]`

An arc or milestone boundary. Focus: is everything consistent and complete before moving on?

Run these skills in sequence, threading findings:
1. **`/deep-review`** — Comprehensive multi-dimensional quality gate
2. **`/gaps`** — Intent alignment: full check against all stated goals, principles, and success criteria. Focus on gaps between what was intended and what was built.
3. **`/workflow-trace`** — Trace the editorial pipeline end-to-end for friction
4. **`/crystallize`** — Simplify before the next phase adds complexity

If a number is provided (e.g., `boundary 2`), focus all skills on Arc N's deliverables and success criteria from ROADMAP.md.

## Inference

If the argument is a milestone number (e.g., `1a`, `2b`, `3d`):
- Pre-code milestone → `pre-implementation`
- Active development milestone → `during-implementation`
- Milestone with code ready to deploy → `pre-launch`
- Milestone completing an arc → `boundary`

Infer from ROADMAP.md and CONTEXT.md § Current State which phase the milestone is in.

## Execution

For the selected gate:
1. Announce which gate is running and which skills it includes.
2. Execute each skill in order, threading findings forward.
3. After all skills, present a unified summary:
   - **Gate verdict:** Ready / Not Ready / Ready with Reservations
   - **Blocking issues** (must fix before proceeding)
   - **Advisory issues** (should fix, can defer)
   - **Strengths** (what's working well)
4. No changes to files — document only.

## Output Management

If the combined analysis is extensive, deliver blocking issues first. Note remaining detail available on request.
