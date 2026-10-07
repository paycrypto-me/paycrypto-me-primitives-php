# PayCrypto.Me Public Architecture — Canonical Architecture Reference

## Architecture Baseline v1.1

> **Document role:** canonical, self-sufficient architecture reference for the **PayCrypto.Me Public Architecture**.
>
> **Status:** accepted cross-domain architecture checkpoint.
>
> **Authority:** public scope, recognized domains, cross-domain topology, inter-domain boundaries, dependency direction, systemic properties, invariants, rejected/corrected directions, and cross-domain open questions.
>
> **Replacement policy:** this document supersedes v1.0 as the current PayCrypto.Me Public Architecture canonical. Domain internals remain governed by their own canonicals.
>
> **Reading rule:** a domain decision that changes a cross-domain relation, boundary, or invariant must explicitly reconcile this canonical. Conflicts must not be silently normalized.

# 0. Purpose and authority

This document governs architecture **between** the domains of the PayCrypto.Me Public Architecture.

It is deliberately not a container for the internal architecture of Consumer, SDK, Core, Primitives, Supply Chain Assurance, or any future domain.

> **Public Architecture owns relations between domains. Domain canonicals own architecture within domains.**

This canonical answers questions such as:

- which first-class public domains exist;
- why they exist at the cross-domain level;
- which dependency directions are supported;
- what may and may not cross a domain boundary;
- which properties apply to the Public Architecture as a whole; and
- where architectural authority lives when multiple domains are involved.

A domain may be described here only as deeply as required to establish its identity, externally relevant responsibility, boundary, contract, or relationship with another domain. Mention does not transfer authority.

# 1. Canonical terminology

Only PayCrypto.Me-specific or locally overloaded terms are defined here.

## PayCrypto.Me Public Architecture

The governed public architectural super-domain described by this canonical.

“Ecosystem” may describe participants and relationships around this architecture, but does not name a competing architectural scope.

## Consumer

A PayCrypto.Me architectural role/domain that adapts a concrete Customer or platform to PayCrypto.Me through the SDK boundary.

## Customer

A concrete product, integration, or entity exercising the Consumer role.

Customer is not a synonym for the Consumer architectural domain.

## External Project

A project outside the PayCrypto.Me architectural topology that independently consumes a public PayCrypto.Me boundary made available for such use.

The currently established case is direct independent consumption of Primitives.

An External Project does not thereby acquire the PayCrypto.Me `Consumer` role.

# 2. Canonical scope

The governed scope is **PayCrypto.Me Public Architecture**.

Constraints in this document apply to this public scope and must not be silently generalized to every possible present or future PayCrypto.Me architecture.

No other architectural super-domain is defined by this canonical.

# 3. Public security and custody boundary

**FROZEN:** PayCrypto.Me Public Architecture is **wallet-read-only**.

It must not require or handle wallet secret/signing material:

```text
private keys
extended private keys
seeds
mnemonics
signing authority
custodial key material
```

Public information and admitted public derivation material may be used.

Basic/local payment acceptance is non-custodial and must not require a mandatory PayCrypto.Me remote service.

These are Public Architecture constraints, not universal claims about every possible future PayCrypto.Me architectural scope.

# 4. First-class public domains

