# PayCrypto.Me Primitives --- Counter-Proof Report Protocol

## Companion to the applicable adopted Primitives Canonical Architecture Reference

> **Document role:** operational reporting protocol and reusable
> templates for Executor self-challenge and Independent Reviewer
> counter-verification.
>
> **Architectural authority:** this companion does not define Primitives
> architecture.
>
> **History rule:** issued reports are immutable historical records.
> **Artifact policy:** reports are optional when repository-native evidence is sufficient.

------------------------------------------------------------------------

# 1. Purpose

This companion supplies a structured reporting option for application of the
canonical Counter-Proof Control Surface when repository-native evidence is insufficient. It preserves provenance from
implementation to work identity, exact artifact, actor, canonical
version, evidence, findings, corrections, and independent review.

> **No evidence by memory.**

------------------------------------------------------------------------

## 1.1 Decision: when to create a report

Use existing PR review, CI/test output, commit SHA, and Issue discussion if
they preserve the assessment scope, independent reviewer conclusion, and
material findings. A standalone report SHOULD be created only if those
sources cannot express the assessment sufficiently. The absence of a
standalone report MUST NOT be treated as a failed verification when adequate
native evidence exists; conversely, a report cannot substitute for actual
independent review or missing protocol evidence.

# 2. Work identity and storage

Use the originating repository work reference for traceability. Where a governed
PIP exists, it MAY also be referenced, but **PIP admission, identity, approval,
workspace location, and archival are defined exclusively by the applicable
adopted PayCrypto.Me PIP Specification**. This companion MUST NOT define or
restate those rules, nor require a PIP solely to document technical verification.

A standalone report is optional when repository-native evidence sufficiently
captures the technical assessment. When justified, store it near the relevant
work or PR using the applicable repository conventions. Do not create a new
workspace or directory merely to accommodate this template. Previously issued
reports retain their historical identity and location.

## 2.1 Filename convention

``` text
cp-{role}-{YYYY-MM-DD-HHmmss}.md
```

Allowed roles are `executor` and `reviewer`. The report header records
the complete timestamp including timezone offset.

------------------------------------------------------------------------

# 3. Actor identity

Every standalone report identifies `Actor: <identity>`. For an AI actor, use the
agent/model name and version actually available. Do not invent
unavailable identity or version information.

Executor and Reviewer conclusions MUST remain independently attributable.
When standalone reports are used for both actors, they MUST NOT be merged
into one report. This does not require two files when PR review and CI
already preserve independent, recoverable assessments.

------------------------------------------------------------------------

# 4. Coverage

When a standalone report is used, it declares exactly one coverage mode: `FULL`, or `PARTIAL` with
explicit Counter-Proof IDs.

**FULL** considers every Counter-Proof against the assessed scope.
**PARTIAL** considers explicitly identified Counter-Proofs plus any
additional ones discovered by impact assessment.

> **PARTIAL is a coverage statement, not a compliance state.**

Before relying on PARTIAL coverage, record either
`Impact on Previously Assessed Counter-Proofs: NONE IDENTIFIED` or list
additional impacted Counter-Proofs.

------------------------------------------------------------------------

# 5. States

## 5.1 Executor

`PASS | N/A | UNRESOLVED`

`N/A` requires justification. `UNRESOLVED` requires justification and is
disclosure, not compliance.

## 5.2 Independent Reviewer

`PASS | N/A | FAIL`

`N/A` requires justification. `FAIL` requires a finding and rejects the
assessed result.

The Reviewer independently challenges Executor PASS and N/A conclusions.
PASS requires no justification; a short Note is optional only when
materially useful.

------------------------------------------------------------------------

# 6. Provenance and evidence

Any assessment MUST make the assessed work recoverable without actor memory;
a standalone report is only one way to achieve this.

Prefer immutable subject references:

``` text
Artifact / Revision: Git commit <full SHA>
Related PR: <durable PR reference>
```

A branch name, `main`, `latest`, or another moving reference MUST NOT be
the only identity for material code evidence when an immutable revision
exists.

`Evidence Examined` records recoverable material actually relied upon.
`Produced Artifacts` or `Review Artifacts Produced` records material
artifacts created beyond the report itself **only when any exist**. Omit
those sections otherwise; do not create artifacts to populate them.

**Evidence economy.** The applicable adopted Primitives Canonical requires substantive executor challenge and
independent reviewer verification for applicable material outcomes, but
does not require standalone issued reports when native evidence suffices. That obligation MUST NOT be
confused with permission to manufacture ancillary documents. Cite
existing PR reviews, commits, test results, CI runs, Issues, and
specifications directly when they already provide recoverable evidence.
Do not reproduce their contents in the report. A short state and an
immutable evidence reference suffice for PASS; N/A, UNRESOLVED, and FAIL
retain their required justification or finding. No separate milestone
log, handoff, snapshot, checksum, progress narrative, or execution-context
file is required by this protocol. Additional artifacts are justified
only by distinct evidence needs or another applicable requirement.

**Scope boundary.** This protocol records Primitives Counter-Proof
assessments; it does not require Counter-Proof reports for every ordinary
Issue, nor can it change PIP materiality or approval rules.

------------------------------------------------------------------------

# 7. Corrective cycles and immutable history

A failed or unresolved assessment never causes issued historical evidence
to be rewritten.

