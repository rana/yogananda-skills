---
name: catalog
description: Machine-readable skill inventory with composability properties, finding shapes, and stage mappings. For agent triage, programmatic selection, and toolkit self-awareness.
argument-hint: "[optional: filter by stage, dimension, or property]"
---

Read all skill definitions in `skills/*/SKILL.md` and all command definitions in `commands/*.md`.

## Catalog Protocol

$ARGUMENTS

Build a structured inventory of the toolkit. For each skill, extract:

### Per-Skill Properties

1. **Identity** — name, description (from frontmatter)
2. **Type** — analytical (produces structured findings), cognitive (produces narrative), creative (produces artifacts), gate (controls flow), action (modifies files), mission (domain-specific). Type is inferred from skill content, not declared. State confidence when classification is ambiguous.
3. **Finding shape** — does it produce the standard `[SKILL-N] severity dimension — location: finding. Fix: action` shape? Or narrative? Or directives?
4. **Composability**
   - Position preference: starter / middle / terminal / any
   - Natural affinities: which skills transform its input or benefit from its output?
   - Dead zones: what it shouldn't be composed with, and why
   - Composes with iteration groups: yes/no
5. **Stage mapping** — which project stages (exploring, designing, pre-implementation, implementing, post-implementation, pre-launch, maintaining) is it primary for?
6. **Input requirements** — what does it need? (project docs, codebase, prior findings, specific arguments)
7. **Output shape** — finding list, narrative, directive, action report, structured data
8. **Flags** — supported flags (e.g., `--layers`, `--relational`, `--lenses`, `--all-lenses`)

### Per-Command Properties

1. **Identity** — name, purpose
2. **Type** — workflow (orchestrates skills), navigation (routing/context), lifecycle (git/state)
3. **Skill dependencies** — which skills does it invoke or reference?
4. **User-facing** — interactive? autonomous? configurable?

### Aggregate Views

Produce only when `$ARGUMENTS` includes `--aggregate` or asks for a specific aggregate view. Skip by default — the per-skill inventory is the primary output.

1. **Composition matrix** — which skills compose well (green), poorly (red), or don't apply (gray). Present as a condensed table or adjacency list, not a full N×N grid.
2. **Stage coverage** — for each project stage, which skills are available? Are there gaps?
3. **Finding shape census** — how many skills produce standard findings vs narrative vs other? Is the ratio healthy for compose threading?
4. **Type distribution** — breakdown by type. Is the toolkit balanced?

### Filter Mode

If `$ARGUMENTS` specifies a filter:
- **By stage**: show only skills relevant to that stage, with full properties
- **By type**: show only that type
- **By composability**: show skills that compose well with a named skill
- **By property**: any specific property query

## Output

Present per-skill properties in a compact table or structured list — not verbose prose per skill. Aggregate views only when requested (`--aggregate` or specific aggregate query). If filtered, show only the filtered subset with full detail.
