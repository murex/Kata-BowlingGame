#!/usr/bin/env bash
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

set -u

base_dir="$(cd "$(dirname -- "$0")" && pwd)"
if [ -z "${CMAKEW_BASE_DIR+x}" ]; then CMAKEW_BASE_DIR="${base_dir}"; fi
if [ -z "${CMAKEW_CACHE_DIR+x}" ]; then CMAKEW_CACHE_DIR="$(dirname "${base_dir}")/.cmake"; fi
if [ -z "${CMAKEW_CMD+x}" ]; then CMAKEW_CMD="cmake"; fi

# ------------------------------------------------------------------------------
# cmake directory structure and information
# ------------------------------------------------------------------------------

CMAKEW_VERSION_FILE="${CMAKEW_BASE_DIR}/version.txt"

# ------------------------------------------------------------------------------
# Trace messages
# ------------------------------------------------------------------------------

print_info() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do >&2 printf "%b" "\e[1;34m>>> ${line} \e[0m\n"; done
}

print_warning() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do >&2 printf "%b" "\e[1;33m>>> ${line} \e[0m\n"; done
}

print_error() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do >&2 printf "%b" "\e[1;31m>>> ${line} \e[0m\n"; done
}

print_horizontal_line() {
  term_columns=$(tput cols)
  repeated=$((term_columns - 5))
  line=$(head -c "${repeated}" </dev/zero | tr '\0' '-')
  print_info "$line"
}

# ------------------------------------------------------------------------------
# Download cmake from cmake website
# ------------------------------------------------------------------------------

download_cmake() {
  version="$1"
  os="$2"
  arch="$3"
  archive_extension="$4"
  exe_path="$5"

  # ----------------------------------------------------------------------------
  # 1) create and enter cache directory
  # ----------------------------------------------------------------------------

  mkdir -p "${CMAKEW_CACHE_DIR}"
  pushd "${CMAKEW_CACHE_DIR}" >/dev/null 2>/dev/null || return 1

  # ----------------------------------------------------------------------------
  # 2) download cmake archive
  # ----------------------------------------------------------------------------

  cmake_version="${version}"
  cmake_expected_dir="cmake-${cmake_version}-${os}-${arch}"
  cmake_expected_archive_file="${cmake_expected_dir}.${archive_extension}"
  cmake_archive_url="http://github.com/Kitware/CMake/releases/download/v${cmake_version}/${cmake_expected_archive_file}"
  cmake_home="cmake-${os}-${arch}"

  if ! [ -f "${cmake_expected_archive_file}" ]
  then
    print_info "downloading ${cmake_expected_archive_file}"
    if ! curl -f -# -L "${cmake_archive_url}" -o "${cmake_expected_archive_file}"; then
      print_error "failed to download ${cmake_archive_url}"
      return 1
    fi
  fi

  # ----------------------------------------------------------------------------
  # 3) expand cmake archive
  # ----------------------------------------------------------------------------

  print_info "extracting cmake ${cmake_version}"
  case "${archive_extension}" in
  zip)
    if ! unzip -q -K -o "${cmake_expected_archive_file}"; then
      print_error "failed to expand ${cmake_expected_archive_file}"
      return 1
    fi
    ;;
  tar.gz)
    if ! tar zxf "${cmake_expected_archive_file}"; then
      print_error "failed to expand ${cmake_expected_archive_file}"
      return 1
    fi
    ;;
  *)
    print_error "archive format ${archive_extension} is currently not supported"
    exit 1
    ;;
  esac

  # ----------------------------------------------------------------------------
  # 4) make the expanded archive the current version in cache
  # ----------------------------------------------------------------------------

  [ -d "${cmake_home}" ] && rm -Rf "${cmake_home}"
  mv -f "${cmake_expected_dir}" "${cmake_home}"

  popd >/dev/null 2>/dev/null || return 1
}

# ------------------------------------------------------------------------------
# Return expected cmake version
# ------------------------------------------------------------------------------

retrieve_expected_cmake_version() {
  if [ -f "${CMAKEW_VERSION_FILE}" ]; then
    expected_version=$(awk '{ print $2 }' < "${CMAKEW_VERSION_FILE}")
    # print_info "expected cmake version: ${expected_version}"
    echo "${expected_version}"
    return 0
  else
    print_error "version file not found: ${CMAKEW_VERSION_FILE}"
    return 1
  fi
}

# ------------------------------------------------------------------------------
# Return current cmake version
# ------------------------------------------------------------------------------

retrieve_current_cmake_version() {
  exe_path="$1"
  current_version=$("${exe_path}" --version | head -1 | awk '{ print $3 }')
  # print_info "current cmake version: ${current_version}"
  echo "${current_version}"
  return 0
}

# ------------------------------------------------------------------------------
# Retrieve the path to the cmake command to be launched
# depending on local machine's OS and architecture
# ------------------------------------------------------------------------------

retrieve_command_path() {
  case $(uname -s) in
  Darwin)
      os="macos"
      arch="universal"
      archive_extension="tar.gz"
      cmake_bin_dir="CMake.app/Contents/bin"
      cmd="${CMAKEW_CMD}"
      ;;
  Linux)
      os="linux"
      arch="x86_64"
      archive_extension="tar.gz"
      cmake_bin_dir="bin"
      cmd="${CMAKEW_CMD}"
      ;;
  MINGW64_NT-*)
      os="windows"
      arch="x86_64"
      archive_extension="zip"
      cmake_bin_dir="bin"
      cmd="${CMAKEW_CMD}.exe"
      ;;
  *)
      print_error "os $(uname -s) is currently not supported"
      exit 1
      ;;
  esac

  # Expected cmake version
  expected_version=$(retrieve_expected_cmake_version) || return 1

  cmake_home="cmake-${os}-${arch}"
  cmake_bin_path="${CMAKEW_CACHE_DIR}/${cmake_home}/${cmake_bin_dir}"
  cmake_exe_path="${cmake_bin_path}/${cmd}"

  file_missing=$(type "${cmake_exe_path}" >/dev/null 2>/dev/null; echo $?)
  # If the file already exists, check its current version
  version_mismatch=0
  if [ "${file_missing}" -eq 0 ]; then
    current_version=$(retrieve_current_cmake_version "${cmake_exe_path}")
    version_mismatch="$( [ "${current_version}" = "${expected_version}" ]; echo $? )"
  fi
  # If the file does not exist or if versions do not match, download it from CMAKE GitHub repository
  if [ "${file_missing}" -ne 0 ] || [ "${version_mismatch}" -ne 0 ]; then
    download_cmake "${expected_version}" "${os}" "${arch}" "${archive_extension}" "${cmake_bin_path}" || return 1
  fi

  echo "${cmake_exe_path}"
  return 0
}

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

cmd_path="$(retrieve_command_path)"
# shellcheck disable=SC2181
[ $? -ne 0 ] && print_error "aborting" && exit 1
# shellcheck disable=SC2086
"${cmd_path}" "$@"
