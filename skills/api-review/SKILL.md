---
name: api-review
description: API surface consistency and design review. Use when reviewing REST endpoints, data models, response shapes, naming conventions, or pagination patterns.
argument-hint: "[optional focus like 'REST endpoints' or 'data model']"
---

Read all project markdown documents to ground in the project's actual state.

## API & Data Model Review

Evaluate for consistency and idiom:

### API Surface
- REST endpoint naming: consistent, predictable, resource-oriented?
- Response shapes: envelope conventions followed? Pagination consistent?
- Error formats: uniform across all endpoints?
- Versioning: applied consistently?
- Field naming: camelCase/snake_case consistent? Abbreviations standardized?

### Data Model
- Table/column naming conventions consistent?
- Foreign key relationships complete and documented?
- Migration strategy clear?
- Index strategy specified for query patterns?

### Design Rationale
- Is the "why" explained, not just the "what"?
- Would a new developer understand the design choices from the docs alone?
- Are there design decisions that should be ADRs but aren't?

### Idiom
- Does the API follow established conventions for its domain?
- Are there modern (2026) patterns that would improve the design?
- Is the API discoverable? Self-documenting?

Focus area: $ARGUMENTS

For every finding:
1. The inconsistency or improvement
2. The specific location (endpoint, table, section)
3. The proposed fix

Present as an action list. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 10 findings, ordered by inconsistencies over style preferences.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

What questions would I benefit from asking?

What am I not asking?
