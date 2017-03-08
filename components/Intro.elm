module Intro exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import SiteText
import Style exposing (..)


view : Html msg
view =
    div
        []
        [ h1 []
            [ text SiteText.header
            ]
        , p []
            [ text SiteText.intro ]
        ]
