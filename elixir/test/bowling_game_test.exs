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

defmodule BowlingGameTest do
  use ExUnit.Case

  describe "acceptance tests -" do

    # Comment or remove the line below to enable this test case
    @tag :skip
    test "no bonus - all 1" do
      assert BowlingGame.score(List.duplicate(1, 20)) == 20
    end

    # Comment or remove the line below to enable this test case
    @tag :skip
    test "spares - all 5" do
      assert BowlingGame.score(List.duplicate(5, 20 + 1)) == 150
    end

    # Comment or remove the line below to enable this test case
    @tag :skip
    test "strikes - all 10" do
      assert BowlingGame.score(List.duplicate(10, 10 + 2)) == 300
    end

    # Comment or remove the line below to enable this test case
    @tag :skip
    test "a bit of everything" do
      assert BowlingGame.score([1,4, 4,5, 6,4, 5,5, 10, 0,1, 7,3, 6,4, 10, 2,8,6]) == 133
    end

  end

  describe "unit tests -" do

    # TODO - Implement me!

  end

end
