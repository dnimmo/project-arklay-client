module Game exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List


type alias Model =
    { availableDirections : List Direction }


type alias Direction =
    { text : String
    , destination : String
    }


initModel : Model
initModel =
    { availableDirections =
        [ { text = "North"
          , destination = "Some Room"
          }
        ]
    }


renderDirectionOptions : Direction -> Html msg
renderDirectionOptions direction =
    li [] [ text direction.text ]


directions : List Direction -> Html msg
directions availableDirections =
    ul [ class "DirectionOptions" ]
        (availableDirections
            |> List.map renderDirectionOptions
        )


view : Html msg
view =
    div []
        [ p []
            [ text "You are in the foyer of what appears to be a mansion.\nA vast, dimly-lit foyer, with a grand staircase and a couple of doors." ]
        , directions
            [ { text = "North"
              , destination = "Some Room"
              }
            ]
        ]
