module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SiteText
import Intro
import Game


type Page
    = IntroPage
    | GamePage


type alias Model =
    { page : Page
    , game : Game.Model
    }


initModel : Model
initModel =
    { page = IntroPage
    , game = Game.initModel
    }


type Msg
    = StartGame
    | GameMsg Game.Msg


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

        GameMsg gameMsg ->
            { model
                | game = Game.update gameMsg model.game
            }


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                IntroPage ->
                    Intro.view

                GamePage ->
                    Html.map GameMsg (Game.view model.game)
    in
        section []
            [ page
            , (if model.page == IntroPage then
                a
                    [ class "Button", onClick StartGame ]
                    [ text SiteText.startButton ]
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
