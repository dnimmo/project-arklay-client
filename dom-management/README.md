Everything in this directory is responsible for updating the UI. The UI Update methods for 'room' and 'inventory' are triggered by event listeners that are fired whenever the data in the data store changes, and following this they will get the latest data from the data store, and update the UI accordingly.

The 'item options' update method is applied when an item in the inventory is selected; this updates the 'use' item button to call the API with the selected item.
