# First Capability Execution Plan — Public Address Derivation

**Status: IN PROGRESS — research and implementation selection pending.**

This is a working execution plan, not canonical architecture or a frozen API.
The scope and responsibility boundaries below are established. Library choices,
concrete objects and remaining contract decisions must be resolved through the
research gates before production implementation. Saving this plan does not
claim that those decisions have already been made.

## 1. Objective, scope and established decisions

Deliver a locally executable, public-key-only Primitives capability that derives
Bitcoin receiving addresses from public extended keys and a relative public path.
Support P2PKH, P2SH-P2WPKH and P2WPKH using validated mainnet/testnet definitions
and an explicit address policy.

- Primitives has no knowledge of higher layers. External repositories provide
  requirement or reference evidence only; they do not supply its architecture,
  implementation blueprint or behavioral-preservation contract.
- OWN covers capability contracts, protocol semantics, invariants, semantic
  values, definitions, pertinent operations and composition.
- Cryptographic algorithms, elliptic-curve mathematics and standardized
  encoders/decoders are delegated to evaluated libraries or runtime facilities.
  Apparent simplicity does not authorize local implementation.
- No provider-specific points, scalars, buffers, GMP objects or other library
  types cross public capability boundaries.
- Network parameter differences are data. Do not introduce behavioral classes
  merely for network or protocol identity.
- Public derivation paths are explicit inputs. Do not inherit a fixed `0/index`
  path, an account-depth restriction, prefix-based defaults, policy overrides or
  network rewriting from a reference implementation.
- PHP 8.1 is the supported baseline; PHP 8.3 is also verified. GMP is permitted
  for the initial ECC implementation, subject to explicit runtime requirements.
- Select implementations explicitly; do not add silent runtime backend fallback.
- Documentation, decision records, diagram labels and review artifacts use English.
- Final diagrams follow the research and contract decisions. Existing temporary
  diagrams are drafts and are not approved for canonical use.

Out of scope: upper-layer integration, index allocation or reservation, order or
payment state, persistence, private material, key generation, signing, transaction
handling, Lightning, additional chains, Taproot and general address discovery.
Public-key export or general address-validation APIs do not enter scope merely
because a selected dependency offers them.

Completion means an implemented and reproducibly verified capability with a
documented contract, selected implementations, supported-runtime checks and a
reviewable evidence package. Readiness for independent review and completion of
that external review are separate milestones; neither may be reported as the other.

## 2. Current evidence and authority

Read [Public Architecture](architecture/PUBLIC-ARCHITECTURE.md) and the
[Primitives canonical v1.4](architecture/paycrypto-primitives-canonical-architecture-reference-v1.4.md)
as the architectural baseline. This plan does not define neighboring domains.

The [delegation inventory](research/delegation-inventory.md) identifies D01–D11,
provider internals, composite-provider research, initial leads and evaluation
criteria. The [BitWasp reference investigation](reviews/bitwasp-public-derivation/README.md)
provides a source-path map, reproducible observations, provenance and limitations.
Its implementation is not automatically a production candidate that passes our
requirements, and its address fixtures are regression observations rather than
normative authority.

Already established:

- Development tooling exists, but no production crypto or codec package is selected.
- The delegation inventory and initial reference investigation are recorded.
- The reference investigation found parsing and invalid-child discrepancies to
  include in candidate qualification.
- BitWasp using Paragonie is not an independent ECC oracle for another adapter
  using the same Paragonie backend.

Documentary reconciliation remains necessary: canonical section 13.3 retains
open wording about codec ownership, while the explicit project instruction in
[AGENTS.md](../AGENTS.md) requires delegation. BIP32 semantic/composition ownership
must also remain distinct from implementation sourcing. Record these decisions
explicitly during canonical reconciliation; do not resolve them through code or
diagram drift.

## 3. Execution sequence and exit gates

| Phase | Work and deliverables | Exit gate | Status |
|---|---|---|---|
| 1. Feasibility research | Compare versioned candidates against D01–D11. Investigate ECC and BIP32 provider boundaries, strict extended-key/Base58Check handling, SegWit Bech32 and runtime hashing. Record scope, license, maintenance/security evidence, runtime requirements, transitive dependencies and known gaps. | Every required item has a documented candidate disposition; unsupported requirements are explicit. No algorithm or codec implementation is invented to close a gap. | In progress: inventory and initial reference evidence available; comparative qualification pending. |
| 2. Qualification spikes and verification corpus | Exercise candidates through small semantic contracts. Establish normative vectors, negative cases, regression provenance, independent references and reproducible commands. Capture performance and deployment constraints without inventing an unsupported acceptance threshold. | Required behavior is demonstrated, discrepancies are resolved or the candidate is rejected, and reference independence is explained. | Pending. |
| 3. Select implementations and freeze contracts | Record implementation selections and rejected alternatives. Finalize public inputs/results/errors, adapter boundaries, definitions and invalid-child behavior. Reconcile accepted documentary changes and then produce concrete diagrams with editable sources. | All decisions in section 4 are closed for this slice; contracts preserve the canonical boundaries and implementations pass the qualification gate. | Pending. |
| 4. Implement the vertical capability | Add selected dependencies and runtime requirements; implement semantic values, invariant checks, adapters, validated network definitions and the three address compositions. Deliver a standalone usage example. | The complete public-key-to-address flow works through its own contract, with no external types or higher-layer concepts leaking through it. | Pending. |
| 5. Verify and prepare independent review | Run the complete capability suite and existing CI checks on PHP 8.1/8.3. Assemble source, dependency, decision, vector and execution evidence for a frozen revision. | Reproduction succeeds; discrepancies and limitations are disclosed; review materials identify the exact implementation and evidence under review. | Pending. |
| 6. Independent review and disposition | Supply the review package through the agreed process, record findings and responses, and rerun affected checks after changes. | The external review outcome is actually received and recorded; unresolved correctness findings are not presented as accepted behavior. | Pending external review. |

