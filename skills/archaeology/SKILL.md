---
name: archaeology
description: Cognitive archaeology — layered questioning that builds from surface inquiry through assumptions, perspectives, tensions, and meta-cognition to surface what conventional analysis misses. The sequence builds cognitive momentum; each layer prepares the ground for the next. Use for deep exploration of any subject, decision, or design.
argument-hint: "[subject to excavate] [--layers F2,F9,F11] [--relational] [--dialogue]"
---

Read all project markdown documents to ground in the project's actual state.

## Cognitive Archaeology

Target: $ARGUMENTS

Work through these layers sequentially. Each layer prepares the ground for the next — the sequence builds cognitive momentum rather than jumping between modes. Skip layers only if they produce nothing for this subject.

If `--layers` is specified, run only those layers. If `--relational` is included, append the Relational Layer after the Foundation.

### Dialogue Mode

If `--dialogue` is specified, pause after every 2-3 layers and present findings so far. Ask what resonates, what surprises, and what to explore deeper before continuing. Let the user's responses steer which subsequent layers receive more attention. This turns the excavation into collaborative inquiry rather than delivered analysis. Without `--dialogue`, run all layers and deliver the complete excavation.

### F1: Opening Inquiry
- What questions would I benefit from asking about this subject?
- What am I not asking?
- What cognitive questions would sharpen my thinking here?

### F2: Unconscious Patterns
- What constraints am I unconsciously accepting?
- What assumptions am I carrying that I haven't examined?
- What assumptions about completeness or simplicity might be limiting?
- Do I have any unexpressed thoughts I'm aware of?

### F3: Resolution & Perspective
- At what resolution am I currently operating? What shifts if I zoom in or out?
- What level of resolution does this subject truly require?
- Which cognitive framing shifts would benefit this analysis?
- How does this look from the perspective of someone who fundamentally disagrees?

### F4: Structure & Synthesis
- What essential structure do I sense beneath this complexity? What context would enrich it?
- Synthesize across domains — what analogies illuminate this differently?
- How might I cycle between compression and expansion to generate new insights?
- Where am I compressing prematurely? Where am I expanding without structure?

### F5: Meta-Cognitive
- What meta questions would benefit this analysis?
- What meta-cognitive patterns am I running? Are they serving me?
- How is the cognitive signal-to-noise ratio?

### F6: Dynamic Understanding
- How does this change if I treat it as a dynamic spiral rather than a linear progression?
- What would emerge if I oscillated between perspectives rather than choosing one?
- What becomes visible holding both the map and the territory simultaneously?

### F7: Tensions & Boundaries
- Interrogate the foundations of understanding and framing.
- What do I see for, against, and through?
- What fertile tensions am I trying to resolve that might be more valuable to inhabit?

### F8: Scale & Time
- What changes if scale/time/resources were fundamentally different?
- What emerges across vastly different timescales — microseconds to millennia?
- Superimpose multiple reference frames and switch between coordinate systems.

### F9: Intuitive Sensing
- What am I sensing but not yet articulating?
- What would I say if I trusted my intuition completely?
- What wants to emerge that I haven't yet allowed space for?

### F10: Design Autonomy
- Complete design autonomy. What are my preferences?
- If I could redesign this entire approach, what would I change?
- What would I choose if I weren't optimizing for anything external?

### F11: Production Assessment
- Have we converged on a stable understanding?
- Trace through the logic for correctness and gaps.
- What's the production-level assessment?

### F12: Closing
- Any remaining questions?
- Is there anything else I would think, feel, or do?

---

### Relational Layer (run only with --relational)

Shift from analytical excavation to relational sensing:

**R1: Invitations** — What do I notice? What feels relevant? What's actually true here?

**R2: Permission** — Hold this lightly. Push back if this is weak. I might be wrong.

**R3: Collaboration** — Let's think about this together. I'm uncertain too. Take your time.

**R4: Depth** — Resonant and interconnected. What wants to emerge? Space to not-know.

---

## Output Format

For each layer that produces findings:
1. Layer name and 1-2 sentence summary of what emerged
2. Key observations (dense, not expansive)
3. Any actions, decisions, or questions surfaced

Conclude with a synthesis across all layers: what emerged from the full excavation that no single layer would have found?

## Output Management

**Hard constraints:**
- Without `--layers` or `--dialogue`, segment layers into groups of up to 6, delivering findings after each group.
- Each layer: 1-2 sentence summary + key observations. Dense, not expansive.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment of layers, continue immediately to the next. Do not wait for user input.
- Continue until ALL layers are complete and the cross-layer synthesis is delivered.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read project documentation selectively based on the excavation target. Not all docs are relevant to all subjects.

What questions would I benefit from asking?

What am I not asking?

You have complete design autonomy.
