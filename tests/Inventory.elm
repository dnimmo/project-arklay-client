port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Inventory exposing (..)


type alias Model =
    Inventory.Model


type alias Item =
    Inventory.Item


mockItem : Item
mockItem =
    { name = "Test Item"
    , description = ""
    , messageWhenNotUsed = ""
    , messageWhenUsed = ""
    }


mockItem2 : Item
mockItem2 =
    { name = "Test Item 2"
    , description = ""
    , messageWhenNotUsed = ""
    , messageWhenUsed = ""
    }


mockItems : List Item
mockItems =
    [ mockItem, mockItem2 ]


mockInventory : Model
mockInventory =
    Inventory.initModel


tests : Test
tests =
    describe "Inventory functionality"
        [ test "itemsAlreadyTouched returns empty list for empty inventory" <|
            \() ->
                Expect.equal []
                    (itemsAlreadyTouched mockInventory)
        , test "itemsAlreadyTouched returns names of items held" <|
            \() ->
                Expect.equal [ "Test Item" ]
                    (itemsAlreadyTouched { mockInventory | items = [ mockItem ] })
        , test "itemsAlreadyTouched returns names of items used" <|
            \() ->
                Expect.equal [ "Test Item" ]
                    (itemsAlreadyTouched { mockInventory | itemsUsed = [ mockItem ] })
        , test "itemsAlreadyTouched returns the names of both items held and items used" <|
            \() ->
                Expect.equal [ "Test Item", "Test Item" ]
                    (itemsAlreadyTouched
                        { mockInventory
                            | itemsUsed = [ mockItem ]
                            , items = [ mockItem ]
                        }
                    )
        , test "checkForItem returns Nothing when no item is found" <|
            \() ->
                Expect.equal Nothing
                    (checkForItem "Something" mockItems)
        , test "checkForItem returns item when requested item name exists" <|
            \() ->
                Expect.equal (Just mockItem)
                    (checkForItem "Test Item" mockItems)
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
