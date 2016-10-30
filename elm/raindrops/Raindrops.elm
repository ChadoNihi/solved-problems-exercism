module Raindrops exposing (..)

import Array as Arr exposing (fromList, length, push, toList)
import String exposing (join)


raindrops : Int -> String
raindrops n =
    let
        resArr =
            Arr.fromList []
                |> pushIfDivBy "Pling" 3 n
                |> pushIfDivBy "Plang" 5 n
                |> pushIfDivBy "Plong" 7 n
    in
        if Arr.length resArr == 0 then
            toString n
        else
            String.join "" (Arr.toList resArr)


pushIfDivBy : a -> Int -> Int -> Arr.Array a -> Arr.Array a
pushIfDivBy sToPush fctr n arr =
    if n % fctr == 0 then
        Arr.push sToPush arr
    else
        arr
