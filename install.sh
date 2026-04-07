#!/bin/bash
# jdvance installer — run from inside your project directory
# Usage: curl -sL https://raw.githubusercontent.com/MikWess/jdvance/main/install.sh | bash

set -e

# Colors
ORANGE='\033[38;5;208m'
DIM='\033[2m'
BOLD='\033[1m'
GREEN='\033[32m'
RESET='\033[0m'

echo ""
echo -e "${ORANGE}${BOLD}  J.D. VANCE${RESET}"
echo -e "${DIM}  Junior Dev — Driven Via Agentic Native Claude Education${RESET}"
echo ""
echo -e "  Installing into ${BOLD}$(pwd)${RESET}..."
echo ""

# Clone to temp dir
TMPDIR=$(mktemp -d)
git clone --quiet https://github.com/MikWess/jdvance.git "$TMPDIR/jdvance"

# Copy project files into .jdvance/
if [ -d ".jdvance" ]; then
  echo -e "  ${ORANGE}Warning:${RESET} .jdvance/ already exists. Updating..."
fi
mkdir -p .jdvance/commands .jdvance/skills
cp "$TMPDIR/jdvance/.jdvance/CLAUDE.md" .jdvance/CLAUDE.md
cp "$TMPDIR/jdvance/.jdvance/commands/"*.md .jdvance/commands/
cp "$TMPDIR/jdvance/.jdvance/skills/"*.md .jdvance/skills/
# Only copy knowledge.json if it doesn't exist (preserve existing)
if [ ! -f ".jdvance/knowledge.json" ]; then
  cp "$TMPDIR/jdvance/.jdvance/knowledge.json" .jdvance/knowledge.json
fi
cp "$TMPDIR/jdvance/dev.md" .
echo -e "  ${GREEN}+${RESET} Installed .jdvance/ (coach, modes, knowledge store)"

# Install global /jdvance command
mkdir -p "$HOME/.claude/commands"
cp "$TMPDIR/jdvance/jdvance-command.md" "$HOME/.claude/commands/jdvance.md"
echo -e "  ${GREEN}+${RESET} Installed /jdvance command globally"

# Ask about gitignore
echo ""
echo -e "  ${ORANGE}${BOLD}Add jdvance to .gitignore?${RESET} ${DIM}(recommended — keeps coach files out of commits)${RESET}"
echo ""
read -p "  Add to .gitignore? (Y/n) " -n 1 -r </dev/tty
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
  IGNORE_ENTRIES=(".jdvance/" "dev.md" "plan.json")
  if [ -f ".gitignore" ]; then
    for entry in "${IGNORE_ENTRIES[@]}"; do
      grep -qxF "$entry" .gitignore || echo "$entry" >> .gitignore
    done
  else
    printf '%s\n' "${IGNORE_ENTRIES[@]}" > .gitignore
  fi
  echo -e "  ${GREEN}+${RESET} Added .jdvance/, dev.md, and plan.json to .gitignore"
else
  echo -e "  ${DIM}Skipped. jdvance files will be visible to git.${RESET}"
fi

# Ask about global knowledge store
if [ ! -f "$HOME/.jdvance/knowledge.json" ]; then
  echo ""
  echo -e "  ${ORANGE}${BOLD}Want jdvance to remember you across projects?${RESET}"
  echo ""
  echo -e "  This creates a small folder at ${BOLD}$HOME/.jdvance/${RESET} containing:"
  echo -e "    ${DIM}-${RESET} knowledge.json  ${DIM}(your concept mastery, starts empty)${RESET}"
  echo -e "    ${DIM}-${RESET} dashboard.html  ${DIM}(visualize your progress)${RESET}"
  echo -e "    ${DIM}-${RESET} jdvance CLI     ${DIM}(open dashboard from anywhere)${RESET}"
  echo ""
  echo -e "  When you ${BOLD}/sync${RESET}, learnings transfer here so you never start from zero."
  echo -e "  ${DIM}To remove later: rm -rf ~/.jdvance${RESET}"
  echo ""
  read -p "  Set up global knowledge store? (y/n) " -n 1 -r </dev/tty
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p "$HOME/.jdvance"
    cat > "$HOME/.jdvance/knowledge.json" << 'ENDJSON'
{
  "dev_profile": {
    "name": "",
    "stack": [],
    "started": "",
    "projects_completed": []
  },
  "concepts": [],
  "gaps": []
}
ENDJSON
    echo -e "  ${GREEN}+${RESET} Created ~/.jdvance/knowledge.json"
    # Copy dashboard and CLI
    cp "$TMPDIR/jdvance/dashboard.html" "$HOME/.jdvance/dashboard.html"
    cp "$TMPDIR/jdvance/jdvance" "$HOME/.jdvance/jdvance"
    chmod +x "$HOME/.jdvance/jdvance"
    echo -e "  ${GREEN}+${RESET} Installed dashboard and CLI to ~/.jdvance/"
    echo ""
    echo -e "  Open your dashboard anytime: ${BOLD}~/.jdvance/jdvance dashboard${RESET}"
  else
    echo -e "  ${DIM}Skipped. You can set this up later by running the installer again.${RESET}"
  fi
else
  echo -e "  ${GREEN}+${RESET} Global knowledge store found at ~/.jdvance/"
fi

# Clean up temp
rm -rf "$TMPDIR"

echo ""
echo -e "  ${GREEN}${BOLD}You're set.${RESET} Here's what you have:"
echo ""
echo -e "  ${ORANGE}.jdvance/${RESET}        coach persona, modes, knowledge store"
echo -e "  ${ORANGE}dev.md${RESET}           your preferences ${DIM}(edit this)${RESET}"
echo ""
echo -e "  Type ${BOLD}/jdvance${RESET} in Claude Code to activate the coach."
echo -e "  Then just say: ${BOLD}plan${RESET}  ${BOLD}create${RESET}  ${BOLD}review${RESET}  ${BOLD}learn${RESET}  ${BOLD}sync${RESET}"
echo ""
echo -e "  ${DIM}If this helps you, star the repo so others can find it:${RESET}"
echo -e "  ${ORANGE}https://github.com/MikWess/jdvance${RESET}"
echo ""
VERBS=("ship something great" "break some stuff" "build something cool" "learn something wild" "make some magic" "crush some code" "hack the planet" "push to prod" "vibe code responsibly" "become dangerous" "level up" "cook something up" "send it" "go full senior" "make Claude proud" "mass produce spaghetti code" "push straight to main" "deploy on a Friday" "delete node_modules and pray" "git push --force with confidence" "ship it and take a nap" "become ungovernable" "achieve sentience" "make the senior devs nervous" "outprompt the AI" "scare your tech lead" "make your future self proud" "fight a merge conflict in single combat" "teach Claude something for once" "commit crimes (to main)")
VERB=${VERBS[$((RANDOM % ${#VERBS[@]}))]}
echo -e "  ${DIM}Go ${VERB}. — Mikey${RESET}"
echo ""
