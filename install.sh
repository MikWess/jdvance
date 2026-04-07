#!/bin/bash
# devcoach installer — run from inside your project directory
# Usage: curl -sL https://raw.githubusercontent.com/MikWess/devcoach/main/install.sh | bash

set -e

echo "Installing devcoach into $(pwd)..."

# Check if .claude/CLAUDE.md already exists
if [ -f ".claude/CLAUDE.md" ]; then
  echo ""
  echo "Warning: .claude/CLAUDE.md already exists in this directory."
  echo "devcoach will overwrite your .claude/ folder."
  read -p "Continue? (y/n) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
  fi
fi

# Clone to temp dir
TMPDIR=$(mktemp -d)
git clone --quiet https://github.com/MikWess/devcoach.git "$TMPDIR/devcoach"

# Copy coach files
cp -r "$TMPDIR/devcoach/.claude" .
cp "$TMPDIR/devcoach/dev.md" .

# Create project-level knowledge store
mkdir -p .devcoach
cp "$TMPDIR/devcoach/knowledge.json" .devcoach/knowledge.json

# Clean up temp
rm -rf "$TMPDIR"

# Add devcoach files to .gitignore
IGNORE_ENTRIES=(".devcoach/" "dev.md" "plan.json")
if [ -f ".gitignore" ]; then
  for entry in "${IGNORE_ENTRIES[@]}"; do
    grep -qxF "$entry" .gitignore || echo "$entry" >> .gitignore
  done
else
  printf '%s\n' "${IGNORE_ENTRIES[@]}" > .gitignore
fi
echo "  Added .devcoach/, dev.md, and plan.json to .gitignore"

# Ask about global knowledge store
if [ ! -f "$HOME/.devcoach/knowledge.json" ]; then
  echo ""
  echo "devcoach can also keep a global knowledge store at ~/.devcoach/"
  echo "that tracks your learning across all projects. When you finish a"
  echo "project, your learnings transfer up so you never lose what you learned."
  echo "Next time you start a new project, the coach already knows you."
  echo ""
  read -p "Set up global knowledge store? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p "$HOME/.devcoach"
    cat > "$HOME/.devcoach/knowledge.json" << 'ENDJSON'
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
    echo "  Created ~/.devcoach/knowledge.json"
  else
    echo "  Skipped. You can set this up later by running the installer again."
  fi
else
  echo "  Global knowledge store found at ~/.devcoach/"
fi

echo ""
echo "devcoach installed. You now have:"
echo "  .claude/         — coach persona + 5 modes (/plan /create /review /learn /sync)"
echo "  .devcoach/       — project knowledge store"
echo "  dev.md           — your preferences (edit this)"
echo ""
echo "Open Claude Code and start a session. The coach will take it from here."
echo ""
echo "If devcoach helps you, star the repo so others can find it:"
echo "  https://github.com/MikWess/devcoach"
