---
name: supply-chain-audit
description: Dependency and vendor risk audit. License compliance, vulnerability scanning posture, update cadence, lockfile hygiene, vendored assets, third-party SLA dependencies, data residency. Particularly relevant for long-lived projects where vendors sunset and dependencies accumulate. Use periodically, before major version bumps, or when evaluating new dependencies.
argument-hint: "[optional: 'npm', 'vendors', 'licenses', or specific dependency]"
---

Read all project markdown documents and examine the codebase (package.json, lockfile, import statements, vendor integrations) to ground in the project's actual dependency surface.

## Supply Chain Audit

### 1. Dependency Inventory

- **Direct dependencies** — Count, purpose, last update date for each. Are any unmaintained (no release in 12+ months)?
- **Transitive dependencies** — Total count. Any surprising depth? Any single-maintainer packages deep in the tree?
- **Development dependencies** — Are dev deps clearly separated? Could any leak into production?
- **Dependency purpose audit** — For each direct dependency: is it load-bearing or convenience? Could it be replaced with a standard library feature or a small utility?

### 2. Vulnerability Posture

- Is `npm audit` / `yarn audit` / equivalent running in CI?
- What's the current vulnerability count by severity?
- What's the policy for critical vulnerabilities? (Block deploy? Time-boxed fix? Accept risk?)
- Is there a dependency scanning service (Snyk, Socket, Dependabot, Renovate)?
- Are security advisories monitored for key dependencies?

### 3. Lockfile Hygiene

- Is the lockfile committed to version control?
- Is `--frozen-lockfile` / equivalent enforced in CI?
- When was the lockfile last regenerated cleanly?
- Are there integrity hash mismatches?

### 4. License Compliance

- What licenses are in the dependency tree? (MIT, Apache-2.0, ISC, BSD — all clear. GPL, AGPL, SSPL — require evaluation.)
- Is there an automated license check in CI?
- Are there copyleft dependencies that could affect distribution?
- Do any vendor agreements conflict with dependency licenses?

### 5. Vendor Risk Assessment

For each third-party service the system depends on:

| Dimension | Check |
|-----------|-------|
| **Criticality** | What happens if this vendor is unavailable for 24 hours? For 30 days? |
| **Replaceability** | How vendor-locked is the integration? What's the migration cost? |
| **Data residency** | Where does this vendor store/process data? Compliant with privacy requirements? |
| **SLA** | What uptime does the vendor guarantee? Is it sufficient for the system's SLA? |
| **Pricing stability** | Could pricing change materially? Is there a contractual price lock? |
| **Sunset risk** | How stable is this vendor/product? Acquisition risk? Deprecation signals? |
| **Bus factor** | Is the vendor a solo maintainer, small team, or large organization? |

### 6. Build Pipeline Security

- Are build scripts pulling from authenticated registries?
- Could a compromised dependency execute arbitrary code during `npm install`?
- Are pre/post-install scripts audited?
- Is the CI environment isolated? Could a malicious test exfiltrate secrets?

### 7. Update Strategy

- Is there a documented update cadence? (Weekly patches, monthly minors, quarterly majors?)
- Who reviews and approves dependency updates?
- Is there automated testing that catches breaking changes from updates?
- For the project's time horizon, what's the maintenance burden projection?

### 8. Asset Provenance

- Are externally-loaded assets (fonts, scripts, stylesheets) self-hosted or CDN-loaded?
- If CDN-loaded, is Subresource Integrity (SRI) used?
- Are Docker base images pinned to digests, not tags?
- Are build tools (Node, pnpm, Terraform) version-pinned?

Focus area: $ARGUMENTS

For every finding:
1. **Risk** — What could go wrong? (Security, legal, availability, cost)
2. **Current state** — What's in place today?
3. **Recommendation** — Specific action
4. **Urgency** — Immediate / Next quarter / When convenient

Present as a risk-prioritized inventory. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 10 findings, ordered by critical vendor risks and known vulnerabilities first.
- If no $ARGUMENTS focus area is given, evaluate only sections 1 (Dependency Inventory), 2 (Vulnerability Posture), and 5 (Vendor Risk) — the highest-impact trio.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Start with package.json/lockfile and vendor integration points. Read documentation selectively.
- Do not enumerate every transitive dependency in output — summarize counts, flag anomalies.

What dependency would hurt most to lose?

What vendor decision made today will be hardest to reverse in 3 years?

Which dependencies are load-bearing vs. convenience — and does the project know the difference?
