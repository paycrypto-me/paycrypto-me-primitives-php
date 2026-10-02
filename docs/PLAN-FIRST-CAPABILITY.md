# First Capability Execution Plan — Public Address Derivation

**Checkpoint: 2026-10-02. Status: first implementation phase; preliminary evidence
exists, production contracts and providers remain open.**

The [provider refresh](research/public-address-provider-research.md), tracked by
[PIP-0002](pips/PIP-0002/PIP-0002.md), adds pinned candidates and bounded executable
probes. Full provider qualification and joint selection remain pending.

This plan turns the current architecture into executable work for the first
Primitives capability. It is not a canonical, a dependency selection, or a frozen
PHP API. The documentation rewrite is tracked by
[PIP-0001](pips/PIP-0001/PIP-0001.md); that PIP does not implement the capability.
Create a separate implementation PIP before advancing material capability work.

## 1. Authority and reading path

Start at the [repository README](../README.md), then use these authorities:

| Reference | Responsibility in this plan |
|---|---|
| [Public Architecture v1.1](canonicals/public-architecture/paycrypto-public-architecture-canonical-v1.1.md) | Public scope, wallet-read-only boundary, domain relationships and independent public consumption of Primitives. |
| [Primitives canonical v1.6](canonicals/primitives/paycrypto-primitives-canonical-architecture-reference-v1.6.md) | Domain architecture, accepted and open decisions, capability composition, verification semantics and CP-01–CP-12. |
| [PIP Specification v0.1](specifications/PIP-SPECIFICATION.md) | Identity and durable proposal record for material work. |
| [Counter-Proof Report Protocol v1.1](protocols/primitives/COUNTER-PROOF-REPORT.md) | Executor and independent-review reports, exact artifact references, coverage and immutable corrective history. |
| [Repository instructions](../AGENTS.md) | English documentation and the explicit prohibition on local cryptographic algorithms and standardized encoders/decoders. |

For initial orientation, read Primitives §§0–0B, 2–15 and 31–34. During execution,
use §0B as the control surface and follow each applicable CP's Deep References
when a decision is uncertain. This plan supplies work and evidence gates; it does
not redefine the CPs or require repeated full-canonical reading for every edit.

### Reconciliation with the current baseline

The previous plan cited retired paths and claimed a dated amendment of v1.4
settled codec ownership, two-provider qualification and standalone delivery.
That claim must not be carried forward as authority over v1.6.

Three distinctions matter for execution:

- **Delegation:** v1.6 §§13.3 and 32 retain open codec-ownership wording, and
  §34 step 2 mentions investigating Base58 implementation techniques. Apply
  §§10A and 31.1 together with the explicit repository instruction: research
  runtime/library implementations, including GMP-free options; do not implement
  an algorithm or standardized codec locally. Provider choice remains open.
  This plan discloses the residual wording; it does not amend the canonical.
- **BIP32 composition:** §§10A and 12 explicitly allow Primitives-owned CKDpub
  semantics composed from delegated HMAC-SHA512 and public-key tweak operations.
  A complete external BIP32 provider is an option to qualify, not a prerequisite.
  The old blanket wording against handwritten CKDpub must not prohibit owned
  protocol orchestration. Cryptographic mathematics and codec machinery remain
  delegated, and reference internals are not an implementation blueprint.
- **Delivery boundary:** §34's contextual vertical-slice example mentions higher
  domains. This repository delivers and tests the Primitives portion locally,
  consistent with Public Architecture §§10–11 and Primitives §§1 and 24–27.
  Core/SDK/Consumer implementation is not an exit gate for this library slice.

The two-library qualification rule retained in §5 is a **plan-level verification
commitment**, not a requirement stated by canonical CP-07. It must not be silently
promoted into architecture or silently dropped because qualification is difficult.

## 2. Delivery contract and scope

Deliver a standalone, public-key-only operation:

```text
public extended key + explicit relative public path
                    + validated network definition + explicit address policy
    → public-key admission and non-hardened derivation
    → Bitcoin address construction
    → public address result or defined failure
```

The slice includes P2PKH, P2SH-P2WPKH and P2WPKH, with Bitcoin mainnet and testnet
definitions. The three constructions come from the canonical baseline; both
network definitions and explicit request inputs are retained delivery choices
from the earlier plan. P2SH-P2WPKH is not optional. Start with one complete branch
as an internal milestone, then reuse its common capabilities for the other two.

