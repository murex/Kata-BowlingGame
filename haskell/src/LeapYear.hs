module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year | isEvenlyDivisibleBy(year, 400) = True
                | isEvenlyDivisibleBy(year, 100) = False
                | isEvenlyDivisibleBy(year, 4) = True
                | otherwise = False

isEvenlyDivisibleBy :: (Integer, Integer) -> Bool
isEvenlyDivisibleBy (a, b) = a `rem` b == 0
