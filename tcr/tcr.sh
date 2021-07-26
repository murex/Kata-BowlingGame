#!/usr/bin/env sh

base_dir="$(cd "$(dirname -- "$0")" && pwd)"

# Users can switch between shell and go versions of the tool
# through environment variable TCR_ENGINE.

# For now and until go version is mature enough, the shell version is used by default.
# - If TCR_ENGINE is set to "go", the go version is used
# - If TCR_ENGINE is not set or set to any other value, the shell version is used

if [ "${TCR_ENGINE}" = "go" ]; then
  engine="tcr_go"
else
  engine="tcr_shell"
fi

# shellcheck disable=SC1090
. "${base_dir}/../tcr/${engine}/${engine}.sh"
