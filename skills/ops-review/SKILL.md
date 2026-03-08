---
name: ops-review
description: Operational readiness review covering deployment, costs, monitoring, incident response, and scaling. Use before launch, at phase boundaries, or when evaluating infrastructure decisions.
argument-hint: "[optional focus like 'costs' or 'deployment']"
---

Read all project markdown documents to ground in the project's actual state.

## Operational Readiness Review

1. **Deployment** — Is the deployment pipeline fully specified? Rollback strategy? Blue-green or side-by-side? Environment management?
2. **Costs** — Are operational costs estimated? Service-by-service breakdown? Cost alerts? Budget boundaries?
3. **Monitoring & Observability** — Structured logging? Metrics? Alerting thresholds? Dashboard cadence?
4. **Incident Response** — Runbook exists? Escalation path? On-call expectations?
5. **Scaling** — Load projections? Bottleneck identification? Horizontal vs vertical scaling decisions?
6. **Security** — Secrets management? Access control? Dependency audit cadence?
7. **Data** — Backup strategy? Retention policy? Migration path? Disaster recovery?
8. **Compliance** — Privacy requirements (GDPR, etc.)? Data residency? Audit trail?

Focus area: $ARGUMENTS

For every gap or recommendation:
1. What's missing or underspecified
2. Where it should be documented (file, section)
3. Priority (blocks launch vs. nice-to-have)

Present as an action list. No changes to files — document only.

## Output

- Order by launch-blocking gaps first. State the total count when complete.
- If no $ARGUMENTS focus area is given, evaluate only Deployment, Costs, and Monitoring — the operational core.

**Document reading strategy:**
- Read deployment config, infrastructure-as-code, and monitoring setup first. Skip application business logic.

What questions would I benefit from asking?

What am I not asking?
