module CurrentRoom exposing (..)

import Rooms


type alias Model =
    Rooms.Room


type alias Room =
    Rooms.Room


type alias Direction =
    Rooms.Direction


initModel : Model
initModel =
    getRoom "start"


getRoom : String -> Room
getRoom roomName =
    let
        roomToReturn =
            Rooms.list
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


renderRoomInfo : Model -> Html Msg
renderRoomInfo model =
    div [ class "RoomDescription", class model.previousDirection ]
        [ p []
            [ text model.room.intro ]
        , p []
            [ text model.room.surroundings ]
        ]


view =
    ""
