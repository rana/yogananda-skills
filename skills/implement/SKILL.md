---
name: implement
description: Design-to-code specification. Given a deliverable or FTR, produce a concrete implementation plan with file paths, function signatures, SQL migrations, config constants, and test specifications. The bridge from architecture to code.
argument-hint: "[deliverable number, FTR-NNN, or free-text feature description]"
---

Read all project markdown documents referenced by the target. Follow CLAUDE.md § Arc-gated reading to load only what the target requires.

## Implementation Specification

Target: $ARGUMENTS

### Phase 1: Gather Requirements

1. **Identify the target** — Parse the argument. If it's a deliverable number (e.g., "1a.2"), find it in ROADMAP.md. If it's an FTR identifier, locate the file in `features/`. If it's free-text, find the closest matching specification.
2. **Follow all references** — Read every FTR file and cross-reference the target depends on. Build the complete requirements picture.
3. **Extract constraints** — From PRINCIPLES.md and CLAUDE.md, identify which principles constrain this implementation (verbatim fidelity, DELTA compliance, performance budgets, accessibility, multilingual, etc.).
4. **Check prerequisites** — What must already exist for this implementation to proceed? Database tables, API routes, services, config values, credentials. Flag anything missing.

### Phase 2: Map to Code

5. **File inventory** — List every file that will be created or modified, with full paths per the project's code layout:
   - `/lib/services/` — Business logic (framework-agnostic TypeScript)
   - `/lib/config.ts` — Named constants (FTR-012)
   - `/app/api/v1/` — API routes
   - `/app/` — Pages and components
   - `/migrations/` — SQL migrations (dbmate)
   - `/terraform/` — Infrastructure changes
   - `/messages/` — Locale strings

6. **Function signatures** — For each service function, specify:
   - Name, parameters, return type
   - Which FTR governs its behavior
   - Error cases

7. **SQL migrations** — For any database changes:
   - Full CREATE TABLE / ALTER TABLE statements
   - Indexes (specify type: btree, GIN, HNSW)
   - Constraints and defaults
   - UUIDv7 primary keys per project convention

8. **Config constants** — Any tunable parameters per FTR-012:
   - Constant name, type, default value
   - Which FTR specifies the value
   - Where in `/lib/config.ts` it belongs

9. **API routes** — For any new endpoints per FTR-015:
   - HTTP method and path
   - Request/response shapes (following FTR-088 conventions)
   - Pagination strategy (cursor-based for lists)
   - Language parameter handling

### Phase 3: Specify Tests

10. **Test specifications** — For each file/function:
    - Unit tests (what to test, edge cases)
    - Integration tests (API route testing)
    - Which testing layer per FTR-081

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
| /lib/services/foo.ts | Create | ... | FTR-NNN |

### SQL Migrations
[Full SQL with comments]

### Config Constants
| Constant | Type | Default | Source |
|----------|------|---------|--------|
| FOO_LIMIT | number | 100 | FTR-NNN |

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

## Output

**Document reading strategy:**
- Follow CLAUDE.md § Arc-gated reading. Only load documents the target references.
- Read FTR files fully. Read FEATURES.md selectively based on cross-references.

What questions would I benefit from asking?

What am I not asking?

You have complete design autonomy.
