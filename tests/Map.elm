port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Map exposing (..)


type alias Room =
    Map.Room


mockRoom : Room
mockRoom =
    { name = "Start"
    , intro = "It's dark, and cold. You're soaked through. You struggle to remember where you are, let alone how you ended up here. What were you doing again?"
    , surroundings = "There's a large door in front of you."
    , surroundingsWhenItemPickedUp = Nothing
    , surroundingsWhenItemUsed = Nothing
    , item = Nothing
    , availableDirections =
        [ { text = "Enter"
          , destination = "Entrance"
          , unlockedWith = Nothing
          }
        ]
    }


tests : Test
tests =
    describe "Map functionality"
        [ test "getRoom returns the requested room" <|
            \() ->
                Expect.equal mockRoom
                    (getRoom "Start")
        , test "getUsableItems returns an empty list when no items can be used" <|
            \() ->
                Expect.equal [ "" ]
                    (getUsableItems mockRoom.availableDirections)
        , test "getUsableItems returns items that can be used in currentRoom" <|
            \() ->
                Expect.equal [ "Something" ]
                    (getUsableItems [ { text = "", destination = "", unlockedWith = Just [ "Something" ] } ])
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
