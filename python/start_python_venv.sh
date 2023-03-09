#!/usr/bin/env bash
#
# Copyright (c) 2023 Murex
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

venv_dir=".venv"
base_dir="$(cd "$(dirname -- "$0")" && pwd)"
venv_path="${base_dir}/${venv_dir}"

if ! [ -d "${venv_path}" ]; then
  echo "Creating python virtual environment..."
  python3 -m venv "${venv_path}"
fi

echo "Starting python virtual environment..."
# instead of relying on venv's activate with sometimes screws up the path on windows,
# we append venv/Scripts to the path by ourselves
# source "${venv_dir}/Scripts/activate"
VIRTUAL_ENV="${venv_path}"
export VIRTUAL_ENV
PATH="$VIRTUAL_ENV/Scripts:$PATH"
export PATH

python -m pip install --upgrade pip
pip3 install --editable .
pip3 install -r ./requirements.txt

# Starting a new shell in order to keep the changes done on the path after the script ends
echo "Python virtual environment is ready (type 'exit' to leave)"
exec "${SHELL}" --norc
