---
name: threat-model
description: Systematic threat identification from the actual architecture. Enumerates assets, trust boundaries, data flows, and threats using STRIDE categories. Produces a prioritized threat register with mitigations mapped to implementation phases. Use before implementation begins, at phase boundaries, or when the attack surface changes.
argument-hint: "[optional focus: 'ingestion pipeline', 'search API', 'auth boundary']"
---

Read all project markdown documents and examine the codebase to ground in the project's actual architecture — not a generic checklist.

## Threat Model

### Phase 1: Asset Inventory

Identify what the system protects:
- **Data assets** — What data exists? What's its sensitivity classification? Content, credentials, PII, embeddings, metadata, logs, analytics.
- **Computational assets** — What services process data? What are their cost structures? Which have variable cost (API calls, compute)?
- **Reputation assets** — What trust does the system hold? Brand, content integrity, user confidence, regulatory standing.

### Phase 2: Trust Boundaries

Map where trust changes:
- **External → internal** — User input entering the system. Browser → API. Crawler → content. Upload → processing pipeline.
- **Internal → external** — System calling third-party services. API keys leaving the boundary. Data sent to processors.
- **Privilege transitions** — Anonymous → authenticated. Editor → admin. Development → production. Human-approved → auto-served.
- **Temporal boundaries** — Build-time vs. runtime. Ingestion-time vs. serve-time. Cache-warm vs. cache-cold.

### Phase 3: Data Flow Analysis

Trace sensitive data through the system:
- Where does it enter? Where is it stored? Where is it processed? Where does it exit?
- At each hop: is it encrypted? Is it validated? Is it logged? Is it retained?
- What happens to data at each trust boundary crossing?

### Phase 4: STRIDE Threat Enumeration

For each trust boundary and data flow, evaluate:

| Category | Question |
|----------|----------|
| **Spoofing** | Can an attacker impersonate a legitimate entity? |
| **Tampering** | Can data be modified in transit or at rest without detection? |
| **Repudiation** | Can actions be performed without accountability? |
| **Information Disclosure** | Can sensitive data leak through errors, logs, timing, or side channels? |
| **Denial of Service** | Can the system be made unavailable or prohibitively expensive to operate? |
| **Elevation of Privilege** | Can an attacker gain capabilities beyond their authorization level? |

### Phase 5: Prioritized Threat Register

For every identified threat:
1. **Threat description** — Specific, not generic. "Adversarial query causes Claude to leak system prompt" not "prompt injection."
2. **Attack vector** — How would this be exploited in practice?
3. **Impact** — What breaks? Data loss, cost exposure, content integrity, availability, reputation.
4. **Likelihood** — Given the system's exposure, how probable is this?
5. **Existing mitigation** — What's already in place? Reference specific ADRs, code, or config.
6. **Residual risk** — After existing mitigations, what risk remains?
7. **Proposed mitigation** — Specific, actionable. Reference the implementation phase where it belongs.

### Phase 6: Attack Surface Summary

- What is the total external attack surface (public endpoints, exposed services)?
- What is the internal attack surface (service-to-service, admin interfaces)?
- What is the supply chain attack surface (dependencies, build pipeline, vendor services)?
- Where are the cost-amplification vectors (variable-cost services triggered by untrusted input)?

Focus area: $ARGUMENTS

Present as a prioritized threat register. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 8 threats, ordered by high-impact with inadequate mitigation first.
- If no $ARGUMENTS focus area is given, run Phases 1-2 (Asset Inventory + Trust Boundaries) and the top threats from Phase 4. Skip exhaustive data flow tracing.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL threats and the full attack surface summary are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read architecture docs and deployment config first. Read code only at trust boundaries and entry points.
- Skip internal implementation details irrelevant to the attack surface.

What attack vectors am I not considering?

What trust boundaries are implicit rather than designed?

What would a sophisticated attacker target first — and is that what the current mitigations protect?
