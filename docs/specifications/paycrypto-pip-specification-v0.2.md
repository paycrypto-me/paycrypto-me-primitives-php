# PayCrypto.Me Improvement Proposal --- PIP Specification

## Specification Baseline v0.2

> **Document role:** project-wide specification for identifying,
> proposing, approving, executing, tracing, and preserving material
> PayCrypto.Me change.
>
> **Canonical term:** **PIP --- PayCrypto.Me Improvement Proposal**.
>
> **Status:** operational pre-major baseline. v0.2 incorporates evidence
> from real executor use and is intended to be exercised before a stable
> v1.0 contract.
>
> **Scope:** this specification governs the PIP mechanism. It does not
> define the internal architecture of any PayCrypto.Me domain and does
> not replace a domain canonical.

------------------------------------------------------------------------

# 0. How to use this specification

A PIP gives material PayCrypto.Me work a stable identity and a durable
proposal record before material execution begins.

The mechanism exists so that a future engineer or agent can reconstruct,
without relying on chat, personal memory, or the original participants:

-   why the work exists;
-   what change was proposed;
-   what boundaries were approved;
-   which authorities governed the proposal;
-   how the approved proposal was executed when explicit planning was
    needed;
-   which repository changes realized the work;
-   which material evidence or verification artifacts belong to it; and
-   what happened to the proposal over time.

This specification deliberately does **not** prescribe the architecture
of the work. When a PIP affects a governed domain, that domain's
canonical remains authoritative for its architecture.

> **PIP identifies and carries the work. A Domain Canonical governs the
> architecture. Verification mechanisms evaluate results against the
> applicable authority.**

``` text
Issue
  │  identity + lifecycle + historical relationships
  ▼
PIP
  │  WHAT + WHY + BOUNDARIES
  │  Draft → Proposed → Approved
  │                    │
  │                    └── freezes
  ▼
Plan
  │  HOW + ORDER + EXECUTION
  │  exists only after approval, when justified
  │  evolves during execution
  ▼
PR(s)
  │  concrete implementation + review + diff
  ▼
Codebase
```

> **Issue tells us what happened to the proposal.**\
> **PIP tells us what was proposed and approved.**\
> **Plan tells us how the approved proposal is being realized.**\
> **Pull Request shows what the execution actually changed.**

------------------------------------------------------------------------

# 1. Canonical terminology

## 1.1 PIP --- PayCrypto.Me Improvement Proposal

A stable project work identity and durable proposal record for a
**material proposed change** to PayCrypto.Me.

`Improvement` is intentionally broad. It is not limited to new features.
A PIP may originate from a product requirement, domain requirement,
defect/correctness finding, maintenance need, architectural need, or
another admitted project need when the resulting work is material.

A PIP is not synonymous with a commit category such as `feat`, `fix`,
`refactor`, or `chore`. Those labels may describe implementation
changes; PIP applicability is determined by materiality and purpose.

## 1.2 Material change

A change is material when executing it warrants a durable work identity
because it can meaningfully affect behavior, architecture, contracts,
dependencies, correctness, maintained project knowledge, or another
governed project property.

Routine mechanical changes that do not materially affect such properties
do not require a PIP merely for process completeness.

The exact materiality boundary remains evidence-driven. When uncertain,
the author should state why the work is or is not being treated as
material rather than inventing bureaucracy by default.

## 1.3 Originating Issue

The repository Issue from which a PIP originates.

The originating Issue is the authoritative record of the PIP's
**identity, lifecycle, coordination, and historical relationships**. It
is not merely a number allocator.

Not every Issue is a PIP, but every PIP MUST originate from an Issue.

## 1.4 PIP proposal record

`PIPxxxxx.md` is the authoritative proposal artifact for the work.

While the PIP is `DRAFT`, the proposal record may evolve substantially.
Once the proposal is `APPROVED`, the approved proposal record is
immutable.

