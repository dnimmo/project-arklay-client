module Game exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Map


type alias Model =
    { room : Room
    }


type alias Room =
    Map.Room


type Msg
    = ChangeRoom String


initModel : Model
initModel =
    { room = Map.startingRoom
    }


renderRoomInfo : Model -> Html Msg
renderRoomInfo model =
    div []
        [ p []
            [ text model.room.intro ]
        , p []
            [ text model.room.surroundings ]
        ]


renderDirectionOptions : Map.Direction -> Html Msg
renderDirectionOptions direction =
    li [ onClick (ChangeRoom direction.destination) ] [ text direction.text ]


renderDirections : List Map.Direction -> Html Msg
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
                | room = (Map.getRoom roomToChangeTo)
            }


view : Model -> Html Msg
view model =
    div []
        [ renderRoomInfo model
        , renderDirections model.room.availableDirections
        ]
