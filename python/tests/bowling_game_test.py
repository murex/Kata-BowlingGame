import pytest

from bowling_game.bowling_game import bowling_score


class TestBowlingGame:

    @pytest.mark.skip(reason="test currently disabled")  # Comment or remove this line to enable this test case
    def test_acceptance_test(self) -> None:
        assert (133 == bowling_score(1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6))
