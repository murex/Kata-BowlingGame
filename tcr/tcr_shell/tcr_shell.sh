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

set -u

LANGUAGE_BASE_DIR="$(cd "$(dirname -- "$0")" && pwd)"
WRAPPER_PATH="${LANGUAGE_BASE_DIR}/$(basename "$0")"
COMMAND_ARGS=$*
SCRIPT_DIR="$(dirname "${LANGUAGE_BASE_DIR}")/tcr/tcr_shell"

# ------------------------------------------------------------------------------
# For POSIX-compliant list manipulation (Cf. https://github.com/Ventto/libshlist)
# ------------------------------------------------------------------------------
. "${SCRIPT_DIR}/lib/liblist.sh"

# ------------------------------------------------------------------------------
# Catch Ctrl-C to bypass infinite loop around fswatch/inotify
# ------------------------------------------------------------------------------

tcr_catch_ctrl_c() {
  echo
  # We restart the script. This trick prevents having multiple CTRL-C
  # not being handled properly in some situations
  # shellcheck disable=SC2086
  exec "${WRAPPER_PATH}" ${COMMAND_ARGS}
}

# ------------------------------------------------------------------------------
# For TCR-specific traces and errors
# ------------------------------------------------------------------------------

tcr_info() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do printf "%b" "\e[1;36m[TCR] ${line} \e[0m\n"; done
}

tcr_horizontal_line() {
  term_columns=$(tput cols)
  repeated=$((term_columns - 7))
  line=$(head -c "${repeated}" </dev/zero | tr '\0' '-')
  tcr_info "$line"
}

tcr_warning() {
  message="$1"
  printf "%b" "${message}\n" | while IFS= read -r line; do printf "%b" "\e[1;33m[TCR] ${line} \e[0m\n"; done
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
  LANGUAGE=${LANGUAGE_BASE_DIR##*/}
  LANGUAGE_VARIABLES_FILE="${SCRIPT_DIR}/languages/${LANGUAGE}"

  if [ -f "${LANGUAGE_VARIABLES_FILE}" ]; then
    # shellcheck source=languages/java
    # shellcheck source=languages/cpp
    . "${LANGUAGE_VARIABLES_FILE}"
    # defines:
    #  TOOLCHAIN
    #  SUPPORTED_TOOLCHAINS
    #  WORK_DIR
    #  SRC_DIRS
    #  TEST_DIRS
  else
    tcr_error "Unable to detect language"
  fi
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
    ;;
  Linux)
    tcr_check_inotifywait_availability
    FS_WATCH_CMD="inotifywait -r -e modify"
    ;;
  MINGW64_NT-*)
    FS_WATCH_CMD="${SCRIPT_DIR}/bin/inotify-win.exe -r -e modify"
    ;;
  *)
    tcr_error "OS $(OS) is currently not supported"
    ;;
  esac
}

# ------------------------------------------------------------------------------
# Detect git working branch
# ------------------------------------------------------------------------------

tcr_detect_git_working_branch() {
  GIT_WORKING_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  GIT_WORKING_BRANCH_EXISTS_ON_ORIGIN=$(git branch -r | grep -c "origin/${GIT_WORKING_BRANCH}" || [ $? = 1 ])
}

# ------------------------------------------------------------------------------
# Pull branch contents from origin
# ------------------------------------------------------------------------------

tcr_pull() {
  if [ "${GIT_WORKING_BRANCH_EXISTS_ON_ORIGIN}" = 1 ]; then
    tcr_info "Pulling latest changes from origin/${GIT_WORKING_BRANCH}"
    git pull --no-recurse-submodules origin "${GIT_WORKING_BRANCH}"
  else
    tcr_info "Working locally on branch ${GIT_WORKING_BRANCH}"
  fi
}

# ------------------------------------------------------------------------------
# Push branch contents to origin
# ------------------------------------------------------------------------------

tcr_push() {
  tcr_info "Pushing changes to origin/${GIT_WORKING_BRANCH}"
  git push --no-recurse-submodules origin "${GIT_WORKING_BRANCH}"
  git_rc=$?
  [ ${git_rc} -eq 0 ] && GIT_WORKING_BRANCH_EXISTS_ON_ORIGIN=1
  return ${git_rc}
}

