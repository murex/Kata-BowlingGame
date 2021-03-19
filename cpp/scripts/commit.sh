#!/usr/bin/env sh

current_branch=$(git rev-parse --abbrev-ref HEAD)

echo "[TCR] Committing changes"
git commit -am TCR
git push --no-recurse-submodules origin "${current_branch}"