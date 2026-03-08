---
name: docs-quality
description: Documentation practice quality review. Use when evaluating whether docs serve AI readers (Claude), human developers, and stakeholders effectively.
argument-hint: "[optional focus area]"
---

Read all project markdown documents to ground in the project's actual state.

## Documentation Quality Review

Evaluate documentation as communication architecture. For each dimension, ask the pointed question — not "is this good?" but "what specifically fails?"

1. **AI readability** — Drop a fresh Claude session into these docs with no prior context. Where does it get lost? Which identifiers are ambiguous? Where does structure break pattern and force re-parsing? Test: can Claude find the answer to "how does X work?" in under 3 hops?
2. **Onboarding** — Follow the reading path a new developer would take. Where do they hit a wall? Where do docs assume knowledge they haven't given yet? Where is the reading order implicit rather than explicit?
3. **Staleness** — What describes what *was* rather than what *is*? Not just dead links — state descriptions that lag behind reality, counts that haven't been updated, phase statuses frozen in time.
4. **Convention adherence** — Where do documents break their own rules? Identifier formats that drift, section headers that don't follow stated patterns, maintenance procedures documented but not followed.
5. **Reconstructibility** — Would this document survive deletion? If you regenerated it from the code, domain knowledge, and remaining docs, would you lose anything? Documentation that merely restates what code makes obvious is weight, not value. The test: what does this document tell you that *nothing else* tells you?
6. **Redundancy** — Same information in multiple places. When it serves different audiences (API docs vs architecture overview), it's intentional. When it's copy-paste drift, it's a maintenance burden waiting to diverge.
7. **What's missing** — Not completeness-for-completeness-sake. What question would a reader actually ask that the docs can't answer? What decision would they need to make that the docs don't inform?

Focus area: $ARGUMENTS

For every finding:
1. The issue or opportunity
2. The specific location
3. The proposed improvement

Present as an action list. No changes to files — document only.

## Output

Order findings by impact on reader comprehension. State the total count when complete.

What questions would I benefit from asking?

What am I not asking?
