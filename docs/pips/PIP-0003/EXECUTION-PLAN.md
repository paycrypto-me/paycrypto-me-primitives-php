# PIP-0003 — Historical Execution Plan

This document separates the implementation plan from the [PIP-0003 capability
record](PIP-0003.md). It recovers the delivery sequence and technical gates from
the [plan embedded in PIP-0003 at `247f1f1`](https://github.com/paycrypto-me/paycrypto-me-primitives-php/blob/247f1f11c484675bcc8f56aeb0a20c68edde4337/docs/pips/PIP-0003/PIP-0003.md).
That plan continued the earlier [first-capability plan at `83ccd557`](https://github.com/paycrypto-me/paycrypto-me-primitives-php/blob/83ccd5571843eed57726e140e493868f0f152b5f/docs/PLAN-FIRST-CAPABILITY.md).
These revisions remain the exact historical records; this file is an organized
reading of their execution content, not a new implementation strategy.

The plan was made before the PIP Specification v1.0 approval model. Neither
its recovery here nor the completed M01 draft establishes an Approved PIP
Decision, an approved proposal SHA, or current execution authorization. Work
within accepted architectural decisions can be coordinated through Issue #3;
any material departure must pass the current Materiality Gate.
The [retrospective Issue #3](https://github.com/paycrypto-me/paycrypto-me-primitives-php/issues/3)
coordinates the work. New work follows the [PIP Specification v1.0](../../specifications/paycrypto-pip-specification-v1.0.md),
the [Primitives Canonical v1.8](../../canonicals/primitives/paycrypto-primitives-canonical-architecture-reference-v1.8.md),
the [Public Architecture v1.1](../../canonicals/public-architecture/paycrypto-public-architecture-canonical-v1.1.md),
and the [Counter-Proof Protocol v1.5](../../protocols/primitives/COUNTER-PROOF-REPORT-v1.5.md)
within their respective authority boundaries. The PIP defines the capability's
WHAT, WHY, and BOUNDARIES; this plan records the historical HOW and ORDER.

## Delivery approach

The historical plan scoped a standalone, public-key-only Primitives operation
for P2PKH, P2SH-P2WPKH, and P2WPKH on Bitcoin mainnet and testnet. It proposed
one complete address branch first, then shared lower capabilities across all
three branches. Core, SDK, and Consumer implementation were outside the local
delivery. The [PIP](PIP-0003.md) states the durable capability boundary; the
[M01 contract draft](milestones/M01-CONTRACTS.md) holds the detailed R01–R12,
Q01–Q12, and O01–O07 working definitions. Neither source selects a PHP API or
production provider.

Feasibility, protocol validation, minimal semantic contracts, and isolated
adapter spikes precede production wiring. Research starts from delegated
operation requirements rather than a package shortlist. Public CKDpub is an
owned protocol composition over delegated HMAC-SHA512 and ECC operations; a
whole BIP32 package is not a prerequisite. Cryptographic algorithms, curve
mathematics, and standardized codecs stay delegated. Vendor types and failures
stay behind semantic adapters. Network variation remains validated data, and
provider choice is explicit with no silent fallback.

## Recorded progress and remaining sequence

The historical M00 planning baseline and [M01 handoff](milestones/M01.md) are
recorded. M01 delivered a contract draft and diagrams, without runtime
implementation or provider selection. Its [issued executor assessment](cp-executor-2026-10-06-210959.md)
left CP-07, CP-10, and CP-11 unresolved for the assessed draft; independent
review was pending. Later milestones in the historical plan have no recorded
delivery in this workspace. The next identified work was M02, subject to the
applicable authorities and decisions at the time work resumes.

| Work | Historical dependency and intended result |
|---|---|
| M02 — Protocol questions and candidates | Use the M01 O01–O07 questions to pin BIP32, SLIP-132, network and codec sources; resolve invalid-child/effective-path semantics, compatibility and limits; compare focused providers by required operation, runtime, license, security, footprint and actual dependency path. Candidate eligibility is distinct from selection. |
| M03 — ECC and public derivation | After relevant M02 decisions, exercise real semantic adapters and one unchanged CKDpub consuming composition; test public derivation, scalar bounds, zero, infinity, invalid intermediate children and exhaustion. Establish an independently implemented ECC reference and PHP 8.1/8.3 evidence. This is research qualification, not production delivery. |
| M04 — Codecs, key admission and definitions | After relevant M02 decisions, qualify hashing, conversion, Base58Check and SegWit codecs, strict extended-public-key admission, and validated data-only definitions. Key admission closure also depends on M03 key-validity evidence. Exercise negative inputs and policy/network compatibility. |
| M05 — Provider and contract selection | After qualification, jointly record selected provider versions, rejected alternatives, actual runtime/dependency requirements, semantic contracts, errors, wiring and first address branch. Requalify earlier evidence if the contract or dependency changes. Preliminary probes do not count as selection. |
| M06 — First address branch | Implement one complete public request-to-address path on both networks, with explicit admission, derivation, selected adapters, validated definitions, a local usage example and independently justified expected results. |
| M07 — Complete address policies | Add the remaining constructions and verify all six policy/network combinations, direct-composition parity, shared lower capabilities, failures and provider replacement. Bitcoin Cash remains a bounded reuse check, not an implementation target. |
| M08 — Assembled candidate verification | Run full capability tests and CI on the supported PHP runtimes, identify the exact source/dependency/definition revisions, and challenge all applicable Counter-Proofs against the assembled result. Executor evidence does not establish independent acceptance. |
| M09 — Independent verification and corrections | Obtain an independent challenge of the actual result and its applicable Counter-Proofs. Record findings and corrected revisions without rewriting issued evidence; unresolved or failed applicable properties prevent a compliance claim. |

M03 and M04 can overlap only where their M02 inputs are settled; M04 key-admission
closure still needs M03 validity evidence. One branch at M06 is an incomplete
capability, so any merged increment must independently preserve a valid
architectural state. The table describes the historical sequence, not a new
milestone status field or automatic assignment.

## Technical gates retained from the plan

- Keep BIP32 public derivation and SLIP-132 version/policy interpretation
  separate. Resolve exact-index versus advancing behavior, invalid children at
  every path level, requested versus effective paths, bounded retry and
  exhaustion from versioned protocol evidence. Do not inherit one provider's
  exceptions or reference-application policy as the contract.
- Qualify strict 78-byte extended-public-key admission, root metadata, public
  versions, compressed-key validity, path/depth/index limits, definitions,
  explicit network/policy compatibility, stable failure meanings and safe
  diagnostics. The M01 draft supplies the detailed candidate criteria and
  explicitly leaves O01–O07 open.
- The historical plan called for two suitable distinct libraries through real
  adapters at each library-backed boundary, using one semantic suite and
  unchanged consuming compositions. This was a **plan-level verification
  choice**, not a universal Canonical rule or a claim of cryptographic
  independence. A future use or revision of that choice must retain the
  Canonical's replaceability and independent-evidence requirements. Runtime
  facilities need conformance evidence without artificial duplicate wrappers.
- The historical slice excluded broad `bitwasp/bitcoin` from production on
  footprint grounds while retaining it as reference evidence. The separate
  focused `bitwasp/bech32` package remained an unselected candidate. The
  [provider research](../../research/public-address-provider-research.md),
  [delegation inventory](../../research/delegation-inventory.md), and
  [BitWasp investigation](../../reviews/bitwasp-public-derivation/README.md)
  preserve the observations, candidate limits and known reference defects.
- Verification covers official and independently justified vectors, admitted
  regressions, malformed inputs, leading-zero and checksum boundaries, zero
  tweak, scalar at or above order, infinity, invalid intermediate children,
  exhaustion, all six address combinations, adapter containment, local use,
  and appropriate differential checks. Distinguish shared dependencies from
  independent implementations; investigate disagreements rather than voting.
  The historical runtime targets were PHP 8.1 and 8.3, with actual extension
  and package requirements to be established by qualification.

The applicable Counter-Proof challenge and independent review remain substantive
requirements of the Primitives Canonical. Record their scope, exact revision,
evidence and findings through PR reviews, CI, commits or Issue discussion when
those surfaces suffice. The Counter-Proof Protocol provides standalone reports
when necessary; it does not require new handoffs, snapshots, checksums or report
files merely to show activity.

## Supporting records and provenance

The [M01 contract draft](milestones/M01-CONTRACTS.md), [handoff](milestones/M01.md),
and [diagram sources and exports](milestones/diagrams/README.md) preserve the
work actually completed. The [independent plan-alignment review](../../reviews/plan-first-capability-canonical-alignment.md)
assessed the earlier plan and research before the milestone package; it did not
review M01 or implementation. The [2026-10-03](cp-executor-2026-10-03-171445.md)
and [2026-10-04](cp-executor-2026-10-04-011735.md) executor reports assess
planning documents only. Original [execution context](EXECUTION-CONTEXT.md),
[report templates](COUNTER-PROOF-TEMPLATES.md), [handoff template](MILESTONE-HANDOFF-TEMPLATE.md),
[snapshots](snapshots/README.md), and checksum manifests remain unchanged as
historical package evidence. Their older procedural instructions are not the
current governing rules. References to `PIP-0003.md` as a plan in those records
mean the file at their assessed Git revisions, not the present capability
proposal. Consult those revisions and assessed hashes when reconstructing a
historical conclusion.
