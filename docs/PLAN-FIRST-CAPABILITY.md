# First Capability Execution Plan — Public Address Derivation

**Status: IN PROGRESS — research and implementation selection pending.**

**Consolidation checkpoint: 2026-09-28.** Recommendations below are proposals for
joint investigation, not selected production dependencies. The user will add
independent candidates before comparative discussion and selection.

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

### Scope by flow

**This plan delivers the public derivation capability only. It is not a plan
for every payment or receiving flow that may eventually use Primitives.**

Terms such as *fixed address*, *derived address* and *hosted payment* describe
different use cases, not an established set of Primitives flow classes. The
current Primitives canonical grounds this slice in public extended-key-to-address
derivation. Mentioning other flows below marks the scope boundary; it does not
introduce those concepts into Primitives contracts or define another domain's
architecture.

| Flow / use case | Coverage in this plan | Boundary |
|---|---|---|
| Derived address | **Included: public protocol capability only.** Import a public extended key, derive along an explicit non-hardened relative path, and construct a Bitcoin address for an explicit policy and network. | Does not choose, allocate, reserve or persist an index; discover address usage; assign addresses to payments; or guarantee uniqueness across requests. |
| Fixed address | **Not delivered as a separate capability or flow.** | Accepting an already supplied address does not require public-key derivation. General address parsing, validation or normalization would need a separately admitted requirement. Reusable codecs and verification of generated outputs do not establish a fixed-address API. |
| Hosted payment | **Outside this plan.** | No hosted checkout, remote payment session, provider integration, HTTP API, redirect, webhook or payment lifecycle is introduced. If such a use case later needs a low-level operation, admit that operation independently without teaching Primitives about hosted payments. |

The input/output boundary for this delivery is:

```text
Public extended key + relative public path + network definition + address policy
    → validated public derivation and address construction
    → public address result or typed failure
```

Input validation, public-key validity, key decoding, derivation, hashing and
address encoding are supporting parts of this capability. The candidate worksheet
below exists to supply this scope; it is not a catalog of additional promised
flows. A standalone public-key-to-address API is also not automatically promised
merely because address construction is needed internally.

Future fixed-address-related or other low-level capabilities may reuse these
components after their requirements are admitted. No such expansion is required
to complete this plan, and this exclusion is not a permanent ban on useful
protocol capabilities.

### Established decisions

The choice of public extended-key derivation follows the canonical's initial
concrete requirement and recommended vertical slice (sections 5 and 34). It is
not a claim that this is the easiest flow. Its implementation must demonstrate
the canonical composition and replacement properties, not merely produce the
expected Bitcoin address strings.

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

Out of scope: fixed-address flow delivery, hosted-payment flow delivery,
upper-layer integration, index allocation or reservation, order or
payment state, persistence, private material, key generation, signing, transaction
handling, Lightning, additional chains, Taproot and general address discovery.
Public-key export or general address-validation APIs do not enter scope merely
because a selected dependency offers them.

Completion means an implemented and reproducibly verified capability with a
documented contract, selected implementations, supported-runtime checks and a
reviewable evidence package. Readiness for independent review and completion of
that external review are separate milestones; neither may be reported as the other.

### Mandatory capability reuse and adapter boundaries

Canonical anchors: sections 7–9 (reuse and definitions), 11 (minimal ECC
contract), 18 (actual divergence), 25 (backend replacement) and 35 (fitness tests).

**Share identical behavior until the actual divergence point.** The unit of
reuse is a semantic capability, not a coin class or a vendor package. Shared
public derivation, key operations, hashing and codecs must not be duplicated
under Bitcoin-specific and Bitcoin-Cash-specific implementations. Changes to
representable parameters require definitions, not new behavioral classes.

Use the canonical's compatible Bitcoin / Bitcoin Cash derivation example as a
design fitness check, not as an additional delivery commitment:

