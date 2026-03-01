---
name: implement
description: Design-to-code specification. Given a deliverable, DES section, or ADR, produce a concrete implementation plan with file paths, function signatures, SQL migrations, config constants, and test specifications. The bridge from architecture to code.
argument-hint: "[deliverable number, DES-NNN, ADR-NNN, or free-text feature description]"
---

Read all project markdown documents referenced by the target. Follow CLAUDE.md § Arc-gated reading to load only what the target requires.

## Implementation Specification

Target: $ARGUMENTS

### Phase 1: Gather Requirements

1. **Identify the target** — Parse the argument. If it's a deliverable number (e.g., "1a.2"), find it in ROADMAP.md. If it's a DES/ADR identifier, locate it in the appropriate file. If it's free-text, find the closest matching specification.
2. **Follow all references** — Read every ADR, DES section, and cross-reference the target depends on. Build the complete requirements picture.
3. **Extract constraints** — From PRINCIPLES.md and CLAUDE.md, identify which principles constrain this implementation (verbatim fidelity, DELTA compliance, performance budgets, accessibility, multilingual, etc.).
4. **Check prerequisites** — What must already exist for this implementation to proceed? Database tables, API routes, services, config values, credentials. Flag anything missing.

### Phase 2: Map to Code

5. **File inventory** — List every file that will be created or modified, with full paths per the project's code layout:
   - `/lib/services/` — Business logic (framework-agnostic TypeScript)
   - `/lib/config.ts` — Named constants (ADR-123)
   - `/app/api/v1/` — API routes
   - `/app/` — Pages and components
   - `/migrations/` — SQL migrations (dbmate)
   - `/terraform/` — Infrastructure changes
   - `/messages/` — Locale strings

6. **Function signatures** — For each service function, specify:
   - Name, parameters, return type
   - Which ADR/DES governs its behavior
   - Error cases

7. **SQL migrations** — For any database changes:
   - Full CREATE TABLE / ALTER TABLE statements
   - Indexes (specify type: btree, GIN, HNSW)
   - Constraints and defaults
   - UUIDv7 primary keys per project convention

8. **Config constants** — Any tunable parameters per ADR-123:
   - Constant name, type, default value
   - Which DES/ADR specifies the value
   - Where in `/lib/config.ts` it belongs

9. **API routes** — For any new endpoints per DES-019:
   - HTTP method and path
   - Request/response shapes (following ADR-110 conventions)
   - Pagination strategy (cursor-based for lists)
   - Language parameter handling

### Phase 3: Specify Tests

10. **Test specifications** — For each file/function:
    - Unit tests (what to test, edge cases)
    - Integration tests (API route testing)
    - Which testing layer per ADR-094

### Phase 4: Flag Ambiguities

11. **Ambiguities** — Questions that must be answered before implementation:
    - Design decisions not yet made
    - Unclear specifications
    - Missing information
    - Choices that need human judgment

12. **Implementation order** — Sequence the work:
    - What to build first (dependencies)
    - What can be parallelized
    - Natural commit boundaries

## Output Format

```
## Implementation Spec: [target]

### Prerequisites
[What must exist before starting]

### Files
| File | Action | Purpose | Governing Ref |
|------|--------|---------|---------------|
| /lib/services/foo.ts | Create | ... | DES-NNN |

### SQL Migrations
[Full SQL with comments]

### Config Constants
| Constant | Type | Default | Source |
|----------|------|---------|--------|
| FOO_LIMIT | number | 100 | DES-NNN |

### API Routes
[Method, path, request/response shapes]

### Function Signatures
[TypeScript signatures with JSDoc]

### Test Specifications
[What to test per file]

### Ambiguities
[Questions requiring human input]

### Implementation Order
[Sequenced steps with commit boundaries]
```

## Output Management

**Hard constraints:**
- Segment output into groups: Prerequisites + Files first, then SQL + Config, then API + Functions, then Tests + Ambiguities + Order.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until the full specification is delivered.
- If the target is too large for one session, state what was covered and what remains.

**Document reading strategy:**
- Follow CLAUDE.md § Arc-gated reading. Only load documents the target references.
- Read DES/ADR sections fully. Read DESIGN.md selectively based on cross-references.

What questions would I benefit from asking?

What am I not asking?

You have complete design autonomy.
