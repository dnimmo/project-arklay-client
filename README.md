# project-arklay-client

The client-side app for v2 of http://project-arklay.com

This application uses Webpack to create a single file (`bundle.js`) for all of its JS and CSS. Run `npm run build` (after running `npm install`) to create this file.

Project Arklay's client-side application is written in plain JavaScript (ES6), and does not use any frameworks or libraries. I've tried to keep this simple in terms of the data flow through the application, so initial setup happens in `app.js` (in the root directory). This file initialises the player's inventory, and gets the starting room from the Project Arklay API.

The way the application updates is as follows:
```
+ Information is requested from the API
+ Data is received from the API
+ This data is sent to the data store (found in /data-management) to update the player's state
+ When the data store is updated, an event is emitted to indicate that the data store has changed
+ An event listener picks up the emitted 'change' event, causing the app renderer (found in /dom-management/app-container.js) to request the data from the data store, and create an object representation of the UI with the new data
+ The UI is created from the object representation that is passed in to the 'render' function
+ Whenever the user presses a button that calls the API for information, this loop starts again
```

The API can be found here: https://github.com/dnimmo/project-arklay/tree/rebirth
