# PayCrypto.Me Primitives --- Counter-Proof Report Protocol

## Companion to the Primitives Canonical Architecture Reference v1.6

> **Document role:** operational reporting protocol and reusable
> templates for Executor self-challenge and Independent Reviewer
> counter-verification.
>
> **Architectural authority:** this companion does not define Primitives
> architecture. The canonical defines the counter-proofs, their required
> properties, applicability, and Deep References.
>
> **History rule:** issued reports are immutable historical records. A
> later report may extend, challenge, correct, or re-evaluate prior
> results, but MUST NOT replace, rewrite, or erase an issued report.

------------------------------------------------------------------------

# 1. Purpose

This companion standardizes how actors record application of the
canonical Counter-Proof Control Surface while preserving enough
provenance to reconstruct the path from a future implementation back to
the work identity, exact artifact, actor, canonical version, evidence,
findings, corrections, and independent review that governed it.

The report is a provenance record, not a substitute for the evidence it
references.

> **No evidence by memory.**
>
> A material conclusion MUST NOT rely on an artifact, result, decision,
> or evidence that cannot be durably identified or recovered from its
> recorded reference.

------------------------------------------------------------------------

# 2. Work identity and storage

Material Primitives work evaluated by this protocol is identified through an originating Issue and its Issue-derived **PIP — PayCrypto.Me Improvement Proposal** before material execution advances. Follow the [PayCrypto.Me PIP Specification](../../specifications/paycrypto-pip-specification-v0.2.md) for identity, lifecycle and planning. An Execution Plan follows PIP approval and is optional when execution complexity does not justify a separate Plan. Each report identifies the PIP and exact assessed artifact; preserve traceability from Issue through PIP, any justified Plan, PRs and repository changes.

Recommended active physical grouping:

```text
docs/
└── pips/
    └── PIP00042/
        ├── PIP00042.md
        ├── cp-executor-2027-01-01-145959.md
        ├── cp-reviewer-2027-01-01-151203.md
        ├── cp-executor-2027-01-01-163411.md
        └── cp-reviewer-2027-01-01-170022.md
```

The `PIPxxxxx` identity is `PIP` plus the originating Issue number, left-padded to a minimum width of five digits. Do not allocate PIP numbers independently. The containing directory carries that identity, and each report records it as `Work: PIPxxxxx`; repeating the PIP identifier in report filenames is unnecessary.

When a PIP becomes inactive/resolved and satisfies the PIP Specification's archival requirements, its directory may move to:

```text
docs/archives/pips/PIP00042/
```

Archival placement is governed by the PIP Specification, not by this reporting protocol.

## 2.1 Filename convention

```text
cp-{role}-{YYYY-MM-DD-HHmmss}.md
```

Allowed `{role}` values:

```text
executor
reviewer
```

Examples:

```text
cp-executor-2027-01-01-145959.md
cp-reviewer-2027-01-01-151203.md
```

`CP` is the canonical abbreviation for **Counter-Proof**. The filename timestamp is human-readable and lexicographically sortable. The report header records the complete timestamp including timezone offset.

---

# 3. Actor identity

Every report identifies the responsible actor with one field:

``` text
Actor: <identity>
```

For an AI actor, use the agent/model name and version available to the
actor and, when useful for disambiguation, the provider. Do not invent
unavailable identity or version information.

Examples:

``` text
Actor: OpenAI GPT-5.6 Sol
Actor: Anthropic Claude Code / <available version>
Actor: <human name>
```

`Actor` answers **who** produced the report. `Role` answers **in which
capacity** the actor acted.

Exactly one actor template is used per report. Executor and Reviewer
roles MUST NOT be merged into one report.

------------------------------------------------------------------------

# 4. Coverage

A report declares exactly one coverage mode:

``` text
Coverage: FULL
```

or:

``` text
Coverage: PARTIAL
Counter-Proofs: CP-04, CP-06
```

**FULL** means every counter-proof is considered against the current
assessed scope of the identified PIP/artifact.

**PARTIAL** means only the explicitly identified counter-proofs are
being reassessed, plus any additional counter-proofs discovered by
impact assessment to be materially affected by the change.

> **PARTIAL is a coverage statement, not a compliance state.**

Counter-proofs outside a PARTIAL report's declared coverage are not
`N/A`. They are simply outside that report.

A first complete assessment of a candidate delivery SHOULD normally be
FULL. PARTIAL exists for bounded corrective or incremental reassessment
where prior results remain historically valid unless the new change
materially affects them.

## 4.1 Impact assessment for PARTIAL reports

Before relying on PARTIAL coverage, the actor MUST consider whether the
change materially affects any counter-proof outside the initially
intended set.

Record:

``` text
Impact on Previously Assessed Counter-Proofs: NONE IDENTIFIED
```

or:

``` text
Additional Impacted Counter-Proofs:
- CP-06
- CP-07
```

Any additionally impacted counter-proof becomes part of the report's
coverage.

------------------------------------------------------------------------

# 5. States

## 5.1 Executor states

``` text
PASS
N/A
UNRESOLVED
```

**PASS** --- the counter-proof is applicable and the executor concludes
the delivered decision satisfies its required property.

**N/A** --- the counter-proof is genuinely outside the assessed
decision. `Justification` is REQUIRED. `N/A` never removes the
underlying canonical invariant.

