module Main where
  colors = ["black", "white", "blue", "yellow", "red"]

  combinations = [(a,b) | a <- colors, b <- colors, a < b]
