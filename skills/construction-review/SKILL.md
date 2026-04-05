---
name: construction-review
description: Multi-lens construction review. Runs one pass of the review protocol — spawns sub-agents for the appropriate wave, collects findings, reports convergence. Use after construction to audit fidelity, safety, and design quality. For the full protocol, see firm-scaffold/patterns/REVIEW.md.
argument-hint: "pass-N [wave-A|wave-B|wave-C|all] [lifecycle-phase]"
---

Read all project markdown documents to ground in the project's actual state.

Read `firm-scaffold/patterns/REVIEW.md` for the full review protocol. Read `firm-scaffold/REVIEW-GUIDE.md` for the step-by-step guide.

## Construction Review Pass

You are running one pass of the multi-lens review protocol. The review uses 13 cognitive lenses across 3 waves to find defects that single-perspective review misses.

### Determine the pass and wave

From the arguments (`$ARGUMENTS`), determine:
- **Pass number** (1, 2, 3, 4+). Default: 1.
- **Wave** (A, B, C, or all). Default: depends on pass number.
  - Pass 1: A then B
  - Pass 2: A only (verification)
  - Pass 3: A + C (expansion)
  - Pass 4: Dreamer + Forensic + Witness
- **Lifecycle phase** (pre-construction, post-construction, pre-deployment). Default: post-construction.

### Wave A: Compare (fact-finding)

Launch these sub-agents IN PARALLEL:

1. **Tracer** (Perception mode): Trace every spec requirement to archive evidence, code implementation, and test coverage. Produce traceability matrix.
2. **Forensic** (Adversary mode): Trace every data flow for future information leakage. Produce contamination risk register.
3. **Mathematician** (Direct Action): Verify every formula and numerical computation. Produce per-computation verdict.
4. **Navigator Reviewer** (Oscillator): Assess what fraction of the spec's search space is reachable. Produce coverage map.
5. **Absence** (Unsaid mode): Catalogue what files, code paths, tests, and docs should exist but don't. Produce absence register.

### Wave B: Judge + Perceive (informed by Wave A)

Include Wave A findings as context for each agent. Launch IN PARALLEL:

1. **Architect** (Connoisseur mode): Judge design quality on 3 axes — scaffold compliance, cognitive architecture, engineering balance.
2. **Trader** (Simultaneity mode): Hold the entire system at once — would you deploy this? Top 5 break points.
3. **Inhabiter** (Creative Encounter): Be the system. Trace a complete runtime cycle as first-person experience.
4. **Witness** (Reflection mode): Observe the construction and review process. What patterns connect the oversights?

### Wave C: Expansion (later passes)

Launch IN PARALLEL:

1. **Optimizer** (Direct Action): Profile computational bottlenecks, scaling analysis.
2. **Integrator** (Direct Action): Design the integration test suite that doesn't exist.
3. **Inverter** (Adversary on assumptions): Systematically invert every core assumption.
4. **Dreamer** (Creative Encounter, no reference): Encounter code without criteria.

### Pass 2+ context injection

For passes after the first, include in each agent's prompt:
- What previous passes found (summary of key findings)
- What was fixed (list of fixes applied)
- Instruction: "Verify fixes AND probe deeper. Report only delta."

## Output

For each wave, present:

1. **Per-lens findings** with severity (CRITICAL / HIGH / MEDIUM / LOW)
2. **Cross-lens convergence** — where multiple lenses flagged the same issue
3. **Triage recommendation** per finding: FIX / DOCUMENT / DEFER

Then assess convergence across passes:
- Category collapse? (same defect category as previous pass)
- Severity drop? (no CRITICAL findings from Tracer or Forensic)
- Monotonic delta? (fewer findings than previous pass)
- Witness stability? (same themes as previous pass)

If all four: declare CONVERGED. If not: recommend which lenses to run in the next pass.

What am I not seeing? What class of defect would require a lens that doesn't exist yet?
