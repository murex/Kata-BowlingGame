import unittest

from bowling_game.bowling_game import bowling_score


class BowlingGameTest(unittest.TestCase):

    # @unittest.skip("test currently disabled")  # Comment or remove this line to enable this test case
    def test_acceptance_test(self):
        self.assertEqual(133, bowling_score(1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6))


if __name__ == "__main__":
    unittest.main()
