module Inventory exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import List exposing (filter, head, length)
import Items
import SiteText


type alias Model =
    { items : List Item
    , itemsUsed : List Item
    , open : Bool
    , messageToDisplay : Maybe String
    }


type alias Item =
    Items.Item


type Msg
    = AddItem String
    | UseItem Item
    | OpenInventory
    | CloseInventory
    | UpdateMessage String


initModel : Model
initModel =
    { items = []
    , itemsUsed = []
    , open = False
    , messageToDisplay = Nothing
    }


itemsTouched : Model -> List String
itemsTouched inventory =
    inventory.items
        ++ inventory.itemsUsed
        |> List.map (\item -> item.name)


checkForItem : String -> List Item -> Maybe Item
checkForItem itemToCheck itemsList =
    itemsList
        |> filter (\item -> item.name == itemToCheck)
        |> head


addItem : String -> Model -> List Item
addItem itemToAdd model =
    let
        itemAlreadyHeld =
            model.items
                ++ model.itemsUsed
                |> checkForItem itemToAdd
    in
        case itemAlreadyHeld of
            Just item ->
                model.items

            Nothing ->
                getItem itemToAdd :: model.items


getItem : String -> Item
getItem itemName =
    let
        itemToReturn =
            items
                |> checkForItem itemName
    in
        case itemToReturn of
            Just item ->
                item

            Nothing ->
                getItem "Error"


renderItem : Item -> Html Msg
renderItem item =
    li [ class "Selectable", onClick (UseItem item) ] [ text item.name ]


renderItems : List Item -> Html Msg
renderItems items =
    ul []
        (items
            |> List.map renderItem
        )


items : List Item
items =
    Items.list


displayMessage : Model -> Html Msg
displayMessage model =
    p []
        [ (case model.messageToDisplay of
            Just message ->
                "== " ++ message ++ " =="

            Nothing ->
                "== Inventory =="
          )
            |> text
        ]


closeButton : Html Msg
closeButton =
    p [ class "Selectable Inventory Separate", onClick CloseInventory ]
        [ text SiteText.closeInventory ]


inventoryButton : Model -> Html Msg
inventoryButton model =
    if length model.items == 0 then
        p [ class "NotSelectable Inventory" ] [ text SiteText.openInventory ]
    else
        p [ class "Selectable Inventory", onClick OpenInventory ]
            [ text SiteText.openInventory ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddItem itemName ->
            { model
                | items = addItem itemName model
            }

        UseItem itemUsed ->
            { model
                | items = filter (\item -> item /= itemUsed) model.items
                , itemsUsed = itemUsed :: model.itemsUsed
                , open = False
            }

        OpenInventory ->
            { model
                | open = True
            }

        CloseInventory ->
            { model
                | open = False
                , messageToDisplay = Nothing
            }

        UpdateMessage message ->
            { model
                | messageToDisplay = Just message
            }


view : Model -> Html Msg
view model =
    if model.open == True then
        div [ class "UserOptions" ]
            [ displayMessage model
            , renderItems model.items
            , closeButton
            ]
    else
        inventoryButton model
