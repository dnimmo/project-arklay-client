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
            rooms
                |> List.filter (\room -> room.name == roomName)
                |> List.head
    in
        case roomToReturn of
            Just room ->
                room

            Nothing ->
                errorRoom


getUseableItems : List Direction -> List String
getUseableItems directions =
    directions
        |> List.map
            (\direction ->
                Maybe.withDefault [ "" ] direction.unlockedWith
            )
        |> List.concat


startingRoom : Room
startingRoom =
    getRoom "Start"


errorRoom : Room
errorRoom =
    getRoom "Error"


rooms : List Room
rooms =
    Rooms.list
