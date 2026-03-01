---
name: launch-gate
description: Pre-launch production readiness gate. Comprehensive go/no-go checklist covering SLAs, monitoring, backups, load testing, security, accessibility, legal, rollback, and runbook completeness. Runs at any phase boundary — not just final launch. Use when asking "are we ready to ship this phase?"
argument-hint: "[optional: phase name or focus area]"
---

Read all project markdown documents and examine the codebase to ground in the project's actual state, deployment architecture, and phase criteria.

## Launch Gate Review

Evaluate readiness across every dimension. A single critical gap is a no-go.

### 1. Availability & SLA

- Is there an explicit availability target? (99.9%? 99.5%? "Best effort"?)
- What's the planned maintenance window policy?
- What's the expected response time for different endpoint classes?
- Are these targets documented and monitored?

### 2. Monitoring & Alerting

- Does every critical path have monitoring? (Search, read, API health, database, AI services)
- Are alerting thresholds set? Who gets paged?
- Is there a dashboard showing system health at a glance?
- Are synthetic monitors running from target geographic regions?
- Can you detect a degradation before users report it?

### 3. Backup & Recovery

- Are backups running? Verified? How recently was a restore tested?
- What's the Recovery Point Objective (RPO)? How much data can be lost?
- What's the Recovery Time Objective (RTO)? How long until the system is back?
- Is the backup stored in a different failure domain than the primary?

### 4. Rollback

- Can the last deployment be rolled back in under 5 minutes?
- Can a database migration be rolled back? Is there a down migration?
- What happens to data written between deploy and rollback?
- Has rollback been tested? (Not "we have a plan" — has someone actually done it?)

### 5. Load & Capacity

- What's the expected traffic? Peak concurrent users?
- Has the system been load-tested to at least 2x expected peak?
- What's the bottleneck? Database connections? API rate limits? Memory?
- What's the cost at 10x traffic? Is there a cost ceiling?

### 6. Security

- Has `/threat-model` been run for this phase?
- Has `/hardening-audit` been run?
- Are all secrets rotatable without downtime?
- Is dependency scanning running in CI?
- Are HTTP security headers configured?

### 7. Incident Response

- Does a runbook exist for the top 5 failure scenarios?
- Is there an on-call rotation or escalation path?
- Is there a status page or incident communication channel?
- Has the team done a tabletop exercise for a realistic failure?

### 8. Data Integrity

- Are content integrity checks in place? (Hashes, checksums, verification endpoints)
- Is there an audit trail for content changes?
- Can content be reconstructed from source if the database is lost?

### 9. Accessibility & Compliance

- Do all pages pass automated accessibility checks?
- Has manual accessibility testing been performed? (Screen reader, keyboard-only)
- Are legal pages in place? (Privacy policy, terms, cookie policy if applicable)
- Is the privacy implementation consistent with the stated policy?

### 10. Documentation & Operability

- Can a new developer set up the project from the README alone?
- Is the operational playbook current?
- Are environment variables documented?
- Is the deployment process documented and reproducible?

### 11. Cost Controls

- Are there budget alerts on variable-cost services?
- Is there a hard spending cap on the most expensive service?
- What happens when the cap is hit? Graceful degradation or outage?
- Is the cost trajectory documented and projected forward?

Focus area: $ARGUMENTS

For every dimension:
1. **Status** — Ready / Partially ready / Not ready / Not applicable
2. **Evidence** — What demonstrates readiness? (Not "we planned it" — what proves it works?)
3. **Gap** — If not ready, what's missing?
4. **Remediation** — Specific action to close the gap
5. **Severity** — No-go (blocks launch) / Degraded (launch with risk acknowledged) / Nice-to-have

Present as a go/no-go summary with the full checklist. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 10 findings, ordered by no-go items that block launch first.
- If no $ARGUMENTS focus area is given, evaluate only sections 1 (Availability), 4 (Rollback), 6 (Security), and 7 (Incident Response) — the launch-critical quartet.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL sections are reviewed and the go/no-go verdict is delivered. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read project documentation selectively. Start with deployment config, monitoring setup, and existing runbooks.
- Only examine codebase sections relevant to the focused area. Do not read the entire codebase.

What would break on day 2 that wouldn't break on day 1?

What's been tested in development but never in production conditions?
