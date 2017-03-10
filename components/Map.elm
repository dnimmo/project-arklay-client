module Map exposing (..)

import List


type alias Room =
    { name : String
    , intro : String
    , surroundings : String
    , surroundingsWhenItemPickedUp : Maybe String
    , surroundingsWhenItemUsed : Maybe String
    , item : Maybe String
    , availableDirections : List Direction
    }


type alias Direction =
    { text : String
    , destination : String
    , unlockedWith : Maybe (List String)
    }


getRoom : String -> Room
getRoom roomName =
    let
        roomToReturn =
            List.head (List.filter (\room -> room.name == roomName) rooms)
    in
        case roomToReturn of
            Just room ->
                room

            Nothing ->
                errorRoom


startingRoom : Room
startingRoom =
    { name = "Start"
    , intro = "It's dark, and cold. You're soaked through. You struggle to remember where you are, let alone how you ended up here. What were you doing again?"
    , surroundings = "There's a large door in front of you."
    , surroundingsWhenItemPickedUp = Nothing
    , surroundingsWhenItemUsed = Nothing
    , item = Nothing
    , availableDirections =
        [ { text = "Enter"
          , destination = "Entrance"
          , unlockedWith = Nothing
          }
        ]
    }


errorRoom : Room
errorRoom =
    { name = "Error"
    , intro = "You shouldn't be able to get here."
    , surroundings = "If you have, something has gone wrong, and for that I apologise."
    , surroundingsWhenItemPickedUp = Nothing
    , surroundingsWhenItemUsed = Nothing
    , item = Nothing
    , availableDirections =
        [ { text = "Start again?"
          , destination = "Start"
          , unlockedWith = Nothing
          }
        ]
    }


