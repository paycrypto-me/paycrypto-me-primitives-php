---
description: Design, structure, operationalize, and assess canonical
  architecture documents for PayCrypto.Me domains. Use when creating a
  new domain canonical, restructuring an existing canonical for
  execution, defining its information model, designing an execution-time
  control surface, preparing a domain for AI/human implementation, or
  evaluating whether a canonical is merely complete versus actually
  usable by executors and independent reviewers.
name: paycrypto-domain-canonical-engineering
---

# PayCrypto.Me Domain Canonical Engineering

## Purpose

Use this skill to engineer a domain canonical as an **architectural
control system**, not merely as a large architecture document.

This skill governs how architectural knowledge is discovered,
classified, structured, made retrievable at decision time, and connected
to execution and independent verification.

Its central lesson is:

> **Information completeness is not execution effectiveness.**

A canonical can contain the correct decision and still fail
operationally if an executor does not retrieve or apply that decision
when making a material implementation choice.

Therefore a high-quality canonical must solve two distinct problems:

``` text
KNOWLEDGE PRESERVATION
What must remain knowable without the original people/chats/history?

EXECUTION EFFECTIVENESS
What must remain cognitively available when an executor makes a decision?
```

Neither substitutes for the other.

This skill complements, but does not replace, the
`paycrypto-canonical-doc-governance` skill. Canonical Engineering
defines how to build and operationalize a canonical. Canonical Document
Governance defines how to revise and supersede it without silent
semantic loss.

------------------------------------------------------------------------

# 1. Governing model

Engineer a canonical through this progression:

``` text
domain discovery
      ↓
boundary establishment
      ↓
evidence classification
      ↓
architectural decisions
      ↓
invariants + rationale
      ↓
deep canonical knowledge
      ↓
cognitive organization
      ↓
compressed execution control surface
      ↓
execution protocol
      ↓
independent verification
      ↓
observed execution evidence
      ↓
canonical refinement
```

Do not begin by inventing a table of contents.

The structure must emerge from the domain knowledge and from how future
actors will need to reason with it.

------------------------------------------------------------------------

# 2. First principle --- domain authority before document structure

Before designing the canonical, establish:

-   the exact domain governed;
-   why the domain exists;
-   what concrete requirements currently justify it;
-   what responsibilities belong inside it;
-   what neighboring responsibilities do not;
-   what relationships with neighboring domains must be mentioned;
-   what is evidence versus accepted architecture;
-   what remains deliberately open.

A domain canonical owns the architecture **inside its domain**.

References to neighboring domains must be shallow and only strong enough
to establish boundary, dependency direction, requirement provenance,
constraints, or external contracts relevant to this domain.

Do not use a domain canonical as a convenient place to design another
domain.

------------------------------------------------------------------------

# 3. Evidence-driven architecture

Do not architect from taxonomy, possibility, library APIs, or
design-pattern availability.

For each proposed abstraction ask:

> **What concrete admitted requirement or demonstrated behavioral
> divergence gives this thing a reason to exist?**

Classify source material before promoting it:

``` text
ACCEPTED / FROZEN
CONTEXT
EVIDENCE
PROPOSAL / CANDIDATE
OPEN / UNRESOLVED
REJECTED / CORRECTED
```

Existing code is evidence of current behavior, not automatic authority
over the new architecture.

External libraries are evidence about implementation feasibility and
behavior, not automatic owners of domain contracts.

------------------------------------------------------------------------

# 4. Deep canonical layer

The deep canonical must preserve enough knowledge that a competent
future engineer or AI agent can reconstruct the architecture without the
original conversation or authors.

Preserve, when applicable:

-   purpose and reason for existence;
-   domain boundary;
-   concrete evidence;
-   architectural thesis;
-   accepted decisions and invariants;
-   capability/component model;
-   composition and dependency rules;
-   data-versus-behavior rules;
-   security boundaries;
-   implementation-independence rules;
-   dependency policy;
-   correctness/verification semantics;
-   rationale and meaningful tradeoffs;
-   rejected/corrected approaches;
-   anti-goals;
-   deliberately open decisions;
-   fitness tests;
-   canonical terminology when project-specific or locally specialized terms require it;
-   continuation/handoff guidance;
-   revision record.

Do not compress away rationale merely to make the document shorter.

The deep layer answers:

> **Why is the architecture this way, what exactly is required, what is
> not decided, and how may it legitimately evolve?**

------------------------------------------------------------------------

# 4A. Canonical terminology

A canonical must not depend on undocumented local vocabulary, but it also must not become a glossary of the reader's profession.

Use this test:

> **Would a competent specialist, already fluent in the relevant technical field but with no prior PayCrypto.Me context, need project-specific prior knowledge to reliably understand this term?**

