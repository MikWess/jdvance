#!/bin/bash
# jdvance installer — run from inside your project directory
# Usage: curl -sL https://raw.githubusercontent.com/MikWess/jdvance/main/install.sh | bash

set -e

echo "Installing jdvance into $(pwd)..."

# Check if .claude/CLAUDE.md already exists
if [ -f ".claude/CLAUDE.md" ]; then
  echo ""
  echo "Warning: .claude/CLAUDE.md already exists in this directory."
  echo "jdvance will overwrite your .claude/ folder."
  read -p "Continue? (y/n) " -n 1 -r </dev/tty
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
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
IGNORE_ENTRIES=(".jdvance/" "dev.md" "plan.json")
if [ -f ".gitignore" ]; then
  for entry in "${IGNORE_ENTRIES[@]}"; do
    grep -qxF "$entry" .gitignore || echo "$entry" >> .gitignore
  done
else
  printf '%s\n' "${IGNORE_ENTRIES[@]}" > .gitignore
fi
echo "  Added .jdvance/, dev.md, and plan.json to .gitignore"

# Ask about global knowledge store
if [ ! -f "$HOME/.jdvance/knowledge.json" ]; then
  echo ""
  echo "Want jdvance to remember you across projects?"
  echo "This sets up ~/.jdvance/ — your global brain. When you /sync,"
  echo "learnings transfer here so you never start from zero again."
  echo ""
  read -p "Set up global knowledge store? (y/n) " -n 1 -r </dev/tty
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
    echo "  Created ~/.jdvance/knowledge.json"
    # Copy dashboard and CLI
    cp "$TMPDIR/jdvance/dashboard.html" "$HOME/.jdvance/dashboard.html"
    cp "$TMPDIR/jdvance/jdvance" "$HOME/.jdvance/jdvance"
    chmod +x "$HOME/.jdvance/jdvance"
    echo "  Installed dashboard and CLI to ~/.jdvance/"
    echo ""
    echo "  To open your dashboard anytime: ~/.jdvance/jdvance dashboard"
    echo "  (or add ~/.jdvance to your PATH)"
  else
    echo "  Skipped. You can set this up later by running the installer again."
  fi
else
  echo "  Global knowledge store found at ~/.jdvance/"
fi

# Clean up temp
rm -rf "$TMPDIR"

echo ""
echo "jdvance installed. You now have:"
echo "  .claude/         — coach persona + 5 modes (/plan /create /review /learn /sync)"
echo "  .jdvance/       — project knowledge store"
echo "  dev.md           — your preferences (edit this)"
echo ""
echo "Run 'claude' to start. The coach will take it from here."
echo ""
echo "If jdvance helps you, star the repo so others can find it:"
echo "  https://github.com/MikWess/jdvance"