``` text
Originating Issue
├── identity
├── lifecycle
├── discussion / coordination
└── historical relationships

PIPxxxxx.md
├── WHAT
├── WHY
└── BOUNDARIES
```

Issue discussion does not replace the proposal artifact. Material
proposal changes discovered through discussion MUST be incorporated into
the PIP before approval.

## 1.5 Execution Plan

An optional, evolving execution record for realizing an **approved**
PIP.

> **PIP defines WHAT is proposed, WHY it should exist, and the
> BOUNDARIES of the proposed change.**
>
> **Plan defines HOW an accepted proposal will be executed, in what
> ORDER, and through which execution steps, milestones, deliverables,
> and verification activities.**

A Plan is not a competing proposal authority.

------------------------------------------------------------------------

# 2. Relationship to domain canonicals and verification

A PIP may affect one domain, several domains, or project-wide concerns.
It does not gain architectural authority merely by existing.

``` text
PayCrypto.Me need / defect / requirement
              │
              ▼
       originating Issue
              │
              ▼
             PIP
      work identity + proposal
              │
              ├──────> applicable Domain Canonical(s)
              │              govern architecture
              │
              ▼
           approval
              │
              ▼
       execution / Plan
              │
              ▼
       produced artifact(s)
              │
              ▼
    applicable verification/review
```

A domain may define its own execution-time verification mechanism. This
specification does **not** universalize any domain-specific mechanism.

When a verification artifact refers to a PIP, the PIP identifies **which
work** is being evaluated. The verification artifact identifies **which
assessment** occurred.

References inside a PIP SHOULD communicate their relationship to the
work. A Plan, research note, repository instruction, canonical,
specification, and verification protocol do not automatically carry the
same authority merely because they are referenced together.

------------------------------------------------------------------------

# 3. When to create a PIP

Create a PIP before material execution when the proposed work represents
a material PayCrypto.Me change arising from an admitted need.

Typical sources include:

-   a new or changed product requirement;
-   a domain requirement;
-   a defect or correctness issue;
-   a material maintenance or dependency change;
-   an architectural change or correction;
-   a material documentation change that changes maintained project
    knowledge or governing behavior.

Do not create a PIP merely because a change can be assigned a
Conventional Commit label. Conversely, a `refactor`, maintenance task,
or other non-feature label does not exempt material work from PIP
identity.

A trivial typo, formatting-only change, or equivalent mechanical edit
normally does not need a PIP unless it participates in a larger material
work unit.

> **Revising a PIP does not, by itself, justify another PIP.**

Researching, correcting, refining, challenging, or replanning a PIP
while it represents the same admitted need does not create another PIP.
A new PIP requires a distinct proposal with independently meaningful
work identity and therefore its own originating Issue.

------------------------------------------------------------------------

# 4. Identity and Issue origin

Every PIP MUST originate from an Issue in the repository that owns the
proposed work.

> **Not every Issue is a PIP, but every PIP MUST originate from an
> Issue.**

The PIP identifier is deterministically derived from the originating
Issue number. PIPs do not maintain an independent numeric sequence.

``` text
PIP + issue number left-padded to a minimum width of five decimal digits
```

Examples:

``` text
Issue #1      → PIP00001
Issue #27     → PIP00027
Issue #438    → PIP00438
Issue #1234   → PIP01234
Issue #12345  → PIP12345
Issue #100000 → PIP100000
```

Five digits is a **minimum width**, not a numeric limit.

Gaps are normal because not every Issue is a PIP. An executor MUST NOT
inspect existing PIPs and increment the highest identifier to allocate
another PIP.

Issue numbers are repository-local. When repository context is not
implicit, external references SHOULD identify the repository together
with the Issue, for example `paycrypto-me/example-repository#42`.

The concrete Issue label/type taxonomy remains outside this v0.2
baseline.

------------------------------------------------------------------------

# 5. Issue and proposal responsibilities

The originating Issue is the persistent lifecycle and traceability
anchor for the work.

