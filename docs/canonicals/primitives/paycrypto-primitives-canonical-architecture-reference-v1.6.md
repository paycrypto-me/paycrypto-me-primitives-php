# PayCrypto.Me Primitives --- Canonical Architecture Reference

## Architecture Baseline v1.6

> **Document role:** canonical, self-sufficient architecture reference
> for the **PayCrypto.Me Primitives** domain\
> **Audience:** human engineers, reviewers, architects, and AI agents\
> **Status:** accepted Primitives architecture checkpoint;
> implementation details remain selectively open\
> **Primary concrete requirement that grounded Primitives v1:**
> `XPUB → derived public receiving address`, initially Bitcoin\
> **Replacement policy:** this document **supersedes** the previous
> Primitives canonical/reference document; canonical documents are
> replaced by their latest accepted revision rather than composed
> cumulatively\
> **Reading rule:** when a later discussion conflicts with this
> document, the conflict must be made explicit and resolved as a new
> architecture decision rather than silently changing the model.

> \[!IMPORTANT\] **Scope boundary --- read this before interpreting any
> reference to the rest of PayCrypto.Me.**\
> **Core, SDK, Consumers, External Projects, and other domains are
> referenced in this document only where their relationship with
> PayCrypto.Me Primitives is necessary to establish the Primitives
> boundary, dependency direction, requirement provenance, product
> constraints, or responsibilities. Their internal architecture,
> implementation model, abstractions, APIs, domain model, orchestration,
> lifecycle, and design decisions are outside the scope of this
> architecture revision.**
>
> References to surrounding domains are intentionally shallow. This
> canonical defines Primitives; it does not define the architecture of
> neighboring domains.

------------------------------------------------------------------------

# 0. How to use this document

This file is intentionally more than an architecture diagram. It is the
**source of truth for the Primitives domain at this checkpoint** and is
designed to survive loss of the conversation, memory, or historical
reasoning that produced it.

It preserves:

1.  **the concrete product/technical constraints that justify
    Primitives;**
2.  **the architectural decisions already accepted inside the Primitives
    domain;**
3.  **the reasoning and rejected alternatives behind those decisions;**
4.  **the vocabulary and invariants future Primitives work must
    preserve;**
5.  **what was learned from the current implementation versus what is an
    architectural choice;**
6.  **what remains deliberately undecided;**
7.  **the next work that should be done;**
8.  **fitness tests future proposals should pass before being
    accepted;**
9.  **the relationship of Primitives to surrounding domains only where
    that relationship clarifies the Primitives boundary.**

A new engineer or agent should be able to continue the **Primitives
architecture** from this file without needing the conversation that
produced it.

> \[!NOTE\] Do not interpret the contextual diagrams in this document as
> canonical internal designs for Core, SDK, Consumers, External
> Projects, or any other external domain. Their presence answers
> questions such as **"who requires this capability?"**, **"where does
> this dependency point?"**, and **"what must not leak across the
> Primitives boundary?"**.

> \[!CAUTION\] Do not treat examples in this document as frozen PHP APIs
> unless explicitly marked as an invariant. Most code snippets are
> conceptual contracts used to communicate responsibility.

## 0.1 Operational reading model

This canonical has two reading speeds.

**First orientation.** A new engineer or agent should read enough of the
canonical to understand the Primitives purpose, boundary, vocabulary,
architectural thesis, accepted decisions, and deliberately open
decisions.

**During execution.** The executor should keep the **Counter-Proof
Control Surface** in section 0B as the active architectural index. The
counter-proofs are compressed representations of deeper canonical
knowledge; they do not replace that knowledge.

**On doubt or deviation.** When a counter-proof raises doubt, fails to
hold, or cannot be resolved confidently, follow its **Deep References**
directly to the authoritative detailed sections. Do not repeatedly
reread the entire canonical when the relevant architectural knowledge is
already indexed.

**Before delivery.** Every counter-proof in the declared assessment
coverage must be challenged. An executor records `PASS`, `N/A`, or
`UNRESOLVED` according to the reporting semantics defined by the
companion `COUNTER-PROOF-REPORT.md`.

**Independent verification.** A reviewer independently challenges the
delivered result against the same counter-proofs and records `PASS`,
`N/A`, or `FAIL`. The reviewer does not inherit the executor's states as
conclusions.

The companion report defines the operational recording protocol,
provenance fields, evidence references, FULL/PARTIAL coverage, immutable
report history, and the Executor/Independent Reviewer templates. It does
**not** define Primitives architecture. This canonical remains
authoritative for the meaning and required properties of every
counter-proof.

Material implementation work evaluated through this mechanism is
identified by its project work identity, a **PIP (PayCrypto.Me Improvement Proposal)**.
PIP lifecycle and conventions are governed by the PayCrypto.Me PIP Specification;
this canonical uses the PIP only as the identity of the material work being governed
and evaluated.

Conceptually:

``` text
validated requirement / PIP
          |
          v
planning and implementation
          |
          v
EXECUTOR COUNTER-PROOF GATE
          |
          +-- doubt / violation / unresolved
          |          |
          |          v
          |    investigate / revise
          |          |
          +----------+
          |
          v
candidate result
          |
          v
INDEPENDENT COUNTER-VERIFICATION
          |
     +----+----+
     |         |
 PASS / N/A   FAIL
     |         |
     v         v
 compliant   return to execution
 result          |
                 +--> partial corrective cycle when appropriate
```

A later corrective cycle does not rewrite historical reports. It creates
new immutable reports. A PARTIAL cycle may reassess only explicitly
declared counter-proofs, plus any additional counter-proofs materially
affected by the change.

------------------------------------------------------------------------

# 0A. Canonical Terminology

This section defines only PayCrypto.Me-specific, locally coined, or locally specialized terminology whose intended meaning cannot be safely inferred from the technical expertise expected of this canonical's audience.

It is **not** a glossary of software engineering, cryptography, Bitcoin, or protocol terminology. Standard technical terms are defined in place only when Primitives gives them additional architectural semantics.

**PIP — PayCrypto.Me Improvement Proposal**  
Project-wide mechanism and stable work identity for a material proposed change to PayCrypto.Me. PIP lifecycle, storage, and proposal conventions are governed by the **PayCrypto.Me PIP Specification**. A PIP identifies the work; it does not itself define Primitives architecture.

**CP — Counter-Proof**  
Stable identifier prefix for a Counter-Proof in this canonical's execution-time Control Surface (`CP-01`, `CP-02`, ...). A CP challenges whether a material result preserves a required Primitives architectural property.

**OWN / COMPOSE / DELEGATE**  
Primitives-specific responsibility model defined normatively in §10. The terms are used together as an architectural decision framework, not merely in their ordinary English meanings.

**Consumer**  
PayCrypto.Me architectural role inside the surrounding canonical topology that uses the SDK. It does not mean any generic consumer of the public Primitives library.

**External Project**  
A project outside the PayCrypto.Me architectural topology that independently consumes the public Primitives library.

---

# 0B. Counter-Proof Control Surface

The Counter-Proof Control Surface is the compact execution-time index of
this canonical. It exists to reduce retrieval cost without reducing
architectural rigor.

> **Counter-proofs constrain architectural outcomes, not implementation
> techniques.**

They define properties a compliant implementation must preserve. They
must not prescribe implementation techniques where this canonical
deliberately leaves implementation open.

> **Counter-Proof Discipline**
>
> Whenever an implementation decision introduces or changes a
> capability, composition, definition, adapter, dependency, semantic
> type, execution path, protocol-specific behavior, or another material
> Primitives decision, the executor MUST challenge the decision against
> every applicable counter-proof in the declared coverage.
>
> Passing tests or satisfying the immediate use case does not waive this
> gate. If an applicable counter-proof cannot be satisfied or
> conclusively demonstrated, the executor records it as `UNRESOLVED`;
> that disclosure is not canonical compliance.
>
> `N/A` means only that a counter-proof is genuinely outside the scope
> of the assessed decision. It MUST be justified. `N/A` never removes
> the underlying canonical invariant from the architecture.
>
> The independent reviewer MUST challenge both executor `PASS` results
> and the legitimacy of every executor-declared `N/A`. A reviewer `FAIL`
> returns the affected work to execution.
>
> Passing the current use case is not sufficient. A result is
> canonical-compliant only when independent verification leaves no
> applicable counter-proof failed or unresolved.

The counter-proofs are intentionally ordered as a cognitive progression:
**reason for existence -\> reuse -\> divergence/data -\> composition -\>
ownership -\> external implementation boundaries -\>
replaceability/containment -\> domain isolation -\> security boundary
-\> protocol correctness -\> verification -\> scope discipline**.

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

## 0B.1 Executor and independent reviewer semantics

The same counter-proofs are used by two different actors with different
state vocabularies.

``` text
EXECUTOR                       INDEPENDENT REVIEWER
---------------------------    ---------------------------
PASS                           PASS
N/A + justification            N/A + justification
UNRESOLVED + justification     FAIL + finding
```

For both actors, `PASS` requires no justification. A short note MAY be
added only when materially useful to future execution, review, or
understanding; it should not merely restate the counter-proof.

