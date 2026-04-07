# devcoach

A senior dev in your terminal. Claude Code skills that coach junior devs through planning, building, reviewing, and learning — backed by a three-tier knowledge system that tracks what you understand and grows with you over time.

## What is this?

devcoach is a set of Claude Code skills that turn your terminal into a pair programming session with a patient, demanding senior developer. It doesn't write code for you — it makes sure you understand everything you're building, flags risks you haven't thought about, and grows with you over time.

## Modes

### `/plan` — Before you build
Understand the problem before writing code. The coach assesses what you know, fills gaps, and builds the plan with you. Writes `plan.json` so `/create` and `/review` know what you're building.

### `/create` — While you build
Pair programming. The coach watches what you write, asks why you made the choices you did, and only interrupts when something is genuinely risky. Tracks your progress through the plan.

### `/review` — Before you push
Three checks: **risk** (security, data integrity, architecture), **knowledge** (can you explain what you wrote?), and **metacognition** (do you know what you don't know?). Compares what you built against the plan.

### `/learn` — Anytime
Open-ended learning. Ask about a concept, and the coach builds understanding layer by layer. Surfaces YouTube videos and codebase examples where helpful.

### `/sync` — When you're done
Transfers your learnings up to the next tier and cleans up. Task → project, or project → root. Your knowledge is never lost.

## Three-Tier Knowledge System

Knowledge lives at three levels, and insights flow upward:

```
~/.devcoach/knowledge.json         ← ROOT: follows you across all projects
project/.devcoach/knowledge.json   ← PROJECT: specific to this codebase  
project/plan.json                  ← TASK: what you're building right now
```

**Task level** (`plan.json`) — written during `/plan`, tracks your current task. Steps, risks, concepts involved. Disposable after the work is done.

**Project level** (`.devcoach/knowledge.json`) — tracks your understanding within this project. Updated automatically during sessions.

**Root level** (`~/.devcoach/knowledge.json`) — your global brain. Persists across all projects. Only updated via `/sync` when you finish a project.

When you `/sync`, learnings transfer up and the current tier cleans up. When you start a new project, the coach reads your root knowledge and already knows you.

### Mastery Levels

| Level | Name | Meaning |
|-------|------|---------|
| L0 | Encountered | Came up in conversation or code |
| L1 | Exposed | You engaged with it — asked questions, restated it |
| L2 | Applied | You reached for it correctly on your own |
| L3 | Internalized | You can explain it, predict failures, transfer it to new contexts |

## Setup

One command from inside any project:

```bash
curl -sL https://raw.githubusercontent.com/MikWess/devcoach/main/install.sh | bash
```

That's it. It drops the coach files into your project and asks if you want to set up a global knowledge store. Then:

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
~/.devcoach/
  knowledge.json           ← root-level knowledge (global, optional)

project/
  .claude/
    CLAUDE.md              ← always-on coach persona
    commands/
      plan.md              ← /plan mode
      create.md            ← /create mode
      review.md            ← /review mode
      learn.md             ← /learn mode
      sync.md              ← /sync — transfer & clean up
    skills/
      knowledge-update.md  ← when/how knowledge stores update
      socratic-method.md   ← teaching by questioning
      youtube-search.md    ← surfacing video resources
  .devcoach/
    knowledge.json         ← project-level knowledge
  dev.md                   ← your personal preferences
  plan.json                ← current task plan (auto-generated)
```

## Uninstall

From inside a project:
- `/sync` to save your learnings to root, then it removes all devcoach files
- Or manually: `rm -rf .claude .devcoach dev.md plan.json`

To remove the global store: `rm -rf ~/.devcoach`

## Philosophy

The goal is to make yourself unnecessary. A junior dev who uses this for six months should need it less, not more. Every interaction is designed to build genuine understanding — not dependency on an AI that writes code for you.

## License

MIT