The operation does not allocate, reserve or persist indices, discover usage,
assign addresses to payments, or guarantee uniqueness between requests. It does
not inherit an account-depth restriction, a fixed `0/index` path, prefix-derived
policy defaults or network rewriting from the reference application.

Private keys, extended private keys, seeds, mnemonics, hardened/private derivation,
key generation, signing and transactions remain outside scope. Fixed-address
validation and hosted-payment flows are not delivered. Neither are additional
chains, Lightning, Taproot, Bech32m, address discovery, or general public-key
export. Internal codec or validation operations do not automatically become
separate public APIs.

PHP 8.1 is the consumer baseline in [composer.json](../composer.json); the
repository checks PHP 8.1 and 8.3. GMP is permitted as an explicitly documented
provider requirement, not imposed as a domain capability. Runtime requirements,
including integer-width assumptions, must be established by qualification.

### Architecture translated into delivery obligations

| Architectural anchor | Obligation for this slice |
|---|---|
| §§7–9, 18, 28A; CP-02–CP-04 | Share derivation, key operations, hashing and compatible codecs; network variation remains validated data. Specialize at actual address-semantic divergence. |
| §§10–13; CP-05–CP-06 | Own contracts, invariants, definitions and composition. Delegate algorithms, curve mathematics and codecs. No vendor point, scalar, buffer, GMP object or exception crosses a capability boundary. |
| §§24–27; CP-07, CP-11 | Select production providers deliberately, verify replacement and disclose reference independence. Never switch backends silently at runtime. |
| §§1, 20; CP-08 | Offer a locally usable operation without higher-domain objects or mandatory remote infrastructure. |
| §§12, 14, 33; CP-10 | Keep BIP32, SLIP-132 interpretation and the three address constructions semantically distinct. Resolve invalid-child behavior from evidence. |
| §§15–19, 32; CP-09, CP-12 | Preserve public-only scope and deliberate openness. Fitness examples do not become promised capabilities. |

## 3. Starting evidence and candidate research

The repository currently contains development tooling and a setup test; `src/`
has no production capability implementation. Composer selects no production
crypto or codec package. No executable provider qualification or independent
review of a Primitives implementation is established by this documentation.

| Existing artifact | Use and limits |
|---|---|
| [Delegation inventory](research/delegation-inventory.md) | D01–D11 identify required delegated operations; composite-provider and internal-entity considerations identify integration questions. Rows do not mandate separate packages or interfaces. |
| [Historical candidate worksheet](research/public-address-candidate-worksheet.md) | Preserves the 2026-09-28 proposals, D01–D11/C01–C07 mapping and space for user candidates. Leads require version-level research; they are not current compatibility or maintenance findings. |
| [Current provider research](research/public-address-provider-research.md) | Updated recommendations, version/requirement/advisory evidence, public API/codec probes and the active user-candidate column. Explicitly distinguishes observations from completed qualification. |
| [BitWasp investigation](reviews/bitwasp-public-derivation/README.md) | Version-specific source map, harness, observations and provenance. Reference behavior is evidence, not a compatibility obligation. |
| [Composition/API proposal](research/public-address-composition-proposal.md) | Prospective direct compositions and a typed-request invocable. Neither API shape nor example class names are accepted contracts. Bitcoin Cash remains a fitness example. |

The BitWasp investigation records 17 public-key round trips, six official public
non-hardened derivation edges and 30 address regressions. It also records accepted
invalid root metadata, ignored trailing payload data, rejected zero tweak,
invalid-child progression questions and an infinity result under controlled
injection. Turn these into qualification cases; do not inherit the discrepancies.
The run used PHP 8.3.35 and does not establish the supported-runtime matrix.
BitWasp backed by Paragonie is not an independent ECC oracle for another
Paragonie-backed adapter.

The documentation rewrite preserved existing research without renewing its
external claims. The subsequent PIP-0002 research reran the BitWasp harness with
identical output and added bounded provider probes; their limits are recorded in
the current worksheet. A future selection record must identify exact releases/commits,
license, runtime/extensions, dependency footprint, maintenance/security evidence,
actual executed dependency paths, unsupported behavior and reproducible results.

### Research priorities

1. Define the minimum ECC and BIP32 semantic contracts; evaluate the canonical's
   initial `paragonie/ecc` candidate through an adapter. Compare materially
   different APIs and identify a mathematically independent reference.
2. Resolve BIP32 invalid-child semantics and strict extended-public-key admission.
   Compare owned protocol composition with composite-provider integration;
   preserve the canonical capability boundaries in either case.
