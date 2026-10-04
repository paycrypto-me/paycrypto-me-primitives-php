# PIP-0003 — Execution context

**Package baseline: 2026-10-03.** Read this with [the plan](PIP-0003.md) and the
assigned milestone's handoffs. Together they supply the architectural and
operational context needed for ordinary execution of this slice. The user does
not need to attach canonical documents or reconstruct earlier conversations.

This is a scoped execution aid derived from Public Architecture v1.1, Primitives
v1.6, PIP Specification v0.1 and Counter-Proof Report Protocol v1.1. It creates no
new architectural authority. Its PIP Specification v0.1 reference records the
package baseline; current new material work follows v0.2 below. Canonical
citations identify provenance and exception paths; they are not a mandatory
reading list for every milestone.

## 1. Mission and boundaries

Deliver a locally executable public extended-key-to-Bitcoin-address capability.
Inputs are an explicit public extended key, relative non-hardened path, validated
network definition and address policy. Deliver P2PKH, P2SH-P2WPKH and P2WPKH on
mainnet/testnet. One branch can be delivered and validated first, but all six
policy/network combinations are required for the complete capability.

No private keys, seeds, mnemonics, hardened/private derivation, signing or
transactions enter this slice. No payment/order state, address allocation,
persistence, discovery, hosted-payment integration or general fixed-address API.
Taproot, other chains and future encodings remain fitness questions, not features.

Inside PayCrypto.Me, dependency direction is Consumer → SDK → Core → Primitives.
Core expresses intent; Primitives owns its low-level composition. Do not pull
higher-domain objects into Primitives or expose vendor types upward. An External
Project may consume this standalone library directly without becoming a
PayCrypto.Me Consumer or authorizing a Consumer bypass. Local capability use must
not depend on a mandatory PayCrypto cloud service.

## 2. Architectural decisions carried into this assignment

- Start from a concrete admitted requirement. Every abstraction and production
  dependency needs a traceable purpose. A library's available features do not
  establish requirements.
- Reuse identical behavior until its exact semantic divergence. Coin/network
  identity alone does not justify a new class, hierarchy or execution path.
  Parameter variation belongs in validated definitions; behavioral variation may
  justify composition or a minimal new capability.
- Definitions contain data, not vendor classes, executable steps or fallback
  instructions. Protocol code consumes validated semantic views rather than raw
  storage keys. The physical representation remains open until qualified.
- Primitives owns contracts, semantic values, invariants, protocol semantics,
  validation, errors and composition. Algorithms, curve mathematics, standardized
  encoders/decoders and equivalent low-level machinery are delegated to qualified
  runtime facilities or libraries. Apparent simplicity does not permit copying
  or implementing them locally. Missing providers require research or explicit
  scope reconsideration.
- BIP32 CKDpub is an owned protocol composition over delegated HMAC-SHA512 and
  public-key tweak operations. A whole BIP32 package is not required. The minimal
  ECC operation is a compressed public key plus a public scalar tweak producing
  a compressed public key or defined failure; generic point/curve arithmetic
  does not become a domain API.
- BIP32 metadata/path semantics and SLIP-132 version/address-policy interpretation
  remain distinct. Do not infer policy, rewrite networks or inherit account-depth
  and fixed-path assumptions from the reference application. Invalid-child,
  effective-path, exhaustion and exact error contracts require specification
  evidence; an external library's behavior is not the specification.
- HASH160 composes delegated SHA-256 and RIPEMD-160. The three address policies
  retain distinct owned semantics; key hashes, witness programs and redeem-script
  hashes are not interchangeable payloads. Standardized codecs remain delegated.
- Vendor points, scalars, buffers, GMP objects and exceptions stay behind adapters.
  Contracts and consuming compositions must remain meaningful with a differently
  shaped backend API. Select and replace providers explicitly, verified and
  fail-closed. Never silently try another backend on failure.
- Avoid coin hierarchies, a universal CryptoManager, a configurable protocol
  interpreter and Chain of Responsibility for deterministic derivation. Do not
  freeze illustrative PHP class names, namespaces or calling conventions.
- Verification combines appropriate specification evidence, normative vectors,
  justified regressions, boundary tests and independent differential evidence.
  Investigate disagreement. Neither majority agreement nor two wrappers around
  one underlying implementation establishes independent correctness.

These constraints summarize Public Architecture §§3–11 and Primitives §§2–15,
18, 20, 22–28A and 31–37 for the admitted slice. The full CP index below preserves
its questions, required properties and deeper provenance.