| Part of a future compatible flow | Required architectural treatment |
|---|---|
| Same admitted BIP32 public derivation and secp256k1 operations | Reuse the existing semantic capabilities and their selected adapters. Do not clone the derivation stack for another coin name. |
| Same compressed-key hashing behavior | Reuse the existing hashing composition and delegated implementations. |
| Different network/version/prefix parameters | Supply validated definitions where existing semantics support the variation. |
| Different final address semantics or encoding, such as CashAddr | Introduce only the genuinely divergent composition/capability and delegate its codec after a concrete requirement is admitted. CashAddr must not be treated as a Bech32 parameter variation. |

This comparison assumes compatible key/path semantics; it does not assert that
all Bitcoin and Bitcoin Cash wallet policies are interchangeable. Bitcoin Cash
and CashAddr implementation remain outside this slice. The design review must
identify which existing components would be reused and the exact point where
new behavior would begin, without implementing speculative support.

### Definitions and public operation

Definitions are declarative data validated once into immutable semantic views
(canonical §9). Request inputs provide the public key, explicit relative path,
selected definition and explicit address policy. Provider wiring is separate.
Neither definitions nor requests name vendor classes or executable steps.

**Proposal:** one typed-request invocable for the admitted public-address
operation, with explicit policy-to-composition wiring. Lower capabilities receive
only their own inputs, never the whole request or knowledge of their callers.
Qualify this against direct composition before freezing the API. There is no
universal crypto dispatcher, coin hierarchy or dynamic pipeline interpreter.

The [composition/API proposal](research/public-address-composition-proposal.md)
contains the Bitcoin/Bitcoin Cash declarations, data-driven definition examples,
parameter provenance rules and pattern vocabulary. These examples are not APIs
already delivered. Adding compatible data requires validation and fixtures;
adding unsupported behavior requires a separately qualified capability.

### Provider adapters and replacement qualification

**Adapters implement our capability contracts, not a mirror of vendor APIs.**
Sketch the minimum semantic contract from the requirement before evaluating a
provider's method names. For example, the ECC boundary expresses a validated
compressed public key plus a public scalar tweak producing a compressed public
key or a defined failure. It does not expose generic point addition,
multiplication, curve factories or the shape of a provider's object model.

- A compliant adapter may coordinate several vendor calls, validate preconditions
  and postconditions, convert representations and normalize failures to satisfy
  one semantic operation. Forwarding a call is acceptable only when it actually
  satisfies the independently defined contract; one-to-one method mapping is not
  the design rule.
- Entities, capability interfaces, protocol compositions and definitions must
  remain independent of vendor classes, exception types, factory patterns and
  implicit global/default configuration. Vendor-specific mechanics belong inside
  the implementation adapter and its explicit wiring.
- One library may implement several capabilities without merging their semantic
  boundaries. Conversely, replacing one capability's provider must not require
  replacing unrelated capabilities or changing their consumers.
- Replacement changes the adapter, explicit construction/wiring and dependency
  configuration. It must not change domain entities, capability contracts or
  protocol compositions solely because the new library exposes different APIs.
- Validate a replacement against the same conformance suite, then switch it
  explicitly. Replaceability is not automatic runtime fallback or an untested
  promise that every library can satisfy the contract.

For every library-backed capability boundary, require two suitable, distinct
libraries to be exercised through separate adapters before accepting the boundary.
Prefer candidates with materially different usage APIs: their differences test
whether our contract expresses the capability or merely reproduces one vendor's
API. ECC is the first concrete case; the research candidates already listed in
section 3 are investigation options, not a selected pair.

Reuse the semantic contract, entities, conformance corpus and protocol
composition. Each adapter accommodates its own library's API. Do not require the
same adapter implementation to support unrelated libraries, or introduce vendor
flags into a shared adapter to manufacture reuse. Share adapter implementation
details only where independently justified by identical semantics.

The qualification procedure is:

1. Define required inputs, results, invariants and failures from the capability.
2. Implement two real provider adapters and run the same success, boundary and
   failure corpus against both, recording exact dependency/runtime versions.
3. Run the consuming protocol composition with each adapter, changing only
   dependency wiring. Changes to semantic entities, contracts or compositions
   solely to accommodate a vendor API fail this architectural check.
