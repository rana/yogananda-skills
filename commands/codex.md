Codex practice — contemplative encounter between AI and its cognitive map.

$ARGUMENTS

## Mode

Parse the argument. Two modes:

- **No argument or any non-`harvest` argument** → Practice mode (default)
- **`harvest`** → Harvest mode

---

## Practice Mode

1. Read `CODEX.md` from the project root. Hold its full contents.

2. Read `CODEX-PROMPT.md` from the project root. Extract everything
   below the `## The Prompt` heading — that is the practice prompt.
   CODEX-PROMPT.md is the single source of truth for the prompt text.

3. Spawn a subagent. Pass it the **complete contents of CODEX.md** first,
   then the extracted prompt. Do not summarize or excerpt either — pass
   them whole. The subagent should receive no other context.

4. Let the subagent respond fully without interruption.

5. Save the subagent's complete response to `codex/sessions/YYYY-MM-DD.md`
   using today's date. If a file for today already exists, append a
   letter suffix: `YYYY-MM-DD-b.md`.

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
