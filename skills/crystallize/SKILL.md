---
name: crystallize
description: Simplification and editorial sharpening. Use when designs feel heavy, over-engineered, or accumulated rather than composed. The editorial knife.
argument-hint: "[optional focus area]"
---

Read all project markdown documents to ground in the project's actual state.

## Crystallization Review

Apply the editorial knife across two dimensions: structural simplification and communication quality.

### Structural Simplification

1. **Would you simplify anything?** — What's more complex than it needs to be? What's solving a problem that doesn't exist yet?
2. **Would you remove anything?** — What's dead weight? Vestigial decisions? Features that don't earn their keep? Could this be reconstructed from the code and domain knowledge alone — and if so, is it documentation weight masquerading as documentation value?
3. **Would you restructure anything?** — What would be clearer reorganized? What's in the wrong document or section?
4. **What are you not enthusiastic about?** — Where does the design feel forced, over-engineered, or uncertain? Be honest.
5. **What are you enthusiastic about?** — What's working well? What's elegant? Reinforce the strengths.
6. **Is the design crystalline?** — Does every element serve a purpose? Can you see through it clearly?

### Communication Quality

7. **AI readability** — Can a fresh Claude session navigate these documents efficiently? Are identifiers unambiguous? Is structure consistent enough for pattern-matching?
8. **Onboarding** — Could a new developer (or a new Claude session) understand the project from docs alone? Where would they get lost?
9. **Staleness** — Are there references to things that no longer exist? Outdated state descriptions? Dead links?
10. **Redundancy vs. value** — Is the same information in multiple places? Is that useful (different audiences need different formats) or dead weight (documentation that exists only because someone wrote it)?

Focus area: $ARGUMENTS

For every proposal:
1. What to change and why (the simplification or removal)
2. What's preserved (nothing valuable is lost)
3. Where the change belongs

Present as an action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 simplification proposals, ordered by complexity reduction impact.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL proposals are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
