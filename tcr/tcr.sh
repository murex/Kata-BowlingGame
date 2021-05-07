#!/usr/bin/env sh

set -eu

BASE_DIR="$(cd "$(dirname -- "$0")" && pwd)"
SCRIPT_DIR="$(dirname "${BASE_DIR}")/tcr"

# ------------------------------------------------------------------------------
# For POSIX-compliant list manipulation (Cf. https://github.com/Ventto/libshlist)
# ------------------------------------------------------------------------------
. "${SCRIPT_DIR}/liblist.sh"

# ------------------------------------------------------------------------------
# Force termination on Ctrl-C to bypass infinite loop around fswatch/inotify
# ------------------------------------------------------------------------------

force_termination() {
  kill -s "${TERMINATION_SIGNAL}" $$
  tcr_info "Exiting"
  exit 0
}

trap force_termination INT TERM

# ------------------------------------------------------------------------------
# For TCR-specific traces and errors
# ------------------------------------------------------------------------------

tcr_info() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do printf "%b" "\e[1;36m[TCR] ${line} \e[0m\n"; done
}

tcr_error() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do printf "%b" "\e[1;31m[TCR] ${line} \e[0m\n"; done
  printf "%b" "\e[1;31m[TCR] Aborting \e[0m\n"
  exit 1
}

# ------------------------------------------------------------------------------
# Verify that fswatch command is available on the machine path
# ------------------------------------------------------------------------------

check_fswatch_availability() {
  command_name="fswatch"
  if ! type "${command_name}" >/dev/null 2>/dev/null; then
    tcr_error "Command ${command_name} not found.\nCf. https://emcrisostomo.github.io/fswatch/getting.html"
  fi
}

# ------------------------------------------------------------------------------
# Detect kata language and set parameters accordingly
# ------------------------------------------------------------------------------

detect_kata_language() {
  LANGUAGE=${BASE_DIR##*/}

  case "${LANGUAGE}" in
  java)
    TOOLCHAIN="gradle"
    WORK_DIR="${BASE_DIR}"
    SRC_DIRS="$(list "${BASE_DIR}/src/main")"
    TEST_DIRS="$(list "${BASE_DIR}/src/test")"
    ;;
  cpp)
    TOOLCHAIN="cmake"
    WORK_DIR="${BASE_DIR}/build"
    SRC_DIRS="$(list "${BASE_DIR}/src" "${BASE_DIR}/include")"
    TEST_DIRS="$(list "${BASE_DIR}/test")"
    ;;
  *)
    tcr_error "Unable to detect language"
    ;;
  esac
}

# ------------------------------------------------------------------------------
# Detect running OS and set parameters accordingly
# ------------------------------------------------------------------------------

detect_running_os() {
  OS=$(uname -s)

  case ${OS} in
  Darwin)
    check_fswatch_availability
    TERMINATION_SIGNAL=TERM
    FS_WATCH_CMD="fswatch -1 -r"
    CMAKE_BIN_PATH="./cmake/cmake-macos-universal/CMake.app/Contents/bin"
    CMAKE_CMD="${CMAKE_BIN_PATH}/cmake"
    CTEST_CMD="${CMAKE_BIN_PATH}/ctest"
    ;;
  MINGW64_NT-*)
    TERMINATION_SIGNAL=INT
    FS_WATCH_CMD="${SCRIPT_DIR}/inotify-win.exe -r -e modify"
    CMAKE_BIN_PATH="./cmake/cmake-win64-x64/bin"
    CMAKE_CMD="${CMAKE_BIN_PATH}/cmake.exe"
    CTEST_CMD="${CMAKE_BIN_PATH}/ctest.exe"
    ;;
  *)
    tcr_error "OS $(OS) is currently not supported"
    ;;
  esac
}

# ------------------------------------------------------------------------------
# File System watch
# ------------------------------------------------------------------------------

tcr_watch_fs() {
  tcr_info "Going to sleep until something interesting happens"
  ${FS_WATCH_CMD} ${SRC_DIRS} ${TEST_DIRS}
}

# ------------------------------------------------------------------------------
# Build command
# ------------------------------------------------------------------------------

tcr_build() {
  tcr_info "Launching Build"
  case "${TOOLCHAIN}" in
  gradle)
    ./gradlew build -x test || true
    ;;
  maven)
    ./mvnw test-compile || true
    ;;
  cmake)
    ${CMAKE_CMD} --build . --config Debug || true
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
    ${CTEST_CMD} --output-on-failure -C Debug
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
  tcr_info "Committing changes on branch ${GIT_WORKING_BRANCH}"
  git commit -am TCR
  if [ "${AUTO_PUSH_MODE}" -eq 1 ]; then
    git push --no-recurse-submodules origin "${GIT_WORKING_BRANCH}"
  fi
}

# ------------------------------------------------------------------------------
# Revert command
# ------------------------------------------------------------------------------

tcr_revert() {
  tcr_info "Reverting changes"
  git checkout HEAD -- ${SRC_DIRS}
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
# Display usage information
# ------------------------------------------------------------------------------

show_help() {
  tcr_info "Usage: $0 [OPTION]..."
  tcr_info "Run TCR (Test && Commit || Revert)"
  tcr_info ""
  tcr_info "  -h, --help                 show help information"
  tcr_info "  -n, --no-loop              run TCR once and exit"
  tcr_info "                             the script runs indefinitely by default"
  tcr_info "  -p, --auto-push            enable git push after every commit"
  tcr_info "                             auto-push is disabled by default"
  tcr_info "  -t, --toolchain TOOLCHAIN  indicate the toolchain to be used by TCR"
  tcr_info "                             supported toolchains:"
  tcr_info "                             - gradle (java, default)"
  tcr_info "                             - maven (java)"
  tcr_info "                             - cmake (C++, default)"
}

# ------------------------------------------------------------------------------
# TCR Main Loop
# ------------------------------------------------------------------------------

detect_running_os
detect_kata_language

# Loop through arguments and process them

help_mode=0
tcr_loop_mode=1
AUTO_PUSH_MODE=0

set +u
for arg in "$@"; do
  case $arg in
  -h | --help)
    help_mode=1
    shift
    ;;
  -n | --no-loop)
    tcr_loop_mode=0
    shift
    ;;
  -p | --auto-push)
    AUTO_PUSH_MODE=1
    shift
    ;;
  -t | --toolchain)
    update_toolchain "$2"
    shift
    shift
    ;;
  *)
    if [ "$1" != "" ]; then
      tcr_error "Option not recognized: \"$1\"\nRun \"$0 -h\" for available options"
    fi
    ;;
  esac
done
set -u

if [ ${help_mode} -eq 1 ]; then
  show_help
  exit 1
fi

cd "${WORK_DIR}" || exit 1
GIT_WORKING_BRANCH=$(git rev-parse --abbrev-ref HEAD)

tcr_info "Starting. Language=${LANGUAGE}, Toolchain=${TOOLCHAIN}"
[ "${AUTO_PUSH_MODE}" -eq 1 ] && auto_push_state="enabled" || auto_push_state="disabled"
tcr_info "Running on git branch \"${GIT_WORKING_BRANCH}\" with auto push ${auto_push_state}"

if [ ${tcr_loop_mode} -eq 1 ]; then
  while true; do
    tcr_watch_fs
    tcr_run
  done
else
  # Run TCR only once
  tcr_info "Auto loop is disabled. Running TCR only once"
  tcr_run
fi

tcr_info "Exiting"
