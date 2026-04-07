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

# Check if .claude/CLAUDE.md already exists
if [ -f ".claude/CLAUDE.md" ]; then
  echo -e "  ${ORANGE}Warning:${RESET} .claude/CLAUDE.md already exists."
  echo -e "  jdvance will overwrite your .claude/ folder."
  read -p "  Continue? (y/n) " -n 1 -r </dev/tty
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "  Aborted."
    exit 1
  fi
fi

# Clone to temp dir
TMPDIR=$(mktemp -d)
git clone --quiet https://github.com/MikWess/jdvance.git "$TMPDIR/jdvance"

# Copy coach files
cp -r "$TMPDIR/jdvance/.claude" .
cp "$TMPDIR/jdvance/dev.md" .

# Create project-level knowledge store
mkdir -p .jdvance
cp "$TMPDIR/jdvance/.jdvance/knowledge.json" .jdvance/knowledge.json

# Add jdvance files to .gitignore
# Ask about gitignore
echo ""
echo -e "  ${ORANGE}${BOLD}Add jdvance to .gitignore?${RESET} ${DIM}(recommended — keeps coach files out of commits)${RESET}"
echo ""
read -p "  Add to .gitignore? (Y/n) " -n 1 -r </dev/tty
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
  IGNORE_ENTRIES=(".claude/" ".jdvance/" "dev.md" "plan.json")
  if [ -f ".gitignore" ]; then
    for entry in "${IGNORE_ENTRIES[@]}"; do
      grep -qxF "$entry" .gitignore || echo "$entry" >> .gitignore
    done
  else
    printf '%s\n' "${IGNORE_ENTRIES[@]}" > .gitignore
  fi
  echo -e "  ${GREEN}+${RESET} Added .claude/, .jdvance/, dev.md, and plan.json to .gitignore"
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
echo -e "  ${ORANGE}.claude/${RESET}         coach persona + 5 modes"
echo -e "  ${ORANGE}.jdvance/${RESET}       project knowledge store"
echo -e "  ${ORANGE}dev.md${RESET}           your preferences ${DIM}(edit this)${RESET}"
echo ""
echo -e "  Modes: ${BOLD}/plan${RESET}  ${BOLD}/create${RESET}  ${BOLD}/review${RESET}  ${BOLD}/learn${RESET}  ${BOLD}/sync${RESET}"
echo ""
echo -e "  Run ${BOLD}claude${RESET} to start. The coach will take it from here."
echo ""
echo -e "  ${DIM}If this helps you, star the repo so others can find it:${RESET}"
echo -e "  ${ORANGE}https://github.com/MikWess/jdvance${RESET}"
echo ""
VERBS=("ship something great" "break some stuff" "build something cool" "learn something wild" "make some magic" "crush some code" "hack the planet" "push to prod" "vibe code responsibly" "become dangerous" "level up" "cook something up" "send it" "go full senior" "make Claude proud")
VERB=${VERBS[$((RANDOM % ${#VERBS[@]}))]}
echo -e "  ${DIM}Go ${VERB}. — Mikey${RESET}"
echo ""