# ------------------------------------------------------------------------------
# File System watch
# ------------------------------------------------------------------------------

tcr_watch_filesystem() {
  tcr_info "Going to sleep until something interesting happens"
  # shellcheck disable=SC2086
  ${FS_WATCH_CMD} ${SRC_DIRS} ${TEST_DIRS}
}

# ------------------------------------------------------------------------------
# Build command
# ------------------------------------------------------------------------------

tcr_build() {
  tcr_info "Launching Build"

  build_rc=0
  ${TCR_BUILD_CMD}
  build_rc=$?

  [ $build_rc -ne 0 ] && tcr_warning "There are build errors! I can't go any further"
  return $build_rc
}

# ------------------------------------------------------------------------------
# Test command
# ------------------------------------------------------------------------------

tcr_test() {
  tcr_info "Running Tests"

  test_rc=0
  ${TCR_TEST_CMD}
  test_rc=$?

  [ $test_rc -ne 0 ] && tcr_warning "Some tests are failing! That's unfortunate"
  return $test_rc
}

# ------------------------------------------------------------------------------
# Commit command
# ------------------------------------------------------------------------------

tcr_commit() {
  tcr_info "Committing changes on branch ${GIT_WORKING_BRANCH}"
  git commit -am TCR
  if [ "${AUTO_PUSH_MODE}" -eq 1 ]; then
    tcr_push
  fi
}

# ------------------------------------------------------------------------------
# Revert command
# ------------------------------------------------------------------------------

tcr_revert() {
  tcr_warning "Reverting changes"
  # shellcheck disable=SC2086
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

  list_contains "${required_toolchain}" "${SUPPORTED_TOOLCHAINS}"
  TOOLCHAIN_NOT_SUPPORTED=$?

  if test ${TOOLCHAIN_NOT_SUPPORTED} -eq 0; then
    TOOLCHAIN="${required_toolchain}"
  else
    tcr_error "Toolchain ${required_toolchain} is not supported for language ${LANGUAGE}"
  fi
}

tcr_define_toolchain_commands() {
  TOOLCHAIN_COMMANDS_FILE="${SCRIPT_DIR}/toolchains/${TOOLCHAIN}"

  if [ -f "${TOOLCHAIN_COMMANDS_FILE}" ]; then
    # shellcheck source=toolchains/gradle
    # shellcheck source=toolchains/maven
    # shellcheck source=toolchains/cmake
    . "${TOOLCHAIN_COMMANDS_FILE}"
    # defines:
    #  TCR_BUILD_CMD
    #  TCR_TEST_CMD
  else
    tcr_error "Could not load toolchain commands file"
  fi
}

# ------------------------------------------------------------------------------
# Ask user to indicate in which mode we should operate
# ------------------------------------------------------------------------------

tcr_what_shall_we_do() {

  trap tcr_catch_ctrl_c INT TERM

  tcr_horizontal_line
  tcr_info "Language=${LANGUAGE}, Toolchain=${TOOLCHAIN}"
  [ "${AUTO_PUSH_MODE}" -eq 1 ] && auto_push_state="enabled" || auto_push_state="disabled"
  tcr_info "Running on git branch \"${GIT_WORKING_BRANCH}\" with auto-push ${auto_push_state}"

  old_stty_cfg=$(stty -g)

  while true; do
    tcr_horizontal_line
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
  tcr_info "  -p, --auto-push            enable git push after every commit"
  tcr_info "                             auto-push is disabled by default"
  tcr_info "  -t, --toolchain TOOLCHAIN  indicate the toolchain to be used by TCR"
  tcr_info "                             supported toolchains:"
  tcr_info "`ls ${SCRIPT_DIR}/toolchains | sed 's/^/                              - /'`"
}

# ------------------------------------------------------------------------------
# TCR Main Loop
# ------------------------------------------------------------------------------

tcr_detect_running_os
tcr_detect_kata_language

# Loop through arguments and process them

AUTO_PUSH_MODE=0

set +u
for arg in "$@"; do
  case $arg in
  -h | --help)
    tcr_show_help
    exit 1
    ;;
  -p | --auto-push)
    AUTO_PUSH_MODE=1
    shift
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

cd "${WORK_DIR}" || exit 1

tcr_define_toolchain_commands
tcr_detect_git_working_branch

tcr_what_shall_we_do
