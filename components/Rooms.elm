module Rooms exposing (..)


type alias Model =
    { name : String
    , intro : String
    , surroundings : String
    , availableDirections : List Direction
    }


type alias Direction =
    { text : String
    , destination : String
    }


initModel : Model
initModel =
    { name = "Start"
    , intro = "IntroText"
    , surroundings = "SurroundingsText"
    , availableDirections =
        [ { text = "North"
          , destination = "Some Room"
          }
        ]
    }
