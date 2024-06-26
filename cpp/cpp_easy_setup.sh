#!/usr/bin/env sh
#
# Copyright (c) 2024 Murex
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -eu

case $(uname -s) in
Darwin)
    os="macos"
    arch="universal"
    archive_extension="tar.gz"
    cmake_bin_dir="CMake.app/Contents/bin"
    cmake="cmake"
    ctest="ctest"
    cmake_generator_options="-G \"Xcode\""
    ;;
Linux)
    os="linux"
    arch="x86_64"
    archive_extension="tar.gz"
    cmake_bin_dir="bin"
    cmake="cmake"
    ctest="ctest"
    cmake_generator_options="-G \"Unix Makefiles\""
    ;;
MINGW64_NT-*)
    os="windows"
    arch="x86_64"
    archive_extension="zip"
    cmake_bin_dir="bin"
    cmake="cmake.exe"
    ctest="ctest.exe"
    cmake_generator_options="-G \"Visual Studio 17 2022\""
    ;;
*)
    echo "os $(uname -s) is currently not supported."
    exit 1
    ;;
esac

base_dir=$(dirname -- "$0")
cd "${base_dir}"

cmake_version="3.29.3"
cmake_expected_dir="cmake-${cmake_version}-${os}-${arch}"
cmake_expected_archive_file="${cmake_expected_dir}.${archive_extension}"
cmake_archive_url="http://github.com/Kitware/CMake/releases/download/v${cmake_version}/${cmake_expected_archive_file}"
cmake_home="cmake-${os}-${arch}"

build_dir="build"
mkdir -p "${build_dir}"

cmake_dir=".cmake"
mkdir -p "${cmake_dir}"
cd "${cmake_dir}"

if ! [ -f "${cmake_expected_archive_file}" ]
then
  echo "-- Downloading ${cmake_expected_archive_file}"
  curl -# -L "${cmake_archive_url}" -o "${cmake_expected_archive_file}"

  echo "-- Extracting cmake ${cmake_version}"
  case "${archive_extension}" in
  zip)
    unzip -q -o "${cmake_expected_archive_file}"
    ;;
  tar.gz)
    tar zxf "${cmake_expected_archive_file}"
    ;;
  *)
    echo "Archive format ${archive_extension} is currently not supported."
    exit 1
    ;;
  esac

  [ -d "${cmake_home}" ] && rm -Rf "${cmake_home}"
  mv "${cmake_expected_dir}" "${cmake_home}"
fi

cd ..

cmake_bin_path="${cmake_dir}/${cmake_home}/${cmake_bin_dir}"

eval ${cmake_bin_path}/${cmake} "${cmake_generator_options}" -S . -B "${build_dir}"
${cmake_bin_path}/${cmake} --build "${build_dir}" --config Debug
${cmake_bin_path}/${ctest} --test-dir "${build_dir}" --output-on-failure --build-config Debug
