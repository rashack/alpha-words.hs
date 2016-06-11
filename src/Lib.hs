module Lib
    ( hasAllChars
    , onlyWordsWith
    , spellableWords
    ) where

import Data.List (delete, (\\))

spellableWords :: String -> String -> [String] -> [String]
spellableWords chars alphabet dict =
  filter (restrict chars) possibleWords
  where
    forbiddenChars = alphabet \\ chars
    possibleWords = removeForbidden forbiddenChars dict

removeForbidden :: String -> [String] -> [String]
removeForbidden forbiddenChars dict =
  filter containsForbidden dict
  where
    containsForbidden word =
      not $ containsOne forbiddenChars word

containsOne :: String -> String -> Bool
containsOne []     word = False
containsOne (c:cs) word =
  (c `elem` word) || containsOne cs word

restrict :: String -> String -> Bool
restrict _      []   = True
restrict []     word = False
restrict (l:ls) word = restrict ls (delete l word)

onlyWordsWith :: String -> [String] -> [String]
onlyWordsWith chars words =
  filter (hasAllChars chars) words

hasAllChars :: String -> String -> Bool
hasAllChars word chars =
  chars \\ word == ""
