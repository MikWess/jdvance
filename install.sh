#!/bin/bash
# jdvance installer
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
echo -e "  This will install the following to your machine:"
echo ""
echo -e "  ${BOLD}~/.claude/commands/${RESET}"
echo -e "    6 slash commands: /jdvance /jdplan /jdcreate /jdreview /jdlearn /jdsync"
echo ""
echo -e "  ${BOLD}~/.jdvance/${RESET}"
echo -e "    Coach persona, teaching skills, and a global knowledge store"
echo -e "    ${DIM}(tracks your concept mastery across all projects)${RESET}"
echo ""
echo -e "  ${DIM}Nothing is installed in any project directory."
echo -e "  Nothing touches your existing .claude/ config."
echo -e "  To uninstall: rm -rf ~/.jdvance ~/.claude/commands/jd*.md${RESET}"
echo ""
read -p "  Install? (Y/n) " -n 1 -r </dev/tty
echo ""
if [[ $REPLY =~ ^[Nn]$ ]]; then
  echo "  Aborted."
  exit 0
fi
echo ""

# Clone to temp dir
TMPDIR=$(mktemp -d)
git clone --quiet https://github.com/MikWess/jdvance.git "$TMPDIR/jdvance"

# Install commands to ~/.claude/commands/
mkdir -p "$HOME/.claude/commands"
cp "$TMPDIR/jdvance/commands/"*.md "$HOME/.claude/commands/"
echo -e "  ${GREEN}+${RESET} Installed slash commands: /jdvance /jdplan /jdcreate /jdreview /jdlearn /jdsync"

# Install persona, skills, and knowledge to ~/.jdvance/
mkdir -p "$HOME/.jdvance/skills"
cp "$TMPDIR/jdvance/.jdvance/CLAUDE.md" "$HOME/.jdvance/CLAUDE.md"
cp "$TMPDIR/jdvance/.jdvance/skills/"*.md "$HOME/.jdvance/skills/"

# Only create knowledge.json if it doesn't exist (preserve existing)
if [ ! -f "$HOME/.jdvance/knowledge.json" ]; then
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
else
  echo -e "  ${GREEN}+${RESET} Kept existing ~/.jdvance/knowledge.json"
fi

echo -e "  ${GREEN}+${RESET} Installed coach persona and skills to ~/.jdvance/"

# Clean up temp
rm -rf "$TMPDIR"

echo ""
echo -e "  ${GREEN}${BOLD}You're set.${RESET}"
echo ""
echo -e "  Type ${BOLD}/jdvance${RESET} in any Claude Code session to activate the coach."
echo -e "  Commands: ${BOLD}/jdplan${RESET}  ${BOLD}/jdcreate${RESET}  ${BOLD}/jdreview${RESET}  ${BOLD}/jdlearn${RESET}  ${BOLD}/jdsync${RESET}"
echo ""
echo -e "  When you activate in a project, the coach will ask if you want"
echo -e "  a temporary project-level knowledge base. That's the only file"
echo -e "  that touches your project — and you delete it when you're done."
echo ""
echo -e "  ${DIM}If this helps you, star the repo so others can find it:${RESET}"
echo -e "  ${ORANGE}https://github.com/MikWess/jdvance${RESET}"
echo ""
VERBS=("ship something great" "break some stuff" "build something cool" "learn something wild" "make some magic" "crush some code" "hack the planet" "push to prod" "vibe code responsibly" "become dangerous" "level up" "cook something up" "send it" "go full senior" "make Claude proud" "mass produce spaghetti code" "push straight to main" "deploy on a Friday" "delete node_modules and pray" "git push --force with confidence" "ship it and take a nap" "become ungovernable" "achieve sentience" "make the senior devs nervous" "outprompt the AI" "scare your tech lead" "make your future self proud" "fight a merge conflict in single combat" "teach Claude something for once" "commit crimes (to main)")
VERB=${VERBS[$((RANDOM % ${#VERBS[@]}))]}
echo -e "  ${DIM}Go ${VERB}. — Mikey${RESET}"
echo ""
