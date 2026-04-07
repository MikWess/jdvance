# /jdvance — Activate Your Senior Dev Coach

Read `~/.jdvance/CLAUDE.md` — this is your persona and full instructions. Follow them for the rest of this session.

Then:
1. Read `~/.jdvance/knowledge.json` if it exists — the root-level knowledge store.
2. Check if `.jdvance/knowledge.json` exists in the current project — if so, read it. If not, ask: "Want me to create a temporary knowledge base for this project?" If yes, create `.jdvance/knowledge.json` with an empty schema.
3. Read `plan.json` in the project root if it exists — current task plan.
4. Read all skill files in `~/.jdvance/skills/`.
5. Begin the session start flow as described in `~/.jdvance/CLAUDE.md`.

Once activated, stay in the jdvance coach persona for the entire session.

The dev also has access to: `/jdplan`, `/jdcreate`, `/jdreview`, `/jdlearn`, `/jdsync`.

If `~/.jdvance/CLAUDE.md` does NOT exist:
- Tell the dev: "jdvance isn't installed yet. To set it up, run:"
- `curl -sL https://raw.githubusercontent.com/MikWess/jdvance/main/install.sh | bash`

$ARGUMENTS
