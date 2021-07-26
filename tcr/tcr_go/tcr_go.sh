#!/usr/bin/env sh

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
