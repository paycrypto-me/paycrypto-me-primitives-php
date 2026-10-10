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
General Issue → Materiality Gate ┬─ NO  → ordinary work → result
                                 └─ YES → Issue Type: PIP → PIP proposal → decision
                                                  ├─ Rejected → Issue resolution
                                                  └─ Approved → optional Plan → PR(s) / result
                                                                            ↓
                                                                       Issue closed
                                                                            ↓
                                                               archival eligibility
```

**Governance MUST impose only the process necessary to preserve material decisions, reviewability, and durable traceability.** Additional roles, lifecycle states, records, metadata, or approval steps MUST NOT be introduced without a demonstrated distinct need.

`MUST`, `MUST NOT`, `SHOULD`, and `MAY` express normative strength. `SHOULD` permits a justified exception; `MAY` denotes an option, not a required step.

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

A formal PIP is created only after the Materiality Gate is crossed and the proposal is sufficiently formed for decision. Preliminary research, debate, and refinement belong on the Issue. No `Draft` state is required.

The active workspace is:

```text
docs/pips/PIP00042/
└── PIP00042.md
```

When the Materiality Gate justifies a formal PIP, the originating Issue MUST be assigned the native GitHub Issue Type `PIP` as part of formal proposal creation. This marks the Issue's governance role and exposes its `PIP Decision` field; it does not itself approve the proposal. Preliminary discussion and research MAY remain on an ordinary Issue before that transition. The PIP identifier still derives exclusively from the Issue number, never from the Issue Type.

### 3.1 Issue Types and work classification

The organization maintains **exactly two active native GitHub Issue Types** for this governance model:

- **`General`** — the default governance role for ordinary Issues, regardless of whether the work concerns a defect, enhancement, question, documentation, or another motivation.
- **`PIP`** — the governance role of an originating Issue that has been formally promoted after the Materiality Gate and has a reviewable PIP proposal. It does not signify approval or completion.

**Issue Type represents governance responsibility, not work classification.** Work nature and other descriptive characteristics belong to existing GitHub labels, independently of Issue Type. Applicable labels (for example, `bug`, `enhancement`, `documentation`, or `question`) SHOULD be applied when useful, ideally when the Issue is first classified. Labels are optional and multi-valued; they are not a prerequisite for opening an Issue or crossing the Materiality Gate. This specification does not mandate a fixed label catalog or require new labels. Existing descriptive labels, including `duplicate`, `invalid`, `wontfix`, `help wanted`, and `good first issue`, MAY continue to serve their distinct purposes.

A new Issue SHOULD start as **`General`**. Issue templates SHOULD select `General` by default where supported. An Issue created without a type SHOULD be treated as ordinary work until properly classified; absence of a type MUST NOT be interpreted as PIP status. Contributors SHOULD NOT select `PIP` at creation to bypass the Materiality Gate.

When the Materiality Gate is crossed **and a formal PIP proposal is created**, the originating Issue MUST transition from `General` to **`PIP`** on the **same Issue**. Promotion MUST NOT require relabeling or reclassifying its existing work nature. The Issue number, motivation, discussion, history, and applicable labels remain intact. The PIP identifier still derives solely from the Issue number. Preliminary investigation MAY remain on `General` before formal proposal creation.

**Only a maintainer-authorized promotion through the documented governance process is valid.** A contributor's ability to select `PIP` in GitHub does not confer decision authority or establish that the Materiality Gate was passed. GitHub's Issue Type selection is not itself an access-control or approval mechanism. An improperly selected `PIP` type MUST NOT be treated as sufficient evidence of a formal PIP; maintainers SHOULD correct the classification where appropriate. A rejected PIP remains type `PIP` for historical traceability and MUST NOT be automatically demoted to `General`.

Labels MUST NOT substitute for the `PIP` Issue Type, determine materiality, or constitute governance approval. Project fields and statuses MAY assist coordination but MUST NOT serve as an alternative promotion authority or duplicate the PIP decision. No new Project field, bot, or workflow is required solely to enforce the promotion convention.

A simple link to the formal proposal SHOULD be added to the originating Issue, without requiring labels, subissues, or rewriting the Issue body. The Issue SHOULD identify the escalation rationale sufficiently to make the decision path understandable.

A generic Issue template MAY guide contributors using **Motivation**, **Current Context**, **Expected Outcome**, and **Additional Information**. These prompts MUST NOT imply that every Issue requires a PIP, Plan, or proposed technical implementation.

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

The content MUST make the intended decision and its governing boundaries reviewable. `Open questions` MAY be omitted when none remain; unresolved material questions MUST be resolved before approval. The proposal MUST NOT contain mutable `Status` or other lifecycle fields mirroring GitHub.

The proposal MAY be revised during review **before** the decision. Once approved, its exact approved Git revision is frozen; later execution notes or Plans MUST NOT silently change its WHAT, WHY, or BOUNDARIES.

## 5. Decision and approval integrity

The originating GitHub Issue carries the organization-level, **single-select** Issue Field:

```text
PIP Decision
├── Approved
└── Rejected
```

The organization-level `PIP Decision` field MUST be configured for visibility on Issues of type `PIP` (GitHub Issue Fields → Pin to issues → `PIP`). It need not be pinned to ordinary Issue Types. The `PIP` Issue Type identifies a formal proposal awaiting or holding a decision; the field records its outcome. An empty field on a `PIP` Issue means **no recorded decision**, not approval. `General` Issues need neither the `PIP` type nor a decision value.

There are no `Draft`, `Proposed`, `In Progress`, `Completed`, or equivalent PIP decision values. GitHub Issue state, project status, labels, and other metadata retain independent meanings; **labels and project membership are not normative PIP evidence**. Approval does not imply implementation completion. A field being hidden or unavailable MUST NOT be interpreted as an approval; correct its configuration before relying on it.

At the present project scale, a maintainer with ordinary repository authority may record the decision. No PIP-specific committee, quorum, approver role, or separate permission system is required.

**Approval MUST be reconstructable from all of the following:**

1. `PIP Decision = Approved` on the originating Issue.
2. The **exact Git commit SHA** containing the approved proposal revision.
3. A durable link or reference to that approved revision on the originating Issue.
4. The approved proposal remaining immutable as the accepted decision record.

The Issue MUST make the exact approved commit SHA and a revision-pinned link to the proposal recoverable. A durable Issue comment or body reference MAY record the maintainer's explicit decision and the approved revision; when a comment is used, retain its immutable comment permalink as decision evidence. The decision record MUST distinguish the time of the actual approval from the date of the proposal's Git revision. Neither a Git commit nor a pre-existing plan proves that a maintainer approved it. Do not backdate approvals.

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

Issued historical records MUST NOT be rewritten, renamed, or cosmetically migrated merely to conform to a newer specification. Historical non-conformance is not documentation drift when the record faithfully reflects the rules under which it was created. Historical PIPs MAY be assigned the `PIP` Issue Type for present-day navigation without implying they originated under this specification. Any decision newly recorded for such a PIP MUST be an explicit present-day maintainer decision tied to a verifiable proposal revision, not a reconstruction or backdating of an unrecorded historical approval.

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

Automation MAY assist with deterministic operations: deriving identifiers, promoting an originating `General` Issue to `PIP` only when explicitly instructed by an authorized maintainer after the Materiality Gate and formal proposal creation, validating origin and workspace layout, checking recorded approval and approved SHA, verifying links, finding closed-Issue workspaces eligible for archival, and performing safe local archival.

Automation MUST NOT independently resolve ambiguous materiality, invent decision authority, approve or reject proposals, infer approval from incomplete evidence, or change the governed decision through execution artifacts. When required governance evidence cannot be verified, governed execution MUST fail closed.

> **Automate deterministic mechanics; do not delegate governance judgment to automation.**

## 11. Adoption and compatibility

This specification is a shared governance rule, not a Domain Canonical. Shared specifications and Canonicals belong to the appropriate governance authority; concrete PIPs, Plans, evidence, and execution records remain in the owning domain repository. A central governance repository, if used, MUST NOT become a dumping ground for domain PIP workspaces.

The v1.0 rules govern **new work under v1.0**. Existing historical PIPs, Plans, reports, evidence, and earlier specifications remain intact; no retrospective ID renumbering or documentation migration is required. Active repository-local templates and agent instructions SHOULD be checked for conflicts before use.

## 12. Normative quick check

For a new governed change, verify:

1. **Issue exists first**; Materiality Gate identifies the actual governed decision.
2. **New Issues default to `General`**; existing labels describe work nature independently of Issue Type. On authorized formal PIP creation, the same Issue is promoted to `PIP` without relabeling, changing identity, or losing history. The PIP ID derives from that Issue, and the Issue links to the proposal. Selecting `PIP` alone never establishes valid promotion or approval.
3. **Proposal states WHAT, WHY, BOUNDARIES** and references the applicable authority.
4. **`PIP Decision` is visible for type `PIP`; exact approved SHA, revision-pinned link, and `PIP Decision = Approved` exist before governed execution.**
5. **Plan, if any, begins after approval** and cannot redefine the approved proposal.
6. **Each merged PR preserves a valid governed state**; verification uses the applicable domain rules.
7. **Issue closure represents the actual disposition**, not an invented PIP completion status.
8. **Archive later, deliberately and atomically**, with a separate housekeeping commit and recoverable Git history.
9. **Do not create redundant governance artifacts** when GitHub, Git, CI, or an existing record already preserves the necessary evidence.

## Revision note

**v1.0** stabilizes the v0.4 Issue-first, materiality-based, Issue-derived, fail-closed decision model. It resolves completion and multi-PR semantics, separates completion from deliberate local archival, establishes project-root ignored `archives/` and post-execution housekeeping commits, and makes artifact economy an explicit agent-facing requirement. The organization-level `General`/`PIP` Issue Type model separates governance role from work classification through existing optional labels, makes promotion an authorized change on the same Issue without relabeling, and preserves type-specific visibility of `PIP Decision`, with explicit treatment of present-day decisions on historical PIPs. Earlier versions remain historical records rather than migration targets.
