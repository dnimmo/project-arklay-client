module Map exposing (..)

import List


type alias Room =
    { name : String
    , intro : String
    , surroundings : String
    , availableDirections : List Direction
    }


type alias Direction =
    { text : String
    , destination : String
    }


getRoom : String -> Room
getRoom roomName =
    let
        roomToReturn =
            List.head (List.filter (\room -> room.name == roomName) rooms)
    in
        case roomToReturn of
            Just room ->
                room

            Nothing ->
                errorRoom


startingRoom : Room
startingRoom =
    { name = "Start"
    , intro = "IntroText"
    , surroundings = "SurroundingsText"
    , availableDirections =
        [ { text = "North"
          , destination = "Test Room"
          }
        ]
    }


errorRoom : Room
errorRoom =
    { name = "Error"
    , intro = "You shouldn't be able to get here."
    , surroundings = "If you have, something has gone wrong, and for that I apologise."
    , availableDirections =
        [ { text = "Start again?"
          , destination = "Start"
          }
        ]
    }


rooms : List Room
rooms =
    [ startingRoom
    , { name = "Test Room"
      , intro = "updated"
      , surroundings = "updated"
      , availableDirections =
            [ { text = "South"
              , destination = "Some Room"
              }
            ]
      }
    ]
