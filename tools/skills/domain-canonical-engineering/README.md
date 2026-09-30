# PayCrypto.Me Domain Canonical Engineering

This skill captures the methodology developed while evolving the
PayCrypto.Me Primitives canonical from a self-sufficient architecture
reference into an execution-oriented architectural control system.

The key empirical lesson is simple:

> **Information completeness is not execution effectiveness.**

A large canonical can contain the correct rule and still fail if an
executor does not retrieve that rule when making the decision it
governs.

The skill therefore treats canonical engineering as two coupled
problems:

1.  **deep knowledge preservation** --- architecture, rationale,
    evidence, boundaries, rejected paths, open decisions, and handoff
    knowledge survive;
2.  **execution-time retrieval and verification** --- critical
    invariants are cognitively available during implementation and
    independently challengeable.

## Contents

-   `SKILL.md` --- normative reusable skill.
-   `references/METHOD.md` --- compact method map for humans and agents.
-   `references/CONTROL-SURFACE.md` --- guidance for deriving a
    domain-specific execution control surface without blindly copying
    Primitives.
-   `templates/CANONICAL-SKELETON.md` --- adaptable starting skeleton
    for a new domain canonical.

Use together with the PayCrypto.Me Canonical Document Governance skill
when an existing canonical is being revised or superseded.

The Primitives experience is a reference implementation of the method,
not a mandatory document shape for every domain.


## v1.1 refinement

v1.1 adds the Terminology Gap principle: canonical terminology is a compact entry surface for project-specific or locally specialized terms, not a glossary of standard professional/domain vocabulary.
