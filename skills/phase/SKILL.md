---
name: phase
description: Sprint phase marker for research workflow. Declares current phase and its exit criteria.
argument-hint: "<DREAM|EXPLORE|VALIDATE|IMPLEMENT|REFLECT> [optional context]"
---

## Phase System

Research follows a sprint structure inspired by gstack. Each phase has distinct cognitive modes and exit criteria.

### Phases

| Phase | Mode | Purpose | Exit Criteria |
|-------|------|---------|---------------|
| DREAM | Creative encounter | Generate hypotheses without judgment | 3+ hypotheses articulated |
| EXPLORE | Breadth search | Measure signals, map territory | Profiles computed, territory mapped |
| VALIDATE | Depth verification | Statistical gates, falsification | Walk-forward passes or finding recorded in RETURNED.md |
| IMPLEMENT | Direct action | Build what's validated | Code merged, tests passing |
| REFLECT | Meta-cognition | Update findings, prune returned | FINDINGS.md updated, session closed |

### Current Phase Declaration

Declare the phase: **$ARGUMENTS**

If no phase specified, assess current state and recommend next phase based on:
- What's blocking (CONSTRUCTION-STATE.md)
- What's validated (FINDINGS.md)
- What's queued (RESEARCH.md)

### Phase Transition Protocol

Before transitioning:
1. Verify exit criteria of current phase are met
2. Document what was learned in appropriate file
3. Clear any blocking items or note them for next session

### Output

1. **Current phase** with timestamp
2. **Exit criteria** for this phase instance
3. **Active question** driving this phase
4. **Constraints** (what's out of scope for this phase)
5. **Next phase** (predicted, contingent on exit criteria)

Keep it short. The phase marker is a checkpoint, not a document.
