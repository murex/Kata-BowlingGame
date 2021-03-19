#!/usr/bin/env sh

work_dir="."
script_dir="./scripts"

cd ${work_dir} || exit 1

${script_dir}/buildIt.sh && \
(${script_dir}/test.sh && ${script_dir}/commit.sh || ${script_dir}/revert.sh)
