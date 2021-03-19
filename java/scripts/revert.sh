#!/usr/bin/env sh

echo "[TCR] Reverting changes"
git checkout HEAD -- ./src/main