For the executor, `UNRESOLVED` is disclosure, not compliance. It may
document an objective blocker, missing third-party evidence, unresolved
correctness question, or another material reason the counter-proof
cannot yet be conclusively satisfied.

For the reviewer, `FAIL` is an independent rejection of the assessed
result against an applicable counter-proof.

The operational report format and provenance requirements are delegated
to `COUNTER-PROOF-REPORT.md`.

------------------------------------------------------------------------

# 1. Primitives in the surrounding architecture

Primitives is a low-level domain inside a broader PayCrypto.Me
architecture. Only the relationship necessary to define the Primitives
boundary is canonical here.

``` text
Consumer
             │
             ▼
        PayCrypto.Me SDK
             │
             ▼
        PayCrypto.Me Core
             │
             ▼
════════ PRIMITIVES BOUNDARY ════════
             │
             ▼
     PayCrypto.Me Primitives
             │
             ▼
 selected low-level implementations
```

For this document, the significant facts are:

``` text
higher-level product intent
          │
          ▼
         Core
          │ requires a capability
          ▼
════════════════════════════════
       PRIMITIVES BOUNDARY
════════════════════════════════
          │
          ▼
      Primitives
          │
          ▼
 implementation adapters
```

The internal design of the boxes above the boundary is intentionally
left to their own canonical documents.

## 1.1 Contextual dependency rule

At this boundary, dependency/knowledge flows downward:

``` text
Consumer → SDK → Core → Primitives → selected implementation
```

The Primitives-specific consequences are:

-   Primitives does not depend on Core domain objects merely to perform
    low-level cryptographic/protocol work.
-   Primitives does not know consumer-specific concepts or the internal
    architecture of surrounding domains.
-   Core-facing capability boundaries must not expose external
    crypto-library types.
-   Consumers should not need to know which BIP32, ECC, Base58, Bech32,
    or other low-level implementation Primitives selected.
-   Replacing a low-level backend must not force changes into
    higher-level domains merely because an implementation-specific type
    leaked upward.

> **Core expresses the requirement/intent; Primitives owns the low-level
> protocol mechanics needed to satisfy the Primitives capability.**

This sentence defines the boundary only; it does not prescribe Core's
internal architecture.

## 1.2 Product constraint visible from Primitives

A broader PayCrypto.Me product constraint matters directly to this
domain:

> **Basic/local non-custodial payment acceptance must be possible
> without making PayCrypto.Me cloud infrastructure a mandatory
> dependency for local cryptographic/protocol capabilities.**

Therefore Primitives must be capable of supporting local execution for
the capabilities it owns.

Conceptually:

``` text
Customer
   │ blockchain payment
   ▼
Merchant-controlled wallet

Consumer
   │
   ▼
 SDK / Core
   │
   ▼
════════════════════════════
 PayCrypto.Me Primitives
════════════════════════════
   │
   ▼
local cryptographic/protocol capability
```

## 1.3 New-major context

The current WooCommerce implementation is not being treated as the
architecture blueprint for Primitives.

The new-major direction is conceptually:

``` text
Consumer
   ↓
 SDK
   ↓
 Core
   ↓
 Primitives
   ↓
 selected low-level implementations
```

The current plugin is valuable because it contains **behavioral
evidence**: it tells us what cryptographic/protocol behavior the product
already relies on. It does not automatically determine the new
Primitives class hierarchy, package structure, dependencies, or backend
selection.

> **Existing code is evidence of required behavior, not authority over
> the new architecture.**

------------------------------------------------------------------------

# 2. Architectural thesis

> **PayCrypto.Me Primitives is a capability boundary, not a crypto
> library catalog.**

A second, equally important characterization is:

> **PayCrypto.Me Primitives is primarily an aggregator and composer of
> low-level cryptographic/protocol capabilities, not an implementer of
> cryptographic algorithms.**

Operational shorthand:

> **We own the composition, not the cryptography.**

Full definition:

> **PayCrypto.Me Primitives is a demand-driven low-level cryptographic
> and protocol capability layer whose composition exists in response to
> validated concrete requirements, while keeping implementations
> isolated, verifiable, and replaceable.**

PayCrypto.Me Core is the first concrete consumer and primary initial
requirement source, not the exclusive consumer. A requirement from any
source becomes architectural evidence only after passing the same
capability, composition, divergence, security, and evidence gates
defined by this domain.

## 2.1 First consumer does not mean exclusive consumer

PayCrypto.Me Core is the **first concrete consumer and primary initial
source of requirements** that justified this domain. That is already a
sufficient reason for Primitives to exist.

Primitives may also be published and consumed as an independent open
library:

``` text
                 PayCrypto.Me Core
                       |
                       | first concrete consumer
                       | and requirement source
                       v
              +--------------------+
              |   PayCrypto.Me     |
              |     Primitives     |
              +--------------------+
                ^        ^        ^
                |        |        |
           external   external   external
           project A  project B  project C
```

External adoption is additive value, not a prerequisite for
architectural legitimacy. External requirements may become additional
architectural evidence, but they do not automatically justify scope
expansion. They must pass the same capability, composition, divergence,
security, and evidence tests as requirements originating inside
PayCrypto.Me.

This changes the potential audience of the library, not its
demand-driven architecture.

The architecture grows downward from concrete requirements:

``` text
concrete higher-level requirement
          │
          ▼
 required Primitives capability
          │
          ▼
 minimal protocol composition
          │
          ▼
 minimal primitive contracts
          │
          ▼
 selected implementation/dependency
```

Never upward from a library:

``` text
external library API
        │
        ✕
        ▼
PayCrypto architecture
```

------------------------------------------------------------------------

# 3. Architecture orientation

The accepted Primitives orientation is:

> **Capability-driven, composition-first, behavior-oriented late
> specialization, with evidence-driven abstractions and
> implementation-independent boundaries.**

The most important rule is:

> **Do not bifurcate by technology or coin name. Bifurcate only where
> behavior actually diverges.**

Equivalent formulation:

> **Share until the last common behavior; specialize only the dimension
> that varies.**

And the anti-overengineering rule:

> **Design for extension; do not implement speculation.**

A complementary rule governs class/interface creation:

> **Every abstraction needs a concrete reason to exist. Taxonomy,
> library APIs, foreseeable possibilities, and design-pattern
> availability are not sufficient reasons by themselves.**

------------------------------------------------------------------------

# 4. What is --- and is not --- canonical in this document

## 4.1 Canonical here

This document is authoritative for the current Primitives checkpoint
regarding:

``` text
Primitives purpose
Primitives boundary
capability-driven design
composition model
definition/data model
OWN / COMPOSE / DELEGATE
BIP32 responsibility
SLIP-132 separation
ECC/secp256k1 boundary
hashing/encoding capability model
Bitcoin address compositions required by current evidence
public-key-only v1 security scope
dependency justification
backend replaceability
verification philosophy
Bitcoin-like/non-Bitcoin extension philosophy
rejected Primitives approaches
open Primitives decisions
continuation sequence
fitness tests
```

## 4.2 Context only

The following may appear in diagrams or explanations, but are **not
internally specified here**:

``` text
PayCrypto.Me Core
PayCrypto.Me SDK
Consumers
External Projects
other surrounding domains
their internal modules
their public APIs
their domain models
their orchestration
their lifecycle/versioning policies
their own architectural decisions
```

Their detailed definitions belong to parallel canonical documents.

## 4.3 Preservation rule

When revising this canonical file:

> **Do not remove an accepted Primitives decision, invariant, rationale,
> rejected alternative, open question, or continuation requirement
> merely to shorten the document.**

If a materialized or accepted Primitives decision becomes obsolete,
replace it with an explicit superseding decision and rationale. Absence
is not an acceptable migration mechanism for architectural knowledge
that legitimately belongs to this domain.

Exploratory concepts that are rejected or determined to be outside the
Primitives domain before becoming part of its materialized architecture
do not require permanent historical memorialization in the current
canonical. The preservation rule protects domain knowledge, not every
discarded exploration.

------------------------------------------------------------------------

# 5. Concrete evidence that grounded Primitives v1

The current WooCommerce implementation was investigated specifically to
answer:

> **What low-level behavior are we actually using today?**

The discovered production flow is conceptually:

``` text
account-level extended public key
        │
        ▼
extended-key decode / version handling
        │
        ▼
BIP32 non-hardened derivation: 0/index
        │
        ├── HMAC-SHA512
        └── secp256k1 public-key operation
        │
        ▼
compressed child public key
        │
        ▼
HASH160 / address semantics
        │
        ├── P2PKH
        ├── P2SH-P2WPKH
        └── P2WPKH
        │
        ▼
Base58Check / Bech32
        │
        ▼
public receiving address
```

The current production path does **not** require:

``` text
seed
mnemonic
xprv
CKDpriv
master-key generation
hardened child derivation
ECDSA signing
transaction signing
private-key handling
```

This evidence is why Primitives v1 is intentionally public-key-only.

The old implementation also revealed implementation leakage: GMP is
required by parts of the current Base58/Buffertools/PhpEcc path, but GMP
is **not a product capability**. Therefore:

