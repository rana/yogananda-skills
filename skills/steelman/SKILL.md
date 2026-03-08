---
name: steelman
description: Generate the strongest possible defense of the current approach before proposing alternatives. Prevents premature abandonment of working designs. Use when questioning an existing decision or architecture.
argument-hint: "[decision, pattern, or approach to steelman]"
---

Read all project markdown documents to ground in the project's actual state.

## Steelman Analysis

Target: $ARGUMENTS

Before anything is changed, build the best case for keeping it:

1. **Original reasoning** — Why was this decision made? What constraints existed? What alternatives were considered and rejected? Check ADRs, commit history, PR descriptions, and comments.
2. **Hidden strengths** — What benefits does the current approach provide that might not be obvious? Simplicity? Familiarity? Battle-tested reliability? Performance characteristics?
3. **Switching costs** — What would changing this actually cost? Migration effort, retraining, regression risk, lost institutional knowledge.
4. **What it prevents** — What problems does the current approach avoid that alternatives might reintroduce?
5. **Ecosystem fit** — How well does this integrate with adjacent decisions? Would changing it create cascading changes elsewhere?
6. **The strongest version** — If you were to keep this approach but improve it, what would that look like? Could the issues be addressed without replacing it?

Then, and only then:
7. **Remaining weaknesses** — After steelmanning, what genuine problems remain that can't be solved within the current approach?
8. **Decision threshold** — How bad would the remaining problems need to be to justify the switching costs?

Present the defense first, weaknesses second. The goal is to overcome the best case for status quo before proposing change — not to reflexively defend or attack.

## Output

- Keep the defense concise.
- Deliver the full defense, remaining weaknesses, and decision threshold.

What questions would I benefit from asking?

What am I not asking?
