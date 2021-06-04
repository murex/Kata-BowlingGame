#!/usr/bin/env sh

set -eu

BASE_DIR="$(cd "$(dirname -- "$0")" && pwd)"
WRAPPER_PATH="${BASE_DIR}/$(basename "$0")"
SCRIPT_DIR="$(dirname "${BASE_DIR}")/tcr"

# ------------------------------------------------------------------------------
# For POSIX-compliant list manipulation (Cf. https://github.com/Ventto/libshlist)
# ------------------------------------------------------------------------------
. "${SCRIPT_DIR}/liblist.sh"

# ------------------------------------------------------------------------------
# Catch Ctrl-C to bypass infinite loop around fswatch/inotify
# ------------------------------------------------------------------------------

tcr_catch_ctrl_c() {
  echo
  # Before leaving, we push latest changes to origin if needed
  tcr_push
  # And then we restart the script. This trick prevents having multiple CTRL-C
  # not being handled properly in some situations
  exec "${WRAPPER_PATH}"
}

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
# Verify that a command is available on the machine path
# ------------------------------------------------------------------------------

tcr_check_command_availability() {
  command_name="$1"
  help_url="$2"
  if ! type "${command_name}" >/dev/null 2>/dev/null; then
    tcr_error "Command ${command_name} not found.\nCf. ${help_url}"
  fi
}

tcr_check_fswatch_availability() {
  tcr_check_command_availability fswatch "https://emcrisostomo.github.io/fswatch/getting.html"
}

tcr_check_inotifywait_availability() {
  tcr_check_command_availability inotifywait "https://github.com/inotify-tools/inotify-tools/wiki"
}

# ------------------------------------------------------------------------------
# Detect kata language and set parameters accordingly
# ------------------------------------------------------------------------------

tcr_detect_kata_language() {
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

tcr_detect_running_os() {
  OS=$(uname -s)

  case ${OS} in
  Darwin)
    tcr_check_fswatch_availability
    FS_WATCH_CMD="fswatch -1 -r"
    CMAKE_BIN_PATH="./cmake/cmake-macos-universal/CMake.app/Contents/bin"
    CMAKE_CMD="${CMAKE_BIN_PATH}/cmake"
    CTEST_CMD="${CMAKE_BIN_PATH}/ctest"
    ;;
  Linux)
    tcr_check_inotifywait_availability
    FS_WATCH_CMD="inotifywait -r -e modify"
    CMAKE_BIN_PATH="./cmake/cmake-Linux-x86_64/bin"
    CMAKE_CMD="${CMAKE_BIN_PATH}/cmake"
    CTEST_CMD="${CMAKE_BIN_PATH}/ctest"
    ;;
  MINGW64_NT-*)
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
# Pull branch contents from origin
# ------------------------------------------------------------------------------

tcr_pull() {
  tcr_info "Pulling latest changes from origin on branch ${GIT_WORKING_BRANCH}"
  git pull --no-recurse-submodules origin "${GIT_WORKING_BRANCH}"
  GIT_PUSH_PENDING=0
}

# ------------------------------------------------------------------------------
# Push branch contents to origin
# ------------------------------------------------------------------------------

tcr_push() {
  if [ "${GIT_PUSH_PENDING}" -eq 1 ]; then
    tcr_info "Pushing latest changes to origin on branch ${GIT_WORKING_BRANCH}"
    git push --no-recurse-submodules origin "${GIT_WORKING_BRANCH}"
    GIT_PUSH_PENDING=0
  fi
}

# ------------------------------------------------------------------------------
# File System watch
# ------------------------------------------------------------------------------

tcr_watch_filesystem() {
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
  GIT_PUSH_PENDING=1
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

tcr_update_toolchain() {
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
# Ask user to indicate in which mode we should operate
# ------------------------------------------------------------------------------

tcr_what_shall_we_do() {

  GIT_PUSH_PENDING=0

  trap tcr_catch_ctrl_c INT TERM

  tcr_info "-------------------------------------------------------------------------"
  tcr_info "Language=${LANGUAGE}, Toolchain=${TOOLCHAIN}"
  tcr_info "Running on git branch \"${GIT_WORKING_BRANCH}\""

  old_stty_cfg=$(stty -g)

  while true; do
    tcr_info "-------------------------------------------------------------------------"
    tcr_info "What shall we do?"
    tcr_info "\tD -> Driver mode"
    tcr_info "\tN -> Navigator mode"
    tcr_info "\tQ -> Quit"

    stty raw -echo
    answer=$(head -c 1)
    stty "${old_stty_cfg}"

    tcr_info ""
    case ${answer} in
    [dD])
      tcr_run_as_driver
      ;;
    [nN])
      tcr_run_as_navigator
      ;;
    [qQ])
      tcr_quit
      ;;
    esac
  done
}

# ------------------------------------------------------------------------------
# Run TCR in driver mode, e.g. actually run TCR
# ------------------------------------------------------------------------------

tcr_run_as_driver() {
  tcr_info "Entering Driver mode. Press CTRL-C to go back to the main menu"

  tcr_pull

  while true; do
    tcr_watch_filesystem
    tcr_run
  done
}

# ------------------------------------------------------------------------------
# Run TCR in navigator mode, e.g. regularly pull the repository contents
# ------------------------------------------------------------------------------

tcr_run_as_navigator() {
  tcr_info "Entering Navigator mode. Press CTRL-C to go back to the main menu"

  while true; do
    tcr_pull
  done
}

# ------------------------------------------------------------------------------
# Quit TCR
# ------------------------------------------------------------------------------

tcr_quit() {
  tcr_info "That's All Folks!"
  exit 0
}

# ------------------------------------------------------------------------------
# Display usage information
# ------------------------------------------------------------------------------

tcr_show_help() {
  tcr_info "Usage: $0 [OPTION]..."
  tcr_info "Run TCR (Test && Commit || Revert)"
  tcr_info ""
  tcr_info "  -h, --help                 show help information"
  tcr_info "  -t, --toolchain TOOLCHAIN  indicate the toolchain to be used by TCR"
  tcr_info "                             supported toolchains:"
  tcr_info "                             - gradle (java, default)"
  tcr_info "                             - maven (java)"
  tcr_info "                             - cmake (C++, default)"
}

# ------------------------------------------------------------------------------
# TCR Main Loop
# ------------------------------------------------------------------------------

tcr_detect_running_os
tcr_detect_kata_language

# Loop through arguments and process them

set +u
for arg in "$@"; do
  case $arg in
  -h | --help)
    tcr_show_help
    exit 1
    ;;
  -t | --toolchain)
    tcr_update_toolchain "$2"
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

mkdir -p "${WORK_DIR}"
cd "${WORK_DIR}" || exit 1
GIT_WORKING_BRANCH=$(git rev-parse --abbrev-ref HEAD)

tcr_what_shall_we_do
