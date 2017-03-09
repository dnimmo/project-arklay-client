module Directions exposing (Direction, renderDirections)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Direction =
    { text : String
    , destination : String
    }


renderDirectionOptions : Direction -> Html msg
renderDirectionOptions direction =
    li [] [ text direction.text ]


renderDirections : List Direction -> Html msg
renderDirections availableDirections =
    ul [ class "DirectionOptions" ]
        (availableDirections
            |> List.map renderDirectionOptions
        )
