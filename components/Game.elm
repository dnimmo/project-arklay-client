module Game exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List
import Directions


type alias Model =
    { room : String
    , surroundings : String
    , availableDirections : List Direction
    }


type alias Direction =
    Directions.Direction


type Msg
    = ChangeRoom


initModel : Model
initModel =
    { room = "You are in the foyer of what appears to be a mansion."
    , surroundings = "A vast, dimly-lit foyer, with a grand staircase and a couple of doors."
    , availableDirections =
        [ { text = "North"
          , destination = "Some Room"
          }
        ]
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeRoom ->
            { model
                | room = "Room changed"
            }


view : Model -> Html Msg
view model =
    div []
        [ p [ onClick ChangeRoom ]
            [ text model.room ]
        , p []
            [ text model.surroundings ]
        , Directions.renderDirections model.availableDirections
        ]
