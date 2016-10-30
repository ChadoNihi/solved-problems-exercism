module Anagram exposing (detect)

import Dict
import String


detect : String -> List String -> List String
detect s anagrams =
    let
        s =
            String.toLower s
    in
        List.filter (\w -> isAnagramOf (String.toLower w) s) anagrams


isAnagramOf : String -> String -> Bool
isAnagramOf w s =
    if (String.length w /= String.length s || w == s) then
        False
    else
        let
            temp =
                String.foldl count Dict.empty w

            hist =
                String.foldl decount temp s
        in
            Dict.values hist |> List.all (\cnt -> cnt == 0)


count : Char -> Dict.Dict Char Int -> Dict.Dict Char Int
count ch d =
    if Dict.member ch d then
        Dict.update ch inc' d
    else
        Dict.insert ch 1 d


decount : Char -> Dict.Dict Char Int -> Dict.Dict Char Int
decount ch d =
    if Dict.member ch d then
        Dict.update ch dec' d
    else
        Dict.insert ch -1 d


inc' : Maybe Int -> Maybe Int
inc' i =
    case i of
        Nothing ->
            Just 1

        Just i ->
            Just (i + 1)


dec' : Maybe Int -> Maybe Int
dec' i =
    case i of
        Nothing ->
            Just -1

        Just i ->
            Just (i - 1)
