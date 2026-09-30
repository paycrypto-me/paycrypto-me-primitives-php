# Designing an Execution Control Surface

A control surface keeps critical architecture cognitively active during
execution. It is not a replacement canonical.

## When it is useful

Consider one when:

-   the canonical is substantial;
-   decisions are distributed across many sections;
-   implementation is delegated to humans or AI agents;
-   architecture contains cross-cutting invariants;
-   functional correctness alone is insufficient;
-   a prior executor ignored or missed documented rules;
-   independent verification is valuable.

## Derive, do not invent

Start from the accepted deep canonical.

For each critical invariant ask:

1.  At what implementation decision could this be violated?
2.  What question would expose the violation?
3.  What property must remain true?
4.  Where is the authoritative rationale?
5.  Can the challenge be phrased without prescribing an unnecessary
    technique?

A control item can then use:

``` markdown
## <stable id> — <semantic name>

**Challenge / Counter-proof**
<question that attempts to expose violation>

**Required property**
<architecture property that must remain true>

**Deep References**
→ <authoritative sections>
```

## Cognitive ordering

Prefer the order in which architectural mistakes emerge.

A useful generic progression is:

``` text
reason for existence
    ↓
reuse
    ↓
real divergence
    ↓
data vs behavior
    ↓
composition
    ↓
ownership
    ↓
implementation leakage
    ↓
replaceability / containment
    ↓
protected boundaries
    ↓
correctness evidence
    ↓
scope discipline
```

Adapt it. Do not force it.

## Fidelity audit

For every control item:

> Show me the deep canonical knowledge that authorizes this rule.

No support means the control item is inventing architecture.

## Coverage audit

For every critical deep invariant:

> At what control item would an executor be challenged before violating
> this?

No answer may indicate an operational retrieval gap.

Not every paragraph needs a control item. Compress semantic clusters.

## Technique neutrality

Bad:

``` text
Use a Factory.
Create an Adapter.
Use inheritance here.
```

unless those techniques are themselves canonical decisions.

Better:

``` text
Can the selected implementation be replaced without leaking its API across the
domain boundary?
```

The specialist remains free to choose a compliant implementation
technique.

## Stable identifiers

If control items are referenced by reports, give them stable IDs.

Do not renumber casually. If the semantic meaning survives a canonical
revision, preserve the ID when practical.

If the meaning materially changes, treat that as an
architectural/reporting migration rather than silently reusing the
identifier.

## Independent verification

A control surface becomes especially valuable when the reviewer uses the
same controls independently.

The reviewer is not asked:

> Did the executor fill the report correctly?

The reviewer is asked:

> Can I falsify the executor's result against the canonical property?

That difference prevents review theater.
