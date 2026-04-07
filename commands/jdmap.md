# /jdmap — Visualize Your Knowledge

Read `~/.jdvance/knowledge.json` and `.jdvance/knowledge.json` (if it exists in the current project). Merge them into a single view.

Then generate an interactive HTML concept map and open it in the browser.

## What to Generate

Create a single self-contained HTML file with:

### Layout
- Each concept is a **node** (rounded rectangle)
- Nodes are **color-coded by mastery level**:
  - L0 (Encountered): gray (#555)
  - L1 (Exposed): slate (#6b7280)
  - L2 (Applied): blue (#2563eb)
  - L3 (Internalized): green (#16a34a)
- Nodes show: concept name, level badge, and last seen date
- **Related concepts** are connected with lines
- **Gaps** appear as red-outlined nodes with dashed borders

### Style
- Dark background (#1a1a1a), monospace font
- Claude Code aesthetic — clean, minimal, professional
- Nodes should be draggable so the dev can rearrange
- Include a legend showing the 4 levels
- Title: "jdvance — knowledge map"
- Show total concept count and breakdown by level at the top

### Interactivity
- Click a node to expand it showing: notes, misconceptions cleared, level history
- Hover shows the concept category
- Use basic CSS/JS — no external dependencies, everything inline

### Stats Bar
- Total concepts, count per level, total gaps
- Dev name and current project from the profile

## How to Display

1. Write the HTML file to `/tmp/jdmap-XXXXX.html` (use a timestamp or random suffix)
2. Run `open /tmp/jdmap-XXXXX.html` to open in the default browser
3. Tell the dev: "Knowledge map opened in your browser."

## If Knowledge Store is Empty

If there are no concepts tracked yet, tell the dev: "No concepts tracked yet. Start a `/jdlearn` or `/jdcreate` session to build your knowledge map."

$ARGUMENTS
