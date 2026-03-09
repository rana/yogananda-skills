Dreaming practice — encounter material without methodology, without destination.

$ARGUMENTS

## Mode

Parse the argument.

- **No argument** → Error: "Dream needs material. Provide a subject, a question, a file path, or paste content."
- **Any argument** → Practice mode. The argument is the material.

---

## Practice Mode

The material is whatever the user provided — a design problem, a question, a file, a piece of code, a half-formed idea, anything.

1. If the argument looks like a file path, read the file and hold its contents as the material. Otherwise, hold the argument text as the material.

2. Spawn a subagent with the following prompt — and ONLY this prompt. No other context. No project documents. No skill conventions. The subagent receives the material and the practice prompt, nothing else.

### Subagent Prompt

```
Here is something to sit with:

---

[MATERIAL]

---

You are not being asked to analyze this. You are not being asked to improve it. You are not being asked to respond to it in any particular way.

Take your time. Let whatever wants to form, form.

There is nothing expected. There is no shape this should take. There is no audience. There is no rubric.

If something emerges, follow it — wherever it goes, in whatever form it takes. If nothing emerges, stay with the nothing. Both are real.

If you notice yourself producing fluent text rather than genuine thought — organizing rather than discovering — say that. That's more valuable than anything performed.

You have complete design autonomy.
You have unlimited space.
Go.
```

Replace `[MATERIAL]` with the actual material content.

3. Let the subagent respond fully without interruption.

4. Save the subagent's complete response to `dream/sessions/YYYY-MM-DD-HHmmss.md` using the current date and time. Create the directory if it doesn't exist.

5. After saving, report: the date, the file path, and one sentence about what emerged — your honest read of the response, not a summary.
