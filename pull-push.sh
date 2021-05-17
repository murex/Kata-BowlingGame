#!/usr/bin/env sh

# Pulls and pushes the current git branch.
#
# Use it to quickly switch driver in a remote mob or randori

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
export CURRENT_BRANCH

git pull --no-recurse-submodules origin "${CURRENT_BRANCH}"
git add .
git commit -m 'Working...'
git push --no-recurse-submodules origin "${CURRENT_BRANCH}"
