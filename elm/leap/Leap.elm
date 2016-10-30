module Leap exposing (..)


isLeapYear : Int -> Bool
isLeapYear y =
    if y % 4 == 0 && (not (y % 100 == 0) || y % 400 == 0) then
        True
    else
        False