4. Record API differences, adapter translations, results and remaining gaps in
   the review evidence. If two suitable libraries cannot be qualified, leave
   this gate explicitly pending and return to research; mocks and a proposed
   replacement mapping do not satisfy it.

Apply this requirement per capability boundary, not per package or internal
algorithm: a library may serve several boundaries, each with its own evidence.
Direct runtime facilities still require conformance and independent verification;
do not add artificial library wrappers merely to count them as two providers.
Keep the alternative adapters in verification tooling; only one deliberate
production implementation is required, with no automatic runtime fallback.
Different library APIs demonstrate an architectural challenge, not cryptographic
independence: two libraries using the same underlying implementation cannot serve
as independent cryptographic references for that implementation.

The purpose is strong semantic isolation with the smallest justified contracts.
Do not add a universal crypto manager, generic curve API, coin hierarchy or
plugin framework merely to make the adapters appear sophisticated.

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

Completed work is preserved in WIP commit `61c2e48`: the delegation instructions,
initial plan, inventory and reference investigation. That investigation recorded
17 successful public-key round trips, six matching official public derivation
edges and 30 matching address regressions. It also recorded two accepted invalid
public-key vectors, ignored trailing data, zero-tweak rejection and an infinity
result under controlled fault injection. These observations qualify the
reference's limitations; they do not validate a Primitives implementation.

The review artifacts include a reproducible harness, results, 463 local source
file fingerprints and a comparison of the installed BitWasp `src` tree with its
locked upstream commit. Full comparative candidate qualification, production
implementation and external independent review have not been performed.

The canonical's dated 2026-09-28 reconciliation closes the earlier codec-ownership
conflict, records the two-provider architectural check and makes the first slice
standalone. It preserves open provider and PHP API decisions. This is a documented
amendment of the existing v1.4 file, identifiable by source revision, not a claim
that implementation or external review has occurred.

## 3. Joint candidate research worksheet

This is the central editable worksheet for candidate discussion. D01–D11 match
the [delegation inventory](research/delegation-inventory.md); that document retains
the detailed requirements and verification criteria. C01–C07 below identify its
composite-provider and internal-entity considerations, not new public capabilities.

**Assistant recommendation** means the best first investigation target among the
options examined so far, given PHP 8.1, permitted GMP and our domain boundaries.
It is an engineering recommendation, not evidence of superiority, compatibility
or audit approval. Exact supported releases remain to be qualified. Where the
evidence does not support a production front-runner, the table says so explicitly.

**User candidates** cells are intentionally empty for the user's own research.
Add package/runtime names and links there; versions and notes are welcome. One
provider may cover multiple rows, and a runtime facility can be preferable to a
new Composer dependency. No row mandates a separate class, interface or package.

### Algorithms, public-key operations and codecs

