#!/usr/bin/env runhaskell

module Main where

import Control.Monad (forever)
import Data.List (sortOn)
import Lib
import System.Environment
import System.IO (hFlush, stdout)

alphabet :: [Char]
alphabet = ['a'..'z']

main :: IO ()
main = do
  args <- getArgs
  dict <- getDict args
  case length args of
    2 -> printOrdered words
      where chars = args !! 1
            words = spellableWords chars alphabet dict
    _ -> interactive dict alphabet

getDict args =
  case length args of
    0 -> readDict "/usr/share/dict/words"
    _ -> readDict (args !! 0)

readDict fileName = do
  file <- readFile fileName
  return $ lines file

printOrdered words =
  mapM_ putStrLn (sortOn length words)

interactive dict alphabet = forever $ do
  putStr "> "
  hFlush stdout
  chars <- getLine
  let words = spellableWords chars alphabet dict
  printOrdered words
  putStrLn $ concat $ replicate (length chars) "-"
  putStrLn chars
