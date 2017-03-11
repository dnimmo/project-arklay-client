module Map exposing (..)

import Rooms
import List


type alias Room =
    Rooms.Room


type alias Direction =
    Rooms.Direction


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
    , intro = "It's dark, and cold. You're soaked through. You struggle to remember where you are, let alone how you ended up here. What were you doing again?"
    , surroundings = "There's a large door in front of you."
    , surroundingsWhenItemPickedUp = Nothing
    , surroundingsWhenItemUsed = Nothing
    , item = Nothing
    , availableDirections =
        [ { text = "Enter"
          , destination = "Entrance"
          , unlockedWith = Nothing
          }
        ]
    }


errorRoom : Room
errorRoom =
    { name = "Error"
    , intro = "You shouldn't be able to get here."
    , surroundings = "If you have, something has gone wrong, and for that I apologise."
    , surroundingsWhenItemPickedUp = Nothing
    , surroundingsWhenItemUsed = Nothing
    , item = Nothing
    , availableDirections =
        [ { text = "Start again?"
          , destination = "Start"
          , unlockedWith = Nothing
          }
        ]
    }


rooms : List Room
rooms =
    Rooms.list
