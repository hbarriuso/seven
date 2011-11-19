module Main where
  reverse' :: [a] -> [a]
  reverse' [] = []
  reverse' (x:xs) = reverse' xs ++ [x]
