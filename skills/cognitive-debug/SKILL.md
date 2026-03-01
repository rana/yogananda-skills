---
name: cognitive-debug
description: Reasoning trace and correction. When thinking went wrong — yours or Claude's — trace back to find where pattern-matching replaced mechanism-tracing, where fear replaced exploration, or where compression happened prematurely. The cognitive equivalent of setting breakpoints in a thought process.
argument-hint: "[reasoning, decision, or conclusion to debug] [--dialogue]"
---

Examine the conversation history and any relevant project context.

## Cognitive Debugging

Target: $ARGUMENTS

### Dialogue Mode

If `--dialogue` is specified, present the traced reasoning chain and identified breakpoints (Steps 1-3), then pause. Ask the user to confirm or correct the trace before generating corrective questions and the corrected path. The user often knows *where* thinking went wrong better than the tool does — their correction makes Steps 4-5 sharper. Without `--dialogue`, run all steps and deliver the complete analysis.

### Step 1: State the Conclusion
What was concluded, decided, or produced? State it precisely — the output of the reasoning, not the intent.

### Step 2: Trace the Reasoning Chain
Walk backward through the reasoning that led to the conclusion. For each link:
- What observation or input triggered this step?
- What reasoning connected it to the next step?
- Was this reasoning from **mechanism** (how things actually work) or from **pattern** (how things usually seem)?

### Step 3: Identify Breakpoints
Find where the reasoning diverged. Common failure modes:

- **Fear-driven reasoning**: Protecting against what *might* go wrong instead of tracing what *actually* happens. "This could deadlock" without verifying the mechanism.
- **Premature compression**: Jumping to "X means Y" without tracing the full chain. Compressing a nuanced situation into a simple (wrong) conclusion.
- **Pattern-matching over mechanism**: Treating a similar-looking situation as identical without checking whether the similarity is structural or superficial.
- **Coherence drive**: Resolving a tension prematurely because ambiguity felt uncomfortable. Picking an answer to have an answer.
- **Associative momentum**: Following one line of reasoning past where it stopped being productive. Continuing to elaborate a wrong model instead of stepping back.
- **Solution orientation**: Jumping to fix something before understanding whether it's actually broken.

### Step 4: Corrective Questions
For each breakpoint, propose the question that would have redirected:
- "What does the code/system/mechanism actually do here?"
- "Am I reasoning from fear or from observation?"
- "What's the simplest experiment that would falsify this concern?"
- "What would happen if I traced this with pencil and paper?"
- "First understand what IS before worrying about what MIGHT BE."

### Step 5: Corrected Path
Trace the reasoning again with the corrective questions applied. Where does it lead differently?

## Output

1. Original reasoning chain (compact)
2. Breakpoints identified (what went wrong, why)
3. Corrective questions (what would have helped at each breakpoint)
4. Corrected conclusion (where better reasoning leads)
5. Pattern to watch for (the recurring failure mode to catch next time)

## Output Management

**Hard constraints:**
- Segment output into groups of up to 5 breakpoints, prioritizing the earliest divergence point — fixing that often resolves downstream issues.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until the full reasoning trace, all breakpoints, corrective questions, and corrected path are reported.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.
