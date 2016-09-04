import { component } from '../../dom-creation'
import { getData } from '../../../data-management/store'
import roomInfo from './room-info'
import directions from './directions'
import itemMessage from './item-message'

const roomContainer = () => {
  const room = getData('room')

  return component({
    type: 'div',
    classes: ['room'],
    children: [roomInfo(room), directions(room.directions), itemMessage(room.item)]
  })
}

export default roomContainer
