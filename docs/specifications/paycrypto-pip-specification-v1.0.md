# PayCrypto.Me Improvement Proposal — PIP Specification

**Version:** 1.0  
**Role:** Project-wide governance specification  
**Scope:** Material governed changes in PayCrypto.Me repositories  
**Authority boundary:** This specification governs the PIP mechanism; it does not define or replace architectural decisions owned by applicable Canonicals or other governed authorities.

## 1. Operating contract

> **Issue is the default. PIP is the governed exception.**  
> **Issue first. Materiality second. PIP third.**

A PIP is a **PayCrypto.Me Improvement Proposal**: a durable, reviewable proposal for a material governed change. The originating GitHub Issue remains the entry point, coordination record, and historical navigation anchor. An Issue may express a proposal, opportunity, need, defect, limitation, discovery, or other motivation; it need not describe a problem.

```text
Issue → Materiality Gate ┬─ NO  → ordinary work → result
                         └─ YES → PIP proposal → decision
                                                  ├─ Rejected → Issue resolution
                                                  └─ Approved → optional Plan → PR(s) / result
                                                                            ↓
                                                                       Issue closed
                                                                            ↓
                                                               archival eligibility
```

**Governance MUST impose only the process necessary to preserve material decisions, reviewability, and durable traceability.** Additional roles, lifecycle states, records, metadata, or approval steps MUST NOT be introduced without a demonstrated distinct need.

`MUST`, `MUST NOT`, `SHOULD`, and `MAY` express normative strength. `SHOULD` permits a justified exception; `MAY` denotes an option, not a required step.

## 1.1 Authority ownership and non-duplication

**This Specification is the sole project-wide authority for the PIP governance mechanism**: Issue-origin admission, the Materiality Gate, PIP identity and proposal, approval and its evidence, governed execution boundaries, completion semantics, PIP traceability, and archival. A Domain Canonical or subordinate protocol **MUST NOT restate, redefine, override, or add parallel mandatory PIP lifecycle, approval, identity, status, or archival rules**. It MUST refer to the **applicable adopted PIP Specification** instead. A short reference is sufficient; a Domain Canonical need not reproduce the PIP workflow to remain usable.

**Domain Canonicals retain exclusive authority over their own architectural decisions, invariants, security and protocol guarantees, applicability of technical verification, and acceptance criteria.** This Specification MUST NOT turn domain-specific verification methods, Counter-Proofs, reviewer semantics, or report templates into universal PIP requirements. A rigorous technical review may be necessary for ordinary Issue work; a PIP approval never substitutes for that review.

Operational companions MAY offer non-authoritative recording formats or tooling, but MUST NOT impose additional architectural or PIP-governance requirements. **Verification is an obligation when required by the owning authority; producing a separate Markdown report is not inherently one.** Existing durable Git/Issue/PR/review/CI evidence is sufficient when it demonstrably satisfies the applicable technical requirements.

A change in this Specification **MUST NOT automatically trigger revisions to Domain Canonicals** that merely reference it. Revise a domain authority only if its own owned decisions change, its text duplicates/conflicts with this Specification, or another substantive domain reason exists. Adoption of an applicable specification revision is distinct from changing a domain's architecture; version pinning belongs in an adoption record or repository configuration, not repeated in canonical prose.

## 2. The Materiality Gate

Before creating a PIP, answer:

> **Does resolving this Issue require creating, changing, superseding, or intentionally departing from an accepted decision owned by an applicable governed authority?**

A governed authority may be a Domain Canonical, the PayCrypto.Me Public Architecture Canonical, this specification, another applicable shared specification, or another explicitly authoritative project artifact. An Issue, Plan, discussion, research note, or PR does not acquire such authority merely by being referenced.

A PIP justification MUST identify the admitted need, the applicable authority, and the decision that materially requires change. If these cannot be identified, investigate on the Issue; do not create a speculative PIP.

> **If existing governed authority already permits the proposed resolution, a PIP MUST NOT be created merely to authorize execution.**

