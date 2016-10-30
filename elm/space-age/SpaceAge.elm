module SpaceAge exposing (..)


type Planet
    = Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Uranus
    | Neptune


earthSecPerY =
    31557600


jupiterSecPerY =
    earthSecPerY * 11.862615


marsSecPerY =
    earthSecPerY * 1.8808158


mercurySecPerY =
    earthSecPerY * 0.2408467


neptuneSecPerY =
    earthSecPerY * 164.79132


saturnSecPerY =
    earthSecPerY * 29.447498


uranusSecPerY =
    earthSecPerY * 84.016846


venusSecPerY =
    earthSecPerY * 0.61519726



-- Since Planet is not comparable, I cannot use planets as keys =(


ageOn : Planet -> Float -> Float
ageOn pl sec =
    case pl of
        Earth ->
            sec / earthSecPerY

        Jupiter ->
            sec / jupiterSecPerY

        Mars ->
            sec / marsSecPerY

        Mercury ->
            sec / mercurySecPerY

        Neptune ->
            sec / neptuneSecPerY

        Saturn ->
            sec / saturnSecPerY

        Uranus ->
            sec / uranusSecPerY

        Venus ->
            sec / venusSecPerY
