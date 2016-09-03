// Elements that need to be updated
import { room } from './elements'

import {
  component,
  render
} from './dom-creation'

import { getRoom } from '../data-management/room'
import { addItem, hasItemBeenPickedUp } from '../data-management/inventory'
import { getData } from '../data-management/store'

function addButton ({displayText, rel, link}) {
  const getNewRoom = () => getRoom(link)

  return component({
    type: 'li',
    classes: [rel],
    eventListeners: [{event: 'click', function: getNewRoom}],
    content: displayText || rel
  })
}

function processItem (item) {
  if (!item || hasItemBeenPickedUp(item)) return {type: 'none'}
  addItem(item)

  return component({
    type: 'p',
    classes: ['additional-info', 'extra-message'],
    content: '== Item added to inventory =='
  })
}

function processDirections (directions) {
  const buttons = directions.map(direction => addButton(direction))

  return component({
      type: 'ul',
      classes: ['direction-options'],
      attributes: [{key: 'id', value: 'directions'}],
      children: buttons
    })
}

const updateRoomUI = () => {
  const roomInfo = getData('room')

  const description = component({
    type: 'p',
    content: roomInfo.description
  })
  const surroundings = component({
    type: 'p',
    content: roomInfo.surroundings
  })
  const directions = processDirections(roomInfo.directions)
  const itemMessage = processItem(roomInfo.item)

  const roomObject = component({
    type: 'div',
    classes: ['room'],
    children: [description, surroundings, directions, itemMessage]
  })

  render(room, roomObject)
}

module.exports = {
  updateRoomUI
}
