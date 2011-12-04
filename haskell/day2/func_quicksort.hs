module Main where

quicksort _ [] = []
quicksort _ [x] = [x]
quicksort c (p:xs) = (quicksort c lesser) ++ (p : equal) ++ (quicksort c greater)
  where
    lesser = filter (\y -> y `c` p == LT) xs
    equal = filter (\y -> y `c` p == EQ) xs
    greater = filter (\y -> y `c` p == GT) xs
