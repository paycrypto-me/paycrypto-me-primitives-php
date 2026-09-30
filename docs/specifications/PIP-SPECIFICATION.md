# PayCrypto.Me Improvement Proposal — PIP Specification

## Specification Baseline v0.1

> **Document role:** project-wide specification for identifying, proposing, carrying, and preserving material PayCrypto.Me change.
>
> **Canonical term:** **PIP — PayCrypto.Me Improvement Proposal**.
>
> **Status:** initial operational baseline. This specification is intentionally small and is expected to mature from real executor and reviewer evidence.
>
> **Scope:** this specification governs the PIP mechanism. It does not define the internal architecture of any PayCrypto.Me domain and does not replace a domain canonical.

---

# 0. How to use this specification

A PIP gives material PayCrypto.Me work a stable identity and a durable proposal record before material execution advances.

The mechanism exists so that a future engineer or agent can answer, without relying on chat or personal memory:

- what change was proposed;
- why the work exists;
- what scope it intends to affect;
- which requirements or defects motivated it;
- what decisions and open questions shaped it;
- which implementation/review artifacts belong to that work; and
- where its historical record can be recovered after the work is no longer active.

This specification deliberately does **not** prescribe the architecture of the work. When a PIP affects a governed domain, that domain's canonical remains authoritative for its architecture.

> **PIP identifies and carries the work. A Domain Canonical governs the architecture. Verification mechanisms evaluate results against the applicable authority.**

---

# 1. Canonical terminology

## PIP — PayCrypto.Me Improvement Proposal

A stable project work identity and proposal record for a **material proposed change** to PayCrypto.Me.

`Improvement` is intentionally broad. It is not limited to new features. A PIP may originate from a product requirement, domain requirement, defect/correctness finding, maintenance need, architectural need, or another admitted project need when the resulting work is material.

A PIP is not synonymous with a commit category such as `feat`, `fix`, `refactor`, or `chore`. Those labels may describe implementation changes; PIP applicability is determined by materiality and purpose.

## Material change

A change is material when executing it warrants a durable work identity because it can meaningfully affect behavior, architecture, contracts, dependencies, correctness, maintained project knowledge, or another governed project property.

Routine mechanical changes that do not materially affect such properties do not require a PIP merely for process completeness.

The exact materiality boundary is expected to mature from project evidence. When uncertain, the author should state why the work is or is not being treated as material rather than inventing bureaucracy by default.

---

# 2. Relationship to domain canonicals and verification

A PIP may affect one domain, several domains, or project-wide concerns. It does not gain architectural authority merely by existing.

```text
PayCrypto.Me need / defect / requirement
              |
              v
         PIP-NNNN
      work identity + proposal
              |
              v
      planning / execution
              |
              +------> applicable Domain Canonical(s)
              |             govern architecture
              |
              v
       produced artifact(s)
              |
              v
    applicable verification/review
```

A domain may define its own execution-time verification mechanism. For example, Primitives currently uses Counter-Proofs. This specification does **not** require Counter-Proofs, or any equivalent named mechanism, in other domains.

When a verification artifact refers to a PIP, the PIP identifies **which work** is being evaluated. The verification artifact identifies **which assessment** occurred.

---

# 3. When to create a PIP

Create a PIP before material execution when the proposed work represents a material PayCrypto.Me change arising from an admitted need.

Typical sources include:

- a new or changed product requirement;
- a domain requirement;
- a defect or correctness issue;
- a material maintenance or dependency change;
- an architectural change or correction;
- a material documentation change that changes maintained project knowledge or governing behavior.

Do not create a PIP merely because a change can be assigned a Conventional Commit label. Conversely, a `refactor`, maintenance task, or other non-feature label does not exempt material work from PIP identity.

A trivial typo, formatting-only change, or equivalent mechanical edit normally does not need a PIP unless it participates in a larger material work unit.

---

# 4. Identity

Every PIP has one stable identifier:

```text
PIP-NNNN
```

Examples:

```text
PIP-0001
PIP-0042
```

The identifier MUST NOT be reused for different work.

The allocation mechanism, registry mechanics, and any concurrency rules for assigning new numbers are **OPEN** in v0.1. Until a stronger mechanism is justified, a repository adopting PIPs must allocate an unused identifier deliberately and preserve that identity for the lifetime of the proposal and its history.

> **PIP identity answers what work is being attempted. It does not identify an individual implementation commit, review, or verification report.**

---

# 5. Active storage

Active PIPs use the plural project collection:

```text
docs/
└── pips/
    └── PIP-0042/
        └── PIP-0042.md
```

Material artifacts whose natural ownership is the PIP may live with it. Domain-specific protocols may define additional artifacts within the PIP directory.

For Primitives Counter-Proof reporting, for example:

```text
docs/
└── pips/
    └── PIP-0042/
        ├── PIP-0042.md
        ├── cp-executor-2027-01-01-145959.md
        ├── cp-reviewer-2027-01-01-151203.md
        ├── cp-executor-2027-01-01-163411.md
        └── cp-reviewer-2027-01-01-170022.md
```

The PIP identifier is not repeated in those report filenames because the containing directory already establishes the work identity and the report body records it explicitly.

---

# 6. PIP proposal record

`PIP-NNNN.md` is the durable proposal record for the work.

The first version SHOULD be created early enough to orient planning rather than retrospectively documenting an implementation that has already substantially advanced.

The proposal MUST contain enough information for a competent executor to understand why the work exists and what it is trying to change. At v0.1, the minimum record is:

