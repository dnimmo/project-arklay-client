module Intro exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SiteText


type Msg
    = HideIntro


type alias Model =
    { display : Bool
    }


initModel : Model
initModel =
    { display = True
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        HideIntro ->
            { model
                | display = False
            }


view : Model -> Html Msg
view model =
    if model.display == True then
        section
            []
            [ h1 []
                [ text SiteText.header
                ]
            , p []
                [ text SiteText.intro ]
            , a
                [ class "Button", onClick HideIntro ]
                [ text "Get started" ]
            ]
    else
        span [] []
