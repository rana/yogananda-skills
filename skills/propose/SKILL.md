---
name: propose
description: Write a proposal for any subject — rigorous, executable, complete.
argument-hint: "[subject or problem to propose a solution for]"
---

Read available project documentation to understand existing architecture, conventions, and constraints.

## Preamble

Identify how this project stores proposals — registry files, naming conventions,
identifier schemes, index tables. If a convention exists, discover the next
available identifier. If none exists, use descriptive markdown headers.

**Scale depth to impact.** A cross-cutting governance change needs all five
movements in full. A single-file change may need only Movements I, II, and V
in abbreviated form. A focused proposal is typically 50-150 lines. Only exceed
this for cross-cutting changes that genuinely touch many systems. The test:
would a reader feel the proposal was overwrought? Would they feel it was
underspecified? Find the balance.

$ARGUMENTS

## Movement I: Why This, Why Now

Before proposing anything, establish the problem with evidence:
- What friction, failure, or missed opportunity exists today?
- What is the measurable cost of the status quo?
- Who feels this pain — humans, AI agents, systems, users?
- What existing decisions, principles, or constraints govern this space?
  Reference them explicitly.
- What prior attempts (if any) addressed this?

Do not proceed to a solution until the problem is sharp enough to cut.

## Movement II: The Core Move

Propose the simplest intervention that resolves the problem:
- State the change in one sentence
- What is the new thing? How does it behave?
- What lifecycle does it have, if any? (States, transitions, terminal conditions)
- What does one instance look like? (Anatomy — show the shape)
- What alternatives were considered? Why is this path better?
  ("No real alternative exists" is a valid answer if true.)

The solution should feel inevitable given the problem statement.

## Movement III: Displacement and Integration

Map what the proposal touches:
- What existing things does it replace, modify, or obsolete? (Be explicit.)
- Where does the new thing live? (Files, directories, systems)
- How does the surrounding system change? (Cross-references, conventions, docs)
- What stays unchanged? (Explicitly name what's stable.)
- If ambiguous cases exist, provide judgment rules for resolving them.

## Movement IV: Execution

Design the implementation path:
- If the implementation is a single commit, say so.
- If it requires sequenced steps, design each step as bounded and verifiable.
  - Each step produces a concrete artifact
  - Steps are ordered by dependency (mark parallelizable steps)
  - Each step has clear completion criteria
- For multi-session work: include a resumption protocol.
- Surface judgment calls that require human decision.

## Movement V: Trust

Build confidence through transparency:
- **Risks:** What could go wrong? What mitigates each risk?
- **Scope:** Hard numbers — files affected, estimated size, behavior changes.
- **Decision required from:** Who must approve? What is their decision scope?
- **What this enables:** The future that becomes possible.

## Final Check

Before delivering, verify:
- Could someone execute this proposal without asking me questions?
- Does every section earn its presence?
- What's the strongest argument against this proposal? Is it addressed?
- Am I writing at the right depth for the change's blast radius?
- Have I used tables, diagrams, or code blocks where they communicate more
  efficiently than prose?

## Output Management

Write each movement incrementally. Continue until the full proposal is delivered.
Quality over completeness — stop when adding more would dilute.