It should contain enough initial context to admit, discuss, and
coordinate the proposed work, without becoming a duplicate of the
complete PIP proposal record.

``` text
ISSUE
Why are we considering this work?
Identity + lifecycle + discussion + historical relationships

PIP
What are we proposing?
Why?
Within what boundaries?

PLAN
How will the approved proposal be executed?
In what order?
What is the current execution strategy/state?

IMPLEMENTATION ARTIFACTS
What did execution actually change or produce?
```

The Issue may remain useful after the PIP workspace has been archived
because it preserves the repository-native identity and historical
relationships of the work.

Later relationships such as supersession SHOULD be recorded without
rewriting an already approved PIP merely to annotate later history.

------------------------------------------------------------------------

# 6. PIP proposal record

`PIPxxxxx.md` is the durable and authoritative proposal artifact.

A PIP starts as `DRAFT`. During Draft, it may be researched, corrected,
reorganized, expanded, narrowed, or materially revised while the
proposal is still being formed.

A proposal becomes `PROPOSED` when its authors consider it complete
enough for a decision:

> **No further proposal work is intentionally pending; the proposal is
> submitted for review.**

A typical record is:

``` markdown
# PIP00042 — <concise title>

Status: DRAFT | PROPOSED | APPROVED | REJECTED
Origin: <repository>#42

## Motivation
<why the material change is being considered>

## Proposed change
<what is intended to change>

## Scope
<affected surface, boundaries, and useful exclusions>

## Governing references
<applicable authorities>

## Open questions
<material unresolved questions when they exist>
```

These headings describe information that normally belongs in a proposal;
they are not justification for empty ceremonial sections. Additional
sections are allowed when the work genuinely needs them.

Do not inflate every PIP into a complete implementation design.
Unresolved implementation details need not be invented merely to make a
proposal appear complete.

Material review feedback may return a `PROPOSED` PIP to `DRAFT`.

------------------------------------------------------------------------

# 7. Lifecycle and approval

``` text
DRAFT
  │
  │ refine / research / correct
  ▼
PROPOSED
  │
  │ review requests material revision
  ├──────────────────────────────► DRAFT
  │
  ├──────────────────────────────► REJECTED
  │
  ▼
APPROVED
  │
  │ proposal freezes
  ▼
execution may begin
```

## 7.1 DRAFT

`DRAFT` means the proposal is still being formed. Proposal research,
feasibility investigation, alternatives, and evidence needed to form the
proposal may occur during Draft.

Material execution of the proposed change MUST NOT begin merely because
a Draft exists.

## 7.2 PROPOSED

`PROPOSED` means the authors consider the proposal ready for a decision.
Review may approve it, reject it, or return it to Draft for material
revision.

## 7.3 APPROVED

`APPROVED` means the WHAT, WHY, and BOUNDARIES of the proposal have been
accepted by the applicable approval process.

Approval does not mean that every implementation detail is already
known.

Once approved, the approved PIP proposal artifact MUST NOT be edited to
reflect later execution discoveries, progress, supersession, or
historical annotations.

The approval record SHOULD durably identify the exact repository
revision containing the approved proposal. Existing version-control
identity SHOULD be preferred over inventing redundant integrity
artifacts without a concrete need.

## 7.4 REJECTED

`REJECTED` means the submitted proposal was not accepted.

A rejected proposal remains historical evidence of what was considered.
Rejection is not the appropriate state for a proposal that was once
approved and was later replaced by another proposal.

## 7.5 Later replacement

If later work needs to replace or materially alter an approved proposal,
that need returns to the proposal mechanism through a distinct Issue/PIP
when it represents distinct material work.

The later proposal may state that it supersedes an earlier PIP. The
earlier approved PIP remains unchanged.

The originating Issue may carry later historical relationships such as
`superseded by` without mutating the frozen proposal artifact.

Approval authority and repository-specific mechanics for expressing
approval remain deliberately open in v0.2.

------------------------------------------------------------------------

