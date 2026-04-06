---
name: ask
description: Question-driven autonomous research. Reads knowledge state, generates research questions, designs sub-agent prompts as questions. The meta-prompting protocol.
argument-hint: "[open|synthesize|close] [optional focus area]"
---

Read all project markdown documents to ground in the project's actual state.

Read ALIVE.md, FINDINGS.md, RETURNED.md, RESEARCH.md, HORIZONS.md, PERCEPTION.md.
Read last 3 session archives from `sessions/`.
Read all agent definitions from `.claude/agents/*.md`.
Read `prompts/PATTERNS.md` if it exists.

What is the current knowledge state? Summarize in 10 lines or fewer: what is known, what failed, what is blocking, what is now possible.

## Phase Selection

**Argument:** $ARGUMENTS

- If no argument or `open`: run the OPEN phase
- If `synthesize`: run the SYNTHESIZE phase (sub-agent results are in conversation context)
- If `close`: run the CLOSE phase

---

## Phase: OPEN

What are the most valuable things we do not yet know?

Which knowledge gaps, if filled, would unblock the most downstream work?

What questions does the current state make possible that were not possible before the last session?

What has been tried and returned that should be retried under changed conditions?

What assumption are we making that we have not measured?

From these reflections, what are the 3-5 research questions that would produce the highest information gain from the current knowledge state?

For each question:
- State the question. A genuine question, not an imperative disguised as one.
- What does knowing the answer unlock? (Information gain)
- Which agent cognitive mode is most relevant?
- Design the sub-agent prompt, following the invocation gradient below.
- What should the sub-agent read to ground itself?

### How to formulate for each cognitive mode

This is a gradient from maximally open to maximally specific. The formulation must match the mode.

**Dreamer (maximally open)** -- Provide context and an open invitation. A seed, not a question. No success criteria, no direction, no expected output format. The less structure, the better.
- "Read all project markdown files. Here is what we know: [summary]. What catches your attention? Follow whatever thread emerges. Think without agenda. Mark everything as speculative."
- Dreamer's value IS the unstructured encounter. Do not constrain it.

**Cartographer (open but grounded)** -- Questions include a computational entry point. Cartographer maps structure -- questions connect to what could be measured.
- "What structure exists in [specific residual or space] that current extractions do not capture?"
- "What would a grade-2 measurement of [specific phenomenon] reveal that grade-0 projections miss?"
- Provide the relevant source files to read (e.g., `src/firm/optics/`, `src/firm/composition/`).

**Meta (reflexive)** -- Questions turn the research process into the object of study. The meta-prompter invoking Meta is recursion by design.
- "Read all session archives. Is the research process converging, diverging, or circling? What evidence supports your assessment?"
- "What methodology produced the strongest findings? What methodology produced the weakest?"
- "What is the research process afraid of? What territory is it avoiding?"

**Navigator (structured search)** -- Questions reference the PCFG state, recent validation outcomes, and extraction landscape.
- "Given that [recent findings], what expressions would test whether [specific hypothesis]? What would surprise you?"
- Provide PCFG weights, recent Critic feedback, extraction profiles.

**Critic (adversarial)** -- Questions ask what could be wrong, not what is right.
- "What is the weakest assumption in [specific finding or method]? How would you design a test that exposes it?"
- "If [specific result] is an artifact rather than genuine signal, what evidence would reveal that?"

**Sentinel (simultaneous observation)** -- Questions ask about cross-channel patterns and silent degradation.
- "What monitoring gap exists that would let [specific failure mode] go undetected?"
- "Which channels are NOT alerting that should be, given [current state]?"

**Governor (discriminating judgment)** -- Questions ask about allocation quality, not just allocation rules.
- "Given [current portfolio state and findings], where is attention being over- or under-allocated?"
- "What would a connoisseur notice about the quality of recent research output?"

**Builder (maximally specific)** -- Questions MUST reference a validated finding. Include success criteria (tests, invariants). Builder does not speculate.
- "How would you implement [F-V5-NNN] while preserving SA-INV-10 and PRI-002?"
- "What is the minimal implementation? What tests would prove correctness and detect silent breakage?"
- Provide the specific finding, relevant source directory, and existing test patterns.

### Output

Present the research questions with their sub-agent prompts, ready to spawn.

Then spawn sub-agents autonomously. Multiple agents in parallel. Each with full project context. No pause for human selection.

After all sub-agents return, proceed to SYNTHESIZE.

---

## Phase: SYNTHESIZE

Sub-agent results are in the conversation context (returned or pasted).

What do we now know that we did not know before these sub-agents ran?

What did these results contradict about our prior knowledge state?

Where did independent sub-agents converge? Convergence from independent perspectives is the strongest signal.

Where did they diverge? Divergence points to genuine uncertainty or perspective-dependent truth (PRI-015).

What new questions does this make possible that were not possible before?

### Knowledge State Updates

Draft updates to:
- **FINDINGS.md** -- New findings with claim, evidence, status, dependencies. Assign F-V5-NNN IDs.
- **RETURNED.md** -- New failures with what was tried, why it failed, and the boundary of the failure.
- **RESEARCH.md** -- New RQs generated by results. Update completed RQs.
- **HORIZONS.md** -- New directions opened by results.

### Prompt Archive

Record this session's questions and outcomes in `prompts/archive/YYYY-MM-DD-NNN.md`:
- Knowledge state at open
- Questions generated with agent assignments
- Full sub-agent prompts as delivered
- Outcomes per question (FINDING / RETURNED / INCONCLUSIVE)
- What was surprising
- What questions became possible

Update `prompts/INDEX.md` with the new entry.

---

## Phase: CLOSE

What questions does this session's work make possible that were not possible before?

What would the next session's meta-prompter see that this one cannot?

What question formulations worked well? What fell flat? Update `prompts/PATTERNS.md` with observations.

Update ALIVE.md with session results and current state.

Archive the session to `sessions/` following the existing format in `sessions/INDEX.md`.

---

## What this is not

This is not an agent. It is the medium through which agents reason -- the practice of beginning with questions. It does not replace the ResearchLoop or the Conductor. It provides research direction. The ResearchLoop provides computational execution. The Conductor provides autonomous measurement scheduling.

## The fundamental principle

Questions produce fundamentally different reasoning than statements. "Design X" activates execution mode -- narrow output, pattern-matching. "How would you design X?" activates reasoning mode -- open output, generative. Every prompt this skill produces is a question or an invitation, never a command.

What am I not asking? What would I benefit from asking?