If yes, the term is a strong candidate for canonical terminology. If no, do not define it merely because it is technical, important, or abbreviated.

Good candidates include:

- project-specific acronyms or mechanisms;
- locally coined terms;
- ordinary words given a materially specialized project meaning;
- identifiers whose expansion or semantics cannot be safely inferred by the intended audience.

Do **not** create entries merely for standard software-engineering, cryptography, protocol, or domain terminology that the intended specialist audience can reasonably be expected to know. Prefer defining domain semantics where they naturally occur when no local terminology gap exists.

> **Terminology is not a glossary of the field. It removes hidden dependencies on project-specific prior context.**

For substantial canonicals, place the small canonical-terminology surface early enough that an executor encounters definitions before operational mechanisms that depend on them. Keep deep technical/domain explanations in their natural sections rather than duplicating them into terminology.

------------------------------------------------------------------------

# 5. Cognitive architecture of the document

A canonical is not successful merely because all information exists
somewhere inside it.

Organize knowledge according to the decisions an executor must make.

Prefer cognitive progression over alphabetical organization, historical
order, or arbitrary section accumulation.

A common reasoning progression is:

``` text
Why does this exist?
        ↓
Can existing behavior satisfy it?
        ↓
Where does behavior actually diverge?
        ↓
Is the difference data or behavior?
        ↓
Can existing capabilities be recomposed?
        ↓
What does this domain own?
        ↓
Did an external implementation shape the contract?
        ↓
Can the implementation be replaced/contained?
        ↓
Did we cross a protected boundary?
        ↓
How do we know the result is correct?
        ↓
Did we expand scope beyond evidence?
```

This sequence is illustrative, not mandatory. Derive the actual
progression from the governed domain.

------------------------------------------------------------------------

# 6. Execution-time control surface

For a substantial canonical, create a compact operational surface that
lets an executor retrieve critical invariants at decision time without
repeatedly interpreting the full document.

The control surface MUST be a compression of accepted deep canonical
knowledge. It MUST NOT become a second independent architecture.

Each control item should contain:

``` text
stable identifier
challenge / counter-question
required architectural property
deep reference(s)
```

Example shape:

``` markdown
## CP-04 — Ownership Boundary

**Counter-proof**
Does this decision cause the domain to own low-level machinery when only its
semantics, contracts, or composition need to be owned?

**Required property**
The domain owns its architectural semantics and composition, not unrelated
implementation machinery merely because it can implement it.

**Deep References**
→ §10 — Ownership model
→ §13 — Dependency boundary
```

The exact mechanism is domain-dependent. It may be:

-   counter-proofs;
-   invariant gates;
-   contract checks;
-   safety properties;
-   decision gates;
-   another compact challenge model.

Do **not** force Primitives-style counter-proofs onto every domain.

What is mandatory is the property:

> **Critical architectural constraints must be operationally retrievable
> at the moment material decisions are made.**

------------------------------------------------------------------------

# 7. Counter-proofs constrain outcomes, not techniques

When a counter-proof/control gate is appropriate:

> **Constrain the architectural outcome, not the implementation
> technique.**

Bad:

``` text
Use Adapter Pattern for every external backend.
```

Better:

``` text
Would this domain-owned contract remain meaningful if the current backend were
replaced by an implementation with a materially different API?
```

The canonical may prescribe a technique only when that technique itself
is an accepted architectural decision.

Do not turn the control surface into implementation micromanagement.

------------------------------------------------------------------------

# 8. Bidirectional traceability

Every control-surface item must point back to authoritative deep
knowledge.

``` text
deep canonical knowledge
        ↓ compression
control-surface item
        ↓ deep reference
deep canonical knowledge
```

Audit both directions.

If important normative knowledge is unreachable from the operational
surface, determine whether the surface has a coverage gap.

If a control item has no deep canonical support, it probably invented a
new rule and must be removed or first established as architecture.

The operational surface is an index and challenge mechanism, not a
shadow canonical.

------------------------------------------------------------------------

# 9. How executors should use the canonical

Teach the canonical's interface explicitly.

A recommended model:

1.  **Orient** --- read enough to understand purpose, boundary,
    terminology, architectural thesis, accepted decisions, and open
    decisions.
2.  **Execute with the control surface active** --- challenge material
    decisions as they are introduced, not only at final review.
3.  **Follow deep references on doubt** --- retrieve the detailed
    rationale only where needed.
4.  **Self-challenge before delivery** --- evaluate every applicable
    control item.
5.  **Disclose unresolved constraints** --- do not convert uncertainty
    into a silent PASS.
6.  **Submit to independent verification** --- a different actor
    re-evaluates the result rather than inheriting executor conclusions.

