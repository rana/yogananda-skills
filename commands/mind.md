Activate an AI-native cognitive architecture for mathematical research.

$ARGUMENTS

## Mode

Parse the argument.

- **No argument** → Error: "Mind needs a name. Example: `/mind adversary`. See `riemann-hypothesis/MINDS.md` for the designed minds."
- **"all"** → Run all minds following the execution protocol in MINDS.md (phased, with dependencies).
- **A phase number (1-5)** → Run all minds in that phase.
- **Any other argument** → The argument is the mind's name. Proceed with single-mind execution.

---

## Execution

### Single Mind

1. Read `riemann-hypothesis/MINDS.md` and find the section matching the argument (case-insensitive, partial match OK: "adv" matches "Adversary").

2. If no match found → Error: "Mind '[argument]' not found. Available: Adversary, Simultaneist, Wound, Forgetter, Listener, Bridge, Gradient, Time-Traveler, Geometer, Negator, Self-Aware Reasoner, Archaeologist, Ensemble, Proof Architect."

3. Extract the mind's **Prompt** section from MINDS.md.

4. Read all project markdown documents to ground in the project's actual state. Follow the reading order in CLAUDE.md. Read PROOF-GRAPH.md, ALIVE.md, RETURNED.md, APPROACHES.md.

5. Execute the extracted prompt with full grounding. The prompt IS the cognitive task — follow it precisely.

### All Minds / Phase

Follow the execution protocol in MINDS.md:
- Phase 1 runs first (Forgetter)
- Phase 2 runs in parallel (Adversary, Listener, Wound, Geometer, Negator)
- Phase 3 runs in parallel after Phase 2 (Bridge, Time-Traveler)
- Phase 4 runs sequentially after Phase 3 (Simultaneist, Gradient)
- Phase 5 runs sequentially after Phase 4 (Self-Aware Reasoner, Archaeologist, Ensemble)

Each mind runs as a subagent. Pass the full prompt from MINDS.md. Each subagent reads the knowledge architecture independently.

---

## Output

Write each mind's output to the report path specified in MINDS.md: `riemann-hypothesis/reports/YYYY-MM-DD-[mind-name]-mind.md`

Prepend frontmatter:

```yaml
---
title: "[Mind Name]: [brief description of what emerged]"
date: YYYY-MM-DD
type: mind
status: active
mind: "[mind-name]"
phase: [1-5]
---
```

After saving, update `riemann-hypothesis/MINDS.md`: change the mind's status from DESIGNED to TESTED and add a one-line summary of what emerged.
