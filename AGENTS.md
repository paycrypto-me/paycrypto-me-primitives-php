# Documentation language

English is the standard language for repository documentation, including plans,
architecture documents, diagrams, and captions. Conversation may follow the
user's language; this does not change the documentation language.

# Implementation boundary

Primitives owns its capability contracts, protocol semantics, invariants,
definitions, operations and composition. Do not implement cryptographic
algorithms or standardized encoders/decoders in this domain, regardless of how
simple they appear. Research and validate suitable libraries or runtime
facilities before selecting implementations. Reference implementation internals
are evidence to study, not code or architecture to reproduce.
