#!/usr/bin/env sh

cd "$(dirname -- "$0")" || exit

while true; do
  ./pull-push.sh
done