```text
PayCrypto.Me Public Architecture
|
+-- Consumer
+-- SDK
+-- Core
+-- Primitives
`-- Supply Chain Assurance
```

At the cross-domain level:

- **Consumer** contains concrete platform/integration concerns at the edge of PayCrypto.Me.
- **SDK** is the controlled Consumer-facing integration and change-containment boundary.
- **Core** owns payment-domain/application intent independently of platform-specific and low-level cryptographic/protocol concerns.
- **Primitives** provides the admitted public cryptographic/protocol capability boundary used by the architecture.
- **Supply Chain Assurance** is an orthogonal public domain concerned with continuous external observation and assurance of declared targets and their software supply chains.

These descriptions establish only externally relevant reason, boundary, and relationship.

Internal architecture belongs to each domain's own authority.

A logical domain does not imply one repository, package, process, host, service, or deployment unit.

# 5. Canonical functional topology

**FROZEN:**

```text
Consumer -> SDK -> Core -> Primitives
```

Unsupported PayCrypto.Me bypasses:

```text
Consumer -X-> Core
Consumer -X-> Primitives
SDK      -X-> Primitives  (as a bypass of Core)
```

Dependency direction describes which domain knows, imports, invokes, or relies upon another domain's contract.

Requests and control may follow that direction while results, returned values, errors, events, or outcomes naturally propagate toward the caller. Such return flow does **not** create a reverse architectural dependency.

The topology is logical. It does not prescribe transport, deployment, repository, process, network, or hosting topology.

# 6. Boundary containment

The functional topology carries cross-domain containment rules:

- Consumer/platform concepts do not leak into Core or Primitives.
- SDK does not expose Primitives as an alternate Consumer integration route.
- Core expresses payment/product intent rather than assembling low-level cryptographic/protocol machinery.
- Primitives does not acquire higher-domain internals merely to satisfy a capability request.
- external implementation-library types do not become cross-domain PayCrypto.Me contracts.

A lower domain may know only what is legitimately required by the boundary through which it is consumed.

# 7. SDK as change-containment boundary

**FROZEN:** SDK is not merely a convenience wrapper.

> Consumers depend on SDK rather than directly on Core so changes in how Core capabilities are provided can be absorbed at a controlled integration boundary instead of propagating across every Consumer.

This preserves room for future changes in how Core capabilities are provided without requiring Consumers to absorb those changes directly.

It does **not** imply HTTP, RPC, remote Core, hosted Core, or any particular transport.

The SDK role is canonical. Future SDK cardinality or language materialization remains open unless established by the appropriate authority.

# 8. Consumer and Customer

**FROZEN:**

> **Consumer** is the PayCrypto.Me architectural role/domain.  
> **Customer** is a concrete product, integration, or entity exercising that role.

Known Customers or product directions may provide evidence for architecture without becoming first-class Public Architecture domains merely by existing.

Customers may be independently packaged and implemented.

# 9. Existing implementation is evidence, not authority

Concrete implementations may reveal requirements, flows, constraints, and failure cases.

They are architectural **evidence**, not automatic architectural authority, compatibility blueprints, or behavioral-preservation contracts.

```text
existing implementation
        |
        v
      evidence
        |
        v
real/admitted requirement
        |
        v
governing architecture
```

A governing authority may explicitly preserve behavior when justified. Absent such a decision, current code does not silently redefine architecture.

# 10. Core / Primitives boundary

At the cross-domain level:

```text
Core requirement / intent
        |
======== CORE / PRIMITIVES BOUNDARY ========
        |
        v
Primitives capability
```

Core owns payment-domain/application intent.

Primitives owns the admitted cryptographic/protocol capability boundary required to satisfy that intent.

Core must not assemble low-level cryptographic machinery that belongs behind the Primitives boundary.

Primitives must not acquire Payment, checkout, platform, or other higher-domain internals merely to satisfy a capability.

The internal architecture by which either domain fulfills this relationship belongs to its respective domain canonical.

# 11. Independent public consumption of Primitives

Inside PayCrypto.Me:

```text
Consumer -> SDK -> Core -> Primitives
```

Independent public consumption:

```text
External Project -> Primitives
```

An External Project is outside the PayCrypto.Me architectural topology.

Direct public use of Primitives does not create an alternative PayCrypto.Me dependency path and does not authorize:

```text
Consumer -> Core
Consumer -> Primitives
```

Core is the first concrete/anchor PayCrypto.Me consumer and requirement source for Primitives, but not its exclusive possible consumer.

# 12. Supply Chain Assurance relationship

Supply Chain Assurance is first-class but **orthogonal** to the functional payment chain.

Never:

```text
Consumer -> SDK -> Core -> Supply Chain Assurance -> Primitives
```

Conceptually:

```text
FUNCTIONAL
Consumer -> SDK -> Core -> Primitives

ASSURANCE
Declared Public Architecture targets
        |
        `-- assurance relationship --> Supply Chain Assurance
```