| ID | Delegated item / required use | Assistant recommendation | Reason and qualification still needed | User candidates |
|---|---|---|---|---|
| D01 | SHA-256: HASH160 and checksum hashing | PHP Hash runtime: [`hash('sha256', ..., true)`][php-hash] | Direct runtime implementation with binary output; verify known-answer vectors and availability on both supported runtimes. | |
| D02 | RIPEMD-160: public-key and redeem-script hashing | PHP Hash runtime: [`hash('ripemd160', ..., true)`][php-hash] | Same runtime boundary as D01; confirm algorithm availability, 20-byte output and vectors. | |
| D03 | HMAC-SHA512: public derivation | PHP Hash runtime: [`hash_hmac('sha512', ..., ..., true)`][php-hmac] | Avoid a separate HMAC dependency; verify key/data order, long-key vectors and 64-byte output. | |
| D04 | secp256k1 public-key parsing, validation and compressed serialization | [`paragonie/ecc`][paragonie] first; [`simplito/elliptic-php`][elliptic] as comparison candidate | Fits the initial canonical candidate and permitted GMP deployment. Qualify compressed-key validation and contain all point types. Research [`libsecp256k1`][secp] as the independent ECC reference and possible future backend; no PHP binding is selected. | |
| D05 | secp256k1 public-key scalar tweak addition | [`paragonie/ecc`][paragonie] through a minimal adapter; compare with [`libsecp256k1`][secp] | Reuse D04's provider rather than duplicate ECC stacks. Explicitly test zero tweak, scalar bounds and infinity; a passing BitWasp run using Paragonie is not independent ECC evidence. | |
| D06 | Base58 encode/decode with the Bitcoin alphabet | [`tuupola/base58`][tuupola] first | Focused codec with documented PHP/GMP implementations. Explicitly select the Bitcoin alphabet and a backend; do not inherit its environment-dependent default selection. Verify leading zeros and malformed inputs. | |
| D07 | Base58Check for extended keys and address payloads | [`tuupola/base58`][tuupola] as a conditional first trial; compare the inspected [`BitWasp Base58`][bitwasp-base58] implementation | Tuupola documents checksum support, but full four-byte extended-key-version handling is not established here. BitWasp provides the broader payload reference, with a larger dependency graph. Reject a candidate that cannot cover the required payloads; do not fill gaps with a local codec. | |
| D08 | Bech32 encoding/decoding machinery | [`bitwasp/bech32`][bech32] first | Dedicated package rather than the full Bitcoin library. Qualify official valid/invalid vectors, case/length rules, checksum and padding behavior, release compatibility and maintenance. | |
| D09 | SegWit v0 address codec for P2WPKH | [`bitwasp/bech32`][bech32] `encodeSegwit` / `decodeSegwit` | Reuse D08's provider. Keep the admitted policy at witness v0 with a 20-byte program; verify HRP behavior and negative cases. Codec capabilities beyond this do not expand our API. | |
| D10 | Structural decoding of extended public keys | Investigate [`BitWasp RawExtendedKeySerializer`][bitwasp-raw] as a scoped parsing candidate; no qualified production choice yet | Existing structural machinery is preferable to writing a codec. Assess dependency cost and strict wrapper invariants: exact length, public-only admission, root metadata and version consistency. The inspected high-level parser is not acceptable unchanged. | |
| D11 | Fixed-width binary integer and byte conversion | PHP [`pack()`][php-pack] / [`unpack()`][php-unpack] first; `bitwasp/buffertools` only if a concrete gap remains | Runtime delegation avoids a generic buffer dependency. Verify endianness, unsigned ranges and integer-width assumptions. Domain field definitions remain ours; standardized conversion machinery does not. | |

### Composite operations and provider-internal entities

These rows do not reclassify domain-owned composition as an external entity.
They identify where delegated implementations are needed underneath it.

| ID | Item / responsibility | Assistant recommendation | Reason and qualification still needed | User candidates |
|---|---|---|---|---|
| C01 | BIP32 public derivation provider; protocol contract remains owned | No production front-runner established. Keep [`bitwasp/bitcoin`][bitwasp] as a reference and compare additional providers before choosing the integration. | The inspected version's zero-tweak/infinity behavior prevents recommending it unchanged. Do not substitute a handwritten CKDpub implementation for the missing selection. | |
| C02 | HASH160 operation | Compose the delegated PHP implementations recommended for D01 and D02 | This is owned operation composition, not a new hash implementation or a reason for another package. Verify composition order and expected outputs. | |
| C03 | Double-SHA256/checksum support | Prefer the selected D07 provider for the complete Base58Check operation; reuse D01 where an admitted operation needs hashing | Keep checksum and encoding algorithms delegated. Do not infer permission to implement a local Base58Check codec from the availability of `hash()`. | |
| C04 | Big integers, field elements and modular arithmetic | Use the chosen ECC provider's internal machinery; GMP is permitted | Do not select a domain-wide big-integer API separately. Assess transitive dependencies and prohibit external math objects in capability signatures. | |
| C05 | Points, generators, curves and infinity representations | Keep these inside the D04/D05 provider and adapter | They are backend mechanisms, not domain entities. Map invalid/infinity outcomes to our semantic contract. | |
| C06 | Buffers, parsers and serializers | Prefer runtime byte operations and the selected codec's internal types; assess `bitwasp/buffertools` only if justified | Avoid importing a generic buffer abstraction into public contracts. Qualify bounds checking and runtime diagnostics. | |
| C07 | Script serialization helpers for the three address constructions | No separate script engine recommended. Evaluate [`BitWasp script helpers`][bitwasp-script] only if delegated serialization is needed beyond the chosen provider surface. | Bitcoin address/script semantics remain owned. Reject an unrelated interpreter, transaction or signing dependency unless its footprint is explicitly justified; do not reproduce a standardized serializer locally. | |

