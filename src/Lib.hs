module Lib
    ( hasAllChars
    , onlyWordsWith
    , spellableWords
    ) where

import Data.List (delete, (\\))

spellableWords :: [Char] -> [Char] -> [String] -> [String]
spellableWords chars alphabet dict =
  filter (restrict chars) possibleWords
  where
    forbiddenChars = alphabet \\ chars
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
  case c `elem` word of
    True  -> True
    False -> containsOne cs word

restrict :: [Char] -> [Char] -> Bool
restrict _      []   = True
restrict []     word = False
restrict (l:ls) word = restrict ls (delete l word)

onlyWordsWith :: [Char] -> [String] -> [String]
onlyWordsWith chars words =
  filter (hasAllChars chars) words

hasAllChars :: String -> [Char] -> Bool
hasAllChars word chars =
  chars \\ word == ""
