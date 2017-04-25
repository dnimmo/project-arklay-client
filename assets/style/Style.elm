module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Constants


type CssClasses
    = MainContainer
    | IntroAnimation
    | RoomDescription
    | UserOptions
    | North
    | South
    | Upstairs
    | Downstairs
    | West
    | East
    | Selectable
    | NotSelectable
    | Examine
    | Button
    | Hidden
    | Separate
    | FromNorth
    | FromSouth
    | FromWest
    | FromEast
    | FromEnter
    | FromUpstairs
    | FromDownstairs
    | FromStart



-- Remember: Animations are defined in Index.html until I find a more sensible solution (or elm-css is updated)


css =
    stylesheet
        [ html
            [ boxSizing borderBox
            , fontSize (pct 62.5)
            ]
        , body
            [ backgroundColor Constants.colourPalette1
            , color Constants.colourPalette2
            , fontFamilies [ "Special Elite", "cursive" ]
            , fontSize (Css.rem 2.2)
            , letterSpacing (Css.rem 0.04)
            , lineHeight (Css.rem 3.5)
            , margin (px 0)
            , padding (px 0)
            , property "transition" Constants.transition
            ]
        , h1
            [ fontSize (Css.rem 3.8)
            , fontWeight lighter
            , marginBottom (Css.rem 2)
            , marginTop (Css.rem 2)
            ]
        , h2
            [ marginBottom (Css.rem 2)
            , marginTop (Css.rem 2)
            ]
        , ul [ padding (px 0) ]
        , li
            [ listStyle none ]
        , class IntroAnimation
            [ property "animation" "fadeIn 0.3s linear" ]
        , class RoomDescription
            [ minHeight (Css.vh 25)
            , children
                [ p
                    [ property "animation" "fadeIn 0.3s linear"
                    ]
                ]
            ]
        , class MainContainer
            [ alignItems center
            , displayFlex
            , justifyContent center
            , minHeight (Css.vh 100)
            , overflow hidden
            , paddingLeft (Css.rem 2)
            , paddingRight (Css.rem 2)
            , textAlign center
            ]
        , class UserOptions
            [ borderBottom (Css.rem 0)
            , borderColor (Css.hex "ffffff")
            , borderLeft (Css.rem 0)
            , borderRight (Css.rem 0)
            , borderStyle solid
            , marginTop (Css.rem 5)
            , minHeight (Css.vh 15)
            , paddingLeft (px 0)
            , paddingTop (Css.rem 2)
            , property "animation" "fadeIn 0.3s linear"
            ]
        , class North
            [ adjacentSiblings
                [ class East
                    [ marginLeft (Css.rem 16) ]
                , class South
                    [ marginTop (Css.rem 4) ]
                , class Downstairs
                    [ marginTop (Css.rem 4) ]
                ]
            ]
        , class Upstairs
            [ adjacentSiblings
                [ class East
                    [ marginLeft (Css.rem 16) ]
                , class South
                    [ marginTop (Css.rem 4) ]
                , class Downstairs
                    [ marginTop (Css.rem 4) ]
                ]
            ]
        , class West
            [ display inlineBlock
            , marginRight (Css.rem 16)
            , adjacentSiblings
                [ class East
                    [ marginLeft (Css.rem 0) ]
                ]
            ]
        , class East
            [ display inlineBlock
            , marginLeft (Css.rem 16)
            ]
        , class Selectable
            [ cursor pointer ]
        , class NotSelectable
            [ color Constants.colourPalette3
            , textDecoration lineThrough
            ]
        , class Examine
            [ marginTop (Css.rem 4) ]
        , class Hidden
            [ display none ]
        , class Button
            [ border (Css.rem 0.1)
            , borderColor Constants.colourPalette2
            , borderStyle solid
            , color Constants.colourPalette2
            , display inlineBlock
            , fontSize (Css.rem 2.4)
            , letterSpacing (Css.rem 0.07)
            , margin (Css.rem 2)
            , minWidth (Css.rem 8)
            , paddingBottom (Css.rem 0.3)
            , paddingLeft (Css.rem 1)
            , paddingRight (Css.rem 1)
            , paddingTop (Css.rem 0.3)
            , property "transition" Constants.transition
            , hover
                [ backgroundColor Constants.colourPalette2
                , color Constants.colourPalette1
                , cursor pointer
                , transform (scale 1.1)
                ]
            ]
        , class Separate
            [ marginTop (Css.rem 10) ]
        , class FromNorth
            [ property "animation" "slideDown 0.2s linear" ]
        , class FromSouth
            [ property "animation" "slideUp 0.2s linear" ]
        , class FromWest
            [ property "animation" "slideRight 0.2s linear" ]
        , class FromEast
            [ property "animation" "slideLeft 0.2s linear" ]
        , class FromEnter
            [ property "animation" "scaleIn 0.6s linear" ]
        , class FromDownstairs
            [ property "animation" "slideUp 0.4s linear" ]
        , class FromUpstairs
            [ property "animation" "slideDown 0.4s linear" ]
        , class FromStart
            [ property "animation" "fadeIn 1s linear" ]
        ]