Public Architecture domains are initial declared targets.

This canonical establishes only the existence, position, and cross-domain boundary of this relationship.

Supply Chain Assurance's internal architecture, mechanisms, evidence model, processes, policies, tooling, and implementation belong to its own authority.

A target domain retains authority over its own architecture, behavior, requirements, assumptions, compatibility constraints, and verification semantics.

Knowledge acquisition or external observation does not transfer that authority.

Conversely, continuous external observation and assurance do not become responsibilities of a target domain merely because that domain must remain independently understandable or verifiable.

# 13. Independent verifiability

Independent verifiability is an intended systemic property of the Public Architecture.

Relevant behavior and boundaries should be capable of being independently inspected, tested, challenged, and verified according to the authorities that own them.

This property does not create a centralized audit domain and does not transfer a target domain's verification semantics to Supply Chain Assurance or another sibling domain.

Each domain remains authoritative for the semantics by which its own architecture is shown to satisfy its contracts and guarantees.

# 14. Project-wide mechanisms versus architectural authority

Project-wide engineering or governance mechanisms may operate across multiple domains without becoming architectural domains.

Their existence does not transfer domain authority and does not automatically make a domain-specific mechanism universal.

When such a mechanism affects architectural work, the applicable Public Architecture and domain canonicals remain authoritative for architecture.

This canonical intentionally does not duplicate the lifecycle, storage, reporting, or execution rules of project-wide or domain-specific engineering mechanisms.

# 15. Cross-domain invariants

1. The canonical super-domain name is **PayCrypto.Me Public Architecture**.
2. Public Architecture constraints do not automatically govern other possible PayCrypto.Me architectural scopes.
3. Public Architecture is wallet-read-only and does not handle wallet secret/signing material.
4. Functional dependency direction is `Consumer -> SDK -> Core -> Primitives`.
5. Consumer enters through SDK; Core and Primitives are not supported Consumer bypasses.
6. SDK is a deliberate change-containment boundary.
7. Dependency direction is not the same as runtime result/data-flow direction.
8. Lower domains do not acquire higher-domain internals merely to satisfy their responsibilities.
9. Platform concepts do not leak into Core or Primitives.
10. Primitives implementation details do not leak upward as cross-domain contracts.
11. Core expresses intent rather than low-level cryptographic/protocol composition.
12. Basic/local non-custodial payment acceptance has no mandatory PayCrypto.Me remote dependency.
13. Logical topology does not prescribe physical topology.
14. Existing implementations are evidence, not architectural authority.
15. Primitives may be independently consumed by External Projects without changing PayCrypto.Me topology.
16. Supply Chain Assurance is orthogonal to the functional chain.
17. Target-domain authority and Supply Chain Assurance authority remain distinct.
18. Independent verifiability is systemic and does not transfer domain ownership.
19. Domain internals belong to domain canonicals.
20. Project-wide mechanisms do not become architectural domains merely by operating across domains.
21. Domain-specific mechanisms do not become universal merely because one domain uses them.
22. Accepted architecture cannot be silently changed by code, documentation, tooling, or implementation drift.

# 16. Rejected and corrected directions

Do not silently reintroduce:

```text
Consumer -> Core bypass
Consumer -> Primitives
WooCommerce-centered Public Architecture
platform concepts leaking downward
external crypto-library APIs defining PayCrypto.Me architecture
mandatory PayCrypto.Me remote service for basic/local acceptance
coin/blockchain identity as universal top-level split
AddressDerivationEngine as ecosystem-wide top-level abstraction
Lightning forced into address derivation
PaymentAllocation mandatory for every payment
logical topology treated as repository/deployment topology
Supply Chain Assurance inserted into the functional chain
Watch subsystem generalized per domain
a project-wide process mechanism treated as architectural authority
a domain-specific execution/verification mechanism imposed on sibling domains
```

Historical corrections:

**Old WooCommerce preservation wording:** superseded. Existing implementation provides evidence; its behavior is not automatically preserved.