# 8. Planning and execution

An Execution Plan MUST NOT precede approval of its PIP.

Before approval, research and feasibility work may exist when needed to
form the proposal, but that work is not the Execution Plan for an
unapproved change.

``` text
DRAFT / PROPOSED PIP
        │
        ├── proposal research       ✓
        ├── feasibility evidence    ✓
        ├── alternatives            ✓
        └── execution Plan          ✗

APPROVED PIP
        │
        └── execution Plan          ✓ when justified
```

A separate Plan is optional. Create or retain one only when execution
complexity materially benefits from separating execution strategy and
sequencing from the durable PIP proposal record.

> **The PIP is the stable contract of intent. The Plan is the evolving
> strategy for fulfilling that intent.**

A Plan may evolve during execution. It may contain, when useful,
milestones, sequencing, implementation strategy, deliverables, current
progress, verification activities, or execution discoveries.

The Plan MUST remain within the approved PIP's intent and boundaries.

If execution discovers that realizing the work requires a material
change to the approved WHAT, WHY, or BOUNDARIES, the Plan MUST NOT
silently redefine the PIP. The newly discovered need returns to
proposal-level consideration.

A pre-PIP plan that exists only because it predates adoption of this
specification may be preserved as historical input. Its existence does
not establish the future convention that Plans precede PIPs.

------------------------------------------------------------------------

# 9. PIP workspace and artifact discipline

Active PIPs use a work-owned directory:

``` text
docs/
└── pips/
    └── PIP00042/
        └── PIP00042.md
```

`PIP00042.md` is the center of the workspace. Additional artifacts are
allowed, but their existence must be justified by the work.

> **A PIP should preserve the minimum durable structure necessary to
> understand, execute, review, and reconstruct the proposed work ---
> without prescribing unnecessary artifacts or allowing documentation
> sprawl.**

An additional PIP artifact SHOULD exist only when separating it from the
main proposal record or an existing artifact provides a concrete benefit
to execution, verification, provenance, reproducibility, or
maintainability.

> **Do not create a separate artifact merely because the information has
> a different category.**

Before creating another artifact, an executor should be able to answer:

> **What distinct responsibility does this artifact have that cannot be
> represented more effectively in the existing PIP record or an already
> existing artifact?**

Prefer extending an existing artifact over creating another artifact
when both serve the same responsibility.

> **Artifact count is not a quality metric. Artifact necessity is.**

A legitimate complex workspace might therefore be:

``` text
PIP00042/
├── PIP00042.md
├── PLAN.md
├── provider-research.md
├── assessed-documentation.tar
├── SHA256SUMS
└── verification-report.md
```

but only when each artifact has a distinct and useful responsibility.

Checksums, snapshots, archives, audit-like reports, research documents,
and similar artifacts MUST NOT be created merely because they appear
rigorous. They should exist only when the work or an applicable protocol
gives them a concrete purpose.

Domain-specific protocols may require additional artifacts. This
specification allows such artifacts without making any domain-specific
evidence model universal.

------------------------------------------------------------------------

# 10. Traceability to implementation

Completed PIP work must preserve durable traceability to the repository
changes that realized it when implementation changes exist.

A PIP does not imply a one-to-one relationship with a Pull Request. One
PIP may require multiple PRs or, for some kinds of work, no runtime-code
PR at all.

``` text
"What changed because of PIP00052?"
                 │
                 ▼
              Issue #52
                 │
                 ▼
         implementation PR(s)
                 │
                 ▼
          commits / Git diff
                 │
                 ▼
              codebase
```

Git and repository-native Pull Request facilities SHOULD be used for
implementation provenance rather than reproducing diffs or commit
history inside PIP documents.