> **GMP is a property of the current implementation, not a property of
> the Core requirement.**

That distinction is representative of the purpose of Primitives.

------------------------------------------------------------------------

# 6. Final conceptual diagram

``` mermaid
flowchart TB
    CORE["PayCrypto.Me Core<br/>Payment / WalletPolicy / Allocation / ReceivingSource"]
    PAD["PublicAddressDeriver"]

    CORE --> PAD

    subgraph PRIM["PayCrypto.Me Primitives"]
      direction TB

      subgraph CRYPTO["Crypto capabilities"]
        SHA["Sha256"]
        RIPE["Ripemd160"]
        HMAC["HmacSha512"]
        SECP["Secp256k1 Public-Key Tweak<br/>P + tweak·G → Q"]
        H160["Hash160<br/>COMPOSE"]
        SHA --> H160
        RIPE --> H160
      end

      subgraph HD["HD schemes"]
        XPUB["ExtendedPublicKey"]
        PATH["DerivationPath"]
        CODEC["ExtendedPublicKeyCodec"]
        CKD["BIP32 PublicChildDeriver / CKDpub"]
        XPUB --> CKD
        PATH --> CKD
        CODEC --> XPUB
        HMAC --> CKD
        SECP --> CKD
      end

      subgraph ENC["Encoding capabilities"]
        B58["Base58"]
        B58C["Base58Check"]
        B32["Bech32"]
        B58 --> B58C
      end

      subgraph BTC["Bitcoin protocol compositions"]
        SLIP["SLIP-132 semantics"]
        P2PKH["P2PKH"]
        P2SHW["P2SH-P2WPKH"]
        P2W["P2WPKH"]
        H160 --> P2PKH
        H160 --> P2SHW
        H160 --> P2W
        B58C --> P2PKH
        B58C --> P2SHW
        B32 --> P2W
      end

      subgraph DEF["Definitions — declarative data"]
        BTCDEF["bitcoin-mainnet"]
        LTCDEF["litecoin-mainnet"]
        DOGEDEF["dogecoin-mainnet"]
        OTHER["..."]
      end
    end

    PAD --> CKD
    CKD --> P2PKH
    CKD --> P2SHW
    CKD --> P2W

    DEF -. "parameters" .-> BTC

    subgraph IMPL["Implementation adapters"]
      PHP["Trusted runtime hashing"]
      PARA["paragonie/ecc<br/>initial candidate"]
      ALT["Alternative backend<br/>future"]
    end

    SHA --> PHP
    RIPE --> PHP
    HMAC --> PHP
    SECP --> PARA
    SECP --> ALT
```

## 6.1 Text fallback

``` text
┌────────────────────────────────────────────────────────────────────┐
│                         PAYCRYPTO.ME CORE                          │
│                                                                    │
│  Payment / WalletPolicy / Allocation / ReceivingSource / ...       │
│                                                                    │
│                    PublicAddressDeriver                            │
└──────────────────────────────┬─────────────────────────────────────┘
                               │ capability request
                               ▼
════════════════════ CORE / PRIMITIVES BOUNDARY ═════════════════════

                    PAYCRYPTO.ME PRIMITIVES

        ┌────────────────┬────────────────┬────────────────┐
        ▼                ▼                ▼                ▼
      CRYPTO             HD            ENCODING       DEFINITIONS
        │                │                │                │
 SHA256 ─┐         ExtendedPublicKey    Base58       declarative data
         ├─ Hash160     DerivationPath     │          BTC / LTC / ...
RIPEMD160┘               │             Base58Check
                         ▼
HMAC-SHA512 ───────► BIP32 CKDpub       Bech32
                         ▲
                         │
               Secp256k1 PublicKeyTweak
                  P + tweak·G → Q
                         │
                         ▼
                 PublicKey result
                         │
          ┌──────────────┼───────────────┐
          ▼              ▼               ▼
        P2PKH       P2SH-P2WPKH       P2WPKH
          │              │               │
     Base58Check    Base58Check         Bech32

════════════ PRIMITIVES / IMPLEMENTATION BOUNDARY ════════════════════

     trusted hash runtime       selected ECC backend
                                      │
                               paragonie/ecc
                               initial candidate
```

------------------------------------------------------------------------

# 7. Capability graph, not a hierarchy of blockchains

Do not model every coin as a monolithic implementation:

``` text
Bitcoin
├── BitcoinBip32
├── BitcoinSecp256k1
├── BitcoinHash160
└── BitcoinBase58

Litecoin
├── LitecoinBip32
├── LitecoinSecp256k1
├── LitecoinHash160
└── LitecoinBase58
```

Instead, reuse identical capabilities:

``` mermaid
flowchart TB
    HMAC["HMAC-SHA512"] --> BIP32["BIP32"]
    SECP["secp256k1"] --> BIP32
    BIP32 --> PUB["PublicKey"]
    PUB --> H160["HASH160"]

    H160 --> BTC["Bitcoin composition"]
    H160 --> LTC["Litecoin composition"]
    H160 --> DOGE["Dogecoin composition"]
    H160 --> BCH["Bitcoin Cash compatible flow"]

    DBTC["Bitcoin definition"] -.-> BTC
    DLTC["Litecoin definition"] -.-> LTC
    DDOGE["Dogecoin definition"] -.-> DOGE
    DBCH["Bitcoin Cash definition"] -.-> BCH

    BCH --> CASH["Divergent address capability<br/>e.g. CashAddr when required"]
```

The Docker-layer analogy is useful **only as a composition/reuse mental
model**:

``` text
same lower behavior
      │
      ├─────────────┬─────────────┐
      ▼             ▼             ▼
   Bitcoin       Litecoin       Dogecoin
      │
      └── fork only when semantics diverge
```

This is not inheritance.

------------------------------------------------------------------------

# 8. Primitive Composition Principle

> **A protocol flow should be composed from the smallest reusable
> capabilities available, sharing every capability whose behavior is
> identical and forking only where protocol semantics actually
> diverge.**

Equivalent:

> **Share until the last common behavior; specialize only the dimension
> that varies.**

This prevents both extremes:

``` text
EXTREME A — duplication

BitcoinImplementation
LitecoinImplementation
DogecoinImplementation
BitcoinCashImplementation
```

and:

``` text
EXTREME B — universal monster

UniversalBlockchainDeriver(
    curve,
    hash,
    encoding,
    magicBehavior,
    ...
)
```

The target is a graph of small capabilities composed into protocol
flows.

------------------------------------------------------------------------

# 9. Definitions: data is not behavior

A major accepted decision is to avoid classes whose primary reason to
exist is holding network constants.

In PHP, definitions may naturally be associative arrays:

``` php
return [
    'bitcoin' => [
        'mainnet' => [
            'base58' => [
                'p2pkh' => '00',
                'p2sh'  => '05',
            ],
            'bech32' => [
                'hrp' => 'bc',
            ],
            'bip32' => [
                'xpub' => '0488b21e',
            ],
        ],
    ],
];
```

In Go the same architecture might use structs. In another ecosystem,
another native declarative representation.

The architecture is:

``` text
declarative definition source
            │
            ▼
      validation/loading
            │
            ▼
     validated definition
            │
            ▼
      protocol behavior
```

Not:

``` text
PHP array is the architecture
```

## 9.1 Governing rule

> **Variation of parameters → Definition.\
> Variation of behavior → Capability.**

Therefore:

``` text
new network
     │
     ▼
Does behavior change?
     │
 ┌───┴────┐
 NO       YES
 │         │
 ▼         ▼
Definition  Capability /
only        Composition
```

A new network **must not require a new behavioral class** if all
differences can be represented by data supported by existing
capabilities.

## 9.2 Definitions should not leak raw storage shape

Associative arrays are fine as a source, but protocol code should
consume validated definition semantics rather than scatter raw string
keys everywhere.

> **Definitions contain data; strategies/capabilities contain
> behavior.**

------------------------------------------------------------------------

# 10. OWN / COMPOSE / DELEGATE

This is a central decision framework.

## WE OWN

PayCrypto owns protocol/product semantics whose control improves
correctness, resilience, or independence.

Current candidates:

``` text
ExtendedPublicKey representation
DerivationPath
BIP32 CKDpub semantics
SLIP-132 interpretation
Bitcoin address compositions
definition schema/validation
```

`OWN` does **not** mean "reinvent cryptography."

## WE COMPOSE

PayCrypto owns the larger behavior but assembles it from smaller
capabilities.

``` text
Hash160
    =
Sha256 + Ripemd160

Bip32PublicChildDeriver
    =
HmacSha512 + Secp256k1PublicKeyTweak

P2WPKH
    =
Hash160 + Bitcoin witness/address semantics + Bech32
```

## WE DELEGATE

PayCrypto owns the contract but deliberately delegates sensitive
low-level machinery:

``` text
SHA-256
RIPEMD-160
HMAC-SHA512
secp256k1 mathematical machinery
```

> **Primitives does not eliminate dependencies; it prevents dependencies
> from defining the architecture.**

------------------------------------------------------------------------

# 10A. Implementation Delegation Principle

