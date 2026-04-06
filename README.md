# devcoach

A senior dev in your terminal. Claude Code skills that coach junior devs through planning, building, reviewing, and learning — backed by a persistent knowledge store that tracks what you understand and how deeply.

## What is this?

devcoach is a set of Claude Code skills that turn your terminal into a pair programming session with a patient, demanding senior developer. It doesn't write code for you — it makes sure you understand everything you're building, flags risks you haven't thought about, and grows with you over time.

The system tracks your concept mastery across sessions using a local `knowledge.json` file. Every concept you encounter gets a mastery level (L0–L3), and the coach adapts based on what you know and what you don't.

## Modes

### `/plan` — Before you build
Understand the problem before writing code. The coach assesses what you know, fills gaps with targeted questions and resources, and builds the plan collaboratively. You shouldn't start coding until you can explain the approach yourself.

### `/create` — While you build
Pair programming. The coach watches what you write, asks why you made the choices you did, and only interrupts when something is genuinely risky. The goal: you understand everything you create, independent from the AI.

### `/review` — Before you push
Three checks: **risk** (security, data integrity, architecture), **knowledge** (can you explain what you wrote?), and **metacognition** (do you know what you don't know?). Won't let you push until you demonstrate understanding.

### `/learn` — Anytime
Open-ended learning. Ask about a concept, and the coach builds understanding layer by layer — what it is, why it exists, how it works, when to use it, what breaks. Surfaces YouTube videos and codebase examples where helpful.

## The Knowledge Store

`knowledge.json` tracks every concept you encounter:

| Level | Name | Meaning |
|-------|------|---------|
| L0 | Encountered | Came up in conversation or code |
| L1 | Exposed | You engaged with it — asked questions, restated it |
| L2 | Applied | You reached for it correctly on your own |
| L3 | Internalized | You can explain it, predict failures, transfer it to new contexts |

The store also tracks misconceptions you've cleared, gaps you haven't addressed yet, and notes about the nuances of your understanding. It updates automatically during sessions and you can edit it directly anytime.

## Setup

One command from inside any project:

```bash
curl -sL https://raw.githubusercontent.com/MikWess/devcoach/main/install.sh | bash
```

That's it. It drops the coach files into your project. Then:

```bash
cd your-project  # important: be inside the project directory
claude
```

**Important:** Always start `claude` from inside the project directory. The coach loads from `.claude/CLAUDE.md` at session start — if you run `claude` from your home directory and navigate in later, it won't activate automatically. (It will offer to switch on if it detects the files mid-session, but starting inside the project is the cleanest experience.)

## Customization

Edit `dev.md` to set your preferences in plain english:

```markdown
## How I like to learn
I prefer being asked questions over being told answers.

## Nudge preferences
Only interrupt me if something is genuinely risky.

## Stack context
I'm working in Python + Django. Comfortable with backend, shaky on frontend.
```

Session-level flags work on any command:
- `--fast` — skip deep-dives, get to the point
- `--strict` — hold me to a higher standard
- `--deep` — take your time, go thorough
- `--quiet` — minimal interruption

Everything is editable. The skill files in `.claude/commands/` and `.claude/skills/` are plain markdown — change anything that doesn't work for you.

## File Structure

```
.claude/
  CLAUDE.md              ← always-on coach persona
  commands/
    plan.md              ← /plan mode
    create.md            ← /create mode
    review.md            ← /review mode
    learn.md             ← /learn mode
  skills/
    knowledge-update.md  ← when/how the knowledge store updates
    socratic-method.md   ← teaching by questioning
    youtube-search.md    ← surfacing video resources

dev.md                   ← your personal preferences
knowledge.json           ← your concept mastery store
```

## Philosophy

The goal is to make yourself unnecessary. A junior dev who uses this for six months should need it less, not more. Every interaction is designed to build genuine understanding — not dependency on an AI that writes code for you.

## License

MIT
