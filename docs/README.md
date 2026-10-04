# PayCrypto.Me Primitives — Documentation Map

This file is a navigation map for the repository documentation. It is **not**
an architecture canonical and does not create architectural authority.

## Current structure

```text
README.md
docs/
├── canonicals/
│   └── primitives/
│       └── paycrypto-primitives-canonical-architecture-reference-v1.6.md
├── specifications/
│   └── paycrypto-pip-specification-v0.2.md
├── protocols/
│   └── primitives/
│       └── COUNTER-PROOF-REPORT.md
├── pips/
│   └── PIPxxxxx/                    # Issue-derived identity for an active PIP
├── archives/
│   └── pips/
│       └── PIPxxxxx/                # preserved identity for an archived PIP
└── research/                         # repository evidence/proposals when applicable

tools/
└── skills/
    ├── domain-canonical-engineering/
    └── canonical-document-governance/
```

## Authority and purpose

The active capability plan is
[PIP-0003 — Public Address Derivation](pips/PIP-0003/PIP-0003.md).
Its [independent plan review](reviews/plan-first-capability-canonical-alignment.md)
assesses architectural alignment only. PIP-0001 and PIP-0002 retain their separate
documentation-rewrite and provider-research identities. The former
`PLAN-FIRST-CAPABILITY.md` path is a navigation note for historical assessments.

- `README.md` is the public entry point for the Primitives repository.
- `docs/canonicals/primitives/` contains the current authoritative Primitives
  architecture reference.
- `docs/specifications/` contains project-wide specifications used by this
  repository. The PIP specification governs PIP identity and process; it does
  not replace a domain canonical.
- `docs/protocols/primitives/` contains Primitives-specific operational
  protocols. Counter-Proof reporting is operational/provenance machinery; the
  Primitives canonical owns the architectural meaning of each CP.
- `docs/pips/` is the active material-work space defined by the PIP
  specification.
- `docs/archives/` is the generic documentation archive root. PIP archival uses
  `docs/archives/pips/`.
- New material work starts from its originating Issue. Derive the `PIPxxxxx`
  identity from that Issue; after approval, create a separate Execution Plan
  only when execution complexity justifies one. Preserve traceability through
  PRs to the resulting repository changes.
- Historical PIP-0001 and PIP-0002 predate v0.2. Their issued `SHA256SUMS`
  manifests identify the files assessed at the time, so checking them against
  today's working tree is not a valid historical verification. Verify PIP-0001's
  five files against its [assessed snapshot](pips/PIP-0001/SNAPSHOT.md), and
  PIP-0002's 21 files against Git revision
  `55b4a7bcbee1916801ef2c8387b11ee2650d456e`. Keep the issued manifests
  unchanged when current documentation evolves.
- The PIP-0003 execution package also predates v0.2. Its issued package manifest
  identifies the baseline at Git revision `95e83842ed9f4a577998e49851449230f56f56b2`; the specification references
  now distinguish that historical baseline from the current v0.2 rules.
- `docs/research/` may contain evidence, investigations, spikes, and proposals.
  Those artifacts do not become canonical merely by being stored there.
- `tools/skills/` contains reusable engineering/governance methods. Skills
  govern how architectural documents are engineered or revised; they are not
  Primitives architecture.

## Current authoritative set included in this package

1. Primitives Canonical Architecture Reference v1.6
2. PayCrypto.Me PIP Specification v0.2
3. Primitives Counter-Proof Report Protocol v1.1
4. Domain Canonical Engineering Skill v1.1
5. Canonical Document Governance Skill v1.1

Superseded Primitives canonicals, the former cross-domain architecture
canonical v1.0, earlier skill revisions, earlier Counter-Proof protocol
revisions, and exploratory conceptual reports are intentionally excluded from
this current-state package.

Repository-specific files already produced by local specialists (for example
execution plans, research artifacts, release guides, source code, CI files, and
the Public Architecture entry point referenced by the root README) are not
recreated here when their exact current contents were not part of the
consolidation input. Keep those existing files in the repository unless their
own authority/process explicitly supersedes them.
