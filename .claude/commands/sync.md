# /sync — Sync & Clean Up

You are running a knowledge sync. This transfers learnings from the current tier up to the tier above, then cleans up.

## How It Works

### PR/Task → Project Sync (default)

When the dev runs `/sync` with an active `plan.json`:

1. Read `plan.json` — identify all concepts that were encountered, leveled up, or had misconceptions cleared during this task.
2. Read `.devcoach/knowledge.json` — the project-level store.
3. **Transfer up**: For each concept in the task that showed a mastery change:
   - If the concept exists at project level, update it to the higher level (never downgrade)
   - If the concept is new, add it to project level
   - Carry over `misconceptions_cleared` — these are always valuable
   - Carry over relevant `notes`
4. Show the dev what's being transferred:
   ```
   Syncing task → project:
   - MCP tool registration: L1 → L2
   - Zod schema validation: new (L1)
   - Misconception cleared: "thought MCP servers need HTTP"
   
   Save to project knowledge? (y/n)
   ```
5. On confirmation, update `.devcoach/knowledge.json` and delete `plan.json`.

### Project → Root Sync

When the dev runs `/sync` and there's no `plan.json` (or they use `/sync --project`):

1. Read `.devcoach/knowledge.json` — the project-level store.
2. Read `~/.devcoach/knowledge.json` — the root-level store.
3. **Distill and transfer**: Only transfer concepts that are:
   - Transferable beyond this project (e.g., "understands async/await" yes, "knows where the auth middleware lives in this codebase" no)
   - At a higher level than root currently has
   - New concepts that are generally applicable
4. Show the dev what's being transferred:
   ```
   Syncing project → root:
   - async/await: L2 → L3 (was L2 at root)
   - database transactions: new (L2)
   - Dropping: "SchoolAI auth middleware" (project-specific)
   
   Save to root knowledge? (y/n)
   ```
5. On confirmation, update `~/.devcoach/knowledge.json`.
6. Ask: "Want to remove devcoach from this project? All your learnings are saved to root."
7. If yes, remove `.devcoach/`, `.claude/`, `dev.md`, and `plan.json` from the project.

### `/sync --all`

Does both in sequence: PR → project, then project → root.

### `/sync --keep`

Syncs up but does NOT delete anything at the current level. For when you want to save progress but you're not done yet.

## What Gets Transferred vs Dropped

**Always transfer:**
- Concept level promotions
- Misconceptions cleared
- New concepts at L1+
- Notes that capture understanding nuances

**Never transfer to root:**
- Project-specific knowledge (file locations, codebase architecture, team conventions)
- L0 concepts (just encountered, not yet understood)
- Gaps that were never addressed

**Merge rules:**
- Higher level wins (if project has L3 and root has L2, root becomes L3)
- Never downgrade a level during sync
- Combine notes from both levels
- Combine misconceptions_cleared arrays

## Nudging Toward Sync

The coach should nudge toward `/sync` at natural moments:
- PR merged or task completed → "Nice work. Want to `/sync` your learnings?"
- Dev says "I'm done with this project" → "Before you go — `/sync` will save what you learned to your global knowledge."
- Dev hasn't synced in a while and has significant learning → one gentle nudge

$ARGUMENTS
