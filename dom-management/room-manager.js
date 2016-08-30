// Elements that need to be updated
import {
  roomDescription,
  roomDetails,
  directions,
  itemMessage
} from './elements'

import {
  updateText,
  addClass,
  removeClass,
  toggleClass,
  clearContents
} from './common-functions'

import { getRoom } from '../data-management/room'
import { addItem, hasItemBeenPickedUp } from '../data-management/inventory'
import { getData } from '../data-management/store'

function addButton ({displayText, rel, link}) {
  const button = document.createElement('li')
  addClass(button, rel)
  // If 'displayText' exists on direction, use that instead of rel
  updateText(button, displayText || rel)
  button.addEventListener('click', listener)

  function listener () {
    return getRoom(link)
  }

  return button
}

const updateRoomUI = () => {
  clearContents(directions)
  clearContents(itemMessage)
  const roomInfo = getData('room')
  updateText(roomDescription, roomInfo.description)
  updateText(roomDetails, roomInfo.surroundings)

  if (roomInfo.item && !hasItemBeenPickedUp(roomInfo.item)) {
    // Eventually this should change to happen on examineRoom rather than automatically
    addItem(roomInfo.item)
    updateText(itemMessage, '== Item added to inventory ==')
  }

  if (!roomInfo.directions) {
    return
  }

  // Set up each direction in the UI
  roomInfo.directions.forEach(direction =>
  directions.appendChild(addButton(direction)))
}

module.exports = {
  updateRoomUI
}
