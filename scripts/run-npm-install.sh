#!/usr/bin/env bash

# 第 1 引数と第 2 引数とのコミットに 
# package.json または package-lock.json の差分が見られた場合は
# `npm install` を実行する

set -e

# プロジェクトのルートに移動
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
cd "$REPO_ROOT"

OLD_REV="${1:-}"
NEW_REV="${2:-}"

if [[ -n "${OLD_REV}" && -n "${NEW_REV}" ]]; then
  CHANGED="$(git diff --name-only "${OLD_REV}" "${NEW_REV}" || true)"
  if echo "${CHANGED}" | grep -E -q '^(package\.json|package-lock\.json)$'; then
    echo "👀 Dependency differences detected. Running \`npm install\`..."
    npm install
  fi
fi
