---
name: workflow-trace
description: Trace an end-to-end workflow (user journey, developer workflow, editorial pipeline, etc.) for friction points, missing steps, and improvement opportunities.
argument-hint: "[persona or workflow name]"
---

Read all project markdown documents to ground in the project's actual state.

## Workflow Trace

Trace the specified workflow end-to-end:

$ARGUMENTS

For the given persona or workflow:

1. **Map every step** — From trigger to completion, what happens at each stage?
2. **Identify friction** — Where does the flow break, slow down, or require unnecessary effort?
3. **Find missing steps** — What's assumed but not specified? What's implicit that should be explicit?
4. **Check handoffs** — Where does responsibility transfer between systems, roles, or states? Are handoffs clean?
5. **Evaluate error paths** — What happens when things go wrong at each step? Is recovery possible?
6. **Assess completeness** — Does the workflow achieve its stated goal? Are there paths that lead nowhere?

For every friction point or gap:
1. Where in the workflow it occurs
2. What the impact is (blocks progress, degrades experience, causes confusion)
3. The proposed resolution
4. Where it should be documented

Present as an ordered action list following the workflow sequence. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 friction points, ordered by impact on workflow completion.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL friction points are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