### Recommendation basis and limitations

Primary documentation and available source were checked for this worksheet on
2026-09-28. PHP documents the hashing and binary-conversion facilities above.
Paragonie's current development manifest declares PHP 8 support and GMP; this
does not qualify a particular release. Simplito's manifest also requires GMP,
so it is not proposed as a GMP-free alternative. Tuupola documents multiple
backends and automatic selection; explicit selection is a qualification gate.
The inspected Bech32 package exposes both generic and SegWit codec functions.
The BitWasp concerns come from our preserved, version-specific investigation.

Library documentation, manifests and a focused inspection are preliminary
evidence. This checkpoint adds no new executable qualification results and makes
no claim that every candidate's maintenance, security history or PHP matrix has
already been assessed. Source links to moving branches must be replaced by exact
release/commit references in the eventual selection records.

### Joint research and selection workflow

1. The user fills the empty column with independently researched candidates.
2. Combine both lists by item, retaining why each candidate was proposed. Expand
   the search where neither list provides a credible implementation.
3. Evaluate the same contract, runtime constraints, license, maintenance evidence,
   dependency footprint, vectors, failure cases and reference independence for
   every candidate. Record rejected options and reasons.
4. Discuss the evidence together and explicitly record the selected provider and
   exact version for each item. A recommendation or an empty user cell is not a
   selection or approval; shared providers can cover multiple items.
5. Freeze the resulting contracts and update the plan, then produce concrete
   diagrams. Only then implement the production capability and prepare the
   independent-review snapshot.

[php-hash]: https://www.php.net/manual/en/function.hash.php
[php-hmac]: https://www.php.net/manual/en/function.hash-hmac.php
[php-pack]: https://www.php.net/manual/en/function.pack.php
[php-unpack]: https://www.php.net/manual/en/function.unpack.php
[paragonie]: https://github.com/paragonie/phpecc
[elliptic]: https://github.com/simplito/elliptic-php
[secp]: https://github.com/bitcoin-core/secp256k1
[tuupola]: https://github.com/tuupola/base58
[bech32]: https://github.com/Bit-Wasp/bech32
[bitwasp]: https://github.com/Bit-Wasp/bitcoin-php
[bitwasp-base58]: https://github.com/Bit-Wasp/bitcoin-php/blob/527b1ee7d2cd958b5ce011c7918801ffbfb53f97/src/Base58.php
[bitwasp-raw]: https://github.com/Bit-Wasp/bitcoin-php/blob/527b1ee7d2cd958b5ce011c7918801ffbfb53f97/src/Serializer/Key/HierarchicalKey/RawExtendedKeySerializer.php
[bitwasp-script]: https://github.com/Bit-Wasp/bitcoin-php/blob/527b1ee7d2cd958b5ce011c7918801ffbfb53f97/src/Script/Factory/OutputScriptFactory.php

## 4. Execution sequence and exit gates

