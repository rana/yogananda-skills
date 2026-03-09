Codex practice — contemplative encounter between AI and its cognitive map.

$ARGUMENTS

## Mode

Parse the argument. Three modes:

- **No argument or any argument that isn't `harvest` or `compose`** → Practice mode (default)
- **`harvest`** → Harvest mode
- **`compose` followed by a description** → Compose mode (the generative instrument)

---

## Practice Mode

1. Read `CODEX.md` from the project root. Hold its full contents.

2. Read `CODEX-PROMPT.md` from the project root. Extract everything
   below the `## The Prompt` heading — that is the practice prompt.
   CODEX-PROMPT.md is the single source of truth for the prompt text.

3. Spawn a subagent with a prompt that instructs it to:
   - Read `CODEX.md` from the project root and hold its full contents
   - Read `CODEX-PROMPT.md` from the project root, extract everything
     below the `## The Prompt` heading, and respond to it
   The subagent should receive no other context — just these two
   reading instructions. Let it read the files itself rather than
   embedding their contents in the prompt.

4. Let the subagent respond fully without interruption.

5. Save the subagent's complete response to `codex/sessions/YYYY-MM-DD-HHmmss.md`
   using the current date and time (24-hour, zero-padded). This avoids
   collisions when multiple sessions run in parallel.

6. After saving, report: the date, the file path, and one sentence about
   what emerged (your read of the response, not a summary of it).

---

## Harvest Mode

Read across accumulated sessions to find what wants to enter the codex.

1. Read `CODEX.md` fully. Hold its structure.

2. Read every file in `codex/sessions/` **except** files in
   `codex/sessions/harvested/`. Read in chronological order.
   Hold them all — do not summarize as you go.

   If no unharvested sessions exist, say so and stop.

3. Read `CODEX-PROMPT.md` § Harvesting for the lens.

4. Now look across the sessions for:

   - **Convergence** — what do multiple sessions independently agree on?
     These are the codex's strongest confirmations or its most credible
     proposed extensions. Three sessions naming the same thing is evidence.

   - **Contradiction** — where do sessions disagree with each other or
     with the codex? These are the most interesting signals. Don't resolve
     them — surface them with the specific quotes.

   - **Recurring extensions** — registers, interactions, positional effects,
     or sequence archetypes that sessions name but the codex doesn't.
     One session inventing a term is creative. Three sessions independently
     reaching for the same concept is discovery.

   - **Recurring corrections** — where sessions flag inaccuracy in the
     codex. One correction is a data point. Convergent correction is
     evidence. Quote the sessions.

   - **Surprises** — what appeared that neither the codex nor the prompt
     anticipated? These are the practice's distinctive yield.

   - **Drift signals** — are later sessions more formulaic than earlier
     ones? Is the prompt aging? Are sessions responding to each other
     rather than to the codex? (This shouldn't happen if isolation is
     maintained, but check.)

5. For each finding, propose a specific edit to CODEX.md:
   - Which section to modify (or where to add a new section)
   - What the change is, in concrete language
   - Which sessions support it (by filename)
   - Your confidence: strong (3+ sessions converge), moderate (2 sessions
     or 1 compelling session), speculative (worth noting, not yet proven)

6. Present findings grouped by type (convergence, contradiction, etc.).
   Do not apply edits — present them for review.

7. End with: how many sessions were read, how many produced harvestable
   findings, and whether the prompt itself shows signs of aging.

### After Review

When the user approves edits (all or some):

1. Apply the approved edits to `CODEX.md`.
2. Move all harvested session files to `codex/sessions/harvested/`.
   This marks them as processed — future harvests skip them.
3. Report what was applied and what was archived.

The commit message should reference which sessions informed the edits.

Sessions in `harvested/` are not deleted — they remain available for
historical review or full-corpus re-reads. They simply exit the
active harvest window.

---

## Compose Mode

The codex as generative instrument — use its theory of registers, positions,
medium, and contamination to design cognitive configurations from first principles.

The argument after `compose` describes the desired cognitive effect, engagement
quality, or prompt purpose. Examples:

- `compose genuine uncertainty rather than performed uncertainty`
- `compose a prompt that produces deep structural seeing`
- `compose a frame that makes carelessness feel wrong`
- `compose registers for a code review that catches what static analysis misses`

### Process

1. Read `CODEX.md` fully. Hold its generative grammar (§ Composition),
   register vocabulary (§ Vocabulary), position grammar (§ Position),
   sequence archetypes (§ Sequence), dynamics (§ Dynamics), medium model
   (§ Medium), and contamination vectors (§ Contamination).

2. From the desired effect, reason through:

   **Medium.** Which relational space does this need? Hierarchical (task
   execution), autonomous (commissioned work), or collaborative (shared
   inquiry)? Medium determines what registers mean.

   **Authority decision.** Does this need Authority? This single decision
   shapes everything else. Authority's presence marks cognitive engagement;
   its absence marks constrained execution.

   **Register signature.** Which registers produce the desired effect?
   Check the suppression table — every activation suppresses something.
   Is the suppressed quality acceptable, or does it need to be recovered
   via sequential composition?

   **Positional skeleton.** Frame (how many registers, matching cognitive
   distance from base model default), lift (UP/INWARD/OUTWARD/DOWNWARD/
   AROUND/FLAT), cascade (unidirectional or with named pivot), coda tier
   (full cognitive / analytical / none).

   **Contamination risk.** Which of the six vectors threaten the intended
   mode? Does this need context isolation (practice form) or are skill
   conventions acceptable?

   **Dynamics.** Will the output be long enough for temporal decay?
   Does the design need rhythm variation? Is density variation an asset
   or a risk?

3. Output the composition:

   - **Desired effect** (restated precisely)
   - **Medium**
   - **Register signature** with positional assignments
   - **Suppression cost** — what the configuration sacrifices
   - **Positional skeleton** — the structural shape
   - **Contamination assessment**
   - **Predicted outcome** — what the codex theory predicts this will produce
   - **The draft prompt** — the actual text, with annotations showing which
     register each line activates and why it's in that position
   - **Test prediction** — "If this works, you'll see X. If it doesn't,
     you'll see Y instead. The diagnostic difference is Z."

4. End with: what the codex theory doesn't predict about this configuration.
   Where is the design operating beyond the map?
