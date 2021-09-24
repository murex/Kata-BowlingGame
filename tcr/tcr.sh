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

base_dir="$(cd "$(dirname -- "$0")" && pwd)"

# Users can switch between Shell and Go flavors of the tool
# through environment variable TCR_ENGINE.

# From now on, the Go flavor is used by default.
# - If TCR_ENGINE is set to "shell", the shell version is used
# - If TCR_ENGINE is not set or set to any other value, the Go version is used

if [ "${TCR_ENGINE}" = "shell" ]; then
  engine="tcr_shell"
else
  engine="tcr_go"
fi

# shellcheck disable=SC1090
. "${base_dir}/../tcr/${engine}/${engine}.sh"
