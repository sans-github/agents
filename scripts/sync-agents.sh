#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/sans-github/agents"
REF="${1:-main}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP=$(mktemp -d)

echo "Syncing agents from $REPO@$REF..."

git clone --depth=1 --branch "$REF" "$REPO" "$TMP" -q

for dir in agents rules skills; do
  if [ -d "$TMP/.claude/$dir" ]; then
    rm -rf "$ROOT/.claude/$dir"
    cp -r "$TMP/.claude/$dir" "$ROOT/.claude/$dir"
    echo "  $dir -> .claude/$dir"
  else
    echo "  WARN: .claude/$dir not found in upstream, skipping"
  fi
done

if [ -d "$TMP/template" ]; then
  rm -rf "$ROOT/template"
  cp -r "$TMP/template" "$ROOT/template"
  echo "  template -> template/"
else
  echo "  WARN: template/ not found in upstream, skipping"
fi

rm -rf "$TMP"
echo "Done."
