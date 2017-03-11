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
    , inventory : List Item
    }


type alias Room =
    Map.Room


type alias Item =
    Inventory.Item


type Msg
    = ChangeRoom String
    | ExamineRoom Room


initModel : Model
initModel =
    { room = Map.startingRoom
    , inventory = []
    }


renderRoomInfo : Model -> Html Msg
renderRoomInfo model =
    div []
        [ p []
            [ text model.room.intro ]
        , p []
            [ text model.room.surroundings ]
        ]


renderDirectionOptions : Map.Direction -> Html Msg
renderDirectionOptions direction =
    li [ onClick (ChangeRoom direction.destination) ] [ text direction.text ]


renderDirections : List Map.Direction -> Html Msg
renderDirections availableDirections =
    ul [ class "DirectionOptions" ]
        (availableDirections
            |> List.map renderDirectionOptions
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
                        | inventory = Inventory.addItem item model.inventory
                    }

                Nothing ->
                    model


view : Model -> Html Msg
view model =
    div []
        [ renderRoomInfo model
        , renderDirections model.room.availableDirections
        , p [ onClick (ExamineRoom model.room) ]
            [ text SiteText.examine ]
        , p []
            [ (case (List.head model.inventory) of
                Just item ->
                    text item.name

                Nothing ->
                    text ""
              )
            ]
        ]
