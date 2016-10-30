module Accumulate exposing (..)


accumulate : (a -> a) -> List a -> List a
accumulate =
    List.map