Importance, urgency, effort, complexity, risk, defect correction, documentation work, research, and multiple PRs do not independently cross the gate. Ordinary implementation or Plan adjustments within approved boundaries do not trigger another PIP.

## 3. Origin, identity, and discoverability

Every new PIP MUST originate from an already-existing Issue in the repository owning the proposed work. Its identifier MUST be derived from that Issue number, with no separate PIP sequence:

`PIP` + decimal Issue number, left-padded to **at least five digits**.

Examples: `#1 → PIP00001`; `#42 → PIP00042`; `#100000 → PIP100000`. Identifiers are intentionally sparse; missing numbers imply nothing.

A formal PIP MAY be created once the originating Issue identifies a material governed change and its intended WHAT, WHY, and BOUNDARIES can be expressed for architectural review. The Materiality Gate does not require preliminary research, formal debate, proof of feasibility, or execution design. Investigation and discussion MAY take place on the Issue as needed to establish materiality or clarify the proposal; they are not mandatory stages or separate evidence requirements. The Issue may evolve through discussion. No `Draft` PIP state is required; execution planning belongs after approval.

The active workspace is:

```text
docs/pips/PIP00042/
└── PIP00042.md
```

Upon creating the PIP, a simple link to its proposal SHOULD be added to the originating Issue, without requiring labels, subissues, extra fields, or rewriting the Issue body. The Issue SHOULD identify the escalation rationale sufficiently to make the decision path understandable.

A generic Issue template MAY guide contributors using **Motivation**, **Current Context**, **Expected Outcome**, and **Additional Information**. These sections are guidance, not mandatory content quotas; contributors MAY omit inapplicable or redundant sections. Issues SHOULD be clear, concise, and provide sufficient information for evaluation, with detail proportional to the request. They may gain context through ordinary discussion. These prompts MUST NOT imply that every Issue requires a PIP, Plan, or proposed technical implementation.

## 4. The proposal: WHAT, WHY, BOUNDARIES

The PIP proposal is the governed decision record, not an execution log:

> **PIP = WHAT + WHY + BOUNDARIES.**

Minimum structure:

```markdown
# PIP00042 — <concise title>

Origin: <repository>#42

## Motivation
## Materiality
## Proposed change
## Scope
## Governing references
## Open questions
```

The content MUST make the intended decision and its governing boundaries reviewable. The originating Issue's author need not supply an architectural solution; when a PIP is warranted, its proposal identifies the governed change without requiring an implementation Plan or proof of feasibility as a universal admission prerequisite. `Open questions` MAY be omitted when none remain; unresolved material questions MUST be resolved before approval. The proposal MUST NOT contain mutable `Status` or other lifecycle fields mirroring GitHub.

The proposal MAY be revised during review **before** the decision. Once approved, its exact approved Git revision is frozen; later execution notes or Plans MUST NOT silently change its WHAT, WHY, or BOUNDARIES.

## 5. Decision and approval integrity

The originating GitHub Issue carries the organization-level, **single-select** Issue Field:

```text
PIP Decision
├── Approved
└── Rejected
```

An empty field means **no recorded PIP decision** (or no PIP applies). There are no `Draft`, `Proposed`, `In Progress`, `Completed`, or equivalent PIP decision values. GitHub Issue state, labels, types, and other metadata retain independent meanings; **labels are not normative PIP evidence**.

At the present project scale, a maintainer with ordinary repository authority may record the decision. No PIP-specific committee, quorum, approver role, or separate permission system is required.

**Approval MUST be reconstructable from all of the following:**

1. `PIP Decision = Approved` on the originating Issue.
2. The **exact Git commit SHA** containing the approved proposal revision.
3. A durable link or reference to that approved revision on the originating Issue.
4. The approved proposal remaining immutable as the accepted decision record.

> **NO RECORDED APPROVAL, NO GOVERNED EXECUTION.** Missing, inaccessible, ambiguous, malformed, or contradictory evidence MUST NOT be interpreted as approval. A PIP file, apparent consensus, authorship, Plan, PR, or implementation activity is not approval.

