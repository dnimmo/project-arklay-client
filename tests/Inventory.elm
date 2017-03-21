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
    { name = "Moose Head"
    , description = "A moose's head. Its cold, dead eyes stare at you, looking lost and lonely."
    , messageWhenUsed = "Ah, that's better"
    , messageWhenNotUsed = "I will not rest until this is back where it belongs"
    }


mockItems : List Item
mockItems =
    [ mockItem ]


mockInventory : Model
mockInventory =
    Inventory.initModel


tests : Test
tests =
    describe "Inventory functionality"
        [ test "itemsTouched returns empty list for empty inventory" <|
            \() ->
                Expect.equal []
                    (itemsTouched mockInventory)
        , test "itemsTouched returns names of items held" <|
            \() ->
                Expect.equal [ "Moose Head" ]
                    (itemsTouched { mockInventory | items = [ mockItem ] })
        , test "itemsTouched returns names of items used" <|
            \() ->
                Expect.equal [ "Moose Head" ]
                    (itemsTouched { mockInventory | itemsUsed = [ mockItem ] })
        , test "itemsTouched returns the names of both items held and items used" <|
            \() ->
                Expect.equal [ "Moose Head", "Moose Head" ]
                    (itemsTouched
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
                    (checkForItem "Moose Head" mockItems)
        , test "addItem adds item to inventory" <|
            \() ->
                Expect.equal [ mockItem ]
                    (addItem "Moose Head" mockInventory)
        , test "addItem will not add a duplicate item to inventory" <|
            \() ->
                Expect.equal [ mockItem ] <|
                    (addItem "Moose Head" { mockInventory | items = [ mockItem ] })
        , test "addItem will not an item that has been used already to the inventory" <|
            \() ->
                Expect.equal []
                    (addItem "Moose Head" { mockInventory | itemsUsed = [ mockItem ] })
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
