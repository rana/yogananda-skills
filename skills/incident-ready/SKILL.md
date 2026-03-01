---
name: incident-ready
description: Incident response readiness evaluation. Assesses runbook coverage, escalation paths, severity classification, communication templates, rollback procedures, and post-incident review process. Use when transitioning from development to production, at phase boundaries, or after a real incident exposes gaps.
argument-hint: "[optional: 'runbooks', 'escalation', 'communication', or specific failure scenario]"
---

Read all project markdown documents and examine the codebase to ground in the project's actual operational state — who's on call, what monitoring exists, what procedures are documented.

## Incident Readiness Audit

### 1. Failure Scenario Coverage

For the specific system, identify the top failure scenarios and evaluate runbook coverage:

| Failure class | Examples | Covered? |
|--------------|----------|----------|
| **Service outage** | Primary database down, hosting provider outage, DNS failure | |
| **Data corruption** | Bad migration, ingestion error, cache poisoning | |
| **Cost runaway** | API abuse, unbounded LLM calls, storage explosion | |
| **Security incident** | Credential leak, unauthorized access, content tampering | |
| **Dependency failure** | Third-party API down, certificate expiry, rate limit hit | |
| **Performance degradation** | Slow queries, memory leak, cache miss storm | |
| **Content integrity** | Wrong text displayed, citations mismatched, search returning irrelevant results | |
| **Human error** | Deployed wrong branch, deleted production data, misconfigured environment | |

### 2. Severity Classification

Does the project have a severity framework? Evaluate or propose:

| Severity | Definition | Response time | Who responds |
|----------|-----------|---------------|-------------|
| **SEV-1** | System unavailable, data loss risk, security breach | Immediate | On-call + lead |
| **SEV-2** | Major feature degraded, significant user impact | Within 1 hour | On-call |
| **SEV-3** | Minor feature degraded, workaround exists | Within 1 business day | Assigned engineer |
| **SEV-4** | Cosmetic issue, no functional impact | Next sprint | Backlog |

### 3. Escalation Path

- Who is the first responder? Is this documented?
- What's the escalation chain? First responder → team lead → engineering manager → vendor support?
- Are vendor support contacts documented with account numbers and SLAs?
- What happens outside business hours?
- What happens when the primary on-call is unavailable?

### 4. Runbook Quality

For each documented runbook, evaluate:
- **Detection** — How is this failure detected? Alert? User report? Monitoring gap?
- **Diagnosis** — What commands or dashboards confirm the problem?
- **Remediation** — Step-by-step fix. Can someone unfamiliar with the system follow it?
- **Verification** — How do you confirm the fix worked?
- **Communication** — Who needs to be informed? Users? Stakeholders? Vendors?
- **Post-incident** — What data should be preserved for review?

### 5. Communication Templates

Are templates ready for:
- Internal incident notification (Slack, email)
- External status update (status page, user communication)
- Post-incident summary (what happened, impact, remediation, prevention)
- Vendor communication (support ticket with relevant diagnostics)

### 6. Recovery Procedures

- **Database restore** — Can you restore from backup? What's the procedure? Has it been tested?
- **Deployment rollback** — One-command rollback? Or multi-step?
- **Configuration rollback** — Can Terraform state be reverted? Environment variables restored?
- **Data reconciliation** — After a partial failure, how do you reconcile inconsistent state?

### 7. Post-Incident Review Process

- Is there a defined process for post-incident review?
- Who participates? Is it blameless?
- Where are findings documented?
- How are action items tracked to completion?
- Is there a pattern library of past incidents?

### 8. Operational Knowledge Distribution

- Bus factor — How many people can handle each failure scenario?
- Is operational knowledge documented or tribal?
- Can the on-call person resolve SEV-1 without calling someone else?
- Are vendor credentials and access shared securely (not in one person's head)?

Focus area: $ARGUMENTS

For every gap:
1. **What's missing** — Specific scenario or procedure
2. **Risk if unaddressed** — What happens when this failure occurs without a runbook?
3. **Proposed remediation** — Draft the runbook outline, escalation path, or template
4. **Priority** — Must-have before production / Should-have within 30 days / Nice-to-have

Present as a readiness assessment. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 10 findings, ordered by SEV-1 scenario gaps first.
- If no $ARGUMENTS focus area is given, evaluate only sections 1 (Failure Scenarios), 2 (Severity Classification), and 3 (Escalation Path) — the core triage chain.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read project documentation selectively. Start with README, deployment docs, and any existing runbooks.
- Only examine codebase sections relevant to the focused area (monitoring config, error handling, infrastructure-as-code).

What's the most likely first real incident — and is the team ready for it?

What operational knowledge exists only in someone's head?