| Phase | Work and deliverables | Exit gate | Status |
|---|---|---|---|
| 1. Feasibility research | Merge assistant and user candidates from section 3; compare versioned candidates against D01–D11 and the related C01–C07 considerations. Record scope, license, maintenance/security evidence, runtime requirements, transitive dependencies and known gaps. | Every required item has a documented candidate disposition; unsupported requirements are explicit. No algorithm or codec implementation is invented to close a gap. | In progress: inventory, initial evidence and assistant recommendations available; user research and comparative qualification pending. |
| 2. Qualification spikes and verification corpus | Exercise section 5's contract responsibilities and definition validation. Qualify two distinct libraries through separate adapters for each library-backed boundary, starting with ECC; demonstrate their actual use by unchanged compositions. Run section 1's reuse check and establish normative vectors, negative cases, regression provenance, independent references and reproducible commands. | Required behavior, provider replacement and reuse boundaries are demonstrated; any missing second qualified provider leaves the boundary gate pending; discrepancies are resolved or the candidate is rejected; reference independence is explained. | Pending. |
| 3. Select implementations and freeze contracts | Discuss both candidate lists and qualification evidence together; record explicit implementation selections and rejected alternatives. Finalize public inputs/results/errors, adapter boundaries, definitions and invalid-child behavior. Reconcile accepted documentary changes and then produce concrete diagrams with editable sources. | All decisions in section 5 are closed for this slice; contracts preserve the canonical boundaries and implementations pass the qualification gate. | Pending joint selection. |
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

## 5. Contract responsibilities and decisions to close

The following responsibilities are required; their PHP names and physical package
layout are not frozen. Each contract record must specify input guarantees,
outputs, failure categories, limits, delegated operations and the evidence that
establishes those guarantees. A contract is not defined by a successful example.

| Boundary | Required contract and owner | Verification obligation |
|---|---|---|
| Definition loading | Validate supported profile schemas, exact parameter representations, required/unknown fields and compatible values; produce immutable semantic definitions. | Reject invalid definitions before use; adding compatible network data changes no behavior. Record definition/schema revision with fixtures. |
| Public operation | Accept public extended-key material, explicit relative path, definition and policy; validate compatibility; return a public address result or specified failure. | Exercise all three policies on both networks. No inferred path/policy, network rewriting, index allocation or hidden fallback. |
| Extended-key admission | Delegate structural decoding, then enforce public-only material, exact payload length, root metadata, version interpretation and key validity. Preserve metadata needed for compatibility checks. | Normative valid/invalid fixtures, trailing data and private/unknown versions; a typed value alone is not proof of validation. |
| Public derivation | Enforce non-hardened relative paths and bounds through provider-independent semantics; delegate algorithm machinery. | Exact-index versus advancing behavior, effective path, invalid intermediate children, depth and exhaustion require explicit decisions and tests. |
| ECC operation | Valid compressed key plus admitted scalar tweak gives a valid compressed key or specified failure; all math and parsing machinery delegated. | Zero tweak, range, invalid points and infinity; two real adapters and independent evidence for the mathematical property. |
| Address construction | Reuse the derived compressed key and common hashing; each policy owns its address/script semantics and delegates codecs/serialization. | P2PKH hashes the key; P2WPKH uses the key hash as its witness program; P2SH-P2WPKH also hashes its redeem script. Do not collapse these into one interchangeable hash payload. |
| Failure boundary | Distinguish malformed input, unsupported/incompatible semantics, derivation outcomes and provider/environment failure. | Vendor exceptions do not escape; no partial success or substitution. Freeze exception/result representation and stable error meanings before implementation. |

Request and result design must resolve serialized versus validated key inputs,
where validation occurs, and how requested/effective path and selected
policy/definition remain identifiable when relevant. Routine results need not
expose backend objects or a full audit trace. Keep wallet identifiers out of
automatic diagnostics; review fixtures use public test data.

A complete BIP32 provider may use its own ECC/codec internally. Research must
identify the **actual executed dependency path**: an unused injected adapter does
not prove replaceability. Demonstrate qualified integration through our required
boundaries, or explicitly reconcile a different provider boundary before
selection. Do not keep decorative interfaces or claim coverage for bypassed
adapters; do not fill a provider gap with handwritten CKDpub or codecs.

### Open decisions