rooms : List Room
rooms =
    [ startingRoom
    , { name = "Entrance"
      , intro = "You are in the dim foyer of what appears to be a mansion."
      , surroundings = "There is a grand staircase here, as well as a couple of doors."
      , surroundingsWhenItemPickedUp = Nothing
      , surroundingsWhenItemUsed = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "Upstairs"
              , destination = "Upstairs Foyer"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Dining Hall"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Hallway One"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Foyer"
      , intro = "You're at the top of a staircase."
      , surroundings = "The foyer looks huge from up here. You can't imagine anyone actually living here."
      , surroundingsWhenItemPickedUp = Nothing
      , surroundingsWhenItemUsed = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Hallway One"
              , unlockedWith = Nothing
              }
            , { text = "Downstairs"
              , destination = "Entrance"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Hallway One"
      , intro = "A hallway stretches out ahead. It's too dark to make out what the artwork lining the walls is depicting."
      , surroundings = "You can see three doors from here, though not especially well."
      , surroundingsWhenItemPickedUp = Nothing
      , surroundingsWhenItemUsed = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Upstairs Study"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Upstairs Third Bedroom"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Upstairs Foyer"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Study"
      , intro = "A study. There are huge bookcases, that seem to be filled mostly with scientific journals, although there appear to be a few religious texts in here too."
      , surroundings = "An old computer terminal is on in the corner. Has someone been here recently?"
      , surroundingsWhenItemPickedUp = Nothing
      , surroundingsWhenItemUsed = Just "A bookshelf has moved to one side, revealing a door to the West"
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Hallway Two"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Upstairs Secret Room Three"
              , unlockedWith = Just [ "Keycode" ]
              }
            , { text = "East"
              , destination = "Upstairs Hallway One"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Secret Room Three"
      , intro = "A small room with a podium in the center."
      , surroundings = "A crest depicting a Lion sits neatly on the podium. It looks important."
      , surroundingsWhenItemPickedUp = Just "The room is completely empty. The podium stands bare."
      , surroundingsWhenItemUsed = Nothing
      , item = Just "Lion Crest"
      , availableDirections =
            [ { text = "East"
              , destination = "Upstairs Study"
              , unlockedWith = Just [ "Keycode" ]
              }
            ]
      }
    , { name = "Upstairs Stairway Three"
      , intro = "The top of a stairway. To the North is a fancy door with three indentations, and there is a much more plain door to the East"
      , surroundings = "What could be behind the door?"
      , surroundingsWhenItemPickedUp = Nothing
      , surroundingsWhenItemUsed = Just "Looks like it needs three crests to open"
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Master Bedroom"
              , unlockedWith = Just [ "Lion Crest", "Eagle Crest", "Wolf Crest" ]
              }
            , { text = "East"
              , destination = "Upstairs Hallway Two"
              , unlockedWith = Nothing
              }
            , { text = "Downstairs"
              , destination = "Stairway Three"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Master Bedroom"
      , intro = "A fantastically ostentatious master bedroom, with a roaring fireplace and a huge four-poster bed"
      , surroundings = "There are two doors here."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Upstairs Master En Suite"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Upstairs Stairway Three"
              , unlockedWith = Just [ "Lion Crest", "Eagle Crest", "Wolf Crest" ]
              }
            ]
      }
    , { name = "Upstairs Master En Suite"
      , intro = "A large en-suite."
      , surroundings = "There's a very expensive, but sadly empty, bottle of wine sitting by the sink."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "Empty wine glasses stand on the floor by the bath."
      , item = Just "Wine Bottle"
      , availableDirections =
            [ { text = "East"
              , destination = "Upstairs Master Bedroom"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Stairway Two"
      , intro = "The top of a small staircase. It's eerily quiet here."
      , surroundings = "There's a single door to the North."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Hallway Two"
              , unlockedWith = Nothing
              }
            , { text = "Downstairs"
              , destination = "Stairway Two"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Hallway Two"
      , intro = "A hallway. How big is this place?"
      , surroundings = "There are rooms in every direction here. No wonder everything's thick with dust."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Trophy Room"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Upstairs Stairway Three"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Upstairs Art Gallery"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Upstairs Study"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Art Gallery"
      , intro = "An art gallery."
      , surroundings = "This entire building is full of paintings, but the ones in this room are crazy. They all seem to depict demons and people being tortured. Guess they wanted to stick with a theme."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Upstairs Hallway Two"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Upstairs Hallway Three"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Hallway Three"
      , intro = "A cavernous hallway"
      , surroundings = "There are doors in every direction, but the door to the North is boarded shut."
      , surroundingsWhenItemUsed = Just "There are doors in every direction."
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Aquarium"
              , unlockedWith = Just [ "crowbar" ]
              }
            , { text = "West"
              , destination = "Upstairs Art Gallery"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Upstairs Hallway Four"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Upstairs Library"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Aquarium"
      , intro = "A softly-lit aquarium"
      , surroundings = "There are a number of exotic fish here. Unfortunately, they look like they've all been dead for a while. But there is a small key in the bottom of one of the tanks."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "The air in here is crisp, and salty. How long have the fish been dead though? What happened in this house?"
      , item = Just "Utility Key"
      , availableDirections =
            [ { text = "South"
              , destination = "Upstairs Hallway Three"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Library"
      , intro = "A library."
      , surroundings = "There are many, many books in here. There isn't time to look through them all. However, some sheet music appears to be sticking out from one of the shelves."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "There are many, many books in here. There isn't time to look through them all."
      , item = Just "Sheet Music"
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Hallway Three"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Hallway Four"
      , intro = "A hallway."
      , surroundings = "It's amazing that all of these hallways look so different from one another."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Stairway Two"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Upstairs Hallway Three"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Upstairs Second Bedroom"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Second Bedroom"
      , intro = "A well-furnished bedroom."
      , surroundings = "It looks like this room has never been used. There's an en-suite to the South, and a door leading to a hallway to the North."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Hallway Four"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Upstairs Second Bathroom"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Second Bathroom"
      , intro = "A \"Jack and Jill\" bathroom, connecting two bedrooms."
      , surroundings = "You don't see these very often. It looks very fancy, but the water isn't running."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Second Bedroom"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Upstairs Third Bedroom"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Third Bedroom"
      , intro = "A bedroom."
      , surroundings = "It's surprisingly messy. It looksl ike something terrible happened in here."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Upstairs Hallway One"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Upstairs Second Bathroom"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Upstairs Trophy Room"
      , intro = "A trophy room."
      , surroundings = "There are various stuffed beasts adorning the walls. It's very chilling."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "South"
              , destination = "Upstairs Hallway Two"
              , unlockedWith = Nothing
              }
            ]
      }
    ]
