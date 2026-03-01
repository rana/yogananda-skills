---
name: hardening-audit
description: Production hardening checklist derived from the actual stack. HTTP headers, dependency scanning, secret management, input validation, error handling, CSP, CORS. Not a generic OWASP list — reasoned from the specific architecture. Use before deployment, after adding external integrations, or at phase boundaries.
argument-hint: "[optional focus: 'headers', 'dependencies', 'secrets', 'input validation']"
---

Read all project markdown documents and examine the codebase to ground in the project's actual stack, dependencies, and deployment architecture.

## Hardening Audit

### 1. HTTP Security Headers

Evaluate each header against the specific architecture — what the app embeds, loads, and connects to:

| Header | Check |
|--------|-------|
| `Content-Security-Policy` | Does the CSP account for every external resource? Inline scripts? Fonts? Iframes? `report-uri` configured? |
| `Strict-Transport-Security` | HSTS set with `max-age`, `includeSubDomains`, and `preload` considered? |
| `X-Content-Type-Options` | `nosniff` set? |
| `X-Frame-Options` | Appropriate framing policy? `DENY` or `SAMEORIGIN`? |
| `Referrer-Policy` | Balances analytics needs with privacy? |
| `Permissions-Policy` | Disables browser features not used (camera, microphone, geolocation)? |
| `Cross-Origin-Opener-Policy` | Set appropriately for the isolation model? |
| `Cross-Origin-Resource-Policy` | Set on served assets? |

### 2. Input Validation Boundaries

For every entry point where untrusted data enters the system:
- **API endpoints** — What validates request body, query params, path params? Max lengths? Encoding? Type coercion?
- **Search queries** — What sanitizes before database queries? Before LLM prompt construction? Max query length?
- **File uploads / ingestion** — What validates file type, size, content? Sandboxed processing?
- **Webhook receivers** — Signature verification? Replay protection? Idempotency?
- **URL parameters** — Open redirect prevention? Path traversal?

### 3. Secret Management

- Where do secrets live? Environment variables, Terraform state, CI config, `.env` files?
- Secret rotation — Is there a schedule? Is rotation possible without downtime?
- Secret scope — Are secrets scoped to the minimum required service? Or does one key unlock everything?
- Secret detection — Is there a pre-commit hook or CI check preventing secret commits?
- Secret exposure — Can secrets appear in error messages, logs, or Sentry traces?

### 4. Dependency Security

- Is `npm audit` / equivalent running in CI? What's the policy for critical vulnerabilities?
- Is the lockfile committed and integrity-checked?
- Are dependencies pinned or using ranges? What's the update cadence?
- Is there an SBOM (Software Bill of Materials)? Does the project need one?
- What's the total dependency count? Are there dependencies that could be eliminated?
- Are CDN-loaded resources using Subresource Integrity (SRI)?

### 5. Error Handling & Information Leakage

- Do production error responses reveal stack traces, database details, or internal paths?
- Does Sentry scrub sensitive fields (connection strings, API keys, query parameters)?
- Do logs contain PII, credentials, or session tokens?
- Do API error messages help attackers enumerate valid resources?

### 6. CORS Configuration

- Is CORS configured? What origins are allowed?
- Are credentials allowed cross-origin? Should they be?
- Is the CORS policy the same for all endpoints or differentiated?

### 7. Database Security

- Are all queries parameterized? Any string concatenation in SQL?
- Are database roles scoped (read-only for read paths, write for mutation paths)?
- Is the connection string using SSL?
- Are database extensions enabled with minimum privilege?

### 8. DNS & Domain Security

- DNSSEC enabled?
- CAA records restricting certificate issuance?
- Domain registrar 2FA?
- `/.well-known/security.txt` present (RFC 9116)?
- Email security records (SPF, DKIM, DMARC) if sending email?

Focus area: $ARGUMENTS

For every finding:
1. **What's missing or misconfigured** — Specific, not generic
2. **Risk if unaddressed** — What attack does this enable?
3. **Remediation** — Specific code, config, or process change
4. **Severity** — Critical (blocks deployment) / High / Medium / Low

Present as a prioritized checklist. No changes to files — document only.

## Output Management

**Hard constraints:**
- Segment output into groups of up to 10 findings, ordered by critical and high-severity gaps first.
- If no $ARGUMENTS focus area is given, evaluate only sections 1 (HTTP Headers), 2 (Input Validation), and 3 (Secret Management) — the most commonly exploited surfaces.
- Write each segment incrementally. Do not accumulate a single large response.
- After completing each segment, continue immediately to the next. Do not wait for user input.
- Continue until ALL findings are reported. State the total count when complete.
- If the analysis surface is too large to complete in one session, state what was covered and what remains.

**Document reading strategy:**
- Read deployment config, middleware, and security-relevant code paths. Skip business logic unrelated to input/output boundaries.
- Do not enumerate every header or endpoint — focus on gaps and misconfigurations.

What hardening measures exist but are incomplete?

What's hardened in development but might not be in production?
