// Elements that need to be updated
import {
  roomDescription,
  roomDetails,
  directions
} from './elements'

import {
  updateText,
  addClass,
  removeClass,
  toggleClass
} from './common-functions'

import { getData } from '../data-management/store'

const updateRoomUI = () => {
  const roomInfo = getData('room')
  updateText(roomDescription, roomInfo.description)
  updateText(roomDetails, roomInfo.surroundings)
}

module.exports = {
  updateRoomUI
}