3. Qualify Base58/Base58Check for extended-key and address payloads, and
   Bech32/SegWit v0 for P2WPKH. Investigate Base58/GMP independence without
   assuming that ECC runtime requirements also belong to codecs.
4. Qualify PHP runtime hashing and fixed-width conversion facilities against the
   exact inputs, output formats and supported environments.

Candidate collection and spikes can advance without waiting for an empty user
worksheet cell. Preserve the earlier joint-selection workflow: compare available
research, discuss concrete qualification evidence and record the selected
versions and rejected alternatives before production wiring is finalized.
No recommendation or successful reference run constitutes selection.

## 4. Minimal contracts and decisions to close

Sketch contracts from the requirement before matching them to vendor APIs.
Refine them through spikes; freeze the slice's semantic guarantees before
production delivery. Exact PHP names, namespaces, physical layout and calling
syntax remain open until justified. Do not postpone all contract design until a
library has already determined its shape.

| Boundary | Responsibility to establish | Evidence needed before freezing |
|---|---|---|
| Public operation | Explicit key, relative path, network definition and policy; compatibility admission; public result or defined failure. | All three policies on both networks, unsupported combinations, and equivalence with direct composition. Decide serialized versus prevalidated key input and validation ownership. |
| Definition loading | Validate declarative parameters into semantic views; behavior consumes those views rather than raw storage keys. | Required/unknown fields, exact byte representations, profile compatibility, parameter provenance and no mutation across calls. Physical format and loading API remain open. |
| Extended-key admission | Compose delegated decoding with owned public-only admission, exact payload size, root metadata, version semantics and key validity. | Official valid/invalid public fixtures, trailing data, private/unknown versions and malformed compressed points. Keep SLIP-132 policy interpretation separate from generic BIP32. |
| Public derivation | Own CKDpub semantics and metadata transitions; compose delegated HMAC and ECC or qualify an integration preserving those boundaries. | Specification-backed invalid-child behavior, public-index bounds, depth limits, zero tweak, intermediate invalid children and exhaustion. |
| ECC tweak | Valid compressed public key plus admitted public scalar tweak yields a valid compressed public key or defined failure. | Zero, scalar at/above order, invalid points and infinity; delegated parsing/math/serialization; no generic curve API exposed. |
| Address construction | Reuse derived key and hashing; own each policy's semantics and delegate standardized encoding. | P2PKH key hash, P2WPKH witness program, and P2SH-P2WPKH redeem-script hash are tested distinctly. They are not one interchangeable payload. |
| Failure boundary | Distinguish malformed input, unsupported/incompatible intent, derivation outcomes and provider/environment failure. | Stable meanings, bounded parsing/path work, normalized vendor failures and no partial success or invisible fallback. Exact exception/result representation remains open. |

Required decision records must settle:

- **Invalid-child API:** exact-index operation versus advancing orchestration,
  effective-path reporting, non-terminal invalid children and exhausted ranges.
  Verify normative behavior first; do not infer it from one library's retry or
  exception behavior. Requested and effective paths must remain distinguishable
  whenever the chosen contract allows them to differ.
- **Version/network/policy compatibility:** supported public versions, BIP32
  versus SLIP-132 meaning, supported combinations and explicit rejection rules.
  No silent version rewriting or substitution of intent.
- **Representation and limits:** validated public-key/extended-key values, tweak
  representation, relative-path syntax and bounds, depth and integer limits,
  result contents and error taxonomy. Use public fixtures and avoid automatic
  diagnostics containing wallet identifiers.
- **Construction API:** compare direct composition with the proposed typed-request
  invocable. Definitions and requests must not contain vendor selection or
  executable steps. Lower capabilities receive only their own semantic inputs.
  Do not build a registry framework, universal dispatcher or graph interpreter
  merely to support the initial operation.
- **Provider integration:** selected versions and extensions, adapter obligations,
  actual executed dependency paths, replacement candidates and independent
  references. An unused injected adapter does not demonstrate a boundary.

Each record identifies the requirement, governing reference, evidence, decision,
alternatives, limitations and affected tests. An open decision is a research task,
not permission to inherit a default from a dependency.

## 5. Qualification and verification gates

### Provider conformance and replacement

Adapters implement semantic capabilities, not vendor API mirrors. They may
coordinate vendor calls, convert representations, enforce pre/postconditions and
normalize failures. Provider points, scalars, buffers and configuration stay
inside the adapter and explicit construction wiring.

