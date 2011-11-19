module Main where
  allEven :: [Integer] -> [Integer]
  allEven list = [x | x <- list, even x]
