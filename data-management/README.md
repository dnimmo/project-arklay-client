Everything in this directory is responsible for managing the application's data. All of the data the application needs is in two categories: either 'room' or 'inventory'. 'Room' refers to the room the player is currently in.

The 'api-caller.js' file makes all of the calls to the API (surprise!). When data is received from the API, it is passed to 'store.js' to be processed.

The 'store.js' file is where the data is held, and any updates to the data, or requests for the data, happen here. Whenever the data is updated, an event is dispatched stating that data has been changed, which will be picked up by an event listener (specified in /app.js), which causes the UI to be updated.