Retain the earlier plan's requirement to exercise **two suitable distinct
libraries through separate adapters for each library-backed capability boundary**.
Use the same contract corpus and unchanged consuming compositions; change only
adapter wiring and dependency configuration. Prefer different usage APIs to
challenge accidental coupling. Keep alternative adapters in verification tooling;
production deliberately selects one implementation per capability.

This is an executable isolation check, not a requirement for two packages per
internal algorithm or for automatic failover. One package may serve multiple
boundaries. Runtime facilities require conformance and independent evidence, but
do not need artificial wrappers to count as multiple libraries. Mocks can force
rare outcomes; they do not satisfy provider replacement qualification.

If a second suitable provider is unavailable, record the affected boundary and
leave this plan's gate open. Research or explicitly reconsider the delivery
commitment with supporting evidence; do not report an unexercised alternative as
qualified. Different APIs alone do not establish cryptographic independence:
record shared underlying implementations separately.

### Evidence corpus

| Evidence category | Required coverage |
|---|---|
| Normative vectors | Public portions of BIP32 and applicable hashing, compressed-key and address/codec vectors, with source revision and independently justified expected results. Do not bring private derivation into production to run a vector suite. |
| Regression cases | Existing admitted address/derivation cases with provenance; exclude accidental application policy and known reference defects. |
| Invalid inputs and boundaries | Payload length, root metadata, versions, SEC1 key validity, checksum/alphabet/leading zeros, incompatible intent, hardened requests, depth overflow and maximum public index. |
| Controlled rare outcomes | Zero tweak, scalar at/above order, infinity, invalid intermediate children and exhaustion; document injection seams and distinguish forced outcomes from naturally observed cases. |
| Differential verification | Independently implemented references appropriate to the property under test, exact versions and shared-dependency analysis. Investigate disagreements rather than voting on outputs. |
| Adapter/environment behavior | Determinism, explicit missing-runtime failures, contained vendor types/errors, actual executed wiring and no automatic fallback. |
| Definition and operation fitness | Data-only network variation, rejected invalid definitions, immutable semantic use, unsupported/missing composition failures and parity between the public operation and its direct compositions. |

Expected results must not be generated solely by the implementation being tested.
Keep normative vectors, observed regressions and controlled experiments distinct.

### Reuse fitness

Demonstrate shared behavior across the three address compositions and both network
definitions. Use the canonical's compatible Bitcoin/Bitcoin Cash example as a
bounded design check: identify reused BIP32/ECC/hash capabilities, parameter-only
variation and the exact new terminal semantics a future CashAddr capability would
require. Do not implement that future capability or treat CashAddr as a Bech32
parameter change. Taproot and non-Bitcoin families remain canonical fitness
questions, not implementation milestones.

## 6. Execution sequence

Feasibility analysis, contract refinement, protocol validation and adapter spikes
are the **first implementation phase**, as established by canonical §34. They
are not a new architecture-design phase that blocks all executable investigation.

| Stage | Deliverable | Exit gate | Current state |
|---|---|---|---|
| 1. Identify implementation work | Implementation PIP with admitted scope, canonical baseline, evidence links and open decisions. | Durable identity exists before material capability execution. This rewrite's PIP is not reused as implementation identity. | Pending. |
| 2. Refine contracts and feasibility | Minimal semantic contracts, D01–D11 matrix, provider/reference candidates and invalid-child decision evidence. | Each required operation has an explicit OWN/COMPOSE/DELEGATE treatment, qualification route and recorded gaps. | Pinned candidates and bounded observations available; semantic contracts and full feasibility remain open. |
| 3. Run spikes and establish corpus | ECC adapter spike, strict key/codec probes, normative/negative/rare-outcome tests and replacement evidence. | Required semantics and actual boundaries are demonstrated; unresolved provider gaps remain visible. | Raw provider probes available under PIP-0002; semantic-adapter/composition replacement and full corpus remain pending. |
| 4. Select and record | Joint provider disposition, exact revisions, final slice contracts, definitions and error/result decisions. | Required qualification gates pass; architecture conflicts are reconciled explicitly rather than hidden in adapters. | Pending. |
| 5. Implement the slice | One complete branch, then all three constructions on both networks; adapters, composition, validated definitions and standalone example. | Public flow works locally with explicit inputs, no vendor leakage and shared lower capabilities. | Pending. |
| 6. Verify and self-challenge | Supported-runtime CI, reproducible evidence manifest, implementation map and FULL executor CP report. | Report identifies an exact candidate artifact; every applicable CP is conclusively satisfied for review readiness. | Pending. |
| 7. Independently review and correct | Independent CP report, findings, dispositions and new reports for corrective cycles. | No applicable CP remains failed or unresolved; final reviewed artifact is identifiable. | Pending. |