A rejected PIP MUST NOT proceed as approved governed execution. Its outcome remains traceable through the Issue and Git history. Git revision identity is sufficient; do not create redundant approval manifests or checksums solely to restate it.

## 6. Plan, execution, and valid increments

An Execution Plan is **optional**, created only **after approval**, and justified only when sequencing or execution complexity warrants a separate record.

> **Plan = HOW + ORDER + EXECUTION.**

A Plan may evolve within the approved decision, but MUST NOT expand or redefine its WHAT, WHY, or BOUNDARIES. A newly discovered material departure returns to the Materiality Gate and applicable decision process; it cannot be authorized by quietly editing the Plan.

Implementation proceeds through ordinary repository mechanisms, including PRs, commits, reviews, tests, and applicable domain verification. One PIP may have one PR, several PRs, or no runtime-code PR. The number of PRs is not a governance metric.

**Prefer atomic realization and a single execution PR when practical.** Multiple PRs are appropriate when they provide concrete execution or review benefits. **Every merged increment MUST independently preserve a valid governed state**, even when the full PIP is not yet realized.

> **Partial realization MAY be incomplete; it MUST NOT leave the architecture in an invalid intermediate state.**

The originating Issue SHOULD link or otherwise make the relevant PRs and results discoverable. Existing GitHub/Git/CI evidence SHOULD be reused rather than transcribed into additional Markdown files.

## 7. Completion belongs to the Issue

`PIP Decision` answers whether a proposal was approved or rejected; it is **not** an execution-progress field. The PIP proposal is not a task to mark `Completed`.

The Issue remains open while relevant work continues and may be closed when that work has ended with a traceable result. Successful realization, rejection, abandonment, supersession, or another justified termination can all lead to Issue closure; closure alone MUST NOT be interpreted as successful implementation.

When execution uses multiple PRs, closing the Issue SHOULD reflect the overall disposition of the work rather than an arbitrary intermediate merge. Applicable reviews and verification remain required by their own authorities. No completion certificate, additional PIP state, or special closing report is mandated.

> **Issue closure ends the work; it does not amend the approved PIP decision.**

## 8. Artifact economy and evidence

**Governance MUST reduce the cognitive cost of understanding change, not manufacture documents to demonstrate activity.**

> **Artifact count is not a quality metric. Artifact necessity is.**

Before adding an artifact, ask: *What distinct, durable responsibility would be lost without it, and can an existing Issue, PIP, Plan, PR, review, commit, or CI record fulfill that responsibility?*

- A PIP proposal is required only after justified material escalation.
- A Plan is optional, not a default accompaniment to a PIP.
- Separate milestone notes, executor/reviewer narratives, snapshots, handoffs, checksums, execution-context files, or progress reports MUST NOT be created **merely to prove that an activity occurred** or to duplicate existing repository-native evidence.
- Additional artifacts MAY exist when they preserve distinct, necessary information or an applicable domain verification protocol requires them.
- Domain-specific Counter-Proof or other verification obligations are **not weakened or redefined** by this specification. Their evidence MAY be captured through an appropriate existing surface when that satisfies the applicable protocol.

**An agent MUST NOT interpret a long artifact checklist as a quality target.** Prefer one authoritative record per responsibility and navigation through links over duplicated histories.

## 9. History, supersession, and archival

Issued historical records MUST NOT be rewritten, renamed, or cosmetically migrated merely to conform to a newer specification. Historical non-conformance is not documentation drift when the record faithfully reflects the rules under which it was created.

A later material change to an approved decision requires its own Issue and, when the Materiality Gate is crossed, its own PIP. Supersession relationships SHOULD be discoverable through repository-native references, preferably originating Issues. The earlier approved revision remains immutable.

### 9.1 Archival eligibility and timing

**Closing the originating Issue makes its PIP workspace eligible for archival; it does not mandate immediate archival.** Archival is deliberate, eventual repository housekeeping, separate from completion and from PIP approval. It MAY occur individually or in batches, days or months later.

