{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}

import BowlingGame (bowlingScore)
import Data.Foldable (for_)
import Test.Hspec (Spec, describe, it, shouldBe, xdescribe, xit)
import Test.Hspec.Runner (configFailFast, defaultConfig, hspecWith)
import Test.Hspec.JUnit
import System.Environment (setEnv)

main :: IO ()
-- main = hspecWith defaultConfig {configFailFast = True} specs

main = do
  -- setup JUnit file
  setEnv "JUNIT_ENABLED" "1"
  setEnv "JUNIT_OUTPUT_DIRECTORY" ".stack-work/report"
  setEnv "JUNIT_SUITE_NAME" "bowling-game"

  -- hspecWith defaultConfig {configFailFast = True} specs
  hspecJUnitWith defaultConfig {configFailFast = True} specs
  -- hspecJUnit specs

specs :: Spec
-- Replace "xdecribe" with "describe" below to enable acceptance tests
specs = xdescribe "acceptance tests" $ for_ acceptanceTestCases test
  where
    test Case {..} = it explanation assertion
      where
        explanation = description
        assertion = bowlingScore input `shouldBe` expected

data Case = Case
  { description :: String,
    input :: [Integer],
    expected :: Integer
  }

acceptanceTestCases :: [Case]
acceptanceTestCases =
  [ Case
      { description = "a bit of everything",
        input = [1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6],
        expected = 133
      },
    Case
      { description = "no bonus - all 1",
        input = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        expected = 20
      },
    Case
      { description = "spares - all 5",
        input = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
        expected = 150
      },
    Case
      { description = "strikes - all 10",
        input = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        expected = 300
      }
  ]
