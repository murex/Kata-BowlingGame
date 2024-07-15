#!/usr/bin/env bash

CMAKE_BUILD_DIR="./build"
CMAKE_CONFIG="Debug"
case $(uname -s) in
  Darwin) CMAKE_GENERATOR='Xcode';;
  Linux) CMAKE_GENERATOR='Unix Makefiles';;
  MINGW64_NT-*) CMAKE_GENERATOR='Visual Studio 17 2022';;
  *) echo "os $(uname -s) not supported." && exit 1;;
esac

export CMAKE_BUILD_DIR
export CMAKE_CONFIG
export CMAKE_GENERATOR
