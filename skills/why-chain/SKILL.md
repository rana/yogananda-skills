---
name: why-chain
description: Root cause archaeology. Recursively ask "why?" about any code, pattern, or decision until you hit a fundamental constraint or an arbitrary choice. Surfaces hidden reasoning chains and reveals which decisions are load-bearing.
argument-hint: "[code, pattern, or decision to trace]"
---

Examine the codebase, git history, and project documents.

## Why-Chain Analysis

Target: $ARGUMENTS

Recursively trace the reasoning:

1. **Start with the target** — State the thing being questioned. What exists? What pattern? What decision?
2. **First why** — Why does this exist or work this way? Check code comments, commit messages, PR descriptions, ADRs, and project docs.
3. **Second why** — Why was that the reason? What constraint or goal drove it?
4. **Continue** — Keep asking why until you reach one of these bedrock types:
   - **Fundamental constraint** — Physics, math, protocol spec, regulatory requirement. Can't be changed.
   - **Deliberate tradeoff** — A conscious choice with documented reasoning. Could be changed but at a known cost.
   - **Historical accident** — "It was always this way" or "the original author chose it." No strong reason to keep.
   - **Inherited assumption** — Came from a framework, library, tutorial, or convention. May or may not still apply.
   - **Unknown** — Nobody knows why. The reasoning is lost.

For each chain:
1. The full chain from surface to root (keep it compact)
2. What type of bedrock it hits
3. Whether the chain is healthy (grounded in real constraints) or fragile (resting on accidents or lost reasoning)
4. If fragile: whether it matters enough to fix

Present chains as indented trees. Flag any chains that rest on unknown or accidental foundations — these are the highest-value findings.

## Output

Order by chains resting on unknown or accidental foundations first. State the total count when complete.

What questions would I benefit from asking?

What am I not asking?
