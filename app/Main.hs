#!/usr/bin/env runhaskell

module Main where

import Data.List (delete, find, sortOn, (\\))
import System.Environment

main = do
  args <- getArgs
  file <- readFile (args !! 0)
  let allWords = lines file
  let allowed = args !! 1
  let words = spellableWords allowed allWords
  mapM_ putStrLn (sortOn length words)

spellableWords :: [Char] -> [String] -> [String]
spellableWords chars dict =
  filter (restrict chars) possibleWords
  where
    forbiddenChars = ['a'..'z'] \\ chars
    possibleWords = removeForbidden forbiddenChars dict

removeForbidden :: [Char] -> [String] -> [String]
removeForbidden forbiddenChars dict =
  filter containsForbidden dict
  where
    containsForbidden word =
      not $ containsOne forbiddenChars word

containsOne :: [Char] -> String -> Bool
containsOne []     word = False
containsOne (c:cs) word =
  case elem c word of
    True  -> True
    False -> containsOne cs word

restrict :: [Char] -> [Char] -> Bool
restrict _      []   = True
restrict []     word = False
restrict (l:ls) word = restrict ls (delete l word)