The `OWN / COMPOSE / DELEGATE` model must not be interpreted as
permission to reimplement standardized cryptographic machinery merely
because an implementation appears small, understandable, or easy.

> **PayCrypto.Me Primitives owns capability contracts, protocol
> semantics, composition, invariants, definitions, semantic value
> objects, and integration boundaries. It does not seek ownership of
> cryptographic algorithms, elliptic-curve mathematics, standardized
> low-level codecs, or equivalent specialized machinery when suitable
> language/runtime facilities or specialized libraries can provide
> them.**

Short form:

> **We own the composition, not the cryptography.**

The preferred responsibility split is:

``` text
PayCrypto.Me Primitives
|
+-- OWNS
|   +-- capability contracts
|   +-- protocol semantics
|   +-- deterministic composition
|   +-- definitions and their validation boundary
|   +-- protocol/domain invariants
|   +-- semantic value objects
|   +-- typed outcomes/errors at its boundary
|   `-- integration boundaries
|
+-- COMPOSES
|   +-- hashing capabilities
|   +-- elliptic-curve capabilities
|   +-- encoders / decoders
|   +-- structural codecs
|   `-- protocol operations
|
`-- DELEGATES
    +-- cryptographic algorithms
    +-- elliptic-curve mathematics
    +-- standardized low-level codecs
    `-- equivalent specialized machinery
             |
             v
       language/runtime facilities
       or specialized libraries
```

This is **not** a prohibition against Primitives having its own
functions or implementation code. Primitives necessarily contains code
that expresses PayCrypto.Me-owned semantics: orchestration, validation,
conversion between semantic representations, composition, capability
selection, fail-closed behavior, definitions, and protocol-specific
invariants.

The distinction is the **reason the code exists**.

For example, a BIP32 public derivation composition may be owned by
Primitives because Primitives must control CKDpub semantics and their
interaction. The cryptographic machinery underneath it should still be
delegated:

``` text
Bip32PublicDeriver                 <- OWN / COMPOSE
        |
        +-- HMAC-SHA512            <- DELEGATE
        |
        `-- secp256k1 pubkey tweak <- DELEGATE
```

Similarly, the existence of a simple reference implementation of a hash,
checksum, encoder, decoder, or curve operation is not by itself a reason
to reproduce that algorithm inside Primitives.

Decision test:

``` text
Does this code express PayCrypto.Me protocol/capability semantics?
        |
   +----+----+
   |         |
  yes        no
   |         |
OWN/COMPOSE  Is this standardized low-level machinery
             available from an appropriate runtime/library?
                    |
               +----+----+
               |         |
              yes        no
               |         |
           DELEGATE    investigate explicitly;
                       do not silently reinvent it
```

This strengthens, rather than replaces, the original
`OWN / COMPOSE / DELEGATE` model.

# 11. Minimal secp256k1 contract

This is one of the strongest decisions in this checkpoint.

The architecture must **not** reproduce the API of Paragonie/ECC,
Simplito/Elliptic-PHP, libsecp256k1, or any other implementation.

Do not expose:

``` text
Point
Generator
add(Point, Point)
double(Point)
multiply(Point, Scalar)
recoverY(...)
inverseModulo(...)
generic Curve
```

The concrete BIP32 CKDpub requirement is semantically:

``` text
Q = P + tweak·G
```

Therefore the smallest currently justified ECC capability is
approximately:

``` text
CompressedPublicKey
       +
32-byte scalar tweak
       │
       ▼
Secp256k1PublicKeyTweak
       │
       ▼
CompressedPublicKey
```

A conceptual PHP-like contract might eventually resemble:

``` php
interface Secp256k1PublicKeyTweaker
{
    public function addScalar(
        CompressedPublicKey $publicKey,
        Scalar256 $tweak
    ): CompressedPublicKey;
}
```

**This exact signature/name is not frozen. The semantic boundary is.**

## 11.1 Backend responsibilities

An adapter may internally need to:

``` text
parse compressed key
recover/decode point
validate point
multiply generator by scalar
add points
handle modular arithmetic
serialize compressed result
```

Those are backend mechanisms, not PayCrypto capabilities.

## 11.2 Boundary invariant

The following must never escape into BIP32/Core/SDK:

``` text
Mdanter\Ecc\Point
Elliptic\Curve\Point
BN
GMP objects
native libsecp256k1 structs
other library-specific key/point/scalar types
```

## 11.3 Why three ECC ecosystems were considered

The comparison is used to **stress-test our abstraction**, not to select
our architecture from their APIs.

-   `paragonie/ecc`: initial implementation candidate; generic ECC
    machinery can be hidden behind our adapter.
-   `simplito/elliptic-php`: useful counterexample/reference because a
    BIP32-style flow can be expressed through explicit point
    decode/multiply/add/encode operations.
-   `libsecp256k1`: useful conceptual reference because
    secp256k1-specific APIs include higher-level public-key tweak
    operations.

If our contract only makes sense with one of those APIs, it is too
coupled.

> **The abstraction must remain meaningful if the current backend
> disappears tomorrow.**

------------------------------------------------------------------------

# 12. BIP32 responsibility

BIP32 is a **protocol composition**, not an atomic cryptographic
primitive.

``` text
Bip32PublicChildDeriver
          │
          ├── HmacSha512
          │
          └── Secp256k1PublicKeyTweak
```

BIP32 owns BIP32 protocol semantics.

ECC owns ECC validity/mechanics.

The BIP32 layer must not know backend point objects or generic curve
operations.

## 12.1 Extended public keys

Conceptually:

``` text
serialized extended public key
           │
           ▼
ExtendedPublicKeyCodec
           │
           ▼
ExtendedPublicKey
├── depth
├── parent fingerprint
├── child number
├── chain code
└── compressed public key
```

`ExtendedPublicKeyCodec` composes lower-level encoding capabilities;
Base58 does not know what an XPUB is.

## 12.2 SLIP-132 separation

SLIP-132 semantics are not generic BIP32.

The meaning of prefixes such as `xpub`, `ypub`, `zpub`, `tpub`, `upub`,
and `vpub` belongs to Bitcoin-family extended-key/address-policy
semantics.

Therefore:

``` text
HD/Bip32
    └── ExtendedPublicKey

Bitcoin/ExtendedKey
    └── SLIP-132 semantics
```

------------------------------------------------------------------------

# 13. Hashing and encoding

## 13.1 Atomic/delegated hashing capabilities

``` text
Sha256
Ripemd160
HmacSha512
```

## 13.2 Hash composition

``` text
Hash160(x)
=
RIPEMD160(SHA256(x))
```

`Hash160` is a composition PayCrypto can own while delegating the
underlying algorithms.

## 13.3 Encoding

Currently justified:

``` text
Base58
Base58Check
Bech32
```

`Base58Check` is conceptually a composition of Base58 plus checksum
semantics.

Whether Base58 and Bech32 are implemented by PayCrypto or delegated
remains open pending implementation research.

------------------------------------------------------------------------

# 14. Bitcoin address compositions in v1

The concrete current requirement justifies:

``` text
P2PKH
P2SH-P2WPKH
P2WPKH
```

Conceptually:

``` text
PublicKey
   │
   ▼
Hash160
   │
   ├──────────────┬────────────────┐
   ▼              ▼                ▼
 P2PKH       P2SH-P2WPKH        P2WPKH
   │              │                │
Base58Check   Base58Check         Bech32
```

`P2SH-P2WPKH` is not optional in the baseline because the existing
plugin behavior supports the corresponding extended-key/address flow.

------------------------------------------------------------------------

# 15. Public-key-only v1 security property

Allowed in v1:

``` text
ExtendedPublicKey
PublicKey
CKDpub
non-hardened public derivation
public-key hashing
public address construction
public-key validation
encoding
```

Out of scope:

``` text
seed
mnemonic
private key
xprv
CKDpriv
hardened private derivation
signing
transaction signing
```

> **No private capability enters Primitives until a concrete
> Core/product requirement demands private material.**

This is a deliberate security-surface reduction and aligns with the
non-custodial product model.

------------------------------------------------------------------------

# 16. Future resilience: Taproot as a fitness test, not a feature

Taproot is intentionally **not implemented in v1** merely because it is
foreseeable.

Do not add today solely for future use:

``` text
P2TR
Bech32m
x-only public-key operations
Taproot-specific tweaks
Schnorr
tagged hashing
```

Instead, ask whether the architecture can later grow like this:

``` text
TODAY

Secp256k1 capabilities
└── PublicKeyTweak

Encoding
└── Bech32

Bitcoin Address
├── P2PKH
├── P2SH-P2WPKH
└── P2WPKH


FUTURE — only after concrete requirement

Secp256k1 capabilities
├── PublicKeyTweak
└── + XOnly/Taproot capability

Encoding
├── Bech32
└── + Bech32m

