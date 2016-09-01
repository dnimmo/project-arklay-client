// Elements that need to be updated
import { room } from './elements'

import {
  component,
  render,
  toggleClass
} from './common-functions'

import { getRoom } from '../data-management/room'
import { addItem, hasItemBeenPickedUp } from '../data-management/inventory'
import { getData } from '../data-management/store'

function addButton ({displayText, rel, link}) {
  const func = () => getRoom(link)
  const button = component('li', [rel], [{key: 'onclick', value: func}], false, displayText || rel)
  return button
}

function processItem (item) {
  if (!item || hasItemBeenPickedUp(item)) return {}
  addItem(item)
  return component('p', ['additional-info', 'extra-message'], false, false, '== Item added to inventory ==')
}

function processDirections (directions) {
  return component('ul', ['direction-options'], [{key: 'id', value: 'directions'}],   directions.map(direction => addButton(direction)), false)
}

const updateRoomUI = () => {
  const roomInfo = getData('room')
  const roomObject = component('div', false, false, [component('p', false, false, false, roomInfo.description), component('p', false, false, false, roomInfo.surroundings), processItem(roomInfo.item), processDirections(roomInfo.directions)], false)

  render(room, roomObject)
}

module.exports = {
  updateRoomUI
}
