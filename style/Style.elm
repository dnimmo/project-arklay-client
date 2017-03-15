module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Constants


type CssClasses
    = RoomDescription
    | UserOptions
    | North
    | South
    | Upstairs
    | Downstairs
    | West
    | East
    | Selectable
    | LockedRoom
    | Examine
    | Button
    | Hidden


css =
    stylesheet
        [ html
            [ boxSizing borderBox
            , fontSize (pct 62.5)
            ]
        , body
            [ backgroundColor Constants.colourPalette1
            , color Constants.colourPalette2
            , fontFamilies [ "monospace" ]
            , fontSize (Css.rem 2)
            , letterSpacing (Css.rem 0.04)
            , lineHeight (Css.rem 3.5)
            , margin (px 0)
            , padding (px 0)
            , property "transition" Constants.transition
            ]
        , main_
            [ marginTop (Css.rem 6)
            , overflow hidden
            , paddingLeft (Css.rem 2)
            , paddingRight (Css.rem 2)
            , textAlign center
            ]
        , h1
            [ fontSize (Css.rem 4)
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
        , class RoomDescription
            [ minHeight (Css.vh 25) ]
        , class UserOptions
            [ borderBottom (Css.rem 0)
            , borderColor (Css.hex "ffffff")
            , borderLeft (Css.rem 0)
            , borderRight (Css.rem 0)
            , borderStyle solid
            , marginTop (Css.rem 5)
            , paddingLeft (px 0)
            , paddingTop (Css.rem 2)
            ]
        , class North
            [ adjacentSiblings
                [ class East
                    [ marginLeft (Css.rem 12) ]
                , class South
                    [ marginTop (Css.rem 4) ]
                , class Downstairs
                    [ marginTop (Css.rem 4) ]
                ]
            ]
        , class Upstairs
            [ adjacentSiblings
                [ class East
                    [ marginLeft (Css.rem 12) ]
                , class South
                    [ marginTop (Css.rem 4) ]
                , class Downstairs
                    [ marginTop (Css.rem 4) ]
                ]
            ]
        , class West
            [ display inlineBlock
            , marginRight (Css.rem 12)
            , adjacentSiblings
                [ class East
                    [ marginLeft (Css.rem 0) ]
                ]
            ]
        , class East
            [ display inlineBlock
            , marginLeft (Css.rem 12)
            ]
        , class Selectable
            [ cursor pointer ]
        , class LockedRoom
            [ textDecoration lineThrough ]
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
            , fontSize (Css.rem 1.4)
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
        ]
