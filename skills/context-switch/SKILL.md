---
name: context-switch
description: Rapid reorientation to a different area of the codebase. Delivers a 60-second briefing on a subsystem's current state, recent changes, key files, and known issues. Use when switching between tasks.
argument-hint: "[area, module, or subsystem name]"
---

## Context Switch Briefing

Target area: $ARGUMENTS

Quickly build a mental model:

1. **Locate** — Find the key files and directories for this area using code search, file patterns, and project docs.
2. **Recent changes** — Run `git log --oneline -15 -- {relevant paths}` to see what's changed recently.
3. **Current state** — Read the key files. What's the architecture? What patterns are used?
4. **Known issues** — Check for TODOs, FIXMEs, and HACK comments in the area. Check open issues if `gh` is available.
5. **Dependencies** — What does this area depend on? What depends on it?
6. **Tests** — Where are the tests? What's their state?

Present as a compact briefing:

```
## {Area Name}

### Key files
{3-7 most important files with one-line descriptions}

### Architecture
{2-3 sentences on how this area is structured}

### Recent activity
{What changed recently and why}

### Current issues
{TODOs, known bugs, open questions}

### Dependencies
{What this area talks to}
```

Optimize for speed of comprehension. This is a 60-second orientation, not a deep analysis.
