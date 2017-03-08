module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Intro
import Game


type Page
    = IntroPage
    | GamePage


type alias Model =
    { page : Page
    }


initModel : Model
initModel =
    { page = IntroPage
    }


type Msg
    = StartGame


displayNothing : Html Msg
displayNothing =
    text ""


update : Msg -> Model -> Model
update msg model =
    case msg of
        StartGame ->
            { model
                | page = GamePage
            }


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                IntroPage ->
                    Intro.view

                GamePage ->
                    Game.view
    in
        section []
            [ page
            , (if model.page == IntroPage then
                a
                    [ class "Button", onClick StartGame ]
                    [ text "Get started" ]
               else
                displayNothing
              )
            ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
