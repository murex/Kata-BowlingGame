-- Copyright (c) 2024 Murex
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
{-# OPTIONS_GHC -fno-warn-type-defaults #-}

import BowlingGame (bowlingScore)
import Data.Foldable (for_)
import System.Environment (setEnv)
import Test.Hspec (Spec, describe, it, shouldBe, xdescribe, xit)
import Test.Hspec.JUnit ()
import Test.Hspec.Runner (configFailFast, defaultConfig, hspecWith)

main :: IO ()
main = do
  -- setup JUnit file
  setEnv "JUNIT_ENABLED" "1"
  setEnv "JUNIT_OUTPUT_DIRECTORY" ".stack-work/report"
  setEnv "JUNIT_SUITE_NAME" "bowling-game"

  -- Still need to figure out a way to send test results simultaneously in console and in JUnit file
  -- hspecJUnitWith defaultConfig {configFailFast = False} specs
  hspecWith defaultConfig {configFailFast = False} specs

specs :: Spec
specs = do
  describe "BowlingGame tests" $ do
    describe "unit tests" $ do
      -- Add unit tests here
      it "first unit test" $ do
        bowlingScore [] `shouldBe` 0

    describe "acceptance tests" $ do
      -- Replace "xit" with "it" below to enable this test
      xit "no bonus - all 1" $ do
        bowlingScore [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] `shouldBe` 20

      -- Replace "xit" with "it" below to enable this test
      xit "spares - all 5" $ do
        bowlingScore [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5] `shouldBe` 150

      -- Replace "xit" with "it" below to enable this test
      xit "stikes - all 10" $ do
        bowlingScore [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] `shouldBe` 300

      -- Replace "xit" with "it" below to enable this test
      xit "a bit of everything" $ do
        bowlingScore [1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6] `shouldBe` 133
