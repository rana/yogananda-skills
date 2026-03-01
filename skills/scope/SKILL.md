---
name: scope
description: Pre-implementation sizing and impact mapping. Before writing code, understand how big a change really is — what it touches, its dependency chain, and the minimum viable version. Use to size work before committing to it.
argument-hint: "[feature description or change request]"
---

Read all project markdown documents and examine the codebase to ground in the project's actual state.

## Scope Analysis

For the proposed work:

$ARGUMENTS

Map the full scope:

1. **Surface area** — What files, modules, and systems does this touch? List them explicitly.
2. **Dependency chain** — What does this change depend on? What depends on it? Draw the graph.
3. **Interface changes** — Do any APIs, data models, contracts, or public interfaces change? These are the expensive parts.
4. **New capabilities needed** — Does this require new libraries, services, infrastructure, or permissions?
5. **Test impact** — What existing tests break? What new tests are needed?
6. **Documentation impact** — What docs need updating?
7. **Minimum viable version** — What's the smallest useful slice? What can be deferred to a follow-up?
8. **Full version** — What does the complete implementation look like?
9. **Risk zones** — Which parts are well-understood vs. uncertain? Where might scope expand during implementation?

Present as:
- **Impact summary**: 1-3 sentences on overall scope
- **File/module list**: Specific locations that change
- **Minimum viable version**: Concrete description of the smallest useful deliverable
- **Risk flags**: Areas of uncertainty or potential scope expansion

No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 findings, ordered by scope risk and dependency depth.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