## 3. Additional plan choices and current gaps

These are PIP delivery choices, not new universal canonical rules:

- `bitwasp/bitcoin` is reference-only and excluded from production for this slice.
  The separate focused `bitwasp/bech32` package remains an unselected candidate.
  Candidate, transitive-dependency and reference roles must remain distinguishable.
- Qualify two distinct libraries for each library-backed capability boundary using
  real adapters, the same semantic suite and unchanged consuming compositions.
  Runtime facilities do not need artificial second wrappers. One deliberate
  provider ships per capability; no automatic fallback. Missing qualified
  alternatives keep the affected gate open unless the commitment is explicitly
  reconsidered with evidence.
- PHP 8.1 is the consumer baseline and PHP 8.3 is also checked. GMP is permitted
  as a documented implementation requirement, not a domain capability.
- Provider/version selection is joint and evidence-backed. User candidate input
  may be added during research; an empty cell neither blocks independent research
  nor supplies selection approval. Production wiring waits for M05.
- English is required for repository documentation and artifacts. Use public test
  material. Do not place real wallet identifiers in automatic diagnostics.

No production API/provider has been selected. Existing vendor probes do not
constitute semantic-adapter replacement qualification. PHP 8.1 ECC/GMP evidence,
an independent ECC reference and complete alternative-codec qualification remain
open. The plan's status register and dated handoffs own evolving status; this
paragraph records the starting baseline only. §4 of the plan identifies open
contract decisions; do not guess them because the execution packet is self-contained.

## 4. Execution records and assessment semantics

PIP identifies the work: use `Work: PIP-0003`. Milestone IDs identify bounded
assignments, not separate PIPs or new architectural authorities. Record scope,
inputs, outputs and continuation using the local handoff template. Keep evidence
and decisions durably recoverable through exact revisions or hashes and paths.
A moving branch, local image name or chat assertion alone is insufficient.

Use [the local report templates](COUNTER-PROOF-TEMPLATES.md). Store issued reports
at this PIP root as `cp-executor-YYYY-MM-DD-HHmmss.md` or
`cp-reviewer-YYYY-MM-DD-HHmmss.md`; record the full timestamp with timezone,
available actor identity, role, canonical version, exact artifact and evidence.
Do not invent a model version or merge executor/reviewer roles.

Challenge every material decision against all applicable CPs in the declared
assessment coverage. Passing tests does not waive the assessment.

- **FULL:** consider all twelve CPs against the explicitly bounded artifact. Use
  normally for a first complete candidate assessment and for M08's assembled result.
- **PARTIAL:** identify the reassessed CPs and assess impacts on the others. Add
  materially affected CPs to coverage. Omitted CPs are outside coverage, not N/A.
- **Executor PASS:** the applicable required property is demonstrated for the
  assessed decision. **N/A:** genuinely outside scope, with justification.
  **UNRESOLVED:** applicable but unproven, with justification and the missing
  evidence/blocker. Unresolved is disclosure, not compliance.
- **Reviewer PASS/N/A/FAIL:** independently challenge passes and exclusions.
  Justify N/A; give a finding for FAIL. Do not inherit executor conclusions.
- PASS requires no boilerplate justification; add a note only if materially useful.
  Keep assessment conclusions limited to the actual artifact, never future work.
- Issued reports are immutable. Corrections produce new snapshots and reports,
  preserving findings and their dispositions. The reviewer identifies the exact
  executor report and artifact reviewed.

Local milestone completion does not mean independent canonical compliance.
Applicable unresolved/failed CPs prevent that compliance claim. The existing
independent plan-alignment review is neither a formal CP report nor implementation
approval. A CP index constrains outcomes; it does not freeze techniques or resolve
choices deliberately left open by the architecture.

## 5. Runtime and evidence preparation

The repository is a PHP CLI library project with Docker and Composer. From the
repository root, `bash scripts/setup.sh 8.1` builds that runtime, installs current
project dependencies and runs `composer ci`; `bash scripts/setup.sh` restores the
PHP 8.3 development runtime and also runs CI. On a prepared image,
`docker compose run --rm app composer ci` runs metadata/platform checks, PHP lint,
PHPUnit and PHPStan. Inspect repository scripts if they have changed since this
package baseline. Installing new production dependencies still belongs to the
selected implementation milestone, not to an exploratory probe.