**Primitive Watch:** an exploratory concept discarded before architectural materialization. No successor `Watch` component or Watch-per-domain pattern is established. The legitimate continuous external-observation concern is outside Primitives and lies within the Supply Chain Assurance boundary. `MTTA` was not adopted as a Primitives architectural metric.

**Customer as domain terminology:** superseded. `Consumer` is the architectural role/domain; `Customer` is a concrete product, integration, or entity.

Preserving architectural knowledge does not require a domain canonical to retain every exploratory concept rejected or determined to be outside that domain before materialization.

# 17. Authority map

| Knowledge | Authority |
| --- | --- |
| Public scope, recognized domains, topology, cross-domain boundaries, systemic invariants | PayCrypto.Me Public Architecture Canonical |
| Consumer internals | Consumer Canonical |
| SDK internals/API | SDK Canonical |
| Core internals | Core Canonical |
| Primitives internals | Primitives Canonical |
| Supply Chain Assurance internals | Supply Chain Assurance Canonical |
| project-wide process/specification semantics | owning project-wide specification |
| domain-specific verification semantics | owning Domain Canonical |
| protocol/reporting mechanics | owning protocol/specification |
| Customer implementation | that Customer/project, constrained by applicable architecture |
| research/evidence | non-normative unless promoted by the owning authority |

A canonical may mention another domain as deeply as necessary to define its own relation, contract, constraint, or property.

Mention does not transfer authority.

# 18. Open cross-domain questions

The following remain deliberately unresolved unless and until project evidence justifies a decision:

- universal criteria for promoting a future concept to a first-class Public Architecture domain;
- future SDK cardinality and language materialization;
- exact repository/package mapping where not already established by the owning authority;
- project-wide architecture decision indexing/schema/tooling; and
- domain-internal questions delegated to their owners.

Questions owned by another specification or domain must not be duplicated here merely because they affect work performed within the Public Architecture.

# 19. Distribution and continuation contract

This canonical is a shared Public Architecture authority.

Repositories participating in the PayCrypto.Me Public Architecture may carry synchronized copies or otherwise resolve the same current accepted canonical.

Such copies are not independent authorities and must not intentionally diverge by domain or repository.

A future human or agent should:

1. read this canonical when work depends on, evaluates, or may change cross-domain architecture;
2. read the owning domain canonical before changing a domain's internals;
3. load other affected domain authorities when a change crosses their boundaries;
4. preserve accepted, open, rejected, and corrected knowledge according to the authority that owns it;
5. explicitly reconcile changes to cross-domain relations; and
6. never reconstruct current architecture from superseded canonicals, old code, or unavailable conversations.

The handoff succeeds when a competent actor can continue the Public Architecture from current authorities and referenced evidence without needing the people or conversations that created them.

# 20. Revision record

## v1.0

Established the PayCrypto.Me Public Architecture super-domain, wallet-read-only scope, first-class public domains, canonical functional topology, SDK change-containment role, Consumer/Customer distinction, independent Primitives consumption, Supply Chain Assurance relationship, systemic verifiability, cross-domain invariants, rejected directions, authority split, and continuation contract.

## v1.1

This revision supersedes v1.0 while preserving its legitimate cross-domain architecture.

Principal changes:

1. makes this canonical the single shared Public Architecture document rather than relying on a second shared navigation document;
2. adds lean project-specific canonical terminology;
3. explicitly distinguishes dependency direction from request/result flow;
4. strengthens the separation between Public Architecture authority over inter-domain relations and domain authority over internals;
5. removes versioned/domain-local implementation detail from the shared authority model;
6. narrows Supply Chain Assurance material to its externally relevant relationship and boundary;
7. expresses independent verifiability as a systemic property without assigning it to another domain;
8. recognizes project-wide mechanisms abstractly without duplicating their specifications or turning them into architecture;
9. prevents domain-specific execution or verification mechanisms from being generalized across sibling domains;
10. incorporates the refined treatment of exploratory concepts rejected before architectural materialization; and
11. preserves the accepted v1.0 topology, custody, containment, non-custodial, independent-consumption, evidence-versus-authority, and cross-domain boundary decisions.

> **v1.1 is the current source of truth for the PayCrypto.Me Public Architecture.**