Bitcoin Address
├── existing schemes
└── + P2TR
```

A future requirement should introduce a new capability only where new
behavior genuinely appears.

> **Extensible is not the same as anticipatory.**

------------------------------------------------------------------------

# 17. Bitcoin-like and other protocol families

`Bitcoin-like` is useful terminology for humans, but it is **not yet a
required code abstraction**.

Do not create merely because the category exists:

``` text
namespace BitcoinLike
interface BitcoinLikeNetwork
abstract class BitcoinLike...
```

Let shared behavior emerge through shared capabilities.

For example:

``` text
Bitcoin ─────┐
Litecoin ────┼──► BIP32 / secp256k1 / Hash160 / ...
Dogecoin ────┘
```

If a future concrete shared behavior deserves an explicit `BitcoinLike`
abstraction, introduce it then.

> **Taxonomy does not automatically become code.**

------------------------------------------------------------------------

# 18. Fork only at the real divergence point

A protocol that shares derivation but changes final address encoding
should not duplicate the entire derivation stack.

Conceptual example:

``` text
XPUB
 │
 ▼
BIP32
 │
 ▼
secp256k1
 │
 ▼
PublicKey
 │
 ▼
Hash160
 │
 ├─────────────────────────────┐
 ▼                             ▼
Bitcoin-compatible flow    divergent flow
 │                             │
Base58/Bech32               CashAddr/etc.
```

This is the architecture's "shared layers" principle.

------------------------------------------------------------------------

# 19. Non-Bitcoin protocols are architecture fitness tests

Cardano, Solana, Zcash shielded flows, and other substantially different
systems are **not v1 implementation scope**.

They are useful as weak architecture tests:

> Can a future flow coexist without being forced to pretend it is
> BIP32/secp256k1/Bitcoin?

The model must permit:

``` text
Protocol
   │
   ├── Flow A
   │     └── capability composition A
   │
   └── Flow B
         └── capability composition B
```

A single protocol may itself contain multiple derivation/address flows.

Therefore:

> **Coin/network identity does not define the cryptographic pipeline.
> The selected protocol capability/composition does.**

This is why Core must not switch directly on coin/network names to
assemble cryptographic machinery.

------------------------------------------------------------------------

# 20. Core must not assemble cryptographic LEGO

Do not write Core logic like:

``` php
if ($network === 'bitcoin') {
    $curve = new Secp256k1(...);
    $hash = new Hash160(...);
    $encoder = new Bech32(...);
}
```

Core should say, conceptually:

``` text
derive a public receiving address
for this wallet policy/source/path
```

Then:

``` text
Core
 │
 ▼
PublicAddressDeriver
 │
════════════════════
 │
 ▼
Protocol Composition
 │
 ├── HD capability
 ├── crypto capabilities
 ├── address composition
 ├── encoding
 └── definitions
```

------------------------------------------------------------------------

# 21. Patterns policy

The architecture does not collect design patterns for prestige.

The process is:

``` text
behavior exists
      │
      ▼
pattern accurately describes it?
      │
   ┌──┴──┐
  yes    no
   │      │
 use it  do not force it
```

Chain of Responsibility was explicitly considered and rejected for the
derivation pipeline.

Why:

``` text
Chain of Responsibility:
handler.canHandle?
   no → next handler

Our derivation:
deterministic composition of required capabilities
```

The derivation flow is better described as **composition/pipeline**, not
Chain of Responsibility.

> **Patterns are vocabulary for behavior we already have, not features
> we add to make the architecture look sophisticated.**

------------------------------------------------------------------------

# 22. No universal CryptoManager

Reject designs that trend toward:

``` text
PayCryptoCryptoManager
├── bitcoin()
├── ethereum()
├── solana()
├── derive()
├── sign()
├── verify()
├── encode()
└── ...
```

Primitives should remain a graph of small capabilities with clear
reasons to exist.

For every proposed capability ask:

1.  Which validated concrete requirement requires it?
2.  Does an existing capability already express it?
3.  Is the difference behavior or only data?
4.  Can existing capabilities be composed instead?
5.  What is the smallest semantic contract?
6.  Is the contract ours, or copied from a dependency API?
7.  Would the contract still make sense if the current implementation
    vanished?

If #7 is "no", the abstraction is likely at the wrong level.

------------------------------------------------------------------------

# 23. Dependency justification tree

Every production dependency must be explainable upward:

``` text
PayCrypto Core
└── needs derived receiving address
    │
    └── PublicAddressDeriver
        │
        └── BIP32 Public Derivation
            │
            ├── HMAC-SHA512
            │
            └── secp256k1 PublicKeyTweak
                │
                └── selected ECC implementation
```

## Primitives Dependency Principle

> **Every production dependency of PayCrypto.Me Primitives must be
> justified by a concrete admitted Primitives capability backed by a
> validated requirement.**

PayCrypto.Me Core remains the first concrete consumer and primary
initial requirement source. Requirements originating elsewhere do not
enter the architecture automatically; they must pass the same evidence,
composition, divergence, and security gates. A dependency with no
traceable path to an admitted Primitives capability should not ship in
production.

------------------------------------------------------------------------

# 24. External projects: implementation and reference roles

External projects may relate to Primitives in distinct roles without
their APIs defining the Primitives architecture.

  ---------------------------------------------------------------------
  Role                               Meaning
  ---------------------------------- ----------------------------------
  **Production implementation**      Actually shipped to satisfy a
                                     Primitives capability

  **Reference implementation**       Used for independent differential
                                     or compatibility verification
  ---------------------------------------------------------------------

The same project may serve both roles, but one role does not imply the
other. Information from an external project may become evidence for a
Primitives decision when it is relevant to a capability, implementation,
or compatibility constraint.

Examples conceptually:

``` text
BitWasp
└── possible reference

paragonie/ecc
├── initial production candidate
└── possible reference

libsecp256k1
├── reference
└── possible future adapter target
```

BitWasp does **not** automatically enter the new production architecture
merely because the old plugin uses it.

------------------------------------------------------------------------

# 25. Backend replacement policy

Production should deliberately select one implementation per capability.

Do not implement silent runtime crypto fallback:

``` text
try Backend A
catch → Backend B
catch → Backend C
```

That can hide correctness or compatibility failures.

Replacement should be:

``` text
known problem / lifecycle event
            │
            ▼
     affected capability
            │
            ▼
 alternative implementation
            │
            ▼
 compatibility test suite
            │
            ▼
 explicit reviewed switch
            │
            ▼
       Core unchanged
       SDK unchanged
       Consumer unchanged
```

> **Backend replacement is explicit, verified, and fail-closed.**

------------------------------------------------------------------------

# 26. Verification strategy

Sensitive protocol behavior requires multiple independent anchors.

``` text
Official/reference vectors
          +
PayCrypto regression vectors
          +
known-good implementation outputs
          +
boundary and invalid-input tests
          +
independent differential implementation
```

For BIP32, the compatibility gate should include:

``` text
1. Official BIP32 vectors
2. Existing PayCrypto address/derivation vectors
3. Current known-good implementation outputs
4. Boundary indices, including max valid non-hardened index
5. Known regression vectors
6. Invalid-child behavior verified against the specification
```

Differential disagreement means **investigate**. Majority output is not
automatically truth.

------------------------------------------------------------------------

# 27. Architectural resilience model

``` text
                 ARCHITECTURAL RESILIENCE

                      Replaceability
                            +
                       Verification
                            +
                        Containment
```

-   **Replaceability:** implementation can change without changing Core.
-   **Verification:** deterministic tests protect semantics.
-   **Containment:** dependency failure is bounded to the capability it
    implements.

------------------------------------------------------------------------

# 28. Evidence-driven abstractions

The accepted design process:

``` text
CONCRETE REQUIREMENT
        │
        ▼
CODE / PROTOCOL EVIDENCE
        │
        ▼
REQUIRED BEHAVIOR
        │
        ▼
MINIMAL CAPABILITY
        │
        ▼
COMPOSITION
        │
        ▼
IMPLEMENTATION
```

Never:

``` text
interesting library or pattern
          │
          ▼
reshape architecture around it
```

This is the core defense against both dependency-driven architecture and
speculative overengineering.

------------------------------------------------------------------------

# 28A. Contribution Divergence Principle

The canonical architecture is part of the contribution contract. Code
alone is insufficient to communicate the intended extension model,
especially to contributors or coding agents that may otherwise imitate
existing classes mechanically.

> **A new blockchain, network, fork, asset, address format, or protocol
> identity does not, by itself, justify a new architectural path, class
> hierarchy, or capability.**

A contributor must first determine whether the requirement can be
represented by:

1.  existing capabilities;
2.  new or changed definitions;
3.  a different composition of existing capabilities;
4.  only then, a genuinely new capability at the demonstrated point of
    behavioral divergence.

Decision flow:

``` text
new blockchain / network / fork / asset / format
                       |
                       v
             do not assume new path
                       |
                       v
       which existing capabilities remain
             semantically identical?
                       |
                       v
              reuse those capabilities
                       |
                       v
          where does behavior diverge?
                 +-----+-----+
                 |           |
             parameters    behavior
                 |           |
                 v           v
             Definition   can existing
                          capabilities be
                          recomposed?
                            +--+--+
                            |     |
                           yes    no
                            |     |
                            v     v
                       composition new capability
                                   at the exact
                                   divergence point
