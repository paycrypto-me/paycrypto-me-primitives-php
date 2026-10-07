---
name: mermaid-diagram-artifacts
description: "Create or update repository Mermaid diagrams and deliver editable MMD, portable SVG and compact optimized PNG artifacts. Use for architecture diagrams, flowcharts and documentation visuals; prefer the local mermaid MCP renderer."
---

# Mermaid Diagram Artifacts

Produce a synchronized set of artifacts from one Mermaid source revision:

- `.mmd`: editable structure, labels and relationships; the regeneration source.
- `.svg`: scalable shapes and inspectable text for detailed reading.
- `.png`: a raster view for inspecting geometry, grouping, position and connections,
  including agents/viewers that cannot display SVG directly.

The formats complement each other. SVG is not universally readable as an image
by every AI tool, and PNG does not preserve editable semantic structure. Give
agents both exports and the source when the review needs textual and visual
understanding. Keep all three under the same basename beside the owning artifact.

## Diagram scope

Draw only the documented requirement, contract or execution stage. Label open
decisions as open; do not turn a draft diagram into an accepted PHP API or resolve
protocol alternatives for the sake of a neat flowchart. Put visual explanation
in its owning execution/documentation artifact and preserve issued assessments.
Use English labels and captions in this repository. A box need not imply a
class, interface, package or separate capability. Explain arrow meanings when
mixing execution flow with data/dependency relationships.

## Source and preferred renderer

Prefer the local `mermaid` MCP server for rendering and syntax validation. Inspect
its actual tool schema; the observed `generate_mermaid_diagram` tool accepts
`mermaid`, `theme`, `backgroundColor` and `outputType`. Start with `theme: default`,
`backgroundColor: white`, `outputType: svg`, unless the document needs another
appearance. Store the returned SVG content, not a screenshot of the editor.

When tool exposure is stale, distinguish a missing tool in the current catalog
from an uninstalled server. Reconnect it or use an available trusted MCP stdio
client against the configured server; do not silently claim MCP rendering after
using a different renderer. A manual Mermaid editor export remains a disclosed
fallback. Do not install or change MCP configuration as an automatic side effect.

For portable flowcharts, include this configuration in the `.mmd` source:

```yaml
---
config:
  htmlLabels: false
  flowchart:
    htmlLabels: false
---
```

Append the actual Mermaid diagram after that header. Native SVG labels avoid the
observed failure where the renderer returned valid XML containing HTML
`foreignObject` text, but standalone viewers showed only empty boxes. An XML
parse or a successful browser/MCP PNG is insufficient to validate that SVG.

## Finalize and optimize

Use [scripts/export_artifacts.py](scripts/export_artifacts.py) on the MCP's raw
SVG to produce the final SVG/PNG pair. It requires Python 3, `rsvg-convert` and
`pngquant`; these are documentation tools, not consumer/Composer dependencies.
Check availability. The observed user installation is `~/.local/bin/pngquant`
3.0.3; another user, machine or container may need its own installation.

```bash
python3 tools/skills/mermaid-diagram-artifacts/scripts/export_artifacts.py \
  /tmp/example-raw.svg --output-dir docs/path/diagrams --stem example
```

The helper rejects HTML labels, preserves word spacing, sets explicit dimensions
and adds an opaque white canvas. It rasterizes that finalized SVG at **1280 px
wide**, then applies `pngquant --quality 90-100 --speed 1 --nofs --strip
--skip-if-larger`. Compression starts from a fresh raster, not an already
quantized PNG. A quality-floor/size rejection retains the fresh raster and is
reported; tool failures stop export. If a command is outside PATH, use
`--pngquant /path/to/pngquant` or `--rsvg-convert /path/to/rsvg-convert`.

1280 px is a tested starting point, not a universal diagram requirement. The
PNG's main purpose is the overall architectural arrangement; accepting reduced
small-text legibility saves pixels and bytes because detailed textual reading
has the SVG/MMD as complementary artifacts. Retain labels in the PNG: visual
review still needs to identify nodes and arrows. Raise `--width` or split a dense
diagram when thin edges, arrowheads, groupings or necessary identifiers become
unclear. Do not optimize until structure becomes ambiguous.

Read [references/rendering-insights.md](references/rendering-insights.md) when
choosing resolution, troubleshooting SVG compatibility, or explaining these
format/quality trade-offs. It contains measured results and the original evidence.

## Verify and hand off

Inspect the actual PNG produced from the finalized SVG through an independent
renderer. Check labels/word spacing, edge directions, arrowheads, contrast,
group-title clipping and source-to-image correspondence. The helper checks file
structure and dimensions; it does not perform this visual/semantic review.

Link source and both exports from the owning artifact; record renderer/tool
versions, width and compression settings. Report before/after byte sizes without
calling lossy quantization lossless. Preserve the MMD/SVG for high-detail use;
neither compression settings nor visual inspection establishes protocol correctness.
Do not commit, push or publish solely because this skill ran.