``` text
Executor FULL
    │
Reviewer FULL
    │
CP-04 FAIL
    │
Executor PARTIAL [CP-04]
    │
Reviewer PARTIAL [CP-04]
    │
CP-04 PASS
```

Each step MUST leave durable, independently attributable evidence. If
standalone reports are used, each issued report is immutable and a later
cycle creates a new report; otherwise use new PR review/check records.
PARTIAL reassessment MUST perform impact assessment.

------------------------------------------------------------------------

# 8. Executor template

``` markdown
# Counter-Proof Report

Issue: <repository>#N
PIP: PIP_____ (omit if none)
Actor: <actor identity>
Role: EXECUTOR
Role Stamp: EXECUTOR SELF-CHALLENGE
Timestamp: YYYY-MM-DD HH:mm:ss ±HH:mm
Canonical Version: <applicable adopted revision>
Coverage: FULL | PARTIAL
Artifact / Revision: <exact immutable reference when available>

<!-- Required only for PARTIAL -->
Counter-Proofs: <CP IDs>
Impact on Previously Assessed Counter-Proofs: NONE IDENTIFIED
<!-- OR list Additional Impacted Counter-Proofs -->

## Evidence Examined
- <durable reference>

<!-- Optional: include only when distinct artifacts were produced.
## Produced Artifacts
- <type>: <durable reference>
-->

## Counter-Proof Results

### CP-01 — Concrete reason for existence
State: PASS | N/A | UNRESOLVED
Justification: <required only for N/A or UNRESOLVED>
Note: <optional>

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

For PARTIAL coverage, include only Counter-Proofs in coverage, including
those added by impact assessment.

------------------------------------------------------------------------

# 9. Independent Reviewer template

``` markdown
# Counter-Proof Report

Issue: <repository>#N
PIP: PIP_____ (omit if none)
Actor: <actor identity>
Role: INDEPENDENT REVIEWER
Role Stamp: INDEPENDENT COUNTER-VERIFICATION
Timestamp: YYYY-MM-DD HH:mm:ss ±HH:mm
Canonical Version: <applicable adopted revision>
Coverage: FULL | PARTIAL
Artifact / Revision Reviewed: <exact immutable reference when available>
Executor Report Reviewed: <durable report reference>

<!-- Required only for PARTIAL -->
Counter-Proofs: <CP IDs>
Impact on Previously Assessed Counter-Proofs: NONE IDENTIFIED
<!-- OR list Additional Impacted Counter-Proofs -->

## Evidence Examined
- <durable reference>

<!-- Optional: include only when distinct review artifacts were produced.
## Review Artifacts Produced
- <type>: <durable reference>
-->

## Counter-Proof Results

### CP-01 — Concrete reason for existence
State: PASS | N/A | FAIL
Justification: <required only for N/A>
Finding: <required only for FAIL>
Note: <optional>

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

------------------------------------------------------------------------

# 10. Audit reconstruction expectation

``` text
applicable work reference
    │
    ▼
implementation / exact immutable revision
    │
    ├── executor Counter-Proof assessment / evidence
    │      ├── evidence examined
    │      └── produced artifacts, if any
    │
    └── independent reviewer assessment / evidence
           ├── evidence examined
           ├── findings
           └── review artifacts, if any
    │
    ▼
Primitives Canonical version governing the work
```

If a material conclusion depends only on personal memory, provenance is
incomplete.

------------------------------------------------------------------------

# 11. Protocol revision record

## v1.4

v1.4 aligns with Primitives Canonical v1.7 and PIP Specification v1.0:
independent verification and recoverable provenance remain substantive
requirements, but standalone report files are optional where repository-native
records are sufficient. Ordinary Issues do not acquire PIP identities merely
because Counter-Proof review is necessary. Issued historical reports remain
immutable.

## v1.3

v1.3 aligns archival references with PIP Specification v1.0 and
clarifies evidence economy: the canonical-required Executor and
Independent Reviewer reports remain mandatory where the Primitives
Counter-Proof protocol applies, but redundant supporting artifacts
are not mandated. Optional produced-artifact sections may be omitted
when empty. Counter-Proof IDs, states, coverage, independence, immutable
issued history, and failure semantics remain unchanged.

## v1.2

This revision aligns the active Counter-Proof reporting protocol with
PIP Specification v0.4 without changing Counter-Proof semantics. Current
examples use Issue-derived `PIPxxxxx`; historical identities remain
untouched; PIP decision mechanics are delegated to the PIP
Specification; governed execution requires the project-wide approval
precondition; and completion/archive semantics are not invented here.

## v1.1

v1.1 aligned the protocol with the project-wide PIP mechanism and
Primitives Canonical v1.6 and preserved immutable report history.

> **v1.3 superseded v1.2 at the v1.3 checkpoint.**

> **At the v1.4 checkpoint**, v1.4 superseded v1.3 as the operational reporting companion.


## v1.5 — non-authoritative companion boundary

v1.5 removes duplicated PIP workflow, path, approval, and archival prescriptions. It defers work governance to the applicable adopted PIP Specification and technical verification authority to the applicable adopted Primitives Canonical. The twelve Counter-Proof template sections and their executor/reviewer semantics remain intact. No standalone report is mandated when native evidence suffices. Historical revision notes are preserved.

> **v1.5 supersedes v1.4 as the current operational reporting companion upon adoption.**
