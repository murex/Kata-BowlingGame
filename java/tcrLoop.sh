#!/usr/bin/env sh

while true
do
    ./inotify-win.exe -r -e modify ./src ./test ./include
    ./tcr.sh
done
