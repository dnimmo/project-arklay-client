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
    }


type alias Room =
    Map.Room


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
    }


renderRoomInfo : Model -> Html Msg
renderRoomInfo model =
    div []
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
        li [ class "Selectable", onClick (ChangeRoom direction.destination) ] [ text direction.text ]
    else
        li [ class "LockedRoom" ] [ text direction.text ]


renderDirections : List Map.Direction -> List Item -> Html Msg
renderDirections availableDirections itemsUsed =
    ul [ class "DirectionOptions" ]
        (availableDirections
            |> List.map (\direction -> renderDirectionOptions direction itemsUsed)
        )


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeRoom roomToChangeTo ->
            { model
                | room = Map.getRoom roomToChangeTo
            }

        ExamineRoom currentRoom ->
            case currentRoom.item of
                Just item ->
                    { model
                        | inventory = Inventory.update (Inventory.AddItem item) model.inventory
                    }

                Nothing ->
                    model

        InventoryMsg msg ->
            { model
                | inventory = Inventory.update msg model.inventory
            }


view : Model -> Html Msg
view model =
    div []
        [ renderRoomInfo model
        , renderDirections model.room.availableDirections model.inventory.itemsUsed
        , p [ class "Selectable", onClick (ExamineRoom model.room) ]
            [ text SiteText.examine ]
        , Html.map InventoryMsg (Inventory.view model.inventory)
        ]
