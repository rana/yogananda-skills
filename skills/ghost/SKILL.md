---
name: ghost
description: Hidden dependency and assumption detector. Surfaces things the system depends on that aren't explicit — environment variables, implicit service dependencies, timing assumptions, undocumented contracts. The things that break at 2am.
argument-hint: "[optional focus area or subsystem]"
---

Read all project markdown documents and examine the codebase to ground in the project's actual state.

## Ghost Dependency Audit

Systematically surface the invisible substrate:

1. **Environment assumptions** — Variables read but not documented, config files expected but not templated, paths assumed to exist, permissions required but unspecified.
2. **Service dependencies** — External services called without explicit documentation. DNS entries assumed. Ports expected to be open. Health checks missing.
3. **Timing assumptions** — Operations that assume ordering but don't enforce it. Race conditions waiting to happen. Startup sequences that depend on undocumented timing.
4. **Implicit contracts** — Module boundaries where the interface is convention rather than code. Data formats assumed but not validated. Error handling that assumes specific upstream behavior.
5. **Build & deploy assumptions** — Tools expected to be installed. Versions assumed. Build order dependencies. Network access during build.
6. **Data assumptions** — Seed data expected. Migration order dependencies. Schema assumptions not enforced by constraints. Encoding assumptions.
7. **Human assumptions** — Knowledge required but not documented. Procedures that exist only in someone's head. Tribal knowledge.

Focus area: $ARGUMENTS

For every ghost dependency found:
1. What the assumption is (specific)
2. Where it lives in the code or process
3. What happens when the assumption is violated
4. How to make it explicit (document, validate, or enforce)

Present as an action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 ghost dependencies, ordered by "what breaks at 2am" severity.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL ghost dependencies are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