Research and qualification may iterate. A failed candidate returns to research,
not to a local reimplementation or an invisible fallback. Contract sketches can
precede selection to test independence, but must not freeze objects simply to
match a library API. Production implementation waits for the selection and
contract gate.

Implement one complete address branch first as an internal milestone, then reuse
the same admitted capabilities for the remaining two. The delivery is incomplete
until all three constructions and both network definitions pass their gates.

No publication, external message or reviewer submission is performed merely by
following the local research steps. Reviewer coordination and release execution
are separate actions; this plan records their prerequisites rather than claiming
they have been authorized or completed.

## 4. Decisions to close through research

| Open decision | Evidence needed to close it |
|---|---|
| Production providers and exact supported versions | Candidate matrix and passing qualification results for the required operations; explicit runtime/extension and transitive dependency analysis. |
| BIP32 implementation integration | Demonstrate the selected provider/composition boundary without porting algorithm internals, losing protocol control or adopting a dependency-shaped domain model. |
| Public-key and extended-key representations | Minimum semantic data, validation guarantees and conversion boundaries; no provider-owned objects in public signatures. |
| Path and invalid-child result contract | Decide exact-index versus advancing behavior, the treatment of non-terminal invalid children, effective-path reporting and exhaustion errors; verify against the specification and controlled tests. |
| Version, network and explicit-policy compatibility | Document accepted public versions and valid combinations, including BIP32 versus SLIP-132 semantics; reject unsupported cases without silently changing intent. |
| Definitions and construction API | Validated mainnet/testnet data, loading boundaries and explicit implementation wiring; no speculative registry framework. |
| Error taxonomy and resource limits | Separate malformed input, unsupported operation, invalid-child outcomes and backend/runtime failure; bound parsing/path work and document depth and integer limits. |
| Independent verification tools | Exact versions and provenance; shared-dependency analysis demonstrating independence for the property being checked. |
| Concrete PHP APIs and diagrams | Final names, signatures and object relationships derived from the validated contracts, followed by editable diagrams and SVG exports. |

Each decision record must state the requirement, evidence, selected approach,
alternatives, limitations and affected tests. Open entries are intentional work
items, not permission for an implementer to silently guess the final behavior.

## 5. Acceptance and audit evidence

Build a traceable matrix linking each admitted requirement to its contract,
composition, provider revision and verification evidence. Keep these evidence
categories distinct:

- **Normative vectors:** official public BIP32 and applicable hashing, key,
  encoding and address vectors, with source/revision and expected outputs.
- **Regression cases:** independently justified cases with provenance; no blanket
  preservation of reference quirks or upstream application policies.
- **Boundary and invalid-input tests:** exact key payload length, root metadata,
  unknown/private versions, malformed SEC1 keys, invalid points, checksum and
  alphabet errors, leading zeros, incompatible network/policy, hardened requests,
  depth overflow and public index limits.
- **Controlled rare outcomes:** zero tweak, scalar at/above curve order, infinity,
  invalid non-terminal children and index exhaustion. Record any injection seam
  and distinguish controlled observations from naturally occurring examples.
- **Independent differential checks:** verify the actual property with an
  independently implemented reference; investigate every disagreement.
- **Adapter and environment checks:** deterministic outcomes, explicit failures,
  missing runtime requirements, no backend fallback and no external-type leakage.

Use the existing `composer ci` checks, including Composer metadata/platform
validation, PHP syntax, PHPUnit and PHPStan, on the supported PHP 8.1/8.3 matrix.
Add only capability-relevant checks justified by this work. Verify the complete
standalone flow without loading an upper-layer application.

The independent-review package must identify the reviewed source revision,
dependency lock and source references, runtime/image identity, vector origins,
commands, outputs, artifact hashes, candidate decisions and remaining limitations.
Hash manifests are integrity records, not independent attestations. Preserve the
original review snapshot when making changes; produce a new identifiable snapshot
and record which findings and tests the changes affect.

Do not claim a successful reference run certifies Primitives, a loaded-file list
proves branch coverage, a local image ID proves a reproducible build, or an
internal investigation constitutes independent review.

Update this working plan as research closes decisions. Promote only accepted,
reconciled architectural knowledge into the canonical documents; keep experimental
results and rejected candidates identifiable as research evidence.
