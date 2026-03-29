---
name: grade-audit
description: Detect LA drift in geometric algebra code. Scan for scalar-only returns, missing grade-2 components, and notation that hides structure. The code guard for GA discipline.
argument-hint: "[optional: specific module or file path]"
---

Read DESIGN.md and METHODS.md (Grade Fidelity Audit section).

## The Principle

"Any mathematical concept that fuses distinct geometric operations into a single symbol hides structure." Drift back to LA thinking manifests as: returning only grade-0, discarding grade-2, treating eigenvalues as numbers rather than (magnitude, angle) pairs.

## Audit Protocol

Scan code in Layer 2 modules (embedding/, navigate/) for five drift signatures:

1. **Scalar fusion** — Function returns `float` for a quantity that has grade-2 structure. Check every `-> float` return type in geometric code. Layer 1 (algebra/) is exempt: kernels correctly produce scalars.

2. **Grade-0 isolation** — Code accesses `.grade_0` without corresponding `.grade_2` access in the same function or calling context. The scalar without the bivector is information loss.

3. **Bare distance** — Distance or similarity computed as scalar without bivector available. Check for `cosine_distance()` or `geodesic_distance()` used where `geometric_product()` should be. Convenience functions are acceptable when grade-2 is genuinely irrelevant (e.g., threshold comparisons).

4. **Eigenvalue as number** — Eigenvalue used as magnitude only, without angle or plane interpretation. PCA eigenvalues are real (no angle), but eigenvector PAIRS define bivector planes. Check that smallest-eigenvalue search also considers smallest-bivector-plane.

5. **Matrix without grade** — Matrix constructed or consumed without grade interpretation. Distance matrices should have corresponding diversification matrices. Correlation matrices should note they are grade-0 projections.

Focus area: $ARGUMENTS

## Output

For each finding:
- **File:line** — where the drift occurs
- **Signature** — which of the 5 types
- **Current** — what the code does
- **GA-native** — what it should do
- **Severity** — cosmetic / structural / information loss

Summary: total findings, information-loss count, recommendation.

What LA thinking am I not detecting?

What grade structure is this code hiding?
