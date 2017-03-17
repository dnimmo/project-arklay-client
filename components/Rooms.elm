module Rooms exposing (..)


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


list : List Room
list =
    [ { name = "Entrance"
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
      , surroundings = "There's a single door to the West."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Upstairs Hallway Four"
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
              , unlockedWith = Just [ "Crowbar" ]
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
            [ { text = "West"
              , destination = "Upstairs Hallway Three"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Upstairs Stairway Two"
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
      , surroundings = "It's surprisingly messy. It looks like something terrible happened in here."
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
    , { name = "Dining Hall"
      , intro = "A large dining hall."
      , surroundings = "A grandfather clock is steadily ticking, its sound echoing through the room."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Hallway Two"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Entrance"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Hallway Two"
      , intro = "A hallway"
      , surroundings = "The stench in here is pretty bad. Like rotten food. There are doors in every direction, but the door to the East is locked"
      , surroundingsWhenItemUsed = Just "The stench in here is almost overwhelming now."
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Kitchen"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Hallway Four"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Utility Room"
              , unlockedWith = Just [ "Utility Key" ]
              }
            , { text = "South"
              , destination = "Dining Hall"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Utility Room"
      , intro = "A small, grey, utility room. It feels very cold in here."
      , surroundings = "There's a staircase that goes down a long way. There's a faint light from the bottom."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Hallway Two"
              , unlockedWith = Nothing
              }
            , { text = "Downstairs"
              , destination = "Basement Stairway"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Kitchen"
      , intro = "The kitchen."
      , surroundings = "Flies buzz around piles of black, rotten, fruit and meat. It looks like this has been here for a long time. And it smells like it's been here even longer."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Waste Disposal"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Freezer"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Hallway Two"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Freezer"
      , intro = "A large walk-in freezer."
      , surroundings = "It's full of mountains of meat. And...there's a moose head on the floor."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "It's full of mountains of meat. Why was there a moose head in here?"
      , item = Just "Moose Head"
      , availableDirections =
            [ { text = "West"
              , destination = "Kitchen"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Waste Disposal"
      , intro = "A room that is completely empty, except for a hatch at the back, that appears to be a waste disposal chute."
      , surroundings = "Unfortunately it doesn't have a handle, and can't be opened."
      , surroundingsWhenItemUsed = Just "What could be at the bottom?"
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "Jump in"
              , destination = "Basement Waste Disposal"
              , unlockedWith = Just [ "Handle" ]
              }
            , { text = "South"
              , destination = "Kitchen"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Hallway Four"
      , intro = "A long hallway."
      , surroundings = "There are a few doors leading from this hallway. The carpet appears to have been torn up in a number of places."
      , surroundingsWhenItemUsed = Just "What could be at the bottom?"
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Stairway Three"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Music Room"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Hallway Two"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Stairway Three"
      , intro = "A large, wooden stairway"
      , surroundings = "You can't see all the way to the top in this darkness"
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Upstairs Stairway Three"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Hallway Four"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Music Room"
      , intro = "A music room"
      , surroundings = "A very pleasant-looking music room, with a grand piano in the center."
      , surroundingsWhenItemUsed = Just "A wall has moved, revealing a hidden room behind it."
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Hallway Five"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Hallway Four"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Secret Room One"
              , unlockedWith = Just [ "Sheet Music" ]
              }
            ]
      }
    , { name = "Hallway Five"
      , intro = "A small hallway"
      , surroundings = "There seem to be a lot of hallways in this place."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Gym"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Music Room"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Gym"
      , intro = "A home gym"
      , surroundings = "There is a piece of paper on the floor."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "This is nicer than any gym I've ever been to."
      , item = Just "Keycode"
      , availableDirections =
            [ { text = "East"
              , destination = "Swimming Pool"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Hallway Five"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Swimming Pool"
      , intro = "An olympic-sized swimming pool"
      , surroundings = "This really is incredible. The smell of chlorine fills the air, and the warmth of the pool can be felt against your skin."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Gym"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Showers"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Showers"
      , intro = "A row of showers"
      , surroundings = "There are a row of showers here, as you'd find in a public simming pool. I wonder how many people live here?"
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "West"
              , destination = "Swimming Pool"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Secret Room One"
      , intro = "A well-hidden room."
      , surroundings = "A room that is completely empty, save for a stone podium with a crest on top of it."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "The room is completely empty, except for the podium in the middle, where you found a crest."
      , item = Just "Eagle Crest"
      , availableDirections =
            [ { text = "North"
              , destination = "Music Room"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Hallway One"
      , intro = "A short hallway."
      , surroundings = "You get a strange feeling. Are you alone? It's quiet, but this place is so big, it's hard to be sure."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Statue Room"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Entrance"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Statue Room"
      , intro = "A room full of statues."
      , surroundings = "One of them appears to have been beheaded."
      , surroundingsWhenItemUsed = Just "At least they aren't mannequins, but statues aren't much better. One of them has moved aside, revealing a hidden doorway."
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Secret Room Two"
              , unlockedWith = Just [ "Statue Head" ]
              }
            , { text = "East"
              , destination = "Hallway Three"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Hallway One"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Secret Room Two"
      , intro = "A hidden room."
      , surroundings = "The room is cold, and empty, except for a podium in the middle. On it, sits a crest."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "An empty room, except for a lonely looking concrete podium in the middle."
      , item = Just "Wolf Crest"
      , availableDirections =
            [ { text = "South"
              , destination = "Statue Room"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Hallway Three"
      , intro = "A hallway."
      , surroundings = "This hallway is quite large. There's a locked door to the North with a plaque that reads \"Servants' Quarters\"."
      , surroundingsWhenItemUsed = Just "This hallway is quite large. The door to the servants' quarters is unlocked."
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Servants' Quarters"
              , unlockedWith = Just [ "Small Key" ]
              }
            , { text = "West"
              , destination = "Statue Room"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Stairway Two"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Garage"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Garage"
      , intro = "A large garage."
      , surroundings = "The garage is empty, apart from a few tools. Perhaps one of them could be of some use."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "The garage is empty, apart from a few tools."
      , item = Just "Crowbar"
      , availableDirections =
            [ { text = "North"
              , destination = "Hallway Three"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Servants' Quarters"
      , intro = "The servants' quarters"
      , surroundings = "It's actually pretty nice in here. For some reason, the head of a statue is sitting on a table in the corner."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "It's actaully pretty nice in here. But who were these people serving?"
      , item = Just "Statue Head"
      , availableDirections =
            [ { text = "West"
              , destination = "Servants' Bathroom"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Hallway Three"
              , unlockedWith = Just [ "Small Key" ]
              }
            ]
      }
    , { name = "Servants' Bathroom"
      , intro = "The servants' bathroom"
      , surroundings = "There's not a lot to see in here."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "East"
              , destination = "Servants' Quarters"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Stairway Two"
      , intro = "A stairway."
      , surroundings = "A sturdy-looking staircase sits in a dimly-lit room."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "Upstairs"
              , destination = "Upstairs Stairway Two"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Hallway Three"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Basement Stairway"
      , intro = "The basement."
      , surroundings = "It's cold. And dark."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "Upstairs"
              , destination = "Utility Room"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Basement Storage"
              , unlockedWith = Nothing
              }
            , { text = "East"
              , destination = "Basement Storage Two"
              , unlockedWith = Nothing
              }
            , { text = "South"
              , destination = "Basement Wine Cellar"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Basement Storage"
      , intro = "A storage room."
      , surroundings = "There are a few crates down here. Probably nothing too important in them though. There's a door to the North, but it doesn't seem to open from this side."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "East"
              , destination = "Basement Stairway"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Basement Storage Two"
      , intro = "A small storage room."
      , surroundings = "There's a metal handle on the ground"
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "There's nothing to see here."
      , item = Just "Handle"
      , availableDirections =
            [ { text = "West"
              , destination = "Basement Stairway"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Basement Item Room"
      , intro = "A room full of boxes."
      , surroundings = "Amongst the boxes lies a small key."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Just "There's nothing interesting in here any more."
      , item = Just "Small Key"
      , availableDirections =
            [ { text = "South"
              , destination = "Basement Storage"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Basement Waste Disposal"
      , intro = "Ugh, it stinks down here!"
      , surroundings = "The ground is covered in a slimy, horrible, sludge. There is a door to the East."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "East"
              , destination = "Basement Item Room"
              , unlockedWith = Nothing
              }
            ]
      }
    , { name = "Basement Wine Cellar"
      , intro = "A gigantic wine cellar."
      , surroundings = "Amazingly, every space is filled, except for one."
      , surroundingsWhenItemUsed = Just "One of the racks has moved, revealing a hidden doorway."
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "North"
              , destination = "Basement Stairway"
              , unlockedWith = Nothing
              }
            , { text = "West"
              , destination = "Basement Lab Entrance"
              , unlockedWith = Just [ "Wine Bottle" ]
              }
            ]
      }
    , { name = "Basement Lab Entrance"
      , intro = "An entrance...to a laboratory? This is very unusual. There appears to be an entrance to a laboratory here! Unfortunately, as you enter, you succumb to a strange feeling. You're losing conciousness. As you fall to your knees, you can almost make out a voice nearby..."
      , surroundings = "To be continued."
      , surroundingsWhenItemUsed = Nothing
      , surroundingsWhenItemPickedUp = Nothing
      , item = Nothing
      , availableDirections =
            [ { text = "Roll Credits"
              , destination = "Credits"
              , unlockedWith = Nothing
              }
            ]
      }
    ]