``` text
                    ┌───────────────┐
                    │     ISSUE     │
                    │ identity      │
                    │ lifecycle     │
                    │ history       │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │      PIP      │
                    │ WHAT          │
                    │ WHY           │
                    │ BOUNDARIES    │
                    └───────┬───────┘
                            │ APPROVED
                            │ freezes
                            ▼
                    ┌───────────────┐
                    │     PLAN      │
                    │ HOW           │
                    │ ORDER         │
                    │ EXECUTION     │
                    └───────┬───────┘
                            │ evolves
                            ▼
                    ┌───────────────┐
                    │    PR(s)      │
                    │ implementation│
                    │ review / diff │
                    └───────┬───────┘
                            │
                            ▼
                         CODEBASE
```

The originating Issue is the preferred durable navigation anchor among
these records. Concrete repository mechanics for automatically linking
Issues, Plans, PRs, commits, or verification records remain open until
operational evidence justifies stronger rules.

------------------------------------------------------------------------

# 11. Historical integrity, archiving, and provenance

PIP history must remain reconstructable without relying on personal or
conversational memory.

Do not rewrite an issued historical assessment to make a later outcome
appear to have been the original one. Corrective work produces later
records according to the applicable verification/reporting protocol.

Do not rewrite an approved PIP to make a later proposal, execution
outcome, or supersession appear to have been part of the original
approved intent.

``` text
admitted need
    ↓
originating Issue
    ↓
PIP identity and proposal
    ↓
applicable governing canonical/specification
    ↓
approval
    ↓
Plan / execution
    ↓
PR(s) / implementation artifact(s)
    ↓
review / verification artifact(s)
    ↓
corrections / later proposals
    ↓
resolved historical record
```

## 11.1 Archiving

The generic archive root remains:

``` text
docs/
└── archives/
    └── pips/
        └── PIP00042/
            └── ...
```

Archiving moves a PIP workspace out of the active `docs/pips/`
collection. It does not erase or rewrite its history.

> **Archiving changes active-document placement, not historical truth.**

Before a PIP workspace is archived, the proposal and material records
required to reconstruct the relevant work history MUST be durably
committed/versioned.

The originating Issue remains the persistent repository-native identity
and lifecycle anchor even when the filesystem location of the PIP
workspace changes.

`docs/archives/` is intentionally generic. This specification owns only
`docs/archives/pips/` semantics.

------------------------------------------------------------------------

# 12. Authorship, authority, and execution

A PIP may be authored by a human engineer or an authorized
execution/planning agent participating in the project workflow.

Authorship does not grant architectural authority. The proposal must
obey applicable project and domain authorities.

Do not infer acceptance merely from authorship, research activity,
implementation progress, or the existence of a PIP file.

The Issue owns lifecycle truth. The PIP proposal record owns proposal
truth. Applicable canonicals and specifications own their respective
governing rules. A Plan owns execution strategy, not proposal authority.
Pull Requests and Git history provide implementation provenance.

------------------------------------------------------------------------

# 13. What a PIP is not

A PIP is not:

-   a replacement for a Domain Canonical;
-   automatic permission to change architecture;
-   necessarily a complete implementation design;
-   an Execution Plan;
-   a synonym for a Git commit, branch, Pull Request, or Issue;
-   a requirement that every trivial repository edit pass through
    proposal bureaucracy;
-   a justification for creating documentation artifacts without
    distinct responsibility;
-   a Primitives-specific mechanism;
-   a mandate that every domain adopt the same verification protocol.

------------------------------------------------------------------------

# 14. Deliberately open decisions

The following remain deliberately open in v0.2:

-   exact materiality threshold at difficult boundaries;
-   required approval authority, if any, for different classes of work;
-   concrete repository representation of PIP lifecycle states (`DRAFT`,
    `PROPOSED`, `APPROVED`, `REJECTED`);
-   Issue label/type taxonomy and other classification conventions;
-   exact Issue body template;
-   exact approval-recording mechanism and how the approved repository
    revision is referenced;
-   withdrawal/abandonment semantics if real use demonstrates the need
    for them;
-   automation around Issue-to-PIP creation, validation, linking,
    archival, or indexing;
-   exact conventions for linking one PIP to multiple PRs or other
    implementation records;
