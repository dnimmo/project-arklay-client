module Inventory exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import List
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


itemsAlreadyTouched : Model -> List String
itemsAlreadyTouched inventory =
    (inventory.items
        |> List.map (\item -> item.name)
    )
        ++ (inventory.itemsUsed
                |> List.map (\item -> item.name)
           )


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddItem itemName ->
            { model
                | items = addItem itemName model
            }

        UseItem itemUsed ->
            { model
                | items = List.filter (\item -> item /= itemUsed) model.items
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


checkForItem : String -> List Item -> Maybe Item
checkForItem itemToCheck itemsList =
    itemsList
        |> List.filter (\item -> item.name == itemToCheck)
        |> List.head


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
                (getItem itemToAdd) :: model.items


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
                errorItem


renderItem : Item -> Html Msg
renderItem item =
    li [ class "Selectable", onClick (UseItem item) ] [ text item.name ]


renderItems : List Item -> Html Msg
renderItems items =
    ul []
        (items
            |> List.map renderItem
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


displayMessage : Model -> Html Msg
displayMessage model =
    p []
        [ case model.messageToDisplay of
            Just message ->
                text ("== " ++ message ++ " ==")

            Nothing ->
                text "== Inventory =="
        ]


closeButton : Html Msg
closeButton =
    p [ class "Selectable Inventory Separate", onClick CloseInventory ]
        [ text SiteText.closeInventory ]


inventoryButton : Model -> Html Msg
inventoryButton model =
    if (List.length model.items) == 0 then
        p [ class "NotSelectable Inventory" ] [ text SiteText.openInventory ]
    else
        p [ class "Selectable Inventory", onClick OpenInventory ]
            [ text SiteText.openInventory ]


view : Model -> Html Msg
view model =
    if model.open == True && (List.length model.items) > 0 then
        div [ class "UserOptions" ]
            [ displayMessage model
            , renderItems model.items
            , closeButton
            ]
    else
        inventoryButton model
