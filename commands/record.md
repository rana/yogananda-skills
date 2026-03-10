Save cognitive output to the project's session archive with thread distillation.

Run after any skill or command produces output worth keeping. General-purpose
capture — the explicit version of what dream and codex do automatically.

$ARGUMENTS

## Process

1. **Locate the output.** Scan the conversation for the most recent
   substantial output — the last skill invocation's result, or the last
   analytical/creative block if no skill tag is obvious. If the argument
   names a specific skill or describes what to capture, use that as a hint.

2. **Infer frontmatter.** From conversation context, determine:
   - `skill`: which skill or command produced this (compose, crucible, invoke, gaps, etc.)
   - `chain`: if compose, the full chain spec
   - `focus`: subject matter (infer from the skill's arguments or the output content)
   - `threads`: leave empty for now — populated in step 5
   - `converged`: if a converge pass ran, its final verdict

   If any field is ambiguous, make your best inference and note it.

3. **Compress if needed.** If the raw output exceeds ~400 lines:
   - Preserve the full structure (section headers, key findings, verdicts)
   - Compress supporting detail (evidence lists, intermediate reasoning)
   - Keep all direct quotes and sharpest formulations verbatim
   - Mark compressed sections with `[compressed]`

   If under 400 lines, save verbatim.

4. **Save.** Write to `dream/sessions/YYYY-MM-DD-HHMMSS.md` in the project
   root (not the skill repo). Create `dream/sessions/` if it doesn't exist.
   Use the current timestamp. Frontmatter block at the top.

5. **Thread check.** Read `dream/INDEX.md` if it exists. For each active
   thread, assess: does this session's output touch it? If yes:
   - Add the thread name to the session's `threads` frontmatter
   - Update the thread file: add a new evidence entry with session date
     and 1-3 sentence summary of what this session contributes
   - If the session sharpens the thread's core question, update the
     "Current Sharpest Form" section

   If the output introduces a tension not captured by any existing thread,
   note it but do NOT create a new thread. Threads require convergence
   from 2+ independent sessions. Instead, tag the session with
   `threads: [candidate:tension-name]` so a future record pass can detect
   convergence.

   If `dream/INDEX.md` doesn't exist, skip thread check and note that
   the project doesn't have a thread archive yet.

6. **Update INDEX.md.** If any threads were updated, refresh the session
   count in the INDEX table. If a thread was resolved by this session's
   findings, move it to the Resolved section with a one-line resolution.

7. **Report.** State:
   - File path saved
   - Which threads were updated (if any)
   - Any candidate threads noted (if any)
   - One sentence: what this session's output contributes that wasn't
     in the archive before
