#!/bin/sh
# Pull my fork's changes and the latest t3code release, then push the result to my fork.
set -e
cd "$(dirname "$0")"

if [ -n "$(git status --porcelain)" ]; then
  echo "Uncommitted changes. Commit them first: git add -A && git commit -m \"...\""
  exit 1
fi

git pull --no-rebase origin main
git fetch --tags upstream
release=$(git tag -l 'v*' | grep -vE 'nightly|preview' | sort -V | tail -1)
git merge --no-edit "$release"
git push origin main
. "$HOME/.nvm/nvm.sh" && nvm use 26.12.1 >/dev/null
pnpm install
echo "Up to date with your fork and t3code $release."
echo "Rebuild the Mac app: pnpm run dist:desktop:dmg:arm64"
