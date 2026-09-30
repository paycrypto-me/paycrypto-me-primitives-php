# `<Domain>`{=html} --- Canonical Architecture Reference

## Architecture Baseline v0.x

> **Document role:** canonical, self-sufficient architecture reference
> for `<Domain>`.
>
> **Status:**
> `<exploratory / accepted checkpoint / implementation-entry>`{=html}.
>
> **Concrete requirement(s) grounding the current architecture:**
> \<...\>
>
> **Scope boundary:** this document governs `<Domain>`. Neighboring
> domains are referenced only where necessary to define this domain's
> boundary, requirements, constraints, dependencies, or external
> contracts.

------------------------------------------------------------------------

# 0. How to use this canonical

Explain:

-   what this document preserves;
-   what is normative versus illustrative;
-   what a new executor should read first;
-   how to use any execution control surface;
-   when to follow deep references;
-   how independent review works, if applicable.

------------------------------------------------------------------------

# 0A. Canonical Terminology

Add only project-specific, locally coined, overloaded, or otherwise non-obvious terms whose intended meaning cannot safely be inferred by the expected specialist audience.

Do not turn this into a glossary of the field.

---

# 0B. Execution Control Surface

> Add this only after deriving it from the deep canonical.

For each control item:

``` markdown
## <ID> — <Name>

**Challenge / Counter-proof**
...

**Required property**
...

**Deep References**
→ §...
```

Do not invent a fixed number of controls in advance.

------------------------------------------------------------------------

# 1. Domain purpose and surrounding boundary

Why does this domain exist?

What belongs here?

What explicitly does not?

Which neighboring relationships are necessary to understand this
boundary?

------------------------------------------------------------------------

# 2. Concrete evidence

Record the concrete requirements, existing behavior, standards,
experiments, product constraints, or other evidence that grounded the
architecture.

Keep evidence distinct from architectural decisions.

------------------------------------------------------------------------

# 3. Architectural thesis

State the smallest set of sentences that explain how this domain is
shaped.

Prefer domain-specific rules over generic software best practices.

------------------------------------------------------------------------

# 4. Conceptual architecture

Describe the capability/component model and meaningful relationships.

Use diagrams only when their topology carries information.

------------------------------------------------------------------------

# 5. Composition and extension rules

How does the domain grow?

What is reused?

What constitutes genuine divergence?

What remains data/configuration versus new behavior?

------------------------------------------------------------------------

# 6. Ownership and dependency boundaries

What does the domain own?

What does it delegate?

What external implementation details must not leak into domain
contracts?

------------------------------------------------------------------------

# 7. Correctness, verification, and resilience

What does correctness mean here?

Which behaviors require independent evidence?

What must be replaceable or contained?

------------------------------------------------------------------------

# 8. Security / protected boundaries

Record only boundaries justified by the domain.

Do not invent a security model merely to fill this section.

------------------------------------------------------------------------

# 9. Accepted decisions

List the current frozen architectural baseline.

Do not silently mix proposals or open questions here.

------------------------------------------------------------------------

# 10. Deliberately open decisions

Preserve uncertainty explicitly.

State what evidence should resolve each open point when known.

------------------------------------------------------------------------

# 11. Rejected / corrected approaches

Preserve negative knowledge when forgetting it could recreate a known
mistake.

------------------------------------------------------------------------

# 12. Architectural anti-goals

State what this domain is deliberately not becoming.

------------------------------------------------------------------------

# 13. Fitness tests

Detailed questions that challenge future proposals.

If an execution control surface exists, explain its relationship to
these deeper tests rather than duplicating them as a second canon.

------------------------------------------------------------------------

# 14. Continuation / implementation-entry guidance

Define the next evidence-producing work.

Do not turn speculative future features into a roadmap.

------------------------------------------------------------------------

# 15. Canonical terminology reference

Keep this section only if a later terminology reference is useful. The primary terminology surface should remain compact and appear before operational mechanisms that depend on local terms.

------------------------------------------------------------------------

# 16. Canonical status and revision record

State:

-   what version this is;
-   what prior current version it supersedes;
-   what changed;
-   what remains deliberately open;
-   preservation statement;
-   current source-of-truth statement.

------------------------------------------------------------------------

# Canonical Engineering Gate

Before promoting this document ask:

-   Domain Authority: PASS / FAIL
-   Evidence Classification: PASS / FAIL
-   Self-Sufficiency: PASS / FAIL
-   Cognitive Retrieval: PASS / FAIL
-   Terminology Gap: PASS / FAIL
-   Control-Surface Fidelity: PASS / FAIL / N/A
-   Control-Surface Coverage: PASS / FAIL / N/A
-   Technique Neutrality: PASS / FAIL / N/A
-   Open Decisions Preserved: PASS / FAIL
-   Neighbor-Domain Containment: PASS / FAIL
-   Executor Trial: PASS / FAIL / NOT YET RUN
-   Independent Review: PASS / FAIL / NOT YET RUN
-   Provenance Recoverability: PASS / FAIL / N/A
