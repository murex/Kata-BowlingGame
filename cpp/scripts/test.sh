#!/usr/bin/env sh

./cmake/cmake-win64-x64/bin/ctest.exe --output-on-failure -C Debug

# TODO Extend to other OS's than Windows