Archival MUST treat the **entire PIP workspace directory** as its atomic unit. It MUST NOT selectively discard files as part of the move. It removes the workspace from the current versioned tree while preserving historical recovery through Git.

The local destination is the project-root archive:

```text
project/
├── docs/pips/PIP00042/       # active, tracked
└── archives/                 # ignored locally
    └── pips/PIP00013/       # archived, untracked
```

The repository's `.gitignore` MUST include the root-anchored rule:

```gitignore
/archives/
```

An archival helper MUST verify that the historical workspace content to be removed is committed and recoverable, preserve the local workspace successfully **before** removing the tracked source, and MUST NOT silently overwrite an existing archive or discard uncommitted content. If these checks fail, archival MUST stop without destructive changes. An archival operation must leave a reviewable Git diff; its removal of the source from HEAD is recorded in a separate, small **housekeeping commit after execution**, not mixed into the implementation PR. A commit MAY archive multiple eligible PIPs.

The archive directory is a local convenience, **not a second authoritative history**. It is not distributed to other developers through Git; local copies MAY later be cleaned without modifying the repository. The Git history MUST remain recoverable: archival MUST NOT rewrite or destroy it.

A reference to the **approved commit revision** remains a durable way to recover the proposal after removal from HEAD. The originating Issue SHOULD also provide enough references (approved SHA, execution links, and, where useful, the archival commit) to reconstruct historical work without relying on a live `main/docs/pips/...` path. A housekeeping commit MUST NOT be interpreted as execution, amendment, or completion of the PIP.

## 10. Automation boundary

Automation MAY assist with deterministic operations: deriving identifiers, validating origin and workspace layout, checking recorded approval and approved SHA, verifying links, finding closed-Issue workspaces eligible for archival, and performing safe local archival.

Automation MUST NOT independently resolve ambiguous materiality, invent decision authority, approve or reject proposals, infer approval from incomplete evidence, or change the governed decision through execution artifacts. When required governance evidence cannot be verified, governed execution MUST fail closed.

> **Automate deterministic mechanics; do not delegate governance judgment to automation.**

## 11. Adoption and compatibility

This specification is a shared governance rule, not a Domain Canonical. Shared specifications and Canonicals belong to the appropriate governance authority; concrete PIPs, Plans, evidence, and execution records remain in the owning domain repository. A central governance repository, if used, MUST NOT become a dumping ground for domain PIP workspaces.

The v1.0 rules govern **new work under v1.0**. Existing historical PIPs, Plans, reports, evidence, and earlier specifications remain intact; no retrospective ID renumbering or documentation migration is required. Active repository-local templates and agent instructions SHOULD be checked for conflicts before use.

## 12. Normative quick check

For a new governed change, verify:

1. **Issue exists first**; Materiality Gate identifies the actual governed decision.
2. **PIP ID derives from that Issue**, and the Issue links to the formal proposal.
3. **Proposal states WHAT, WHY, BOUNDARIES** and references the applicable authority.
4. **Exact approved SHA and `PIP Decision = Approved` exist before governed execution.**
5. **Plan, if any, begins after approval** and cannot redefine the approved proposal.
6. **Each merged PR preserves a valid governed state**; verification uses the applicable domain rules.
7. **Issue closure represents the actual disposition**, not an invented PIP completion status.
8. **Archive later, deliberately and atomically**, with a separate housekeeping commit and recoverable Git history.
9. **Do not create redundant governance artifacts** when GitHub, Git, CI, or an existing record already preserves the necessary evidence.

## Revision note

**v1.0** additionally establishes explicit ownership and non-duplication between shared PIP governance, domain architectural authority, and subordinate operational companions. It stabilizes the v0.4 Issue-first, materiality-based, Issue-derived, fail-closed decision model. It resolves completion and multi-PR semantics, separates completion from deliberate local archival, establishes project-root ignored `archives/` and post-execution housekeeping commits, and makes artifact economy an explicit agent-facing requirement. Earlier versions remain historical records rather than migration targets.
