#!/usr/bin/env sh
#
# Copyright (c) 2021 Murex
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

command_args=$*

base_dir="$(cd "$(dirname -- "$0")" && pwd)"
tcr_dir="$(dirname "${base_dir}")/tcr"

# ------------------------------------------------------------------------------
# Retrieves the TCR Go executable to be launched depending on local machine's
# OS and architecture
# ------------------------------------------------------------------------------

retrieve_tcr_go_exe() {
  os_name=$(uname -s)
  arch=$(uname -m)

  case ${os_name} in
  Darwin | Linux)
    os=${os_name}
    ext=""
    ;;
  MINGW64_NT-*)
    os=Windows
    ext=".exe"
    ;;
  *)
    echo "OS $(os_name) is currently not supported"
    exit 1
    ;;
  esac

  exe_path="${tcr_dir}/tcr_go/bin/tcr_${os}_${arch}${ext}"

  # If the file does not exist, this means we don't support this platform
  if ! type "${exe_path}" >/dev/null 2>/dev/null; then
    echo "Platform $(os_name)/${arch} is currently not supported"
    exit 1
  fi

  echo "${exe_path}"
}

# ------------------------------------------------------------------------------
# Main function
# ------------------------------------------------------------------------------

tcr_go_exe=$(retrieve_tcr_go_exe)

# shellcheck disable=SC2086
"${tcr_go_exe}" $command_args --base-dir "${base_dir}"

exit $?
