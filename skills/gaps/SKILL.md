---
name: gaps
description: Systematic search for omissions, blind spots, and missing decisions. Use when preparing for implementation, after completing a design phase, or when asking "what am I not seeing?"
argument-hint: "[optional focus area]"
---

Read all project markdown documents to ground in the project's actual state.

## Gap Analysis

Systematically search for:

1. **Missing decisions** — Areas where the design implies a choice but no ADR or explicit decision exists. Implicit assumptions that should be explicit.
2. **Unaddressed scenarios** — Edge cases, failure modes, or user journeys not covered. What happens when things go wrong?
3. **Dependency gaps** — Technologies, services, or capabilities assumed but not specified. Integration points without defined contracts.
4. **Persona blind spots** — Users, roles, or contexts not considered. Who is underserved?
5. **Phase transition gaps** — What's needed to move between phases that isn't specified? Prerequisites assumed but not documented.
6. **The unasked questions** — What questions would benefit from being asked? What isn't being asked?
7. **Spatial gaps** — Negative space (what's conspicuously absent from the whole), orthogonal space (what reframings reveal hidden gaps), adjacent space (what's one step beyond current scope that matters).

Focus area: $ARGUMENTS

For every gap found:
1. What's missing (specific, not vague)
2. Where it should be addressed (file, section, identifier)
3. Proposed resolution or the question that needs answering

Present as an action list. No changes to files — document only.

## Output

Order findings by risk of the omission. State the total count when complete.

What questions would I benefit from asking?

What am I not asking?