```

This makes the **Primitive Composition Principle** enforceable as a
contribution convention rather than merely an architectural preference.

## 28A.1 Example: a Bitcoin-like network

A request such as "support Litecoin" must not automatically become:

``` text
BitcoinAddressDeriver
LitecoinAddressDeriver
DogecoinAddressDeriver
...
```

Instead, the contributor must identify what is actually shared and what
actually differs. If the required Litecoin flow can reuse existing
BIP32, secp256k1, hashing, and address capabilities while varying
definitions or composition, then no Litecoin-specific derivation
hierarchy is justified.

A new capability is justified only when the requirement exposes behavior
that existing definitions and capabilities cannot faithfully express.

## 28A.2 Required reasoning for a new capability

Every proposed new capability should be able to answer:

``` text
Requirement:
    What concrete use case requires this?

Existing capabilities reused:
    Which existing semantics remain identical?

Definitions added or changed:
    Which differences are data only?

Composition:
    Can the requirement be satisfied by recomposing existing capabilities?

Behavioral divergence:
    What exact behavior is genuinely new?

Why existing capabilities are insufficient:
    Why can the divergence not be expressed through definitions
    or composition?

Implementation delegation:
    Which low-level machinery remains delegated to runtime/libraries?

Boundary impact:
    Does the proposal leak implementation-specific concepts upward?

Verification:
    Which vectors, independent references, or differential tests
    demonstrate correctness?
```

If the proposal cannot identify the behavioral divergence, the default
architectural conclusion is **not** to add a new capability.

## 28A.3 Humans and agents follow the same convention

The same rule applies whether the contribution is authored by a human,
generated by an AI coding agent, or produced collaboratively.

> **Do not extend Primitives by copying the visible shape of the
> codebase. Extend it by preserving the semantics and architectural
> invariants documented here.**

The code tells a contributor what currently exists. The canonical
document explains **why it exists in that form and how legitimate
extension is expected to occur**.

# 28B. Canonical document as an architectural control surface

For Primitives, documentation is not merely descriptive after the
implementation. The canonical document is one of the mechanisms that
preserves the architecture across contributors, agents, refactors,
backend replacements, and new protocol support.

``` text
Canonical architecture
        |
        +-- defines invariants
        +-- defines extension rules
        +-- records rejected shortcuts
        `-- explains reasons for existence
                |
                v
              Code
                |
                v
       concrete implementation
```

This matters because source code can make two structurally similar
solutions appear equally legitimate even when only one preserves the
intended abstraction.

For example, code alone may make a contributor infer:

``` text
Bitcoin/
Litecoin/
Dogecoin/
```

therefore:

``` text
Zcash/
```

The canonical architecture forces the more important question first:

> **Is Zcash a new architectural unit for this requirement, or does the
> requested flow share existing capabilities until a specific point of
> behavioral divergence?**

Consequently:

-   an implementation change that remains inside existing canonical
    rules does not necessarily require a new architectural principle;
-   a change that introduces a new capability, changes a boundary,
    weakens an invariant, changes delegation policy, or creates a new
    divergence rule must be evaluated against and, when accepted,
    reflected in the canonical document;
-   architectural behavior must never be changed implicitly by code
    drift.

# 30. Terminology reference

Canonical PayCrypto.Me-specific terminology required to enter and operate this document is defined early in **§0A Canonical Terminology**.

Domain and protocol terms such as BIP32, CKDpub, secp256k1, Base58Check, Bech32, P2PKH, P2SH-P2WPKH, and P2WPKH are intentionally **not** duplicated into a general technical glossary. Their meaning is either established by the relevant technical domain or introduced where Primitives assigns architectural semantics to them.

This placement is deliberate: terminology exists to remove hidden project-context dependencies, not to restate knowledge reasonably expected from the technical audience.

---

# 31. Accepted decisions --- frozen at this checkpoint

The following are architectural baseline decisions and should not be
silently changed:

-   New major architecture is separate from the current main/plugin
    architecture.
-   Dependency direction is Consumer → SDK → Core → Primitives →
    implementation.
-   Basic local/non-custodial payment acceptance must not require
    PayCrypto cloud.
-   Primitives is demand-driven and capability-oriented.
-   Composition is preferred over inheritance.
-   Abstractions are evidence-driven.
-   Definitions are declarative data.
-   Parameter variation stays data-driven.
-   Behavioral variation becomes capability/composition.
-   Fork only where behavior actually diverges.
-   Core expresses intent and does not assemble cryptographic internals.
-   BIP32 owns BIP32 semantics but not ECC implementation details.
-   SLIP-132 semantics remain separate from generic BIP32.
-   ECC contracts must not expose implementation-specific
    Point/BN/GMP/etc.
-   The smallest currently justified secp256k1 semantic capability is
    public-key scalar tweak addition.
-   Primitives v1 is public-key-only.
-   P2PKH, P2SH-P2WPKH, and P2WPKH are current Bitcoin address
    compositions.
-   Taproot/P2TR/Bech32m/x-only/Schnorr are future-only until a concrete
    requirement exists.
-   `Bitcoin-like` is descriptive, not yet a mandatory code abstraction.
-   Non-Bitcoin families are architecture fitness tests, not current
    implementation scope.
-   Chain of Responsibility is rejected for the deterministic derivation
    pipeline.
-   External libraries implement the architecture; they do not define
    it.
-   Production uses deliberate backend selection, not silent runtime
    crypto fallback.
-   Every production dependency must be justified by an admitted
    Primitives capability backed by a validated concrete requirement.
-   Verification and compatibility testing are part of Primitives
    resilience.

------------------------------------------------------------------------

## 31.1 Additional accepted decisions from the v1.2 review

-   Primitives is primarily an aggregator/composer of capabilities; it
    does not seek to reimplement cryptographic algorithms or
    standardized low-level machinery merely because doing so is
    feasible.
-   **We own the composition, not the cryptography** is an explicit
    interpretation of the `OWN / COMPOSE / DELEGATE` model.
-   PayCrypto.Me Core is the first concrete consumer and primary initial
    requirement source, but Primitives may be published and consumed
    independently as an open library.
-   External adoption is additive value, not a prerequisite for
    Primitives' reason to exist.
-   New blockchain/network/fork/asset/format identity alone does not
    justify a new architectural path or capability.
-   Contributors must reuse definitions and existing capabilities first,
    recompose second, and introduce a new capability only at a
    demonstrated behavioral divergence.
-   The canonical document is part of the architectural contribution
    contract for both human contributors and coding agents.

# 32. Deliberately open decisions

These are intentionally **not frozen**:

-   final Base58 implementation;
-   final Base58Check implementation ownership;
-   final Bech32 implementation;
-   definitive secp256k1 backend;
-   whether `paragonie/ecc` becomes production or remains
    candidate/reference;
-   whether GMP disappears from the final runtime dependency graph;
-   exact physical format/loading/validation API for definitions;
-   final PHP class/interface/package/namespace names;
-   exact error/result types across primitive boundaries;
-   exact representation of `Scalar256`;
-   exact handling API for BIP32 invalid-child outcomes;
-   whether an explicit `BitcoinLike` abstraction is ever justified;
-   future Taproot capabilities;
-   future Ed25519/non-BIP32 families;
-   final package/repository split mechanics.

> **Architecture decisions are frozen where evidence is sufficient.
> Implementation decisions remain open where evidence is not.**

------------------------------------------------------------------------

# 33. Important unresolved correctness question

Before implementing PayCrypto-owned BIP32 CKDpub behavior, verify the
specification's exact semantics for invalid children, including cases
such as:

``` text
IL >= curve order
resulting child point at infinity
```

Do not invent behavior and do not simply copy a current library without
checking the standard.

This should become an explicit compatibility/test requirement.

------------------------------------------------------------------------

# 34. Recommended continuation sequence

A future engineer/agent should continue from here in this order.

## Step 1 --- Freeze minimal semantic contracts

Design only the contracts justified by the Bitcoin XPUB requirement,
especially:

``` text
ExtendedPublicKey
ExtendedPublicKeyCodec
DerivationPath
Bip32PublicChildDeriver
HmacSha512
Sha256
Ripemd160
Hash160
Secp256k1PublicKeyTweaker
Base58 / Base58Check
Bech32
Bitcoin address compositions
Definition schema/registry boundary
```

Do not freeze class names merely because they appear here.

## Step 2 --- Feasibility/dependency matrix

For each capability determine:

``` text
OWN / COMPOSE / DELEGATE
candidate implementation
runtime requirements
security/correctness risk
test/reference vectors
replacement options
production dependency footprint
```

Specifically investigate whether Base58 can be implemented
deterministically without GMP using byte-array/divmod techniques rather
than assuming big integers are required.

## Step 3 --- ECC backend spike

Evaluate `paragonie/ecc` as the initial candidate **through the
PayCrypto contract**, not by exposing its API.

Also use independent/reference implementations to verify that the
contract is not accidentally Paragonie-shaped.

## Step 4 --- Compatibility gate

Build official BIP32 and address vectors before replacing the old
production behavior.

## Step 5 --- Implement one vertical slice

Prefer an end-to-end derived Bitcoin address slice:

``` text
Consumer test
   ↓
SDK
   ↓
Core
   ↓
PublicAddressDeriver
   ↓
Primitives
   ↓
BIP32 + secp256k1 + hashing + encoding
   ↓
address
```

