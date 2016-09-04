import { component } from '../../dom-creation'
import getRoom from '../../../data-management/room'

function addButton ({displayText, rel, link}) {
  const getNewRoom = () => getRoom(link)

  return component({
    type: 'li',
    classes: [rel],
    eventListeners: [{event: 'click', function: getNewRoom}],
    content: displayText || rel
  })
}

function processDirections (directions = []) {
  const buttons = directions.map(direction => addButton(direction))

  return component({
      type: 'ul',
      classes: ['direction-options'],
      attributes: [{key: 'id', value: 'directions'}],
      children: buttons
    })
}

const directions = availableDirections =>  processDirections(availableDirections)

export default directions
