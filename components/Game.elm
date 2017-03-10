module Game exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Rooms


type alias Model =
    { room : Room
    }


type alias Room =
    Rooms.Model


type Msg
    = ChangeRoom String


initModel : Model
initModel =
    { room = Rooms.initModel
    }


getRoom : String -> Room
getRoom roomName =
    { name = "Next"
    , intro = "updated"
    , surroundings = "updated"
    , availableDirections =
        [ { text = "South"
          , destination = "Some Room"
          }
        ]
    }


renderRoomInfo : Model -> Html Msg
renderRoomInfo model =
    div []
        [ p []
            [ text model.room.intro ]
        , p []
            [ text model.room.surroundings ]
        ]


renderDirectionOptions : Rooms.Direction -> Html Msg
renderDirectionOptions direction =
    li [ onClick (ChangeRoom direction.destination) ] [ text direction.text ]


renderDirections : List Rooms.Direction -> Html Msg
renderDirections availableDirections =
    ul [ class "DirectionOptions" ]
        (availableDirections
            |> List.map renderDirectionOptions
        )


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeRoom roomToChangeTo ->
            { model
                | room = (getRoom roomToChangeTo)
            }


view : Model -> Html Msg
view model =
    div []
        [ renderRoomInfo model
        , renderDirections model.room.availableDirections
        ]
