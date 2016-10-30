module Bob exposing (..)

import String exposing (endsWith, startsWith, toUpper, trim)
import Regex


hey : String -> String
hey strToBob =
    if trim strToBob == "" then
        "Fine. Be that way!"
    else if (endsWith "!" strToBob && not (startsWith "Let's" strToBob)) || (toUpper strToBob == strToBob && Regex.contains (Regex.regex "[a-zA-Z]") strToBob) then
        "Whoa, chill out!"
    else if endsWith "?" strToBob then
        "Sure."
    else
        "Whatever."
