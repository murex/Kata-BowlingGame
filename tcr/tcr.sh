#!/usr/bin/env sh

set -eu

BASE_DIR="$(cd "$(dirname -- "$0")" && pwd)"
SCRIPT_DIR="$(dirname "${BASE_DIR}")/tcr"

# ------------------------------------------------------------------------------
# For POSIX-compliant list manipulation (Cf. https://github.com/Ventto/libshlist)
# ------------------------------------------------------------------------------
. "${SCRIPT_DIR}/liblist.sh"

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
  tcr_error "Unable to detect language."
  ;;
esac

# ------------------------------------------------------------------------------
# File System watch
# ------------------------------------------------------------------------------

tcr_watch_fs() {
  tcr_info "Going to sleep until something interesting happens"
  "${SCRIPT_DIR}"/inotify-win.exe -r -e modify ${SRC_DIRS} ${TEST_DIRS}
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
  if [ "${AUTO_PUSH_MODE}" -eq 1 ]; then
    git push --no-recurse-submodules origin "${current_branch}"
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
    help_mode=1
    shift
    ;;
  esac
done
set -u

if [ ${help_mode} -eq 1 ]; then
  show_help
  exit 1
fi

cd "${WORK_DIR}" || exit 1

tcr_info "Starting. Language=${LANGUAGE}, Toolchain=${TOOLCHAIN}"
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "${AUTO_PUSH_MODE}" -eq 1 ]; then
  auto_push_state="enabled"
else
  auto_push_state="disabled"
fi
tcr_info "Running on git branch \"${current_branch}\" with auto push ${auto_push_state}"

if [ ${tcr_loop_mode} -eq 1 ]; then
  while true; do
    tcr_watch_fs
    tcr_run
  done
else
  # Run TCR only once
  tcr_info "Auto loop is disabled. Running TCR only once."
  tcr_run
fi
