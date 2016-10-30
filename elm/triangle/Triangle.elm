module Triangle exposing (..)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind a b c =
    if a <= 0 || b <= 0 || c <= 0 then
        Err "Invalid lengths"
    else if a > b + c || b > a + c || c > a + b then
        Err "Violates inequality"
    else if a == b && b == c then
        Ok Equilateral
    else if a == b || b == c || c == a then
        Ok Isosceles
    else
        Ok Scalene


version : Int
version =
    2
