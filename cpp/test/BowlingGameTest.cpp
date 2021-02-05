
#include <kata/bowling_game/BowlingGame.hpp>

#include <gtest/gtest.h>

#include <vector>

using namespace kata::bowling_game;

TEST(BowlingGame, DISABLED_acceptance_test)
{
   EXPECT_EQ(133, bowlingScore(std::vector<int>{1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6}));
}
