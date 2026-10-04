# Assessed planning snapshots

`milestones-2026-10-03-171445.tar` preserves the two planning documents assessed
by [the milestone executor report](../cp-executor-2026-10-03-171445.md), before
the self-contained execution package was added. The report and its original
hash manifest remain unchanged. This archive is historical evidence, not the
current execution entry point.

From the repository root, recover and verify that snapshot without replacing
the current files:

```sh
snapshot_dir=$(mktemp -d)
tar -xf docs/pips/PIP-0003/snapshots/milestones-2026-10-03-171445.tar -C "$snapshot_dir"
manifest_path="$PWD/docs/pips/PIP-0003/SHA256SUMS-2026-10-03-milestones"
(cd "$snapshot_dir" && sha256sum -c "$manifest_path")
```
