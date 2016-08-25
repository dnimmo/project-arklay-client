// Elements that need to be updated
import {
  roomDescription,
  roomDetails,
  directions,
} from './elements'

import {
  updateText,
  addClass,
  removeClass,
  toggleClass,
  clearContents
} from './common-functions'

import { getRoom } from '../data-management/room'
import { getData } from '../data-management/store'

function addButton ({displayText, rel, link}) {
  const button = document.createElement("li")
  addClass(button, rel)
  // If 'displayText' exists on direction, use that instead of rel
  updateText(button, displayText || rel)
  directions.appendChild(button)
  button.addEventListener('click', listener)

  function listener () {
    // destroy 'directions' document
    return getRoom(link)
  }
}

const updateRoomUI = () => {
  clearContents(directions)
  const roomInfo = getData('room')
  updateText(roomDescription, roomInfo.description)
  updateText(roomDetails, roomInfo.surroundings)

  if (!roomInfo.directions) {
    return
  }

  // Set up each direction in the UI
  roomInfo.directions.forEach(direction => addButton(direction))
}

module.exports = {
  updateRoomUI
}
