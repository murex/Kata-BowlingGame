defmodule BowlingGameTest do
  use ExUnit.Case
  doctest BowlingGame

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