-   migration treatment for historical PIPs created under the v0.1
    `PIP-NNNN` identity convention.

These are not omissions to be silently filled by agents. They remain
open because v0.2 should be exercised before a stable v1.0 contract
freezes mechanics that have not yet earned that stability.

------------------------------------------------------------------------

# 15. Operational convention v0.2

Until later evidence changes this specification:

1.  identify an admitted material need in its owning repository;
2.  create or use the Issue that originates that distinct proposal;
3.  derive the PIP identifier from the Issue number using `PIP` plus a
    minimum five-digit left-padded decimal number;
4.  create `docs/pips/PIPxxxxx/PIPxxxxx.md` in `DRAFT`;
5.  refine the proposal until its WHAT, WHY, and BOUNDARIES are ready
    for decision;
6.  move it to `PROPOSED` for review;
7.  if material revision is requested, return it to `DRAFT`; otherwise
    record rejection or approval through the applicable process;
8.  when approved, freeze the approved proposal artifact and durably
    identify the approved repository revision;
9.  create an Execution Plan only after approval and only when execution
    complexity justifies a separate Plan;
10. keep the Plan within the approved proposal boundaries and allow it
    to evolve during execution;
11. preserve durable traceability from the originating Issue to the
    repository changes that realize the work;
12. create additional artifacts only when they have a distinct justified
    responsibility or an applicable domain protocol requires them;
13. preserve material review/verification evidence without rewriting
    historical records;
14. archive inactive PIP workspaces only after relevant records are
    durably versioned.

------------------------------------------------------------------------

# 16. Revision record

## v0.2

Operational evolution derived from real executor and reviewer evidence.

This revision preserves the v0.1 principles of materiality,
domain-canonical authority, durable work identity, historical integrity,
proportional documentation, and domain-specific verification while
materially strengthening the PIP mechanism.

v0.2 establishes:

-   originating repository Issues as mandatory PIP origins;
-   deterministic Issue-derived PIP identifiers using `PIPxxxxx`
    minimum-five-digit formatting;
-   no independent PIP numeric sequence;
-   the originating Issue as authority for identity, lifecycle,
    coordination, and historical relationships;
-   `PIPxxxxx.md` as authority for the proposal itself;
-   `DRAFT`, `PROPOSED`, `APPROVED`, and `REJECTED` proposal semantics;
-   proposal mutability before approval and immutability after approval;
-   explicit separation of PIP and Execution Plan;
-   **PIP = WHAT + WHY + BOUNDARIES**;
-   **Plan = HOW + ORDER + EXECUTION**;
-   prohibition on an Execution Plan preceding PIP approval;
-   optional Plans for work whose execution complexity justifies them;
-   evolving Plans constrained by frozen approved PIP boundaries;
-   proposal-level reconsideration when execution would materially
    breach approved boundaries;
-   disciplined PIP workspaces based on artifact responsibility rather
    than artifact count;
-   durable traceability from Issue/PIP to PR(s), commits/diff, and
    realized codebase changes;
-   repository-native Git/PR provenance rather than duplicated
    implementation history in PIP documents;
-   archival semantics that preserve the Issue as persistent lifecycle
    and historical anchor;
-   deliberate openness around approval mechanics, lifecycle
    representation, Issue classification, automation, and historical
    migration until further operational evidence supports a stable v1.0.

## v0.1

Initial operational baseline. v0.1 established PIP as a project-wide
mechanism; material change as the applicability principle; stable work
identity; active and archived workspaces; a deliberately small proposal
record; separation from Domain Canonical authority and verification
artifacts; and deliberate openness around lifecycle, allocation,
approval, and automation pending execution evidence.

Several areas deliberately left open in v0.1 are resolved by v0.2 from
observed project use.

> **v0.2 is the current operational source of truth for the PayCrypto.Me
> PIP mechanism. It remains a pre-major baseline intended to earn v1.0
> through operational validation.**