A control gate is iterative. It applies whenever a material
architectural decision is introduced or changed.

------------------------------------------------------------------------

# 10. Independent verification

Where the cost/risk justifies it, separate:

``` text
EXECUTOR SELF-CHALLENGE
          ↓
candidate result
          ↓
INDEPENDENT COUNTER-VERIFICATION
```

The reviewer must independently challenge the result using the same
canonical authority.

Do not ask the reviewer merely to confirm the executor's report.

A reviewer should be able to reject:

-   an executor PASS;
-   an unjustified N/A;
-   stale evidence;
-   incomplete coverage;
-   a result that works functionally but violates architectural
    properties.

The exact report states and templates belong to the domain/project's
operational protocol, not necessarily to the canonical itself.

------------------------------------------------------------------------

# 11. Keep architecture authority separate from report representation

Prefer this separation:

``` text
CANONICAL
  owns architecture, invariants, applicability, control items, deep rationale

REPORT PROTOCOL / COMPANION
  owns recording format, actor fields, states, provenance, evidence references,
  coverage representation, filenames, immutable assessment history
```

Do not bloat the canonical with report templates.

The companion may evolve operationally without redefining architecture.

------------------------------------------------------------------------

# 12. Provenance is part of recoverability

If the project uses execution/review reports, make material conclusions
traceable to recoverable evidence.

A future investigator should be able to reconstruct:

``` text
work identity
    ↓
exact artifact/revision
    ↓
executor assessment
    ↓
evidence used
    ↓
independent review
    ↓
findings
    ↓
correction
    ↓
reassessment
    ↓
canonical version governing the work
```

Prefer immutable artifact identities where available.

Do not rely on:

``` text
main
latest
current branch
I tested it manually
we discussed this before
the executor remembers
```

as the sole evidence for a material conclusion.

> **No evidence by memory.**

------------------------------------------------------------------------

# 13. Work identity

For projects with formal improvement/change proposals, use a stable work
identity that is independent from individual assessment reports.

PayCrypto.Me uses a PIP — PayCrypto.Me Improvement Proposal:

``` text
PIP-0042
  ├── implementation revision
  ├── executor assessment
  ├── reviewer assessment
  ├── corrective revision
  └── partial reassessment
```

The work identity answers **what change is being attempted**.

A report identity answers **which assessment occurred**.

Do not overload one identifier to do both jobs.

------------------------------------------------------------------------

# 14. Full versus partial reassessment

When the operational protocol supports reassessment, distinguish:

``` text
FULL
all control items considered against the current assessed scope

PARTIAL
an explicit subset is reassessed after a bounded correction/change
```

PARTIAL is coverage, not a compliance state.

A partial reassessment must include impact analysis: if a correction
affects previously assessed properties outside the requested subset,
expand the coverage.

Do not rewrite old reports to make history look cleaner.

Issued reports are historical evidence.

------------------------------------------------------------------------

# 15. Failure patterns

Reject these documentary failure modes.

## Information dump

A large file contains all known information but gives no retrieval path
for execution.

## Table-of-contents architecture

Sections were invented first and domain knowledge was forced into them.

## Pattern catalog

The canonical prescribes familiar software patterns without evidence
that the domain requires them.

## Code-shape canon

Current classes/folders are treated as the architecture merely because
they exist.

## Duplicate shadow canon

A summary/control document independently restates architecture without
deep traceability and eventually diverges.

## Everything is normative

Evidence, proposals, examples, open questions, and accepted decisions
are mixed without classification.

## Everything is context

The document avoids strong decisions and therefore cannot constrain
execution.

## Neighbor-domain expansion

The canonical begins designing adjacent domains because they are
mentioned.

## Complete but cognitively inert

The correct invariant exists on page 70 but the executor never
encounters it while making the decision it governs.

## Review theater

A reviewer reads the executor's conclusions and confirms them rather
than independently attempting to falsify the result.

------------------------------------------------------------------------

# 16. Canonical engineering workflow

## Phase A --- Discover

Gather concrete requirements, current behavior, standards,
implementation evidence, constraints, rejected explorations, and open
questions.

## Phase B --- Bound

State domain authority and neighboring-domain limits.

## Phase C --- Classify

Classify every material fact as accepted, context, evidence, proposal,
open, or rejected/corrected.

## Phase D --- Model

Extract domain capabilities/components, responsibilities, composition,
invariants, boundaries, and dependencies.

## Phase E --- Decide

Record accepted decisions with enough rationale to survive loss of the
original discussion.

## Phase F --- Preserve negative knowledge

Record rejected approaches and anti-goals when forgetting them would
predictably recreate a known mistake.

## Phase G --- Expose openness

