#!/usr/bin/env runhaskell

module Main where

import Data.List (sortOn)
import System.Environment
import Lib

main = do
  args <- getArgs
  file <- readFile (args !! 0)
  let allWords = lines file
  let allowed = args !! 1
  let words = spellableWords allowed ['a'..'z'] allWords
  mapM_ putStrLn (sortOn length words)