Do not build all future primitives first.

## Step 6 --- Expand only from concrete requirements

After the first vertical slice, expand Primitives only when a new
validated concrete requirement requires a capability or protocol
composition that legitimately belongs to this domain. Apply the same
evidence-driven, composition-first and divergence rules before expanding
scope.

------------------------------------------------------------------------

# 35. Architecture fitness tests

These detailed fitness tests remain part of the architectural reference.
The Counter-Proof Control Surface in §0B is the execution-time
compressed index and links back into this deeper material; it does not
replace these tests or their rationale.

Every proposal should be challenged with these questions.

### Dependency replacement test

> If the selected implementation disappears, is abandoned, becomes
> incompatible, or develops a known bug, can it be replaced without
> modifying Core?

### Library leakage test

> Does any type or concept exist in our contract solely because the
> current library exposes it?

### Data-vs-behavior test

> Is this truly new behavior, or merely different parameters?

### Composition test

> Can the requirement be expressed by composing existing capabilities?

### Fork-location test

> Are we specializing at the exact point behavior diverges, or
> duplicating everything above it?

### Future-flow test

> Could a substantially different protocol coexist without pretending to
> be Bitcoin/BIP32/secp256k1?

### Security-surface test

> Are we introducing private material or sensitive capabilities without
> a concrete product requirement?

### Core-isolation test

> Would Core/SDK need to change if the low-level implementation changed?

### Language-portability test

> Is this architectural concept still meaningful if PHP arrays become Go
> structs or the implementation language changes?

### Reason-for-existence test

> Can we explain why this class/interface/capability exists in one
> sentence tied to a concrete requirement?

A failed test is a reason to review the abstraction before merging it.

------------------------------------------------------------------------

## 35.11 Implementation-delegation test

Ask:

> **Are we implementing cryptographic or standardized low-level
> machinery because Primitives semantically owns it, or merely because
> implementing it ourselves appears easy?**

If the latter, investigate an appropriate language/runtime facility or
specialized library and keep Primitives focused on contract, semantics,
and composition.

## 35.12 Contribution-divergence test

For proposed support for a new blockchain, network, fork, asset, address
format, or protocol variation, ask:

> **What exact behavior diverges from existing capabilities?**

If the answer is only identity, constants, prefixes, HRPs, version
bytes, or another representable parameter difference, prefer a
definition. If existing capabilities can be recomposed, prefer
composition. Add a new capability only for genuinely new behavior.

## 35.13 Canonical-drift test

Ask:

> **Could a contributor or coding agent infer a structurally plausible
> implementation from the source code that violates the architectural
> reason the existing code has its current shape?**

If yes, improve the canonical rule/contribution guidance before relying
on code shape alone.

# 36. Rejected or corrected approaches

Preserving rejected ideas prevents future teams from repeating the same
exploration without context.

## 36.1 Incrementally wrapping BitWasp in the current main branch

Rejected as the primary migration strategy because the new architecture
is a new major branch. The old implementation remains
evidence/reference, not mandatory scaffolding for the new runtime.

## 36.2 Treating BitWasp as the architecture

Rejected. BitWasp may be a production or reference implementation
depending on later evidence, but its API and class hierarchy do not
define PayCrypto.

## 36.3 Generic `Secp256k1` mirroring ECC math

Rejected because BIP32 currently needs a much smaller semantic
capability.

## 36.4 Classes for every network when only constants differ

Rejected in favor of data-driven definitions.

## 36.5 Chain of Responsibility for derivation

Rejected because derivation is deterministic composition, not sequential
handler resolution.

## 36.6 Implementing Taproot now because it is foreseeable

Rejected. Taproot is a fitness test until a concrete requirement exists.

## 36.7 Formal `BitcoinLike` hierarchy now

Deferred. Let real shared behavior justify the abstraction.

## 36.8 Moving the entire Core away from PHP because low-level crypto is difficult

Rejected as unsupported by current evidence. Most Core behavior is
domain/application logic. If low-level crypto later needs another
implementation language, Primitives is the containment boundary;
deployment simplicity for WordPress remains a product constraint.

------------------------------------------------------------------------

## 36.1 Additional rejected approaches from the v1.2 review

-   Reimplementing cryptographic algorithms, curve mathematics, or
    standardized low-level codecs simply because the implementation is
    small or understandable.
-   Treating `OWN` as a mandate to own low-level cryptographic
    implementations.
-   Creating coin-specific execution paths merely because a requested
    network/fork has a new identity.
-   Allowing source-code imitation to become the extension model for
    contributors or coding agents.
-   Expanding an open-source Primitives library into a general-purpose
    crypto catalog merely because external users request unrelated
    capabilities.

# 37. Architectural anti-goals

The project is explicitly **not** trying to become:

-   a generic all-blockchain cryptography framework;
-   a reimplementation of secp256k1 mathematics;
-   a coin-class hierarchy;
-   a wrapper around BitWasp;
-   a wrapper around Paragonie/ECC;
-   a universal `CryptoManager`;
-   a runtime backend roulette/fallback system;
-   a speculative implementation of every foreseeable chain;
-   a cloud-required payment engine;
-   a system where WooCommerce understands cryptographic implementation
    details.

------------------------------------------------------------------------

## 37.1 Additional anti-goals from the v1.2 review

Primitives must also avoid:

-   implementing cryptographic algorithms or standardized low-level
    codecs merely because implementation is feasible;
-   confusing ownership of semantic composition with ownership of
    cryptographic mathematics;
-   creating new derivation/address hierarchies solely from coin,
    network, fork, asset, or format identity;
-   allowing external adoption to turn the library into a speculative
    catalog of cryptocurrency functionality;
-   relying on source-code shape alone to teach humans or agents how the
    architecture should evolve.

# 38. Primitives Manifesto

> ## PayCrypto.Me Primitives Manifesto
>
> **We do not build a generic cryptocurrency library.**
>
> We implement only capabilities justified by validated concrete
> requirements. PayCrypto.Me Core is the first concrete consumer and
> primary initial requirement source, not the exclusive consumer.
>
> We share behavior until the exact point where protocol semantics
> diverge.
>
> We represent parameter variation as data and behavioral variation as
> capabilities.
>
> We compose small capabilities instead of building coin-specific
> monoliths.
>
> We own protocol semantics when ownership gives us control and
> resilience; we delegate sensitive cryptographic machinery to
> appropriate implementations.
>
> **External libraries implement our architecture. They do not define
> it.**
>
> No library-specific type crosses a PayCrypto capability boundary.
>
> New protocol support should reuse existing capability layers wherever
> their behavior is identical.
>
> We design extension points for foreseeable change, but we do not
> implement hypothetical requirements.
>
> Every production dependency must be traceable to an admitted
> Primitives capability backed by a validated concrete requirement.
>
> Cryptographic backend replacement is explicit, verified, and
> fail-closed --- never an invisible runtime fallback.
>
> Primitives v1 remains public-key-only because the product currently
> requires no private material.
>
> **The architecture grows from evidence, not speculation.**

------------------------------------------------------------------------

## 38.1 Additional manifesto statements from the v1.2 review

> **We own the composition, not the cryptography.**

> **Identity is not divergence. A new coin, network, fork, asset, or
> format earns a new capability only when it introduces behavior that
> existing definitions and compositions cannot express.**

> **The canonical document is part of the architecture: code shows what
> exists; the canonical explains why it exists and how it may
> legitimately evolve.**

> **Open-source adoption may broaden the evidence available to
> Primitives, but it must not turn the library into a speculative
> catalog of cryptocurrency functionality.**

# 39. Guiding sentence

> **The goal is not to predict every blockchain PayCrypto.Me will
> support. The goal is to make the next legitimate requirement expensive
> only in proportion to what is genuinely new about it.**

------------------------------------------------------------------------

# 40. Handoff prompt for a future engineer or AI agent

If this document is the only surviving context, continue with the
following interpretation:

> We are designing a new major-version PayCrypto.Me architecture with
> dependency direction Consumer → SDK → Core → Primitives. The immediate
> Primitives requirement is public-only Bitcoin XPUB derivation to
> P2PKH/P2SH-P2WPKH/P2WPKH addresses. Do not copy the current BitWasp
> architecture. Treat the old implementation only as behavioral
> evidence/reference. Preserve data-driven network definitions,
> capability-driven composition, public-key-only scope, minimal
> implementation-independent secp256k1 contracts, and the
> OWN/COMPOSE/DELEGATE model. Do not introduce future capabilities
> without a concrete requirement. As the first implementation phase,
> refine the minimal contracts and produce a capability/dependency
> feasibility matrix, with special attention to BIP32 invalid-child
> semantics, official vectors, Base58/GMP independence, and an ECC
> adapter spike using paragonie/ecc as an initial candidate rather than
> a permanent architectural dependency.

If a proposal contradicts a frozen decision above, state the
contradiction explicitly and record a new decision before proceeding.

------------------------------------------------------------------------

## 40.1 Mandatory v1.2 handoff addendum

Any future engineer or AI agent continuing from the handoff above must
also preserve these rules:

