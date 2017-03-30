module Map exposing (..)

import Rooms
import List exposing (concat, filter, head)


type alias Room =
    Rooms.Room


type alias Direction =
    Rooms.Direction


getRoom : String -> Room
getRoom roomName =
    let
        roomToReturn =
            rooms
                |> filter (\room -> room.name == roomName)
                |> head
    in
        case roomToReturn of
            Just room ->
                room

            Nothing ->
                errorRoom


getUsableItems : List Direction -> List String
getUsableItems directions =
    directions
        |> List.map
            (\direction ->
                Maybe.withDefault [ "" ] direction.unlockedWith
            )
        |> concat


startingRoom : Room
startingRoom =
    getRoom "Start"


errorRoom : Room
errorRoom =
    getRoom "Error"


rooms : List Room
rooms =
    Rooms.list