**UNRESOLVED** --- the counter-proof is applicable, but the executor
cannot conclusively satisfy or demonstrate it. `Justification` is
REQUIRED and should identify the material blocker/evidence gap.
UNRESOLVED is disclosure, not canonical compliance.

## 5.2 Independent Reviewer states

``` text
PASS
N/A
FAIL
```

**PASS** --- the reviewer independently concludes the assessed result
satisfies the counter-proof.

**N/A** --- the reviewer independently concludes the counter-proof is
genuinely outside the assessed decision. `Justification` is REQUIRED.

**FAIL** --- the reviewer finds that the assessed result violates or
fails to demonstrate an applicable counter-proof. `Finding` is REQUIRED.

The Reviewer MUST independently challenge executor PASS results and the
legitimacy of every executor-declared N/A. Executor states are evidence
of self-challenge, not conclusions inherited by the Reviewer.

## 5.3 PASS notes

`PASS` requires no justification.

Either actor MAY add a short `Note` only when it is materially useful to
future execution, review, audit, or understanding. A note should not
merely restate the counter-proof.

------------------------------------------------------------------------

# 6. Provenance and evidence

A report must make the assessed work recoverable without depending on
actor memory.

## 6.1 Exact subject

Prefer immutable references for the exact implementation/result being
evaluated.

Examples:

``` text
Artifact / Revision: Git commit <full SHA>
Related PR: <durable PR reference>
```

A branch name, `main`, `latest`, or another moving reference MUST NOT be
the only identity for material code evidence when an immutable revision
is available.

## 6.2 Evidence basis

`Evidence Examined` records recoverable material the actor relied upon,
such as specifications, official/reference vectors, tests, regression
cases, spikes, compatibility matrices, prior reports, or reference
implementations.

Do not paste large evidence bodies into the report merely to duplicate
them. Reference durable artifacts.

## 6.3 Produced artifacts

The Executor records material artifacts produced or submitted by the
work, for example:

``` text
Produced Artifacts:
- Git Commit: <full SHA>
- Pull Request: <reference>
- Tests: <path or durable reference>
- Spike: <path or durable reference>
- Compatibility Matrix: <path or durable reference>
```

The Reviewer records material review artifacts it produced beyond the
report itself, for example adversarial tests, reproductions, or
independent compatibility evidence.

The report itself is evidence that the counter-proof assessment
occurred; it does not eliminate the need to identify the exact subject
and material external evidence on which conclusions depend.

------------------------------------------------------------------------

# 7. Corrective cycles and immutable history

A failed or unresolved assessment never causes an older report to be
edited.

Example history:

``` text
Executor FULL
    |
Reviewer FULL
    |
CP-04 FAIL
    |
Executor PARTIAL [CP-04]
    |
Reviewer PARTIAL [CP-04]
    |
CP-04 PASS
```

Each arrow represents a new immutable report.

A corrective report does not need to repeat counter-proofs that remain
unaffected. It uses PARTIAL coverage and performs the required impact
assessment.

When a particular counter-proof is responding to a prior finding, a
durable reference to that prior finding MAY be recorded close to the
affected counter-proof rather than adding global parent/response
metadata to the report header.

Example:

``` text
Prior Finding:
- cp-reviewer-2026-09-28-171503.md#CP-04
```

Relations belong as close as practical to the fact they relate.

------------------------------------------------------------------------

# 8. Executor template

Copy this section into a new report file. Do not modify a previously
issued report.

``` markdown
# Counter-Proof Report

Work: PIPxxxxx
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

Work: PIPxxxxx
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

# 10. Audit reconstruction expectation

The accumulated records should make this path reconstructable without
relying on personal memory:

``` text
implementation / discovered defect
        |
        v
exact immutable artifact revision
        |
        v
PIP work identity
        |
        +--> executor counter-proof report(s)
        |       +--> evidence examined
        |       +--> produced artifacts
        |
        +--> independent reviewer report(s)
                +--> evidence examined
                +--> findings
                +--> review artifacts
        |
        v
canonical version governing the work
```

For a material historical conclusion, an auditor should be able to
answer:

-   what work introduced or changed the behavior;
-   which exact artifact revision was assessed;
-   which canonical version governed it;
-   which actor executed the self-challenge;
-   which actor independently reviewed it;
-   what recoverable evidence each actor used;
-   what findings occurred;
-   what corrective artifacts followed;
-   which later immutable report established the final reviewed state.

If any of those facts depends only on someone's memory, the provenance
chain is incomplete.


---

# 11. Protocol revision record

## v1.1

This revision aligns the reporting protocol with the project-wide PIP mechanism and Primitives Canonical v1.6.

Changes:

- `PIP — PayCrypto.Me Improvement Proposal` replaces the former provisional work identity;
- active work lives under `docs/pips/PIP-NNNN/`;
- historical inactive PIPs may live under `docs/archives/pips/PIP-NNNN/` according to the PIP Specification;
- Counter-Proof report filenames are shortened to `cp-{role}-{YYYY-MM-DD-HHmmss}.md`;
- the PIP identifier is carried by the containing directory and the report `Work:` field rather than repeated in every filename;
- `CP` is the canonical abbreviation for Counter-Proof;
- report immutability, FULL/PARTIAL semantics, actor separation, evidence/provenance rules, and corrective-cycle behavior remain unchanged.
