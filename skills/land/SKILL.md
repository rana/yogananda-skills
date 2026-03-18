---
name: land
description: Transition from analysis to action. Harvest findings, decide, execute.
argument-hint: "[optional: items to prioritize or constraints on action]"
---

You have just completed an analytical or creative pass. The conversation
contains findings, questions, recommendations, and action items.

$ARGUMENTS

## Harvest

Scan the full conversation for:
- Questions surfaced by prior passes — these are addressed to you, not the user.
  Answer them directly using conversation context and project knowledge.
- Action items and recommendations (prioritized lists, fix suggestions)
- Design decisions proposed but not yet committed to files
- Preferences expressed or implied by the user
- If preceded by a compose chain, use its Prioritized Action List as primary input
- Actions already taken in this conversation (files already written, commits
  already made) — exclude these

Organize remaining actions into three categories:
1. **Clear calls** — the right action is evident from context, user
   preferences, and project conventions
2. **Judgment calls** — debatable, but you have enough context to decide well
3. **Human calls** — genuinely require user input (value judgments, scope
   decisions, external commitments)

What am I attempting to achieve?

## Decide

For clear calls: state the decision in one line and act.

For judgment calls: state your reasoning in 1-2 sentences, then act.
Mark these with **[judgment]** so the user can override.

For human calls: present concisely with enough context to decide.
Do not act on these — wait for input.

## Scope Check

If total actions exceed 5 file modifications or touch more than one repository,
present the full action plan and confirm before executing.

## Act

Execute all clear and judgment calls:
- Write files that were designed but not yet created
- Edit files where specific changes were identified
- Update cross-references, indexes, or registries

Work incrementally. Each action should be independently valid.

## Report

After acting, present:
- **Done:** files created or edited, with paths
- **Judgment calls:** marked, overridable
- **Human calls remaining:** if any, with enough context to decide
- **Rollback:** all changes are uncommitted — `git checkout -- <file>` reverts
  any single action
- **Next:** the natural follow-on

## Output

Act first, report after. If many actions are needed, execute in logical
groups. Continue until all clear and judgment calls are resolved.
