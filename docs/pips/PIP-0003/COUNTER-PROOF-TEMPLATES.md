# PIP-0003 — Counter-Proof report templates

These unchanged templates are extracted from Counter-Proof Report Protocol v1.1,
§§8–9, for execution without separately supplying that protocol. Use
[execution context §4](EXECUTION-CONTEXT.md#4-execution-records-and-assessment-semantics)
for role, state, coverage and history rules, and its §7 for all twelve CPs.
Use `Work: PIP-0003` and identify the milestone and exact assessed artifact.
Replace placeholders; never prefill PASS results. The governing protocol remains
authoritative if a conflict is discovered.

# 8. Executor template

Copy this section into a new report file. Do not modify a previously
issued report.

``` markdown
# Counter-Proof Report

Work: PIP-____
Actor: <actor identity>
Role: EXECUTOR
Role Stamp: EXECUTOR SELF-CHALLENGE
Timestamp: YYYY-MM-DD HH:mm:ss ±HH:mm
Canonical Version: v1.6
Coverage: FULL | PARTIAL
Artifact / Revision: <exact immutable reference when available>

<!-- Required only for PARTIAL -->
Counter-Proofs: <CP IDs>
Impact on Previously Assessed Counter-Proofs: NONE IDENTIFIED
<!-- OR list Additional Impacted Counter-Proofs -->

## Evidence Examined

- <durable reference>

## Produced Artifacts

- <type>: <durable reference>

## Counter-Proof Results

### CP-01 — Concrete reason for existence
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional; only when materially useful>

### CP-02 — Reuse and late divergence
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-03 — Data versus behavior
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-04 — Composition before capability expansion
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-05 — Ownership and delegation boundary
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-06 — Implementation-independent semantic boundary
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-07 — Replaceability, verification, and containment
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-08 — Primitives and higher-domain isolation
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-09 — Public-key-only security boundary
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-10 — Protocol semantic correctness
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-11 — Independent evidence and verification
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

### CP-12 — Scope and deliberate openness
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

## Executor Conclusion

Unresolved Counter-Proofs: NONE | <CP IDs>
Conclusion: READY FOR INDEPENDENT REVIEW | NOT CANONICAL-COMPLIANT / BLOCKED
```

For PARTIAL coverage, include only the counter-proofs declared in
coverage, including any added by impact assessment. Do not mark omitted
counter-proofs `N/A`.

------------------------------------------------------------------------

# 9. Independent Reviewer template

The Reviewer creates a separate report. Do not edit or append
conclusions to the Executor report.

``` markdown
# Counter-Proof Report

Work: PIP-____
Actor: <actor identity>
Role: INDEPENDENT REVIEWER
Role Stamp: INDEPENDENT COUNTER-VERIFICATION
Timestamp: YYYY-MM-DD HH:mm:ss ±HH:mm
Canonical Version: v1.6
Coverage: FULL | PARTIAL
Artifact / Revision Reviewed: <exact immutable reference when available>
Executor Report Reviewed: <durable report reference>

<!-- Required only for PARTIAL -->
Counter-Proofs: <CP IDs>
Impact on Previously Assessed Counter-Proofs: NONE IDENTIFIED
<!-- OR list Additional Impacted Counter-Proofs -->

## Evidence Examined

- <durable reference>

## Review Artifacts Produced

- <type>: <durable reference>
<!-- The report itself is implicit; list additional material artifacts here. -->

## Counter-Proof Results

### CP-01 — Concrete reason for existence
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional; only when materially useful>

### CP-02 — Reuse and late divergence
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-03 — Data versus behavior
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-04 — Composition before capability expansion
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-05 — Ownership and delegation boundary
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-06 — Implementation-independent semantic boundary
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-07 — Replaceability, verification, and containment
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-08 — Primitives and higher-domain isolation
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-09 — Public-key-only security boundary
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-10 — Protocol semantic correctness
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-11 — Independent evidence and verification
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

### CP-12 — Scope and deliberate openness
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

## Independent Review Conclusion

Failed Counter-Proofs: NONE | <CP IDs>
Conclusion: CANONICAL-COMPLIANT | RETURN TO EXECUTION
```

For PARTIAL coverage, include only the counter-proofs declared in
coverage, including any added by impact assessment. Do not mark omitted
counter-proofs `N/A`.

------------------------------------------------------------------------