Keep research dependency installations isolated from the production dependency
set. Record actual PHP/extensions, package/source revisions, commands and output.
Supplement CI with the milestone-specific conformance and differential checks;
setup tests alone do not validate the capability. Technical research milestones
must retrieve and pin relevant external specifications/provider sources; package
self-sufficiency is not a claim that every future research question is already solved.

## 6. When to consult an owning authority

Routine milestone work uses this package. Consult the specific linked authority
only when a material decision conflicts with this package, needs architectural
rationale not carried here, changes scope/boundaries or encounters a newer accepted
baseline. Load only the relevant sections, document the discrepancy and reconcile
it; do not silently reinterpret an invariant. If the authority is unavailable,
record the affected blocker and continue independent work that does not depend on
it. Do not ask the user to resend canonicals merely to start a normal milestone.

Authority references for those exceptions:

- [Public Architecture v1.1](../../canonicals/public-architecture/paycrypto-public-architecture-canonical-v1.1.md): domain topology and public security boundary.
- [Primitives v1.6](../../canonicals/primitives/paycrypto-primitives-canonical-architecture-reference-v1.6.md): domain decisions and CP meaning.
- [PIP Specification v0.1 at the package baseline](https://github.com/paycrypto-me/paycrypto-me-primitives-php/blob/95e83842ed9f4a577998e49851449230f56f56b2/docs/specifications/PIP-SPECIFICATION.md): historical work identity and history rules used when this package was recorded.
- [Current PIP Specification v0.2](../../specifications/paycrypto-pip-specification-v0.2.md): Issue-derived identity, proposal lifecycle, approval and planning rules for new material work.
- [Counter-Proof Report Protocol v1.1](../../protocols/primitives/COUNTER-PROOF-REPORT.md): reporting rules.

If an authority or admitted decision changes, reconcile the affected plan/context/
templates and version them together; record which milestone assumptions/evidence
need reassessment. Do not independently evolve this package into a competing
canonical. Report stale package guidance rather than requiring every executor to
repeat architectural discovery.

## 7. Canonical Counter-Proof control surface

The following is an unchanged excerpt of Primitives v1.6's CP-01–CP-12 entries.
Deep References are provenance and exception lookup targets; no additional
canonical reading is required merely to use these questions in routine execution.

## CP-01 --- Concrete reason for existence

**Counter-proof:** Is this capability, abstraction, dependency, class,
interface, or behavior present because a validated concrete requirement
needs it, rather than because it is foreseeable, taxonomically
attractive, or available in a library?

**Required property:** Primitives grows from admitted evidence. Every
material abstraction and production dependency has a concrete reason to
exist.

**Deep References:** §2 Architectural thesis; §3 Architecture
orientation; §23 Dependency justification tree; §28 Evidence-driven
abstractions; §28A Contribution Divergence Principle; §37 Architectural
anti-goals.

## CP-02 --- Reuse and late divergence

**Counter-proof:** Does the solution duplicate behavior that remains
semantically identical instead of sharing it until the exact point where
behavior actually diverges?

**Required property:** Identity is not divergence. Shared behavior
remains shared; specialization begins only at demonstrated semantic
divergence.

**Deep References:** §7 Capability graph, not a hierarchy of
blockchains; §17 Bitcoin-like and other protocol families; §18 Fork only
at the real divergence point; §28A Contribution Divergence Principle.

## CP-03 --- Data versus behavior

**Counter-proof:** Does this decision introduce behavioral structure for
a difference that can be faithfully represented as validated definition
data?

**Required property:** Parameter variation remains declarative data. New
behavioral structure requires actual behavioral divergence.

**Deep References:** §9 Definitions: data is not behavior; §18 Fork only
at the real divergence point; §28A Contribution Divergence Principle.

## CP-04 --- Composition before capability expansion

**Counter-proof:** Can the requirement be satisfied by reusing and
recomposing existing capabilities before introducing a new capability or
execution path?

**Required property:** Existing capabilities and compositions are
preferred; new capabilities exist only for genuinely new behavior.

**Deep References:** §8 Primitive Composition Principle; §28
Evidence-driven abstractions; §28A Contribution Divergence Principle;
§35 Architecture fitness tests.

## CP-05 --- Ownership and delegation boundary

**Counter-proof:** Does this decision cause Primitives to own
cryptographic, elliptic-curve, standardized low-level, or equivalent
specialized machinery when Primitives only needs to own its contracts,
semantics, invariants, or composition?

**Required property:** Primitives owns its architectural semantics and
composition and delegates suitable low-level machinery. **We own the
composition, not the cryptography.**

**Deep References:** §10 OWN / COMPOSE / DELEGATE; §10A Implementation
Delegation Principle; §13 Hashing and encoding.

## CP-06 --- Implementation-independent semantic boundary

**Counter-proof:** Would the Primitives-owned contract, semantic type,
error, or composition still make architectural sense if the selected
external implementation disappeared and were replaced by one with a
materially different API?

**Required property:** External implementations satisfy Primitives
contracts; they do not shape or define them. Library-specific types do
not cross Primitives capability boundaries.

**Deep References:** §11 Minimal secp256k1 contract; §12 BIP32
responsibility; §20 Core must not assemble cryptographic LEGO; §24
External projects: implementation and reference roles; §25 Backend
replacement policy.

## CP-07 --- Replaceability, verification, and containment

**Counter-proof:** If the selected implementation becomes unavailable,
incorrect, incompatible, or undesirable, can it be replaced explicitly
and fail-closed inside the Primitives boundary without forcing
implementation changes into higher domains?

**Required property:** Backend choice is contained, deliberate,
replaceable, and independently verifiable; replacement is never silent
runtime fallback.

**Deep References:** §24 External projects: implementation and reference
roles; §25 Backend replacement policy; §26 Verification strategy; §27
Architectural resilience model.

## CP-08 --- Primitives and higher-domain isolation

**Counter-proof:** Does this decision leak low-level implementation
knowledge, Primitives internals, or external-library types upward, pull
higher-domain objects downward, or make a local Primitives capability
depend unnecessarily on surrounding/cloud infrastructure?

**Required property:** The Primitives boundary remains low-level,
implementation-independent, locally usable for the capabilities it owns,
and isolated from surrounding-domain internals.

**Deep References:** §1 Primitives in the surrounding architecture; §1.1
Contextual dependency rule; §1.2 Product constraint visible from
Primitives; §20 Core must not assemble cryptographic LEGO; §22 No
universal CryptoManager.

## CP-09 --- Public-key-only security boundary

**Counter-proof:** Does this decision introduce private material,
signing, hardened/private derivation, or another sensitive capability
without a newly admitted concrete requirement that explicitly changes
the current security scope?

**Required property:** Primitives v1 remains public-key-only while the
admitted requirements require no private material.

**Deep References:** §5 Concrete evidence that grounded Primitives v1;
§15 Public-key-only v1 security property; §16 Future resilience: Taproot
as a fitness test, not a feature; §31 Accepted decisions.

## CP-10 --- Protocol semantic correctness

**Counter-proof:** Is Primitives preserving the exact protocol semantics
it owns instead of inventing behavior, inheriting accidental library
behavior, or collapsing distinct protocol responsibilities into one
abstraction?

**Required property:** Owned protocol semantics are explicit,
deterministic, fail-closed where required, and separated where the
protocols themselves are distinct.

**Deep References:** §12 BIP32 responsibility; §12.2 SLIP-132
separation; §14 Bitcoin address compositions in v1; §33 Important
unresolved correctness question.

## CP-11 --- Independent evidence and verification

**Counter-proof:** What recoverable specification evidence,
official/reference vectors, regression cases, independent
implementation, differential check, or equivalent evidence demonstrates
that the material behavior is correct?

**Required property:** Sensitive protocol behavior is not accepted
merely because one implementation or one test path agrees with itself.
Verification uses independent anchors appropriate to the behavior being
established.

**Deep References:** §24 External projects: implementation and reference
roles; §26 Verification strategy; §27 Architectural resilience model;
§33 Important unresolved correctness question; §34 Recommended
continuation sequence.

## CP-12 --- Scope and deliberate openness

**Counter-proof:** Is this decision implementing or freezing behavior
because a validated requirement needs it now, or is it prematurely
resolving a deliberately open decision or implementing a future
possibility?

**Required property:** Architecture is extensible but demand-driven.
Open implementation decisions remain open until evidence resolves them;
future fitness cases do not become current product scope by
anticipation.

**Deep References:** §3 Architecture orientation; §16 Future resilience:
Taproot as a fitness test, not a feature; §19 Non-Bitcoin protocols are
architecture fitness tests; §28 Evidence-driven abstractions; §32
Deliberately open decisions; §34 Recommended continuation sequence; §37
Architectural anti-goals.
