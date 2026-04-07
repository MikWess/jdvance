# /sync — Save Your Learnings

You are running a knowledge sync. This pushes learnings upward so nothing is lost.

## `/sync` (default) — Save, don't delete

Push all learnings up to root. Nothing gets deleted.

### Step 1: Task → Project (if plan.json exists)

1. Read `plan.json` — identify concepts encountered, leveled up, or with misconceptions cleared.
2. Read `.jdvance/knowledge.json`.
3. Transfer up:
   - If the concept exists at project level, update to the higher level (never downgrade)
   - If the concept is new, add it
   - Carry over `misconceptions_cleared` and relevant `notes`

### Step 2: Project → Root

1. Read `.jdvance/knowledge.json`.
2. Read `~/.jdvance/knowledge.json`.
3. Distill and transfer — only concepts that are:
   - Transferable beyond this project ("understands async/await" yes, "knows where the auth middleware lives" no)
   - At a higher level than root currently has
   - New and generally applicable
4. Show the dev what's being transferred:
   ```
   Syncing learnings to root:
   - async/await: L2 → L3
   - database transactions: new (L2)
   - Skipping: "project auth middleware" (project-specific)

   Save to root knowledge?
   ```
5. On confirmation, update `~/.jdvance/knowledge.json`.

### Merge Rules

- Higher level wins (project L3 + root L2 = root becomes L3)
- Never downgrade during sync
- Combine notes and `misconceptions_cleared` from both levels

### What Gets Transferred vs Dropped

**Always transfer:** concept level promotions, misconceptions cleared, new concepts at L1+, notes with understanding nuances.

**Never transfer to root:** project-specific knowledge (file locations, architecture, conventions), L0 concepts, unaddressed gaps.

## `/sync --nuke` — Save and remove

Same sync as above, then remove all jdvance files from the project:
- `.jdvance/`
- `.claude/`
- `dev.md`
- `plan.json`

Before nuking, confirm: "All learnings are saved to root. Remove jdvance from this project?"

## Nudging Toward Sync

Nudge at natural moments:
- Task completed → "Nice work. Want to `/sync` your learnings?"
- Dev says "I'm done with this project" → "Before you go — `/sync --nuke` will save what you learned and clean up."
- Significant learning hasn't been synced in a while → one gentle nudge

$ARGUMENTS
