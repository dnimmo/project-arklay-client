module Game exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SiteText
import List
import Map
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
            List.member item (Inventory.itemsAlreadyTouched inventory)

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
    List.any hasUnlockRequirements directions


itemHasBeenUsed : List Direction -> List Item -> Bool
itemHasBeenUsed directions usedItems =
    let
        itemsThatCanBeUsed =
            List.map
                (\direction ->
                    case direction.unlockedWith of
                        Just items ->
                            items

                        Nothing ->
                            []
                )
                directions
    in
        if itemCanBeUsed directions then
            let
                items =
                    List.concat (List.map (\direction -> Maybe.withDefault [ "" ] direction.unlockedWith) directions)
            in
                List.any (\x -> x == True) (List.map (\item -> List.member item.name items) usedItems)
        else
            False


getLatestRoomInfo : Room -> Inventory -> Room
getLatestRoomInfo room inventory =
    let
        updatedRoom =
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
    in
        updatedRoom


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
            List.map (\requiredItem -> List.member requiredItem (List.map (\item -> item.name) itemsUsed)) unlockRequirements
    in
        List.all (\result -> result == True) requirementsMet


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
                    in
                        { modelWithNewItem
                            | room = getLatestRoomInfo modelWithNewItem.room modelWithNewItem.inventory
                            , displayedMessage = Just (item ++ " has been added to your inventory")
                        }

                Nothing ->
                    { model
                        | displayedMessage = Just "There is nothing useful here"
                    }

        InventoryMsg msg ->
            let
                updatedModel =
                    { model
                        | inventory = Inventory.update msg model.inventory
                    }
            in
                { updatedModel
                    | room = getLatestRoomInfo model.room updatedModel.inventory
                }


view : Model -> Html Msg
view model =
    div []
        [ renderRoomInfo model
        , if model.inventory.open == False then
            renderDirections model.room.availableDirections model.inventory.itemsUsed
          else
            Html.map InventoryMsg (Inventory.view model.inventory)
        , if (not (model.room.name == "Start") && model.inventory.open == False) then
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
            span [] []
        ]
