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

getDict :: [FilePath] -> IO [String]
getDict args =
  case length args of
    0 -> readDict "/usr/share/dict/words"
    _ -> readDict (args !! 0)

readDict :: FilePath -> IO [String]
readDict fileName = do
  file <- readFile fileName
  return $ lines file

printOrdered :: [String] -> IO ()
printOrdered words =
  mapM_ putStrLn $ lengthOrdered words

lengthOrdered :: [[a]] -> [[a]]
lengthOrdered = sortOn length

interactive :: [String] -> [Char] -> IO b
interactive dict alphabet = forever $ do
  putStr "> "
  hFlush stdout
  chars <- getLine
  showRes chars alphabet dict
  putStrLn $ concat $ replicate (length chars) "-"
  putStrLn chars

showRes :: String -> [Char] -> [String] -> IO ()
showRes chars alphabet dict = do
  let spellable = spellableWords chars alphabet dict
  case (length $ words chars) of
    1 -> printOrdered spellable
    _ -> printOrderedAndPrioritizedWords chars (head $ words chars) spellable

printOrderedAndPrioritizedWords :: [Char] -> [Char] -> [String] -> IO ()
printOrderedAndPrioritizedWords chars prioritized spellable = do
  let lOrdered = lengthOrdered spellable
  mapM_ (printOrderedAndPrioritizedWord chars prioritized) lOrdered

printOrderedAndPrioritizedWord :: [Char] -> [Char] -> String -> IO ()
printOrderedAndPrioritizedWord chars prioritized word = do
  putStr word
  case hasAllChars word prioritized of
    False -> putStrLn ""
    True  -> putStrLn $ (concat $ replicate (32 - (length word)) " ") ++ word
