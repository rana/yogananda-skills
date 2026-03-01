---
name: consequences
description: Forward-propagation analysis. Given a proposed change, map 2nd and 3rd order effects across behavior, maintenance, user experience, and future optionality. Use before committing to significant decisions.
argument-hint: "[proposed change or decision]"
---

Read all project markdown documents to ground in the project's actual state.

## Consequence Mapping

Given the proposed change:

$ARGUMENTS

Propagate forward through these dimensions:

1. **Direct effects** — What immediately changes? Code, behavior, data, interfaces.
2. **Behavioral shifts** — How does system behavior change for users, operators, developers? What works differently?
3. **Maintenance burden** — Does this make the system easier or harder to maintain? What new complexity is introduced? What's simplified?
4. **Adjacent systems** — What other components, services, or workflows are affected? What contracts change?
5. **Feedback loops** — Does this change create any self-reinforcing dynamics? Positive or negative spirals?
6. **Optionality** — What future choices does this enable? What does it foreclose? Are any changes irreversible?
7. **Failure modes** — What new ways can the system fail? What existing failure modes change?

For every consequence identified:
1. Which order it is (1st, 2nd, 3rd)
2. Whether it's reversible or irreversible
3. Likelihood (certain, likely, possible)
4. Where it manifests (code, docs, ops, user experience)
5. Whether it needs to be addressed now or can be deferred

Present as a propagation chain, not a flat list. Show how effects cascade.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 consequences, ordered by impact and irreversibility.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL consequences are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
