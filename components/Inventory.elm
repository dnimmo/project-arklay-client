module Inventory exposing (..)

import Html exposing (..)
import List


type alias Model =
    { items : List Item
    , itemsUsed : List Item
    }


type alias Item =
    { name : String
    , description : String
    , messageWhenUsed : String
    , messageWhenNotUsed : String
    }


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
                | items = addItem itemName model.items
            }

        UseItem item ->
            { model
                | itemsUsed = item :: model.itemsUsed
            }


checkForItem : String -> List Item -> Maybe Item
checkForItem itemToCheck itemsList =
    List.head (List.filter (\item -> item.name == itemToCheck) itemsList)


addItem : String -> List Item -> List Item
addItem itemToAdd inventoryItems =
    let
        itemAlreadyHeld =
            checkForItem itemToAdd inventoryItems
    in
        case itemAlreadyHeld of
            Just item ->
                inventoryItems

            Nothing ->
                (getItem itemToAdd) :: inventoryItems


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
    li [] [ text item.name ]


renderItems : List Item -> Html Msg
renderItems items =
    ul []
        (List.map
            renderItem
            items
        )


view : Model -> Html Msg
view model =
    div [] [ renderItems model.items ]


errorItem : Item
errorItem =
    { name = "You shouldn't be able to see this. If you can, something has gone wrong."
    , description = ""
    , messageWhenUsed = ""
    , messageWhenNotUsed = ""
    }


items : List Item
items =
    [ { name = "Lion Crest"
      , description = "A crest, with a lion's head on the front."
      , messageWhenUsed = "You place the crest into the door."
      , messageWhenNotUsed = "Cool lion, but what could this be for?"
      }
    , { name = "Wine Bottle"
      , description = "An expensive-looking bottle of wine."
      , messageWhenUsed = "You place the wine bottle back in the rack"
      , messageWhenNotUsed = "It's a shame this is empty. Some wine would be good right now."
      }
    , { name = "Utility Key"
      , description = "A small key, with a tag that reads \"Utility\"."
      , messageWhenUsed = "You unlock the door to the utility room"
      , messageWhenNotUsed = "This key doesn't seem to fit any locks here."
      }
    , { name = "Sheet Music"
      , description = "Sheet music for Beethoven's Piano Sonata No. 14."
      , messageWhenUsed = "You play the piano"
      , messageWhenNotUsed = "An excellent piece of music. Though I'm not sure why I decided to steal it."
      }
    , { name = "Moose Head"
      , description = "A moose's head. Its cold, dead eyes stare at you, looking lost and lonely."
      , messageWhenUsed = "Ah, that's better"
      , messageWhenNotUsed = "I will not rest until this is back where it belongs."
      }
    , { name = "Keycode"
      , description = "A piece of paper with \"2407\" written on it."
      , messageWhenUsed = "You enter the keycode into the terminal"
      , messageWhenNotUsed = "What could these numbers mean?"
      }
    , { name = "Eagle Crest"
      , description = "A crest, with an eagle's head on the front."
      , messageWhenUsed = "You place the crest into the door"
      , messageWhenNotUsed = "What is this for? What does the eagle signify?"
      }
    , { name = "Crowbar"
      , description = "A sturdy crowbar."
      , messageWhenUsed = "You prise off the wooden planks"
      , messageWhenNotUsed = "Nothing to use this on in here."
      }
    , { name = "Statue Head"
      , description = "The head of a small statue."
      , messageWhenUsed = "You place the head carefully back onto the statue"
      , messageWhenNotUsed = "What a strange thing to have found. I wonder who it's meant to be?"
      }
    , { name = "Handle"
      , description = "A metal handle. It looks like it's for some sort of trap door."
      , messageWhenUsed = "You have attached the handle"
      , messageWhenNotUsed = "I'm not sure where I could put this"
      }
    , { name = "Small Key"
      , description = "A small key, with a tag that reads \"S.Q.\""
      , messageWhenUsed = "You unlock the door"
      , messageWhenNotUsed = "It doesn't look like this can be used here"
      }
    ]
