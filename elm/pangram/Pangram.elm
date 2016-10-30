module Pangram exposing (..)

import Char exposing (isLower)
import String as Str exposing (filter, toList, toLower)
import Set exposing (fromList, size)


isPangram : String -> Bool
isPangram s =
    let
        nUniqLetters =
            Str.toLower s
                |> Str.filter isLower
                |> Str.toList
                |> Set.fromList
                |> Set.size
    in
        nUniqLetters >= 26