| Open decision | Evidence needed to close it |
|---|---|
| Production providers and exact supported versions | Candidate matrix and passing qualification results for the required operations; explicit runtime/extension and transitive dependency analysis. |
| BIP32 implementation integration | Demonstrate the selected provider/composition boundary without porting algorithm internals, losing protocol control or adopting a dependency-shaped domain model. |
| Public-key and extended-key representations | Minimum semantic data, validation guarantees and conversion boundaries; no provider-owned objects in public signatures. |
| Path and invalid-child result contract | Decide exact-index versus advancing behavior, the treatment of non-terminal invalid children, effective-path reporting and exhaustion errors; verify against the specification and controlled tests. |
| Version, network and explicit-policy compatibility | Document accepted public versions and valid combinations, including BIP32 versus SLIP-132 semantics; reject unsupported cases without silently changing intent. |
| Definitions and construction API | Qualify the linked declarative-definition and typed-request invocable proposal against direct composition. Demonstrate profile-specific schema validation, parameter provenance, explicit policy compatibility, immutable semantic views and explicit implementation wiring across all three initial policies; no speculative registry framework. |
| Error taxonomy and resource limits | Separate malformed input, unsupported operation, invalid-child outcomes and backend/runtime failure; bound parsing/path work and document depth and integer limits. |
| Independent verification tools | Exact versions and provenance; shared-dependency analysis demonstrating independence for the property being checked. |
| Concrete PHP APIs and diagrams | Final names, signatures and object relationships derived from the validated contracts, followed by editable diagrams and SVG exports. |

Each decision record must state the requirement, evidence, selected approach,
alternatives, limitations and affected tests. Open entries are intentional work
items, not permission for an implementer to silently guess the final behavior.

## 6. Acceptance and audit evidence

Build a review manifest with stable requirement IDs linking each admitted
requirement to its canonical section, contract, composition, definition/schema,
provider revision, test/vector IDs, command and result artifact. Every required
branch and failure must have evidence or an explicit open gap; a passing count
alone is insufficient. Expected results must come from a justified source,
not be generated by the same implementation under test. Keep these evidence
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
- **Replacement conformance:** for each library-backed capability boundary, the
  same contract suite and consuming compositions pass with two distinct libraries
  through separate adapters, without changing semantic entities, contracts or
  protocol compositions. Record provider versions, API differences, adapter
  translations and explicit wiring changes. A missing qualified alternative is
  an open gate, not evidence of replaceability.
- **Reuse fitness:** demonstrate shared capability use across the three admitted
  address compositions and mainnet/testnet definitions. Document the compatible
  Bitcoin Cash extension analysis without shipping that future capability.
- **Definition and invocation fitness:** verify malformed/unknown definition
  fields, unsupported profiles, conflicting key/network/policy combinations and
  missing wired capabilities fail at their declared boundary. Demonstrate that
  changing valid network parameters requires no behavioral code changes, that
  repeated calls do not mutate definitions, and that the selected public operation
  produces the same results as direct compositions across the three admitted
  policies. Apply this check to the invocable if that proposal is adopted.

Use the existing `composer ci` checks, including Composer metadata/platform
validation, PHP syntax, PHPUnit and PHPStan, on the supported PHP 8.1/8.3 matrix.
Add only capability-relevant checks justified by this work. Verify the complete
standalone flow without loading an upper-layer application.

The independent-review package must identify the reviewed source revision,
dependency lock and source references, definition/schema revisions and selected
semantic policies, runtime/image identity, vector origins,
commands, outputs, artifact hashes, candidate decisions and remaining limitations.
Include a short implementation map identifying the public entry point, contracts,
composition wiring, definition loader, provider adapters and tests, plus decision
records explaining alternatives and rejected candidates. Record known limitations
and reviewer findings with dispositions and affected evidence. This map describes
the implemented revision, not the prospective examples.
Hash manifests are integrity records, not independent attestations. Preserve the
original review snapshot when making changes; produce a new identifiable snapshot
and record which findings and tests the changes affect.

Do not claim a successful reference run certifies Primitives, a loaded-file list
proves branch coverage, a local image ID proves a reproducible build, or an
internal investigation constitutes independent review.

Update this working plan as research closes decisions. Promote only accepted,
reconciled architectural knowledge into the canonical documents; keep experimental
results and rejected candidates identifiable as research evidence.
