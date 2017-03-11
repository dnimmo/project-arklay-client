module Inventory exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import List
import Items


type alias Model =
    { items : List Item
    , itemsUsed : List Item
    }


type alias Item =
    Items.Item


type Msg
    = AddItem String
    | UseItem Item


initModel : Model
initModel =
    { items = []
    , itemsUsed = []
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddItem itemName ->
            { model
                | items = addItem itemName model
            }

        UseItem item ->
            useItem item model


useItem : Item -> Model -> Model
useItem itemUsed model =
    { model
        | items = List.filter (\item -> item /= itemUsed) model.items
        , itemsUsed = itemUsed :: model.itemsUsed
    }


checkForItem : String -> List Item -> Maybe Item
checkForItem itemToCheck itemsList =
    List.head (List.filter (\item -> item.name == itemToCheck) itemsList)


addItem : String -> Model -> List Item
addItem itemToAdd model =
    let
        itemAlreadyHeld =
            checkForItem itemToAdd (model.items ++ model.itemsUsed)
    in
        case itemAlreadyHeld of
            Just item ->
                model.items

            Nothing ->
                (getItem itemToAdd) :: model.items


getItem : String -> Item
getItem itemName =
    let
        itemToReturn =
            checkForItem itemName items
    in
        case itemToReturn of
            Just item ->
                item

            Nothing ->
                errorItem


renderItem : Item -> Html Msg
renderItem item =
    li [ class "Selectable", onClick (UseItem item) ] [ text item.name ]


renderItems : List Item -> Html Msg
renderItems items =
    ul []
        (List.map
            renderItem
            items
        )


errorItem : Item
errorItem =
    { name = "You shouldn't be able to see this. If you can, something has gone wrong."
    , description = ""
    , messageWhenUsed = ""
    , messageWhenNotUsed = ""
    }


items : List Item
items =
    Items.list


view : Model -> Html Msg
view model =
    div []
        [ renderItems model.items
        ]
