#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TODAY=$(date +%Y%m%d)
TEMPLATE="$ROOT/.claude/template"
PROJECTS="$ROOT/projects"

echo ""
echo "New feature setup"
echo "-----------------"

# Prompt for feature name
read -rp "Feature name [${TODAY}-sample-feature]: " FEATURE_NAME
FEATURE_NAME="${FEATURE_NAME:-${TODAY}-sample-feature}"

FEATURE_DIR="$PROJECTS/$FEATURE_NAME"

# Abort if feature folder already exists
if [ -d "$FEATURE_DIR" ]; then
  echo ""
  echo "ERROR: '$FEATURE_DIR' already exists. Aborting to avoid overwrite."
  exit 1
fi

# Create projects/ if needed
mkdir -p "$PROJECTS"

# Copy master only if it doesn't exist yet
if [ -d "$PROJECTS/master" ]; then
  echo ""
  echo "  projects/master already exists -- skipping."
else
  cp -r "$TEMPLATE/master/" "$PROJECTS/master"
  echo "  projects/master created from template."
fi

# Copy feature scaffold
cp -r "$TEMPLATE/feature/" "$FEATURE_DIR"
echo "  projects/$FEATURE_NAME created from template."

echo ""
echo "See .claude/GETTING-STARTED.md for next steps."
echo ""
