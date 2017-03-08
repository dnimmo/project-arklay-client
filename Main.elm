module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Intro


type Page
    = IntroPage


type alias Model =
    { page : Page
    , intro : Intro.Model
    }


initModel : Model
initModel =
    { page = IntroPage
    , intro = Intro.initModel
    }


type Msg
    = IntroMsg Intro.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        IntroMsg introMsg ->
            { model
                | intro =
                    Intro.update introMsg model.intro
            }


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                IntroPage ->
                    Html.map IntroMsg
                        (Intro.view model.intro)
    in
        page


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