Keep deliberately unresolved decisions explicit. Do not invent closure.

## Phase H --- Build deep canonical

Create the self-sufficient architecture reference.

## Phase I --- Derive cognitive progression

Map how an executor actually reasons through material domain decisions.

## Phase J --- Compress into control surface

Extract the minimum set of stable challenges/properties needed to keep
the deep architecture cognitively active.

Do not choose the number in advance. Let semantic grouping determine it.

## Phase K --- Add deep references

Make every control item traceable to authoritative detail.

## Phase L --- Define execution interface

Explain orientation, active use, escalation to deep references,
self-challenge, and handoff to independent review.

## Phase M --- Test with an executor

Give the canonical to a capable actor without replaying the original
conversation. Observe where the actor violates, misses, or repeatedly
needs reminders about documented constraints.

Treat those failures as evidence about the canonical's operational
design.

## Phase N --- Test with an independent reviewer

Have another actor challenge both the result and the executor's claimed
compliance.

## Phase O --- Refine from observed evidence

Improve retrieval, control-surface coverage, wording, deep references,
or report protocol based on observed failure --- without silently
changing domain architecture.

------------------------------------------------------------------------

# 17. Quality gates

Before calling a new canonical mature, run these gates.

## Domain Authority Gate

Can a reader tell exactly what this domain owns and what it does not?

## Evidence Gate

Can accepted abstractions be traced to concrete requirements or
demonstrated divergence?

## Classification Gate

Can a reader distinguish accepted decisions, evidence, proposals, open
questions, and rejected paths?

## Self-Sufficiency Gate

Could the original chats/authors disappear without making safe
continuation impossible?

## Cognitive Retrieval Gate

Can an executor find the relevant invariant at the moment a material
decision is made without rereading the whole document?

## Terminology Gap Gate

Would a competent specialist, fluent in the relevant technical field but with no prior project context, encounter any term whose intended meaning requires undocumented project-specific knowledge?

Does the terminology surface avoid redefining standard professional/domain vocabulary merely because it appears in the document?

## Control-Surface Fidelity Gate

Is every operational control item supported by deep canonical knowledge?

## Control-Surface Coverage Gate

Are the domain's critical normative properties represented in the
operational surface, or intentionally excluded with a reason?

## Technique-Neutrality Gate

Do operational challenges constrain outcomes rather than unnecessarily
prescribing implementation techniques?

## Open-Decision Gate

Were deliberately open implementation choices kept open?

## Neighbor-Domain Gate

Did the canonical avoid assuming authority over another domain?

## Execution Trial Gate

Has a capable executor attempted real work using the canonical? What
reminders were still required?

## Independent Review Gate

Can an independent reviewer falsify executor claims using the same
canonical without relying on the executor's reasoning as authority?

## Provenance Gate

Can a material implementation/review conclusion be reconstructed from
durable records rather than memory?

------------------------------------------------------------------------

# 18. Definition of done

A domain canonical is not mature merely because it is comprehensive.

A mature canonical should be:

-   authoritative within an explicit domain;
-   evidence-driven;
-   self-sufficient;
-   semantically classified;
-   rationale-preserving;
-   explicit about rejected and open knowledge;
-   cognitively organized;
-   operationally retrievable;
-   traceable from compressed controls to deep rationale;
-   usable by both human and AI executors;
-   independently challengeable;
-   refinable from observed execution evidence.

The final test is:

> **Can a competent actor who did not participate in the architecture
> discussion make and verify material implementation decisions without
> needing repeated oral/chat reminders of rules already present in the
> canonical?**

If the answer is repeatedly no, the document may be complete, but the
canonical engineering is not finished.

------------------------------------------------------------------------

# 19. Relationship with Canonical Document Governance

Use both skills when revising an established canonical.

``` text
DOMAIN CANONICAL ENGINEERING
How should architectural knowledge be discovered, structured, operationalized,
retrieved, executed, and independently challenged?

CANONICAL DOCUMENT GOVERNANCE
How can the canonical evolve, reorganize, and supersede prior versions without
silent semantic loss?
```

A major reorganization for cognitive/execution effectiveness is still
subject to preservation governance.

Do not trade execution effectiveness for historical loss, and do not
trade semantic completeness for cognitive inertness.

------------------------------------------------------------------------

# 20. Governing maxims

> **Information completeness is not execution effectiveness.**

> **A canonical is an architectural control surface, not merely an
> information repository.**

> **Preserve deep knowledge; compress its retrieval cost.**

> **The control surface indexes architecture. It does not become a
> second architecture.**

> **Constrain architectural outcomes, not implementation techniques.**

> **No evidence by memory.**

> **A canonical should survive the loss of its authors and still guide
> the next material decision correctly.**