Stages 2–3 iterate as evidence changes contracts or candidate feasibility. Failed
qualification returns to research, not local algorithm implementation. Contract
sketches and executable spikes are expected before final production selection.
Concrete PHP diagrams should describe the resulting contracts and wiring, with
editable sources; draft examples are not evidence of implementation.

For the capability, run the repository's documented `composer ci` workflow on
PHP 8.1 and 8.3, including Composer metadata/platform requirements, syntax,
PHPUnit and PHPStan. Follow the [README development instructions](../README.md#development)
for the container commands. Add capability-relevant conformance and differential
checks, and verify the complete example without loading an upper-layer application.
A passing setup test does not validate the future capability.

## 7. Counter-Proof execution and independent review

Use the canonical §0B meanings and the report protocol's templates directly.
Maintain requirement-to-evidence traceability as work advances, so CP assessment
can challenge concrete decisions rather than assertions of intended compliance.

For this slice, prepare evidence around all twelve CPs:

| CPs | Evidence to bring to assessment |
|---|---|
| CP-01–CP-04 | Admitted scope, dependency justification, shared compositions, data-only network variation and bounded reuse fitness analysis. |
| CP-05–CP-07 | Responsibility matrix, minimal contracts, provider adapters, executed dependency paths, replacement results and explicit failure behavior. |
| CP-08–CP-09 | Standalone public operation and example, domain isolation, public-only admission and rejection tests. |
| CP-10–CP-11 | Protocol decisions, versioned specifications, distinct address constructions, vectors, rare outcomes and independent differential evidence. |
| CP-12 | Scope exclusions, open-decision dispositions and justification for each introduced public API or abstraction. |

These are evidence prompts, not preassigned PASS results. A FULL assessment
considers every CP against the assessed artifact. Executor states are `PASS`,
justified `N/A` and justified `UNRESOLVED`; unresolved means no compliance claim.
The independent reviewer uses `PASS`, justified `N/A` or `FAIL` with a finding,
and challenges both executor passes and exclusions independently.

Store reports under the implementation PIP using
`cp-executor-YYYY-MM-DD-HHmmss.md` and `cp-reviewer-YYYY-MM-DD-HHmmss.md`.
Record actor, role, timezone-qualified timestamp, canonical version, coverage,
exact artifact/revision and durable evidence references. Issued reports are
immutable. A corrective PARTIAL assessment names its CPs and assesses impact on
other CPs; it does not erase a prior failure or label unassessed CPs `N/A`.

The review manifest must make the following recoverable:

- requirement IDs linked to contracts, canonical sections, definitions, provider
  revisions, vector/test IDs, commands and results;
- exact source revision, dependency lock/source references, definition/schema
  revisions, selected semantic policies and runtime/image identity;
- public entry point, composition wiring, adapters, definition loading and tests;
- decision records, rejected candidates, reference independence, known limitations
  and remaining gaps;
- execution outputs and artifact hashes, followed by reviewer findings and their
  dispositions on each newly identified corrective snapshot.

Hashes establish artifact identity, not independent attestation. A loaded-file
list is not branch coverage, a local image ID is not proof of reproducible builds,
and the existing internal BitWasp investigation is not independent review of
Primitives. Preserve original review snapshots when producing corrections.

## 8. Completion and immediate continuation

Distinguish three milestones: **implemented and verified**, **ready for independent
review**, and **independently assessed as canonical-compliant**. Neither local CI
nor an executor report completes the third milestone. Publication and integration
into surrounding domains are separate work, not hidden completion criteria here.

The next capability work is to create its PIP, sketch the minimal contracts and
extend the existing feasibility matrix with versioned qualification evidence,
starting with ECC/BIP32. No production provider or PHP API is selected by this
plan. If research exposes an architectural conflict, record it and reconcile it
through the owning authority before accepting the affected result.

This rewrite preserves the prior delivery scope, historical research and stronger
local replacement check while replacing obsolete authority references and the
old execution structure. Future updates should change current status from recorded
evidence, keep research separate from accepted decisions and preserve issued
assessment history.
