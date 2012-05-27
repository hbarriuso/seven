module Main where

import Data.Char

toNumber [] = 0
toNumber cs = read (filter (\x -> isDigit x || x == '.') cs) :: Float 
