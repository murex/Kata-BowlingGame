#!/usr/bin/env sh

set -eu

BASE_DIR="$(cd "$(dirname -- "$0")" && pwd)"
SCRIPT_DIR="$(dirname "${BASE_DIR}")/tcr"

# ------------------------------------------------------------------------------
# For TCR-specific traces and errors
# ------------------------------------------------------------------------------

tcr_info() {
  message="$1"
  printf "%b" "\e[1;36m[TCR] ${message} \e[0m\n"
}

tcr_error() {
  message="$1"
  printf "%b" "\e[1;31m[TCR] ${message}. Aborting. \e[0m\n"
  exit 1
}

# ------------------------------------------------------------------------------
# Detect kata language and set parameters accordingly
# ------------------------------------------------------------------------------

LANGUAGE=${BASE_DIR##*/}

case "${LANGUAGE}" in
java)
  TOOLCHAIN="gradle"
  WORK_DIR="${BASE_DIR}"
  SRC_DIR="${BASE_DIR}/src/main"
  INCLUDE_DIR=""
  TEST_DIR="${BASE_DIR}/src/test"
  ;;
cpp)
  TOOLCHAIN="cmake"
  WORK_DIR="${BASE_DIR}/build"
  SRC_DIR="${BASE_DIR}/src"
  INCLUDE_DIR="${BASE_DIR}/include"
  TEST_DIR="${BASE_DIR}/test"
  ;;
*)
  tcr_error "Unable to detect language."
  ;;
esac

# ------------------------------------------------------------------------------
# File System watch
# ------------------------------------------------------------------------------

tcr_watch_fs() {
  tcr_info "Going to sleep until something interesting happens"
  "${SCRIPT_DIR}"/inotify-win.exe -r -e modify "${SRC_DIR}" "${INCLUDE_DIR}" "${TEST_DIR}"
  # TODO Extend to other OS's than Windows
}

# ------------------------------------------------------------------------------
# Build command
# ------------------------------------------------------------------------------

tcr_build() {
  tcr_info "Launching Build"
  case "${TOOLCHAIN}" in
  gradle)
    ./gradlew build -x test
    ;;
  maven)
    ./mvnw test-compile
    ;;
  cmake)
    ./cmake/cmake-win64-x64/bin/cmake.exe --build . --config Debug
    # TODO Extend to other OS's than Windows
    ;;
  *)
    tcr_error "Toolchain ${TOOLCHAIN} is not supported"
    ;;
  esac
}

# ------------------------------------------------------------------------------
# Test command
# ------------------------------------------------------------------------------

tcr_test() {
  tcr_info "Running Tests"
  case ${TOOLCHAIN} in
  gradle)
    ./gradlew test
    ;;
  maven)
    ./mvnw test
    ;;
  cmake)
    ./cmake/cmake-win64-x64/bin/ctest.exe --output-on-failure -C Debug
    # TODO Extend to other OS's than Windows
    ;;
  *)
    tcr_error "Toolchain ${TOOLCHAIN} is not supported"
    ;;
  esac
}

# ------------------------------------------------------------------------------
# Commit command
# ------------------------------------------------------------------------------

tcr_commit() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  tcr_info "Committing changes on branch ${current_branch}"
  git commit -am TCR
  git push --no-recurse-submodules origin "${current_branch}"
}

# ------------------------------------------------------------------------------
# Revert command
# ------------------------------------------------------------------------------

tcr_revert() {
  tcr_info "Reverting changes"
  git checkout HEAD -- "${SRC_DIR}" "${INCLUDE_DIR}"
}

# ------------------------------------------------------------------------------
# TCR sequence
# ------------------------------------------------------------------------------

tcr_run() {
  tcr_build && (tcr_test && tcr_commit || tcr_revert)
}

# ------------------------------------------------------------------------------
# Setting the toolchain to be used from command line
# ------------------------------------------------------------------------------

update_toolchain() {
  required_toolchain="$1"
  if [ -z "${required_toolchain}" ]; then
    tcr_error "Toolchain is not specified"
  fi

  case $required_toolchain in
  gradle | maven)
    if [ "${LANGUAGE}" = "java" ]; then
      TOOLCHAIN="${required_toolchain}"
    else
      tcr_error "Toolchain ${required_toolchain} is not supported for language ${LANGUAGE}"
    fi
    ;;
  cmake)
    if [ "${LANGUAGE}" = "cpp" ]; then
      TOOLCHAIN="${required_toolchain}"
    else
      tcr_error "Toolchain ${required_toolchain} is not supported for language ${LANGUAGE}"
    fi
    ;;
  *)
    tcr_error "Toolchain ${required_toolchain} is not supported"
    ;;
  esac
}

# ------------------------------------------------------------------------------
# TCR Main Loop
# ------------------------------------------------------------------------------

# Loop through arguments and process them
tcr_loop_mode=1
set +u
for arg in "$@"; do
  case $arg in
  -n | --no-loop)
    tcr_loop_mode=0
    shift
    ;;
  -t | --toolchain)
    update_toolchain "$2"
    shift
    shift
    ;;
  esac
done
set -u

cd "${WORK_DIR}" || exit 1

tcr_info "Starting. Language=${LANGUAGE}, Toolchain=${TOOLCHAIN}"

if [ ${tcr_loop_mode} -eq 1 ]; then
  while true; do
    tcr_watch_fs
    tcr_run
  done
else
  # Run TCR only once
  tcr_run
fi
