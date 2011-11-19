module Main where

import Data.List

colors = ["red", "blue", "green"]

states = ["Alabama", "Mississippi", "Georgia", "Tennessee", "Florida"]

different = [("Mississippi", "Tennessee"), 
             ("Mississippi", "Alabama"),
             ("Alabama", "Tennessee"),
             ("Alabama", "Mississippi"),
             ("Alabama", "Georgia"),
             ("Alabama", "Florida"),
             ("Georgia", "Florida"),
             ("Georgia", "Tennessee")]

coloring [] = []
coloring (x:xs) = different_color(x, coloring(xs)) : coloring(xs)

different_color (x, list) = (x, choose_color(x, list))

choose_color (x, list) = head [ a | a <- colors, is_not_repeated(x, [fst c | c <- list, a == snd c])]

is_not_repeated (x, []) = True
is_not_repeated (x, list) = elemIndex (x, head list) different == Nothing && elemIndex (head list, x) different == Nothing && is_not_repeated(x, tail list)
