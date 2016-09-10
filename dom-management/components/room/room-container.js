import { component } from '../../dom-creation'
import { getData } from '../../../data-management/store'
import roomInfo from './room-info'
import directions from './directions'
import itemMessage from './item-message'

const roomContainer = ( {roomClasses, itemName} ) => {
  const room = getData('room')
  const requiredClasses = roomClasses ? ['room'].concat(roomClasses) : ['room']

  return component({
    type: 'div',
    classes: requiredClasses,
    children: [roomInfo(room), directions(room.directions), itemMessage(room.item, itemName)]
  })
}

export default roomContainer
