import { component, render } from './dom-creation'
import { getData } from '../data-management/store'
import roomInfo from './components/room/room-info'
import directions from './components/room/directions'
import itemMessage from './components/room/item-message'

const updateRoomUI = () => {
  const room = getData('room')

  const roomObject = component({
    type: 'div',
    classes: ['room'],
    children: [roomInfo(room), directions(room.directions), itemMessage(room.item)]
  })

  render(document.getElementById('room'), roomObject)
}

module.exports = {
  updateRoomUI
}
