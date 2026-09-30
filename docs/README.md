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
│   └── PIP-SPECIFICATION.md
├── protocols/
│   └── primitives/
│       └── COUNTER-PROOF-REPORT.md
├── pips/
│   └── PIP-NNNN/                    # created when active PIPs exist
├── archives/
│   └── pips/
│       └── PIP-NNNN/                # created when PIPs are archived
└── research/                         # repository evidence/proposals when applicable

tools/
└── skills/
    ├── domain-canonical-engineering/
    └── canonical-document-governance/
```

## Authority and purpose

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
- `docs/research/` may contain evidence, investigations, spikes, and proposals.
  Those artifacts do not become canonical merely by being stored there.
- `tools/skills/` contains reusable engineering/governance methods. Skills
  govern how architectural documents are engineered or revised; they are not
  Primitives architecture.

## Current authoritative set included in this package

1. Primitives Canonical Architecture Reference v1.6
2. PayCrypto.Me PIP Specification v0.1
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
