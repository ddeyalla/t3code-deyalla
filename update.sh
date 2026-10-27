#!/bin/sh
# Pull my fork's changes and the latest pingdotgg/t3code, then push the result to my fork.
set -e
cd "$(dirname "$0")"

if [ -n "$(git status --porcelain)" ]; then
  echo "Uncommitted changes. Commit them first: git add -A && git commit -m \"...\""
  exit 1
fi

git pull --no-rebase origin main
git pull --no-rebase --no-edit upstream main
git push origin main
corepack pnpm install
echo "Up to date with your fork and t3code."
