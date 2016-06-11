#!/usr/bin/env runhaskell

module Main where

import Control.Monad (forever)
import Data.List (sortOn)
import Lib
import System.Environment
import System.IO (hFlush, stdout)

alphabet :: String
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

getDict :: [FilePath] -> IO [String]
getDict args =
  case length args of
    0 -> readDict "/usr/share/dict/words"
    _ -> readDict $ head args

readDict :: FilePath -> IO [String]
readDict fileName = do
  file <- readFile fileName
  return $ lines file

printOrdered :: [String] -> IO ()
printOrdered words =
  mapM_ putStrLn $ lengthOrdered words

lengthOrdered :: [[a]] -> [[a]]
lengthOrdered = sortOn length

interactive :: [String] -> String -> IO b
interactive dict alphabet = forever $ do
  putStr "> "
  hFlush stdout
  chars <- getLine
  showRes chars alphabet dict
  putStrLn $ concat $ replicate (length chars) "-"
  putStrLn chars

showRes :: String -> String -> [String] -> IO ()
showRes chars alphabet dict = do
  let spellable = spellableWords chars alphabet dict
  case length $ words chars of
    1 -> printOrdered spellable
    _ -> printOrderedAndPrioritizedWords chars (head $ words chars) spellable

printOrderedAndPrioritizedWords :: String -> String -> [String] -> IO ()
printOrderedAndPrioritizedWords chars prioritized spellable = do
  let lOrdered = lengthOrdered spellable
  mapM_ (printOrderedAndPrioritizedWord chars prioritized) lOrdered

printOrderedAndPrioritizedWord :: String -> String -> String -> IO ()
printOrderedAndPrioritizedWord chars prioritized word = do
  putStr word
  putStrLn
    (if hasAllChars word prioritized then
      concat (replicate (32 - length word) " ") ++ word
     else "")
