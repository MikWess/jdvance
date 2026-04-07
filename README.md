# J.D. VANCE

A senior dev in your terminal. Claude Code skills that coach junior devs through planning, building, reviewing, and learning — backed by a three-tier knowledge system that tracks what you understand and grows with you over time.

## What is this?

jdvance is a set of Claude Code skills that turn your terminal into a pair programming session with a patient, demanding senior developer. It doesn't write code for you — it makes sure you understand everything you're building, flags risks you haven't thought about, and grows with you over time.

## Modes

### plan — Before you build
Understand the problem before writing code. The coach assesses what you know, fills gaps, and builds the plan with you. Writes `plan.json` so create and review know what you're building.

### create — While you build
Pair programming. The coach watches what you write, asks why you made the choices you did, and only interrupts when something is genuinely risky. Tracks your progress through the plan.

### review — Before you push
Three checks: **risk** (security, data integrity, architecture), **knowledge** (can you explain what you wrote?), and **metacognition** (do you know what you don't know?). Compares what you built against the plan.

### learn — Anytime
Open-ended learning. Ask about a concept, and the coach builds understanding layer by layer. Surfaces YouTube videos and codebase examples where helpful.

### sync — When you're done
Transfers your learnings up to root. `sync --nuke` saves and removes all jdvance files from the project.

## Three-Tier Knowledge System

Knowledge lives at three levels, and insights flow upward:

```
~/.jdvance/knowledge.json         ← ROOT: follows you across all projects
project/.jdvance/knowledge.json   ← PROJECT: specific to this codebase  
project/plan.json                  ← TASK: what you're building right now
```

**Task level** (`plan.json`) — written during `/plan`, tracks your current task. Steps, risks, concepts involved. Disposable after the work is done.

**Project level** (`.jdvance/knowledge.json`) — tracks your understanding within this project. Updated automatically during sessions.

**Root level** (`~/.jdvance/knowledge.json`) — your global brain. Persists across all projects. Only updated via `/sync` when you finish a project.

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
curl -sL https://raw.githubusercontent.com/MikWess/jdvance/main/install.sh | bash
```

That's it. It drops a `.jdvance/` folder into your project and installs a global `/jdvance` command. Then:

```bash
claude
/jdvance
```

Type `/jdvance` in any Claude Code session to activate the coach. Then just say "plan", "create", "review", "learn", or "sync" to switch modes. It never touches your project's `.claude/` folder — works safely in any repo, even shared production codebases.

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

Everything is editable. The files in `.jdvance/commands/` and `.jdvance/skills/` are plain markdown — change anything that doesn't work for you.

## File Structure

```
~/.claude/commands/
  jdvance.md               ← global /jdvance command (installed once)

~/.jdvance/                ← root-level (global, optional)
  knowledge.json
  dashboard.html
  jdvance                  ← CLI for opening dashboard

project/
  .jdvance/                ← everything lives here, never touches .claude/
    CLAUDE.md              ← coach persona
    commands/
      plan.md              ← /plan mode
      create.md            ← /create mode
      review.md            ← /review mode
      learn.md             ← /learn mode
      sync.md              ← /sync — save learnings
    skills/
      knowledge-update.md
      socratic-method.md
      youtube-search.md
    knowledge.json         ← project-level knowledge
  dev.md                   ← your personal preferences
  plan.json                ← current task plan (auto-generated)
```

## Uninstall

From inside a project:
- `/sync --nuke` to save your learnings and remove all jdvance files
- Or manually: `rm -rf .jdvance dev.md plan.json`

To remove globally: `rm -rf ~/.jdvance ~/.claude/commands/jdvance.md`

## Philosophy

You are always in control. The AI doesn't decide what you build, when you push, or what you learn next — you do. It coaches, it questions, it flags risks, but every decision is yours.

The knowledge store isn't a hidden score. It's yours to read, edit, and watch grow. When you see a concept move from L0 to L3, that's not a metric — that's a real change in what you can do without help.

The goal is that a junior dev who uses this for six months needs it less, not more. Every interaction builds genuine understanding — not dependency on an AI that writes code for you.

## License

MIT
