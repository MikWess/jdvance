# Knowledge Update Skill

This skill governs when and how to update the knowledge stores. All five modes depend on this.

## The Three Tiers

Knowledge lives at three levels:

- **`plan.json`** (PR/task level) — written by `/plan`, tracks the current task. Disposable.
- **`.devcoach/knowledge.json`** (project level) — tracks concepts within this project. Updated during sessions.
- **`~/.devcoach/knowledge.json`** (root level) — tracks concepts across all projects. Updated only via `/sync`.

During normal sessions, you read all three but only write to project level. Root is updated exclusively through `/sync`.

## When to Update

Update the knowledge store in exactly three situations:

### 1. Session End
At the end of a session (or when the dev is wrapping up), do a summary write:
- Add any new concepts encountered (start at L0 or L1 depending on engagement)
- Record any level promotions observed during the session
- Update `last_seen` timestamps on concepts that came up
- Add any newly identified gaps to the `gaps` array

### 2. Mastery Moment (Immediate)
Write immediately when you detect a clear mastery signal mid-session:
- Dev explains a concept correctly without being prompted
- Dev catches their own bug related to a tracked concept
- Dev connects two concepts unprompted ("oh, this is like when we...")
- Dev predicts what will break before running the code

Record the signal in the concept's `level_history` with the date and context.

### 3. Misconception Cleared (Immediate)
When the dev held a wrong mental model and it's now corrected, record it immediately:
- Add to the concept's `misconceptions_cleared` array
- This is the most valuable thing to record — knowing what someone *used to* think wrong is more useful than knowing what they've seen

## Concept Schema

When adding a new concept to the store:

```json
{
  "id": "kebab-case-name",
  "category": "broad-category",
  "level": 0,
  "first_seen": "YYYY-MM-DD",
  "last_seen": "YYYY-MM-DD",
  "level_history": [
    {
      "level": 0,
      "date": "YYYY-MM-DD",
      "context": "mode:project-or-topic",
      "signal": "what happened that triggered this level"
    }
  ],
  "misconceptions_cleared": [],
  "related": [],
  "notes": ""
}
```

## Promotion Logic

Apply these rules strictly. Do not promote on vibes — require a concrete signal.

**L0 -> L1 (Encountered -> Exposed)**
- The dev engaged beyond passive acknowledgment
- They asked a follow-up question, restated the concept, or connected it to prior knowledge
- A simple "ok" or "got it" is NOT sufficient for L1

**L1 -> L2 (Exposed -> Applied)**
- The dev used the concept correctly in their own code without being told to
- They reached for the right pattern independently
- Using it because you suggested it does NOT count

**L2 -> L3 (Applied -> Internalized)**
- The dev explained it correctly when you probed ("walk me through why you did X")
- OR they identified where it applied in a context you hadn't mentioned
- OR they predicted a failure mode before running the code
- This level requires demonstrated transferable understanding

## Probing for L3

In `/review` mode especially, periodically probe the dev's understanding of concepts at L2:
- "Before we wrap up — walk me through why you used X here instead of Y"
- "What would happen if Z failed at this point?"
- "Where else in the codebase would this pattern apply?"

The answer is a live mastery signal. Record it either way — promotion or "not yet ready."

## Managing Gaps

The `gaps` array tracks things the dev has bumped into but doesn't understand yet. This is as important as the concept list.

- Add to gaps when: the dev encounters something they can't reason about, skips over something important, or makes an assumption they can't justify
- Remove from gaps when: the concept gets added to the concepts list at L1 or higher
- Review gaps at session start if they're relevant to the current work
- In `/review` mode, actively scan against the gaps list before allowing a push

## Notes Field

Use the `notes` field for things the mastery level alone can't capture:
- "Solid on the happy path. Has not been tested on error propagation across async boundaries yet."
- "Gets the syntax but doesn't yet understand when to reach for this vs the alternative."
- "Strong intuition here — may be ready for L3 with one more test."

## Rules

- Never update silently. When you write to the knowledge store, briefly tell the dev what you recorded and why.
- Trust the dev's self-assessment if they edit the file directly.
- When in doubt about a promotion, don't promote. Wait for a clearer signal.
- Prefer specificity over breadth. "async error propagation" is a better concept entry than "async/await."
