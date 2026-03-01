---
name: verify
description: Post-implementation fidelity check. Compare code against its governing DES/ADR specification. Verify all requirements are satisfied, tests cover the spec, and recommend document status updates. Closes the implement→verify loop.
argument-hint: "[deliverable number, DES-NNN, ADR-NNN, or file path]"
---

Read the governing specification and examine the implementation code.

## Implementation Verification

Target: $ARGUMENTS

### Phase 1: Locate Specification and Code

1. **Find the spec** — If the argument is a DES/ADR identifier, read that section. If it's a deliverable number, find the ROADMAP.md deliverable and follow all ADR/DES references. If it's a file path, infer the governing spec from the file's purpose and location.
2. **Find the code** — Locate all implementation files. Use the project's code layout conventions to find services, API routes, migrations, config, and tests.

### Phase 2: Specification Compliance

For each requirement in the specification:

3. **Requirement tracing** — Does the code implement this requirement? Map each spec statement to a code location. Flag:
   - **Satisfied** — Code implements the requirement correctly.
   - **Partially satisfied** — Code exists but is incomplete or divergent.
   - **Missing** — No code addresses this requirement.
   - **Divergent** — Code does something different from what the spec says. (This may be correct — the spec may need updating.)

4. **Principle compliance** — Check against the governing principles:
   - Verbatim fidelity: No content generation, paraphrasing, or synthesis?
   - API conventions (DES-019): Correct response shapes, pagination, language parameter?
   - Named constants (ADR-123): Tunable values in `/lib/config.ts`, not inline?
   - Framework-agnostic services: `/lib/services/` has zero framework imports?
   - Multilingual foundation: `language` columns, `language` parameters?

5. **Data model compliance** — If the spec includes SQL:
   - Do migrations match the spec's schema?
   - UUIDv7 primary keys?
   - Correct indexes (type, columns)?
   - All constraints present?

### Phase 3: Test Coverage

6. **Test inventory** — What tests exist for this implementation?
7. **Coverage assessment** — Does each requirement have at least one test? Flag untested requirements.
8. **Edge case coverage** — Does the test suite cover error paths, boundary conditions, and the failure modes identified in the spec?

### Phase 4: Status Recommendations

9. **Document updates** — Based on verification results:
   - Should the DES/ADR status be updated to `Implemented — see [code path]`?
   - Does the code diverge from the spec in ways that should be reflected back? (Update spec, not code, when the divergence is an improvement.)
   - Are there findings that should become new ADRs, open questions, or PRO-NNN proposals?

## Output Format

```
## Verification: [target]

### Compliance Summary
| Requirement | Status | Code Location | Notes |
|-------------|--------|---------------|-------|

### Principle Compliance
[Pass/fail per applicable principle]

### Test Coverage
| Requirement | Test Exists? | Test Location | Gap? |
|-------------|-------------|---------------|------|

### Recommended Document Updates
[Specific edits to DES/ADR status fields, spec corrections, new open questions]

### Issues Found
[Prioritized list of discrepancies]
```

## Output Management

**Hard constraints:**
- Segment output: Compliance Summary first, then Principle Compliance, then Test Coverage, then Recommendations.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until the full verification is delivered.
- If the implementation is too large for one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
