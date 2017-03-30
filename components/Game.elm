module Game exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SiteText
import Map
import List exposing (all, any, map, member)
import Inventory


type alias Model =
    { room : Room
    , inventory : Inventory.Model
    , displayedMessage : Maybe String
    }


type alias Room =
    Map.Room


type alias Direction =
    Map.Direction


type alias Inventory =
    Inventory.Model


type alias Item =
    Inventory.Item


type Msg
    = ChangeRoom String
    | ExamineRoom Room
    | InventoryMsg Inventory.Msg


initModel : Model
initModel =
    { room = Map.startingRoom
    , inventory = Inventory.initModel
    , displayedMessage = Nothing
    }


roomHasItem : Room -> Bool
roomHasItem room =
    case room.item of
        Just anyItem ->
            True

        Nothing ->
            False


itemHasBeenPickedUp : Maybe String -> Inventory -> Bool
itemHasBeenPickedUp item inventory =
    case item of
        Just item ->
            member item (Inventory.itemsTouched inventory)

        Nothing ->
            False


hasUnlockRequirements : Direction -> Bool
hasUnlockRequirements direction =
    case direction.unlockedWith of
        Just anyItem ->
            True

        Nothing ->
            False


itemCanBeUsed : List Direction -> Bool
itemCanBeUsed directions =
    directions
        |> any hasUnlockRequirements


itemHasBeenUsed : List Direction -> List Item -> Bool
itemHasBeenUsed directions usedItems =
    if itemCanBeUsed directions then
        usedItems
            |> List.map
                (\item ->
                    Map.getUsableItems directions
                        |> member item.name
                )
            |> any (\x -> x == True)
    else
        False


getLatestRoomInfo : Room -> Inventory -> Room
getLatestRoomInfo room inventory =
    if (roomHasItem room) && (itemHasBeenPickedUp room.item inventory) then
        case room.surroundingsWhenItemPickedUp of
            Just newSurroundings ->
                { room
                    | surroundings = newSurroundings
                }

            Nothing ->
                room
    else if (itemCanBeUsed room.availableDirections) && (itemHasBeenUsed room.availableDirections inventory.itemsUsed) then
        case room.surroundingsWhenItemUsed of
            Just newSurroundings ->
                { room
                    | surroundings = newSurroundings
                }

            Nothing ->
                room
    else
        room


renderRoomInfo : Model -> Html Msg
renderRoomInfo model =
    div [ class "RoomDescription" ]
        [ p []
            [ text model.room.intro ]
        , p []
            [ text model.room.surroundings ]
        ]


roomIsUnlocked : List String -> List Item -> Bool
roomIsUnlocked unlockRequirements itemsUsed =
    let
        requirementsMet =
            unlockRequirements
                |> List.map
                    (\requiredItem ->
                        member requiredItem (List.map (\item -> item.name) itemsUsed)
                    )
    in
        requirementsMet
            |> all (\result -> result == True)


roomIsOpen : Map.Direction -> List Item -> Bool
roomIsOpen direction itemsUsed =
    case direction.unlockedWith of
        Just requiredItems ->
            roomIsUnlocked requiredItems itemsUsed

        Nothing ->
            True


renderDirectionOptions : Map.Direction -> List Item -> Html Msg
renderDirectionOptions direction itemsUsed =
    if roomIsOpen direction itemsUsed then
        li [ class direction.text, class "Selectable", onClick (ChangeRoom direction.destination) ] [ text direction.text ]
    else
        li [ class direction.text, class "NotSelectable" ] [ text direction.text ]


renderDirections : List Map.Direction -> List Item -> Html Msg
renderDirections availableDirections itemsUsed =
    ul [ class "UserOptions" ]
        (availableDirections
            |> List.map (\direction -> renderDirectionOptions direction itemsUsed)
        )


showDirectionsOrInventory : Model -> Html Msg
showDirectionsOrInventory model =
    if not model.inventory.open then
        renderDirections model.room.availableDirections model.inventory.itemsUsed
    else
        Html.map InventoryMsg (Inventory.view model.inventory)


showExtraRoomOptions : Model -> Html Msg
showExtraRoomOptions model =
    if not (model.room.name == "Start" || model.room.name == "End") && model.inventory.open == False then
        div [ class "Separate" ]
            [ case model.displayedMessage of
                Just message ->
                    p [] [ text message ]

                Nothing ->
                    p [ class "Selectable Examine", onClick (ExamineRoom model.room) ]
                        [ text SiteText.examine ]
            , Html.map InventoryMsg (Inventory.view model.inventory)
            ]
    else
        displayNothing


displayNothing : Html Msg
displayNothing =
    text ""


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeRoom roomToChangeTo ->
            { model
                | room = getLatestRoomInfo (Map.getRoom roomToChangeTo) model.inventory
                , displayedMessage = Nothing
            }

        ExamineRoom currentRoom ->
            case currentRoom.item of
                Just item ->
                    let
                        modelWithNewItem =
                            { model
                                | inventory = Inventory.update (Inventory.AddItem item) model.inventory
                            }

                        itemAlreadyPickedUp =
                            itemHasBeenPickedUp (Just item) model.inventory

                        messageToDisplay =
                            if not itemAlreadyPickedUp then
                                Just ("== " ++ item ++ " has been added to your inventory ==")
                            else
                                Just ("== This was where I found the " ++ item ++ " ==")
                    in
                        { modelWithNewItem
                            | room = getLatestRoomInfo modelWithNewItem.room modelWithNewItem.inventory
                            , displayedMessage = messageToDisplay
                        }

                Nothing ->
                    { model
                        | displayedMessage = Just ("== " ++ SiteText.emptyRoom ++ " ==")
                    }

        InventoryMsg msg ->
            let
                updatedModel =
                    { model
                        | inventory = Inventory.update msg model.inventory
                    }

                modelToReturn =
                    case msg of
                        Inventory.UseItem item ->
                            if member item.name (Map.getUsableItems model.room.availableDirections) then
                                { updatedModel
                                    | room = getLatestRoomInfo model.room updatedModel.inventory
                                    , displayedMessage = Just ("== " ++ item.messageWhenUsed ++ " ==")
                                }
                            else
                                { model
                                    | inventory = Inventory.update (Inventory.UpdateMessage item.messageWhenNotUsed) model.inventory
                                }

                        _ ->
                            { updatedModel
                                | room = getLatestRoomInfo model.room updatedModel.inventory
                            }
            in
                modelToReturn


view : Model -> Html Msg
view model =
    div []
        [ renderRoomInfo model
        , showDirectionsOrInventory model
        , showExtraRoomOptions model
        ]