-   Treat Primitives primarily as an **aggregator/composer of
    capabilities**.
-   Interpret `OWN / COMPOSE / DELEGATE` with the explicit rule: **we
    own the composition, not the cryptography**.
-   Delegate cryptographic algorithms, elliptic-curve mathematics,
    standardized low-level codecs, and equivalent specialized machinery
    to appropriate runtime facilities or specialized libraries.
-   PayCrypto.Me Core is the first concrete consumer and initial
    requirement source, but it is not required to be the only consumer
    of an open Primitives library.
-   For new blockchain/network/fork/asset/format support, do not create
    a new path by identity. Reuse definitions and capabilities first,
    recompose second, and add a new capability only at demonstrated
    behavioral divergence.
-   Treat this canonical document as part of the contribution contract
    for humans and coding agents.

# 41. Canonical status

This document is intended to be **self-sufficient for architectural
continuation** at this checkpoint.

What it preserves:

``` text
Product intent
Architecture boundaries
Core context
Primitives purpose
Concrete evidence
Capability graph
Definitions model
ECC boundary
BIP32 responsibility
Security scope
Resilience philosophy
Dependency policy
Testing philosophy
Rejected alternatives
Open questions
Next steps
Vocabulary
Manifesto
Handoff instructions
```

What it deliberately does **not** pretend to preserve:

``` text
unrecorded implementation details
future decisions not yet made
exact APIs not yet designed
external source snapshots
the full historical conversation transcript
```

Those omissions are intentional: they are not accepted architecture yet.

------------------------------------------------------------------------

# 42. Revision record

This revision is **additive and superseding**. It retains the complete
v1.1 Primitives canonical content and adds the architectural conclusions
reached after the v1.1 review.

The principal additions are:

1.  Primitives is explicitly characterized as an
    **aggregator/composer**, not an implementer of cryptographic
    algorithms.
2.  The `OWN / COMPOSE / DELEGATE` model is clarified by the invariant
    **we own the composition, not the cryptography**.
3.  Cryptographic algorithms, elliptic-curve mathematics, standardized
    low-level codecs, and equivalent machinery are explicitly delegated
    to suitable runtime facilities or specialized libraries.
4.  PayCrypto.Me Core is recorded as the **first concrete consumer and
    primary initial requirement source**, not necessarily the exclusive
    consumer.
5.  Open-source use by external projects is compatible with the
    architecture, but does not justify speculative scope expansion.
6.  A **Contribution Divergence Principle** now governs support for new
    blockchains, networks, forks, assets, formats, and protocol
    variations.
7.  A contributor must prefer existing capabilities/definitions, then
    composition, and introduce a new capability only at a demonstrated
    behavioral divergence.
8.  The canonical document is explicitly an **architectural control
    surface** and contribution contract for humans and coding agents.
9.  New fitness tests, rejected approaches, anti-goals, manifesto
    statements, and handoff requirements encode these conclusions so
    they cannot be lost in future revisions.

At the v1.2 checkpoint, per the canonical replacement policy, **v1.2
superseded v1.1 as the canonical source of truth for the PayCrypto.Me
Primitives domain**.

## 42.1 v1.3 revision record

This revision supersedes v1.2 and is primarily a **domain-boundary
correctness revision**. It preserves the established Primitives
capability architecture while removing material that did not belong to
the Primitives domain and correcting wording that had become
inconsistent with accepted Primitives decisions.

Principal changes:

1.  Primitives resilience is expressed through the properties Primitives
    owns: replaceability, verification, and containment.
2.  External projects are modeled only through roles relevant to
    Primitives architecture: production implementation and reference
    implementation.
3.  Core remains the first concrete consumer and primary initial
    requirement source, but requirement and dependency principles are no
    longer phrased as Core-exclusive.
4.  References to surrounding PayCrypto.Me domains are intentionally
    shallow and exist only where necessary to define the Primitives
    boundary.
5.  Canonical preservation is clarified: architectural knowledge that
    legitimately belongs to the governed domain must not disappear
    silently; exploratory material determined not to belong to the
    domain before materialization need not be preserved in the current
    canonical.

No capability, protocol composition, requirement, guarantee, assumption,
dependency choice, compatibility constraint, verification semantic,
accepted Primitives invariant, or deliberately open Primitives decision
was removed by this revision.

## 42.2 v1.4 revision record

This revision supersedes v1.3 and is the **implementation-entry
consolidation** of the Primitives canonical. It does not introduce a new
capability model or expand the domain. It closes the final documentary
inconsistencies identified before implementation begins.

Principal changes:

1.  The remaining obsolete external-project role is removed; external
    projects are described only through Primitives-relevant production
    and reference implementation roles.
2.  The continuation sequence no longer names surrounding-domain flows
    as a Primitives roadmap. Expansion is permitted only when a
    validated concrete requirement demands capability or protocol
    composition that legitimately belongs to Primitives.
3.  Feasibility/dependency analysis, BIP32 invalid-child validation,
    official vectors, Base58/GMP investigation, and the ECC adapter
    spike are explicitly classified as the **first implementation
    phase**, rather than unresolved architecture work that must precede
    implementation.
4.  The historical v1.2 replacement statement was phrased as historical
    status so that, at the v1.4 checkpoint, v1.4 was the single
    unambiguous current baseline.

No capability, protocol composition, requirement, guarantee, assumption,
dependency choice, compatibility constraint, verification semantic,
accepted Primitives invariant, deliberately open implementation
decision, fitness test, or handoff constraint is removed by this
consolidation.

At the v1.4 checkpoint, per the canonical replacement policy, **v1.4
superseded v1.3 as the canonical source of truth for the PayCrypto.Me
Primitives domain**.

## 42.3 v1.5 revision record

This revision supersedes v1.4 and is the **execution-navigation and
counter-verification consolidation** of the Primitives canonical.

It does **not** introduce a new Primitives capability model, expand
product scope, select previously open implementation choices, or
prescribe coding techniques. The accepted architectural substance of
v1.4 remains authoritative and is preserved.

Principal changes:

1.  The document now defines an operational reading model with two
    speeds: initial architectural orientation and a compact
    execution-time control surface.
2.  A cognitively ordered **Counter-Proof Control Surface** compresses
    existing architectural invariants into twelve execution-time
    counter-proofs.
3.  Every counter-proof provides **Deep References** back to the
    detailed canonical sections that contain its authoritative rationale
    and nuance.
4.  Counter-proofs explicitly constrain required architectural outcomes
    rather than prescribing implementation techniques left open by the
    canonical.
5.  Executor self-challenge and independent reviewer
    counter-verification are separated. Executor states are `PASS`,
    justified `N/A`, and justified `UNRESOLVED`; reviewer states are
    `PASS`, justified `N/A`, and `FAIL` with a finding.
6.  `PASS` is intentionally lightweight. A note is optional only when
    materially useful. `N/A`, `UNRESOLVED`, and `FAIL` carry the
    additional information required by their semantics.
7.  The canonical delegates report formatting, provenance/evidence
    recording, FULL/PARTIAL coverage, immutable report history, work
    identity, and corrective-cycle mechanics to the sibling
    `COUNTER-PROOF-REPORT.md`.
8.  Existing Architecture Fitness Tests remain deeper architectural
    reference material; the new control surface indexes and
    operationalizes them rather than replacing them.

No capability, protocol composition, requirement, guarantee, assumption,
dependency choice, compatibility constraint, verification semantic,
accepted Primitives invariant, deliberately open implementation
decision, rejected approach, fitness test, handoff constraint, or
domain-boundary rule from v1.4 is removed by this revision.

At the v1.5 checkpoint, per the canonical replacement policy, **v1.5 superseded v1.4 as the canonical source of truth for the PayCrypto.Me Primitives domain**.

## 42.4 v1.6 revision record

This revision supersedes v1.5 and is the **terminology and PIP integration revision**. It preserves the accepted Primitives architecture while removing an implicit dependency on project-history knowledge at document entry.

Principal changes:

1. A compact **Canonical Terminology** section is positioned before the execution-time Control Surface so project-specific terminology is known before it is used operationally.
2. Terminology is intentionally restricted to PayCrypto.Me-specific, locally coined, or locally specialized terms; the canonical no longer maintains a broad glossary of standard software/cryptography/protocol vocabulary.
3. **PIP — PayCrypto.Me Improvement Proposal** replaces the former provisional work-identity acronym and is treated as an existing project-wide mechanism governed by the PayCrypto.Me PIP Specification.
4. **CP — Counter-Proof** is formalized as canonical shorthand and remains Primitives-specific unless another domain independently adopts an equivalent mechanism.
5. The Counter-Proof Control Surface moves from §0A to §0B so terminology is available before execution semantics.
6. No Primitives capability, protocol composition, requirement, guarantee, assumption, dependency choice, compatibility constraint, verification semantic, accepted invariant, deliberately open implementation decision, rejected approach, fitness test, handoff constraint, or domain-boundary rule is removed by this revision.

Per the canonical replacement policy, **v1.6 supersedes v1.5 and is the current source of truth for the PayCrypto.Me Primitives domain**.