```markdown
# PIP-NNNN — <concise title>

Status: <current status>

## Motivation
<admitted product/domain/correctness/maintenance/architectural need>

## Proposed change
<what is intended to change; do not pretend unresolved implementation is decided>

## Scope
<affected project/domain surface and explicit exclusions when useful>

## Governing references
<applicable canonical/specification/requirement references>

## Open questions
<material unresolved questions, or NONE>
```

Additional sections are allowed when the work needs them. Do not inflate every PIP into a design document when the change does not require one.

The proposal may evolve during planning and execution. Material changes in direction SHOULD be reflected in the PIP so the current proposal remains understandable from the repository rather than from actor memory.

---

# 7. Authorship and execution

A PIP may be authored by a human engineer or an authorized execution/planning agent participating in the project workflow.

Authorship does not grant architectural authority. The proposal must obey applicable project and domain authorities.

The roles of proposer, planner, executor, reviewer, or approver are not forced into one universal lifecycle by v0.1. Domain/project workflows may distinguish them where evidence justifies doing so.

> **Do not infer acceptance merely from authorship or implementation progress.**

---

# 8. Lifecycle — minimal v0.1 semantics

The complete PIP lifecycle is deliberately **OPEN** in v0.1. We do not yet have evidence for a large state machine.

This specification currently requires only these semantic distinctions:

- **active** — the PIP remains current work and lives under `docs/pips/`;
- **resolved/inactive** — the work no longer needs to remain in the active PIP workspace and may be archived after its relevant records are durably versioned;
- **archived** — the historical PIP record has been moved under the generic project archive structure.

A repository MAY record more precise status values inside `PIP-NNNN.md` as its workflow matures, but those values are not yet standardized by this specification.

The eventual acceptance/rejection/withdrawal/supersession semantics, if needed, must be derived from real project use rather than invented in advance.

---

# 9. Archiving

The generic archive root is:

```text
docs/
└── archives/
    └── pips/
        └── PIP-0042/
            └── ...
```

Archiving moves a PIP out of the active `docs/pips/` workspace. It does not erase or rewrite its history.

> **Archiving changes active-document placement, not historical truth.**

Before a PIP is archived, the proposal and material records required to reconstruct the relevant work history MUST be durably committed/versioned.

A typical transition is:

```text
docs/pips/PIP-0042/
          |
          | work resolved/inactive
          | relevant records durably versioned
          v
docs/archives/pips/PIP-0042/
```

`docs/archives/` is intentionally generic. Other project mechanisms may use their own subdirectories there in the future; this specification owns only `docs/archives/pips/` semantics.

Moving records to `docs/archives/pips/` improves active-workspace clarity. It is not a claim that moving files within the current repository snapshot reduces repository checkout size; version control remains responsible for historical versioning.

---

# 10. Historical integrity and provenance

PIP history must remain reconstructable without relying on personal or conversational memory.

Do not rewrite an issued historical assessment to make a later outcome appear to have been the original one. Corrective work produces later records according to the applicable verification/reporting protocol.

Prefer durable references for material implementation artifacts, reviews, specifications, and evidence.

A future reader should be able to reconstruct, when applicable:

```text
admitted need
    ↓
PIP identity and proposal
    ↓
applicable governing canonical/specification
    ↓
implementation artifact(s)
    ↓
review / verification artifact(s)
    ↓
corrections / reassessments
    ↓
resolved historical record
```

---

# 11. What a PIP is not

A PIP is not:

- a replacement for a Domain Canonical;
- automatic permission to change architecture;
- necessarily a complete implementation design;
- a synonym for a Git commit, branch, pull request, or issue;
- a requirement that every trivial repository edit pass through proposal bureaucracy;
- a Primitives-specific mechanism;
- a mandate that every domain adopt Counter-Proofs.

---

# 12. Deliberately open decisions

The following remain deliberately open in v0.1:

- exact materiality threshold at difficult boundaries;
- authoritative PIP number allocation mechanism;
- whether a project-wide PIP index/registry is required;
- complete lifecycle/status vocabulary;
- acceptance/rejection/withdrawal/supersession mechanics;
- required approval authority, if any, for different classes of work;
- cross-repository PIP representation;
- whether some PIPs need richer design/decision sections;
- automation around creation, validation, archival, or indexing.

These are not omissions to be silently filled by convention. They are implementation/process questions to be resolved from observed project evidence.

---

# 13. Initial operational convention

Until later evidence changes this specification:

1. identify material work with a stable `PIP-NNNN` before material execution advances;
2. create `docs/pips/PIP-NNNN/PIP-NNNN.md`;
3. record motivation, proposed change, scope, governing references, and open questions;
4. let applicable domain canonicals govern architecture;
5. keep material execution/review evidence durably referencable;
6. when the PIP becomes resolved/inactive and its relevant records are versioned, move its directory to `docs/archives/pips/PIP-NNNN/`;
7. do not rewrite historical reports to manufacture a cleaner past.

---

# 14. Revision record

## v0.1

Initial PIP specification materialized from the first real PayCrypto.Me implementation-entry workflow.

This revision establishes:

- `PIP` as **PayCrypto.Me Improvement Proposal**;
- PIP as a project-wide, not Primitives-owned, mechanism;
- material change rather than commit label as the applicability principle;
- stable `PIP-NNNN` work identity;
- `docs/pips/PIP-NNNN/` as active storage;
- `docs/archives/pips/PIP-NNNN/` as generic-archive placement for inactive historical PIPs;
- a deliberately small proposal template;
- separation between PIP work identity, Domain Canonical architectural authority, and verification artifacts;
- deliberate openness around lifecycle, allocation, approval, and automation until execution evidence justifies stronger rules.

> **v0.1 is the current source of truth for the PayCrypto.Me PIP mechanism.**
